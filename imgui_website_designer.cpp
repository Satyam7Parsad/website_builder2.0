// ImGui Website Designer - Creates ImGui WebAssembly Websites
// Same UI as Website Builder V1, but exports ImGui C++ code that runs in browser
// Version 1.0

#define GL_SILENCE_DEPRECATION
#include "imgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_opengl3.h"
#include <GLFW/glfw3.h>
#include <stdio.h>
#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <sstream>
#include <map>
#include <set>
#include <cmath>
#include <algorithm>
#include <ctime>
#include <chrono>
#include <sys/stat.h>
#include <dirent.h>
#include <iomanip>
#include <unistd.h>

// PostgreSQL Database Support
#include <libpq-fe.h>

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

// CSS Layout Engine (Flexbox, Grid, Animations)
#include "layout_engine.h"

// ============================================================================
// SECTION TYPES
// ============================================================================
enum SectionType {
    SEC_HERO, SEC_NAVBAR, SEC_ABOUT, SEC_SERVICES, SEC_CARDS, SEC_TEAM,
    SEC_PRICING, SEC_TESTIMONIALS, SEC_GALLERY, SEC_BLOG, SEC_CONTACT,
    SEC_FOOTER, SEC_FAQ, SEC_CTA, SEC_FEATURES, SEC_STATS, SEC_LOGIN, SEC_IMAGE, SEC_TEXTBOX, SEC_CUSTOM
};

// ============================================================================
// ANIMATION TYPES
// ============================================================================
enum AnimationType {
    ANIM_NONE = 0,
    ANIM_FADE_IN,
    ANIM_SLIDE_UP,
    ANIM_SLIDE_DOWN,
    ANIM_SLIDE_LEFT,
    ANIM_SLIDE_RIGHT,
    ANIM_ZOOM_IN,
    ANIM_ZOOM_OUT,
    ANIM_BOUNCE,
    ANIM_ROTATE_IN,
    ANIM_CAROUSEL
};

static const char* g_AnimationNames[] = {
    "None",
    "Fade In",
    "Slide Up",
    "Slide Down",
    "Slide Left",
    "Slide Right",
    "Zoom In",
    "Zoom Out",
    "Bounce",
    "Rotate In",
    "Carousel (Horizontal Scroll)"
};

// ============================================================================
// IMAGE TEXTURE CACHE
// ============================================================================
struct ImageTexture {
    GLuint id;
    int width, height;
    bool loaded;
};
static std::map<std::string, ImageTexture> g_ImageCache;

// ============================================================================
// POSTGRESQL DATABASE CONNECTION
// ============================================================================
static PGconn* g_DBConnection = nullptr;
static bool g_UseDatabase = false;  // Toggle between JSON and PostgreSQL

// Initialize database connection
bool InitDatabase() {
    // PostgreSQL connection string (using current system user and no password)
    const char* conninfo = "host=localhost port=5432 dbname=website_builder";

    g_DBConnection = PQconnectdb(conninfo);

    if (PQstatus(g_DBConnection) != CONNECTION_OK) {
        printf("PostgreSQL connection failed: %s\n", PQerrorMessage(g_DBConnection));
        PQfinish(g_DBConnection);
        g_DBConnection = nullptr;
        return false;
    }

    printf("PostgreSQL connected successfully!\n");
    g_UseDatabase = true;
    return true;
}

// Close database connection
void CloseDatabase() {
    if (g_DBConnection) {
        PQfinish(g_DBConnection);
        g_DBConnection = nullptr;
    }
}

// Helper: Escape string for SQL
std::string SQLEscape(const std::string& str) {
    if (!g_DBConnection) return str;
    char* escaped = new char[str.length() * 2 + 1];
    int error = 0;
    PQescapeStringConn(g_DBConnection, escaped, str.c_str(), str.length(), &error);
    std::string result(escaped);
    delete[] escaped;
    return result;
}

// Helper: Convert color to string "r,g,b,a"
std::string ColorToSQL(const ImVec4& color) {
    char buf[64];
    snprintf(buf, sizeof(buf), "%.3f,%.3f,%.3f,%.3f", color.x, color.y, color.z, color.w);
    return std::string(buf);
}

// Helper: Convert string to color
ImVec4 SQLToColor(const std::string& str) {
    ImVec4 color;
    if (sscanf(str.c_str(), "%f,%f,%f,%f", &color.x, &color.y, &color.z, &color.w) != 4) {
        return ImVec4(0.1f, 0.1f, 0.1f, 1.0f); // Default dark color
    }
    return color;
}

ImageTexture LoadTexture(const std::string& path) {
    if (path.empty()) return {0, 0, 0, false};
    if (g_ImageCache.count(path) && g_ImageCache[path].loaded) {
        printf("✅ Image loaded from cache: %s (ID=%d)\n", path.c_str(), g_ImageCache[path].id);
        return g_ImageCache[path];
    }

    ImageTexture tex = {0, 0, 0, false};
    int channels;
    printf("📸 Loading image: %s\n", path.c_str());
    unsigned char* data = stbi_load(path.c_str(), &tex.width, &tex.height, &channels, 4);
    if (data) {
        glGenTextures(1, &tex.id);
        glBindTexture(GL_TEXTURE_2D, tex.id);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, tex.width, tex.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
        stbi_image_free(data);
        tex.loaded = true;
        g_ImageCache[path] = tex;
        printf("✅ Image loaded successfully: %dx%d, ID=%d\n", tex.width, tex.height, tex.id);
    } else {
        printf("❌ Failed to load image: %s\n", path.c_str());
    }
    return tex;
}

// Decode PostgreSQL hex BYTEA format (\xHEXHEX...) to raw binary
std::vector<unsigned char> DecodePostgresHexBytea(const char* hex_string, size_t length) {
    std::vector<unsigned char> binary;

    // PostgreSQL hex format starts with '\x'
    if (length < 2 || hex_string[0] != '\\' || hex_string[1] != 'x') {
        printf("ERROR: Invalid PostgreSQL hex BYTEA format (missing \\x prefix)\n");
        return binary;
    }

    // Skip the '\x' prefix
    const char* hex = hex_string + 2;
    size_t hex_len = length - 2;

    // Each byte is represented by 2 hex characters
    binary.reserve(hex_len / 2);

    for (size_t i = 0; i < hex_len; i += 2) {
        if (i + 1 >= hex_len) break;

        // Convert two hex characters to one byte
        char hex_byte[3] = {hex[i], hex[i+1], '\0'};
        unsigned int byte_val;
        sscanf(hex_byte, "%2x", &byte_val);
        binary.push_back((unsigned char)byte_val);
    }

    return binary;
}

// Load texture from memory buffer (for database BLOB data)
ImageTexture LoadTextureFromMemory(const unsigned char* buffer, size_t size, const std::string& cache_key) {
    if (!buffer || size == 0) return {0, 0, 0, false};
    if (!cache_key.empty() && g_ImageCache.count(cache_key) && g_ImageCache[cache_key].loaded) {
        return g_ImageCache[cache_key];
    }

    ImageTexture tex = {0, 0, 0, false};
    int channels;
    unsigned char* data = stbi_load_from_memory(buffer, size, &tex.width, &tex.height, &channels, 4);
    if (data) {
        glGenTextures(1, &tex.id);
        glBindTexture(GL_TEXTURE_2D, tex.id);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, tex.width, tex.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
        stbi_image_free(data);
        tex.loaded = true;
        if (!cache_key.empty()) {
            g_ImageCache[cache_key] = tex;
        }
    }
    return tex;
}

// Read image file into binary buffer
std::vector<unsigned char> ReadImageFile(const std::string& filepath) {
    std::vector<unsigned char> buffer;
    std::ifstream file(filepath, std::ios::binary | std::ios::ate);
    if (!file.is_open()) return buffer;

    std::streamsize size = file.tellg();
    file.seekg(0, std::ios::beg);

    buffer.resize(size);
    if (!file.read(reinterpret_cast<char*>(buffer.data()), size)) {
        buffer.clear();
    }
    return buffer;
}

// Convert binary data to hex string for PostgreSQL BYTEA
std::string BinaryToHex(const std::vector<unsigned char>& data) {
    if (data.empty()) return "";
    std::ostringstream oss;
    oss << "E'\\\\x";  // PostgreSQL escape string format for BYTEA hex
    for (unsigned char byte : data) {
        oss << std::hex << std::setw(2) << std::setfill('0') << (int)byte;
    }
    oss << "'";
    return oss.str();
}

// Convert vector of strings to PostgreSQL TEXT array
std::string StringVectorToArray(const std::vector<std::string>& vec) {
    if (vec.empty()) return "'{}'";
    std::ostringstream oss;
    oss << "ARRAY[";
    for (size_t i = 0; i < vec.size(); i++) {
        if (i > 0) oss << ",";
        oss << "'" << SQLEscape(vec[i]) << "'";
    }
    oss << "]";
    return oss.str();
}

// Convert vector of image files to PostgreSQL BYTEA array
std::string ImageVectorToByteaArray(const std::vector<std::string>& image_paths) {
    if (image_paths.empty()) return "'{}'";
    std::ostringstream oss;
    oss << "ARRAY[";
    for (size_t i = 0; i < image_paths.size(); i++) {
        if (i > 0) oss << ",";
        std::vector<unsigned char> img_data = ReadImageFile(image_paths[i]);
        if (!img_data.empty()) {
            oss << BinaryToHex(img_data);
        } else {
            oss << "NULL";
        }
    }
    oss << "]::bytea[]";
    return oss.str();
}

// Parse PostgreSQL TEXT[] array to vector<string>
std::vector<std::string> ParsePostgresArray(const char* pg_array) {
    std::vector<std::string> result;
    if (!pg_array || pg_array[0] != '{') return result;

    std::string str(pg_array);
    size_t start = 1;  // Skip opening '{'
    size_t end = str.find_last_of('}');
    if (end == std::string::npos) return result;

    std::string content = str.substr(start, end - start);
    if (content.empty()) return result;

    // Simple parser for comma-separated values
    size_t pos = 0;
    while (pos < content.length()) {
        if (content[pos] == '"') {
            // Quoted string
            size_t quote_end = content.find('"', pos + 1);
            if (quote_end != std::string::npos) {
                result.push_back(content.substr(pos + 1, quote_end - pos - 1));
                pos = quote_end + 1;
                if (pos < content.length() && content[pos] == ',') pos++;
            } else {
                break;
            }
        } else {
            // Unquoted value
            size_t comma = content.find(',', pos);
            if (comma == std::string::npos) {
                result.push_back(content.substr(pos));
                break;
            } else {
                result.push_back(content.substr(pos, comma - pos));
                pos = comma + 1;
            }
        }
    }
    return result;
}

// Forward declarations
struct WebSection;
static std::vector<WebSection> g_Sections;
static std::vector<std::string> g_Pages;

// ============================================================================
// URL IMPORT STRUCTURES
// ============================================================================
struct ColorPalette {
    ImVec4 primary;
    ImVec4 secondary;
    ImVec4 accent;
    ImVec4 background;
    ImVec4 text;
};

struct DetectedSection {
    std::string type;  // "navbar", "hero", "cards", etc.
    std::string title;
    std::string subtitle;
    std::string content;
    std::vector<std::string> links;
    std::vector<std::string> images;
    ColorPalette colors;
    float estimated_height;
};

// ============================================================================
// PHASE 1: DYNAMIC SECTION TYPES
// ============================================================================
#include "layout_engine.h"

// Property Definition - describes a single configurable property
struct PropertyDefinition {
    std::string name;
    std::string display_name;
    std::string property_type;
    std::string default_value;
    float min_value;
    float max_value;
    std::string category;
};

// Section Type Definition - replaces hard-coded enum
struct SectionTypeDefinition {
    int id;
    std::string type_name;
    std::string display_name;
    std::string description;
    bool is_builtin;
    std::vector<PropertyDefinition> properties;
    std::string default_layout;
    std::string preview_template;
};

// Global registry of section types
static std::map<std::string, SectionTypeDefinition> g_SectionTypes;
static std::vector<std::string> g_SectionTypeNames;

// ============================================================================
// PHASE 2: LAYOUT ENGINE (already in layout_engine.h)
// ============================================================================
enum LayoutMode {
    LAYOUT_STACKED = 0,
    LAYOUT_FLEXBOX = 1,
    LAYOUT_GRID = 2,
    LAYOUT_ABSOLUTE = 3
};

// ============================================================================
// PHASE 3: INTERACTIVE ELEMENTS
// ============================================================================
enum InteractiveType {
    INTERACT_NONE = 0,
    INTERACT_DROPDOWN,
    INTERACT_CAROUSEL,
    INTERACT_MODAL,
    INTERACT_ACCORDION,
    INTERACT_TAB,
    INTERACT_BUTTON_HOVER,
    INTERACT_IMAGE_LIGHTBOX
};

// Interactive element state
struct InteractiveState {
    bool is_hovered;
    bool is_active;
    bool is_expanded;
    int active_index;
    float animation_progress;  // 0.0 to 1.0
    float hover_time;

    InteractiveState() : is_hovered(false), is_active(false), is_expanded(false),
                         active_index(0), animation_progress(0), hover_time(0) {}
};

// Hover state style overrides
struct HoverStyle {
    bool enabled;
    ImVec4 bg_color;
    ImVec4 text_color;
    float scale;
    float opacity;
    float border_width;
    ImVec4 border_color;
    std::string transform;

    HoverStyle() : enabled(false), bg_color(0,0,0,0), text_color(1,1,1,1),
                   scale(1.0f), opacity(1.0f), border_width(0), border_color(1,1,1,0.5f) {}
};

// Interactive element definition
struct InteractiveElement {
    InteractiveType type;
    std::string id;
    InteractiveState state;
    HoverStyle hover_style;

    // Dropdown specific
    std::vector<std::string> dropdown_items;
    int selected_dropdown_index;

    // Carousel specific
    std::vector<std::string> carousel_images;
    std::vector<GLuint> carousel_texture_ids;
    float carousel_auto_play_speed;
    bool carousel_show_dots;
    bool carousel_show_arrows;

    // Modal specific
    std::string modal_title;
    std::string modal_content;
    float modal_width;
    float modal_height;
    bool modal_backdrop_blur;

    // Accordion specific
    std::vector<std::pair<std::string, std::string>> accordion_items;
    std::vector<bool> accordion_expanded;

    // Animation
    float transition_duration;
    std::string easing_function;

    InteractiveElement() : type(INTERACT_NONE), selected_dropdown_index(0),
                          carousel_auto_play_speed(0), carousel_show_dots(true),
                          carousel_show_arrows(true), modal_width(600), modal_height(400),
                          modal_backdrop_blur(true), transition_duration(0.3f),
                          easing_function("ease-in-out") {}
};

// ============================================================================
// WEBSITE SECTION
// ============================================================================
struct WebSection {
    int id;
    SectionType type;
    std::string name;
    std::string section_id;
    float y_position;
    float height;
    bool selected;

    // Content
    std::string title;
    std::string subtitle;
    std::string content;
    std::string button_text;
    std::string button_link;

    // Typography
    float title_font_size;
    float subtitle_font_size;
    float content_font_size;
    float title_font_weight;
    float subtitle_font_weight;
    float content_font_weight;
    ImVec4 title_color;
    ImVec4 subtitle_color;
    ImVec4 content_color;

    // Images
    std::string background_image;
    std::string section_image;
    GLuint bg_texture_id;
    GLuint img_texture_id;
    bool use_bg_image;
    float bg_overlay_opacity;

    // Hero Animation (multiple images slideshow)
    std::vector<std::string> hero_animation_images;
    std::vector<GLuint> hero_animation_texture_ids;
    bool enable_hero_animation;
    float hero_animation_speed;  // seconds per image
    int current_animation_frame;
    float animation_timer;

    // Style
    ImVec4 bg_color;
    ImVec4 text_color;
    ImVec4 accent_color;
    ImVec4 button_bg_color;
    ImVec4 button_text_color;
    float button_font_size;
    float button_font_weight;
    float padding;
    int text_align;

    // Glass effect for buttons
    bool button_glass_effect;
    float button_glass_opacity;
    ImVec4 button_glass_tint;

    // Navigation specific
    struct NavItem {
        std::string label;
        std::string link;
        std::string target_page;
        std::string target_section;
        ImVec4 text_color;
        float font_size;
        float font_weight;
    };
    std::vector<NavItem> nav_items;
    std::string logo_path;
    GLuint logo_texture_id;
    float logo_size;
    int brand_text_position;  // 0=side (next to), 1=above, 2=below
    ImVec4 nav_bg_color;
    ImVec4 nav_text_color;
    float nav_font_size;
    float nav_font_weight;

    // Cards/Items
    struct CardItem {
        std::string title;
        std::string description;
        std::string image;
        std::string price;
        std::string link;
        ImVec4 bg_color;
        ImVec4 title_color;
        ImVec4 desc_color;
        float title_font_size;
        float desc_font_size;
        float title_font_weight;
        float desc_font_weight;
        GLuint texture_id;
        float width;
        float height;
        // Glass effect
        bool glass_effect;
        float glass_opacity;
        float glass_blur;
        ImVec4 glass_tint;
        // Enhanced glass styling
        float glass_border_radius;
        float glass_border_width;
        ImVec4 glass_border_color;
        bool glass_highlight;        // Top edge highlight/shine
        float glass_highlight_opacity;

        // Modern card design (Screenshot style)
        int card_style;              // 0=old, 1=service(icon+bullets), 2=portfolio(thumbnail)
        ImVec4 icon_color;           // Icon background color (pink, blue, green, etc.)
        std::string icon_emoji;      // Icon emoji or symbol (⚡, 🌐, 📱, etc.)
        std::vector<std::string> bullet_points;  // Feature list with bullets
        std::string thumbnail_image; // Large thumbnail for portfolio cards
        GLuint thumbnail_texture_id; // Thumbnail texture
        std::vector<std::string> tech_tags;      // Technology tags (React, Node.js, etc.)
        std::string category_badge;  // Badge text (Web Development, Mobile, etc.)

        // Animation
        int anim_direction;          // 0=none, 1=left-to-right, 2=right-to-left (default)
        float anim_progress;         // 0.0 to 1.0
        float anim_delay;            // Delay before animation starts
    };
    std::vector<CardItem> items;

    // Text Paragraphs (for text-heavy sections)
    struct Paragraph {
        std::string text;
        float font_size;
        float font_weight;
        ImVec4 color;
        std::string font_family;
    };
    std::vector<Paragraph> paragraphs;

    // Glass Panels (drag-drop glass elements)
    struct GlassPanel {
        float x, y;           // Position relative to section
        float width, height;
        std::string text;
        float text_size;
        ImVec4 text_color;
        float opacity;
        float blur;
        ImVec4 tint;
        float border_radius;
        bool selected;
    };
    std::vector<GlassPanel> glass_panels;

    // Moveable Image Elements (drag-drop images anywhere in section)
    struct ImageElement {
        float x, y;                  // Position relative to section (pixels)
        float width, height;         // Size in pixels
        std::string image_path;      // Path to image file
        GLuint texture_id;           // OpenGL texture ID
        bool selected;               // Is this image currently selected?
        bool dragging;               // Is this image being dragged?
        float drag_offset_x;         // Mouse offset during drag
        float drag_offset_y;         // Mouse offset during drag
        float border_radius;         // Optional rounded corners
        float opacity;               // Image opacity (0-1)
        bool maintain_aspect_ratio;  // Lock aspect ratio when resizing

        ImageElement() :
            x(100), y(100), width(200), height(200),
            texture_id(0), selected(false), dragging(false),
            drag_offset_x(0), drag_offset_y(0),
            border_radius(0), opacity(1.0f),
            maintain_aspect_ratio(true) {}
    };
    std::vector<ImageElement> moveable_images;

    // Card layout settings
    float card_width;
    float card_height;
    float card_spacing;
    float card_padding;
    int cards_per_row;
    float heading_to_cards_spacing;  // Space between heading and cards

    // FAQ Items
    struct FAQItem {
        std::string question;
        std::string answer;
        ImVec4 question_color;
        ImVec4 answer_color;
        float question_font_size;
        float answer_font_size;
        float question_font_weight;
        bool expanded;
    };
    std::vector<FAQItem> faq_items;

    // Login Card Properties
    float login_card_width;
    float login_card_height;
    float login_card_border_radius;
    float login_card_glass_opacity;
    float login_card_glass_blur;
    ImVec4 login_card_glass_tint;
    ImVec4 login_card_border_color;
    float login_card_border_width;
    // Login input fields
    float login_input_height;
    float login_input_border_radius;
    float login_input_glass_opacity;
    ImVec4 login_input_glass_tint;
    ImVec4 login_input_text_color;
    ImVec4 login_input_placeholder_color;
    // Login button
    float login_button_height;
    float login_button_border_radius;
    float login_button_glass_opacity;
    ImVec4 login_button_glass_tint;
    ImVec4 login_button_text_color;
    // Login field labels
    std::string login_username_placeholder;
    std::string login_password_placeholder;
    std::string login_button_label;

    // Contact Form Properties (user controllable)
    float contact_input_width;       // Width of form inputs (% of container)
    float contact_input_height;      // Height of each input field
    float contact_button_width;      // Width of submit button (% of container)
    float contact_button_height;     // Height of submit button
    float contact_field_spacing;     // Spacing between fields

    // Animation Settings
    AnimationType animation_type;
    float animation_duration;        // in seconds (0.3 to 30.0)
    float animation_delay;           // in seconds (0 to 5.0)
    bool animation_repeat;           // whether to repeat animation
    float card_stagger_delay;        // delay between each card starting (0.1 to 2.0)
    std::string animation_trigger;   // "onload", "onscroll", "onclick"

    // Layout Style (which of the 5 template variations)
    int layout_style;                // 0-4: which layout template was selected

    // Gallery/Images Section
    std::vector<std::string> gallery_images;
    std::vector<GLuint> gallery_texture_ids;
    int gallery_columns;             // number of columns in gallery grid
    float gallery_spacing;           // spacing between images
    bool gallery_lightbox;           // enable lightbox on click

    // Width and Position (for Image and Text Box sections)
    float section_width_percent;     // Width as percentage (30%, 50%, 70%, 100%)
    int horizontal_align;            // 0=Left, 1=Center, 2=Right
    bool use_manual_position;        // True = use y_position manually, False = auto-stack

    // ============================================================================
    // PHASE 1: Dynamic Section Types
    // ============================================================================
    std::string type_name;           // String-based type name
    bool use_legacy_type;            // True = use enum, False = use type_name
    std::map<std::string, std::string> custom_properties;

    // ============================================================================
    // PHASE 2: Flexbox/Grid Layout Engine
    // ============================================================================
    LayoutMode layout_mode;
    FlexboxLayout flexbox_props;
    GridLayout grid_props;

    // ============================================================================
    // PHASE 3: Interactive Elements
    // ============================================================================
    std::vector<InteractiveElement> interactive_elements;
    bool section_hovered;
    float section_hover_time;
    float carousel_timer;
    ImVec2 last_mouse_pos;

    // ============================================================================
    // CSS STYLING PROPERTIES (imported from web scraper)
    // ============================================================================
    // Button CSS
    float button_border_radius;
    float button_border_width;
    ImVec4 button_border_color;
    std::string button_box_shadow;      // e.g., "0px 4px 6px rgba(0,0,0,0.1)"
    std::string button_padding;         // e.g., "10px 20px"

    // Section CSS
    float section_border_radius;
    std::string section_box_shadow;     // e.g., "0px 10px 30px rgba(0,0,0,0.1)"
    std::string section_border;         // e.g., "1px solid rgb(200,200,200)"
    float section_opacity;
    std::string section_line_height;
    std::string section_letter_spacing;

    // ============================================================================
    // LAYOUT PROPERTIES (flexbox, grid, positioning, spacing)
    // ============================================================================
    // 4-sided padding
    float padding_top, padding_right, padding_bottom, padding_left;

    // Flexbox properties
    std::string display;                // "block", "flex", "grid"
    std::string flex_direction;         // "row", "column"
    std::string justify_content;        // "flex-start", "center", "space-between", etc.
    std::string align_items;            // "flex-start", "center", "stretch", etc.
    float gap;                          // Gap between flex items

    // Grid properties
    std::string grid_template_columns;  // e.g., "1fr 1fr 1fr" or "repeat(3, 1fr)"
    std::string grid_template_rows;

    // Background positioning
    std::string background_position;    // e.g., "center center"
    std::string background_repeat;      // e.g., "no-repeat"
    std::string background_size;        // e.g., "cover", "contain"
    std::string background_image_css;   // CSS gradient or image URL

    // Position properties (for overlays and absolute positioning)
    std::string css_position;           // "static", "relative", "absolute", "fixed"
    std::string css_top, css_left, css_right, css_bottom;
    int css_z_index;

    // Typography
    std::string font_family;            // e.g., "Roboto", "Poppins"

    // Gradient support
    bool has_gradient;
    std::vector<ImVec4> gradient_colors;
    bool gradient_is_radial;

    WebSection(int _id, SectionType _type) : id(_id), type(_type),
        y_position(0), height(300), selected(false),
        title_font_size(48), subtitle_font_size(20), content_font_size(16),
        title_font_weight(700), subtitle_font_weight(400), content_font_weight(400),
        title_color(0.1f,0.1f,0.1f,1), subtitle_color(0.3f,0.3f,0.3f,1), content_color(0.2f,0.2f,0.2f,1),
        bg_texture_id(0), img_texture_id(0), use_bg_image(false), bg_overlay_opacity(0.0f),
        enable_hero_animation(false), hero_animation_speed(3.0f), current_animation_frame(0), animation_timer(0.0f),
        logo_texture_id(0), logo_size(50.0f), brand_text_position(0),
        bg_color(1,1,1,1), text_color(0.1f,0.1f,0.1f,1), accent_color(0.2f,0.5f,1.0f,1),
        button_bg_color(0.2f,0.5f,1.0f,1), button_text_color(1,1,1,1),
        button_font_size(16), button_font_weight(600),
        button_glass_effect(false), button_glass_opacity(0.0f), button_glass_tint(1,1,1,0.0f),
        nav_bg_color(1,1,1,1), nav_text_color(0.2f,0.2f,0.2f,1),
        nav_font_size(15), nav_font_weight(500),
        card_width(300), card_height(250), card_spacing(20), card_padding(25), cards_per_row(3), heading_to_cards_spacing(40),
        padding(60), text_align(1),
        // Login card defaults
        login_card_width(400), login_card_height(450), login_card_border_radius(20),
        login_card_glass_opacity(0.25f), login_card_glass_blur(20),
        login_card_glass_tint(0.1f, 0.15f, 0.25f, 1.0f),
        login_card_border_color(1.0f, 1.0f, 1.0f, 0.2f), login_card_border_width(1.5f),
        login_input_height(50), login_input_border_radius(8),
        login_input_glass_opacity(0.15f), login_input_glass_tint(0.0f, 0.1f, 0.2f, 1.0f),
        login_input_text_color(1,1,1,1), login_input_placeholder_color(0.7f, 0.7f, 0.7f, 1.0f),
        login_button_height(50), login_button_border_radius(25),
        login_button_glass_opacity(0.35f), login_button_glass_tint(0.1f, 0.2f, 0.35f, 1.0f),
        login_button_text_color(1,1,1,1),
        login_username_placeholder("Enter Username"), login_password_placeholder("Enter Password"),
        login_button_label("LOGIN"),
        // Contact form defaults
        contact_input_width(80.0f), contact_input_height(28.0f),
        contact_button_width(80.0f), contact_button_height(35.0f),
        contact_field_spacing(38.0f),
        // Animation defaults
        animation_type(ANIM_FADE_IN), animation_duration(1.0f), animation_delay(0.0f),
        animation_repeat(false), card_stagger_delay(0.3f), animation_trigger("onload"),
        // Layout style default
        layout_style(0),
        // Gallery defaults
        gallery_columns(3), gallery_spacing(20.0f), gallery_lightbox(true),
        // Width and position defaults
        section_width_percent(100.0f), horizontal_align(0), use_manual_position(false),
        // Phase 1: Dynamic types
        use_legacy_type(true),
        // Phase 2: Layout engine
        layout_mode(LAYOUT_STACKED),
        // Phase 3: Interactive elements
        section_hovered(false), section_hover_time(0), carousel_timer(0), last_mouse_pos(0,0),
        // CSS styling defaults
        button_border_radius(0.0f), button_border_width(0.0f),
        button_border_color(0,0,0,1), button_box_shadow("none"), button_padding("10px 20px"),
        section_border_radius(0.0f), section_box_shadow("none"),
        section_border("none"), section_opacity(1.0f),
        section_line_height("normal"), section_letter_spacing("normal"),
        // Layout properties defaults
        padding_top(60.0f), padding_right(60.0f), padding_bottom(60.0f), padding_left(60.0f),
        display("block"), flex_direction("row"), justify_content("normal"), align_items("normal"),
        gap(0.0f), grid_template_columns("none"), grid_template_rows("none"),
        background_position("0% 0%"), background_repeat("repeat"), background_size("auto"), background_image_css("none"),
        css_position("static"), css_top("auto"), css_left("auto"), css_right("auto"), css_bottom("auto"), css_z_index(0),
        font_family("system-ui"), has_gradient(false), gradient_is_radial(false) {
        SetDefaults();
    }

    void SetDefaults() {
        const char* ids[] = {"hero","nav","about","services","cards","team","pricing",
                            "testimonials","gallery","blog","contact","footer","faq","cta","features","stats","login","image","textbox","custom"};
        section_id = ids[type];

        switch(type) {
            case SEC_HERO:
                name = "Hero Section";
                title = "Transform Your Digital Presence";
                subtitle = "Create stunning websites with elegant design and powerful features";
                content = "Join thousands of satisfied customers who trust us to bring their vision to life";
                button_text = "Get Started Free";
                button_link = "#contact";
                height = 600;
                // Modern gradient background (deep blue to purple)
                bg_color = ImVec4(0.09f, 0.13f, 0.25f, 1.0f);
                title_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                subtitle_color = ImVec4(0.85f, 0.88f, 0.95f, 1.0f);
                content_color = ImVec4(0.7f, 0.75f, 0.85f, 1.0f);
                text_color = ImVec4(1,1,1,1);
                // Modern typography
                title_font_size = 64;
                title_font_weight = 800;
                subtitle_font_size = 24;
                subtitle_font_weight = 500;
                content_font_size = 18;
                content_font_weight = 400;
                // Modern glass button
                button_bg_color = ImVec4(0.37f, 0.51f, 0.99f, 1.0f);  // Modern blue
                button_text_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                button_font_size = 18;
                button_font_weight = 600;
                button_glass_effect = false;
                button_glass_opacity = 0.3f;
                button_glass_tint = ImVec4(1.0f, 1.0f, 1.0f, 0.2f);
                accent_color = ImVec4(0.37f, 0.51f, 0.99f, 1.0f);
                padding = 80;
                animation_type = ANIM_FADE_IN;
                animation_duration = 1.2f;
                break;

            case SEC_NAVBAR:
                name = "Navigation";
                title = "Brand";
                height = 70;
                section_id = "nav";
                bg_color = ImVec4(1,1,1,1);
                nav_bg_color = ImVec4(1,1,1,1);
                nav_text_color = ImVec4(0.2f,0.2f,0.2f,1);
                nav_font_size = 15;
                nav_font_weight = 500;
                nav_items = {
                    {"Home", "#hero", "", "hero", nav_text_color, 15, 500},
                    {"About", "#about", "", "about", nav_text_color, 15, 500},
                    {"Services", "#services", "", "services", nav_text_color, 15, 500},
                    {"Contact", "#contact", "", "contact", nav_text_color, 15, 500}
                };
                break;

            case SEC_ABOUT:
                name = "About Section";
                title = "Who We Are";
                subtitle = "Crafting digital excellence since 2015";
                content = "We are a passionate team of designers, developers, and strategists dedicated to transforming bold ideas into exceptional digital experiences.\n\nOur Story:\nFounded in 2015, we've helped over 500 businesses achieve their digital goals. From startups to enterprise companies, we bring creativity, technical expertise, and strategic thinking to every project.\n\nOur Mission:\nTo empower businesses with innovative digital solutions that drive growth, engage audiences, and create lasting impact in the digital world.\n\nWhat Sets Us Apart:\n• 10+ years of combined experience\n• Award-winning design team\n• Agile development methodology\n• 24/7 dedicated support\n• 98% client satisfaction rate";
                height = 550;
                bg_color = ImVec4(0.99f, 0.99f, 1.0f, 1.0f);
                // Modern colors
                title_color = ImVec4(0.12f, 0.15f, 0.22f, 1.0f);
                subtitle_color = ImVec4(0.45f, 0.50f, 0.60f, 1.0f);
                content_color = ImVec4(0.25f, 0.30f, 0.40f, 1.0f);
                // Typography
                title_font_size = 48;
                title_font_weight = 700;
                subtitle_font_size = 22;
                subtitle_font_weight = 500;
                content_font_size = 17;
                content_font_weight = 400;
                accent_color = ImVec4(0.37f, 0.51f, 0.99f, 1.0f);
                padding = 70;
                animation_type = ANIM_SLIDE_UP;
                animation_duration = 1.0f;
                break;

            case SEC_SERVICES:
            case SEC_FEATURES:
                name = type == SEC_SERVICES ? "Services" : "Features";
                title = type == SEC_SERVICES ? "Our Services" : "Why Choose Us";
                subtitle = type == SEC_SERVICES ? "Professional solutions tailored to your needs" : "The features that make us stand out";
                height = 1200;
                bg_color = ImVec4(0.99f, 0.99f, 1.0f, 1.0f);  // Pure white
                // Modern colors
                title_color = ImVec4(0.12f, 0.15f, 0.22f, 1.0f);
                subtitle_color = ImVec4(0.45f, 0.50f, 0.60f, 1.0f);
                // Professional typography
                title_font_size = 48;
                title_font_weight = 700;
                subtitle_font_size = 20;
                subtitle_font_weight = 400;
                card_width = 800;
                card_height = 1000;
                card_spacing = 40;
                cards_per_row = 3;
                padding = 70;
                items = {
                    {"AI & Machine Learning", "Intelligent solutions for your business", "", "", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.45f, 0.50f, 0.60f, 1.0f), 24, 16, 600, 400, 0, 0, 0,
                     false, 0.15f, 15.0f, ImVec4(0.37f, 0.51f, 0.99f, 0.05f), 16.0f, 1.5f, ImVec4(0.37f, 0.51f, 0.99f, 0.1f), false, 0.15f,
                     1, ImVec4(0.96f, 0.32f, 0.53f, 1.0f), "⚡", {"Custom Models", "Data Analysis", "Predictive Analytics"}, "", 0, {}, "", 2, 0.0f, 0.0f},
                    {"Website Design & Development", "Make your online presence impactful", "", "", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.45f, 0.50f, 0.60f, 1.0f), 24, 16, 600, 400, 0, 0, 0,
                     false, 0.15f, 15.0f, ImVec4(0.56f, 0.27f, 0.68f, 0.05f), 16.0f, 1.5f, ImVec4(0.56f, 0.27f, 0.68f, 0.1f), false, 0.15f,
                     1, ImVec4(0.25f, 0.52f, 1.0f, 1.0f), "🌐", {"Responsive Design", "SEO Optimization", "Performance Tuning"}, "", 0, {}, "", 2, 0.0f, 0.15f},
                    {"Mobile App Development", "Android | iOS | Hybrid", "", "", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.45f, 0.50f, 0.60f, 1.0f), 24, 16, 600, 400, 0, 0, 0,
                     false, 0.15f, 15.0f, ImVec4(0.06f, 0.71f, 0.60f, 0.05f), 16.0f, 1.5f, ImVec4(0.06f, 0.71f, 0.60f, 0.1f), false, 0.15f,
                     1, ImVec4(0.20f, 0.73f, 0.42f, 1.0f), "📱", {"Native Apps", "Cross-platform", "App Store Deployment"}, "", 0, {}, "", 2, 0.0f, 0.3f}
                };
                animation_type = ANIM_SLIDE_UP;
                animation_duration = 0.9f;
                animation_delay = 0.2f;
                break;

            case SEC_CARDS:
                name = "Cards Section";
                title = "Featured";
                height = 1200;
                title_font_size = 42;
                title_font_weight = 700;
                subtitle_font_size = 20;
                subtitle_font_weight = 400;
                card_width = 800;
                card_height = 1000;
                card_spacing = 40;
                cards_per_row = 3;
                padding = 70;
                items = {
                    {"AI & Machine Learning", "Intelligent solutions for your business", "", "", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.45f, 0.50f, 0.60f, 1.0f), 24, 16, 600, 400, 0, 0, 0,
                     false, 0.15f, 15.0f, ImVec4(0.37f, 0.51f, 0.99f, 0.05f), 16.0f, 1.5f, ImVec4(0.37f, 0.51f, 0.99f, 0.1f), false, 0.15f,
                     1, ImVec4(0.96f, 0.32f, 0.53f, 1.0f), "⚡", {"Custom Models", "Data Analysis", "Predictive Analytics"}, "", 0, {}, "", 2, 0.0f, 0.0f},
                    {"Website Design & Development", "Make your online presence impactful", "", "", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.45f, 0.50f, 0.60f, 1.0f), 24, 16, 600, 400, 0, 0, 0,
                     false, 0.15f, 15.0f, ImVec4(0.56f, 0.27f, 0.68f, 0.05f), 16.0f, 1.5f, ImVec4(0.56f, 0.27f, 0.68f, 0.1f), false, 0.15f,
                     1, ImVec4(0.25f, 0.52f, 1.0f, 1.0f), "🌐", {"Responsive Design", "SEO Optimization", "Performance Tuning"}, "", 0, {}, "", 2, 0.0f, 0.15f},
                    {"Mobile App Development", "Android | iOS | Hybrid", "", "", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.45f, 0.50f, 0.60f, 1.0f), 24, 16, 600, 400, 0, 0, 0,
                     false, 0.15f, 15.0f, ImVec4(0.06f, 0.71f, 0.60f, 0.05f), 16.0f, 1.5f, ImVec4(0.06f, 0.71f, 0.60f, 0.1f), false, 0.15f,
                     1, ImVec4(0.20f, 0.73f, 0.42f, 1.0f), "📱", {"Native Apps", "Cross-platform", "App Store Deployment"}, "", 0, {}, "", 2, 0.0f, 0.3f}
                };
                animation_type = ANIM_SLIDE_UP;
                animation_duration = 0.9f;
                animation_delay = 0.2f;
                break;

            case SEC_TEAM:
                name = "Team Section";
                title = "Meet Our Team";
                subtitle = "The talented people behind our success";
                height = 1200;
                bg_color = ImVec4(0.99f, 0.99f, 1.0f, 1.0f);
                // Modern colors
                title_color = ImVec4(0.12f, 0.15f, 0.22f, 1.0f);
                subtitle_color = ImVec4(0.45f, 0.50f, 0.60f, 1.0f);
                // Typography
                title_font_size = 48;
                title_font_weight = 700;
                subtitle_font_size = 20;
                subtitle_font_weight = 400;
                card_width = 800;
                card_height = 1000;
                card_spacing = 40;
                cards_per_row = 3;
                padding = 70;
                items = {
                    {"Sarah Johnson", "CEO & Founder", "", "", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.45f, 0.50f, 0.60f, 1.0f), 24, 16, 600, 400, 0, 0, 0,
                     false, 0.15f, 15.0f, ImVec4(0.37f, 0.51f, 0.99f, 0.05f), 16.0f, 1.5f, ImVec4(0.37f, 0.51f, 0.99f, 0.1f), false, 0.15f,
                     1, ImVec4(0.96f, 0.32f, 0.53f, 1.0f), "", {"10+ years experience", "Strategic vision", "Team leadership"}, "", 0, {}, "", 2, 1.0f, 0.0f},
                    {"Michael Chen", "Creative Director", "", "", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.45f, 0.50f, 0.60f, 1.0f), 24, 16, 600, 400, 0, 0, 0,
                     false, 0.15f, 15.0f, ImVec4(0.56f, 0.27f, 0.68f, 0.05f), 16.0f, 1.5f, ImVec4(0.56f, 0.27f, 0.68f, 0.1f), false, 0.15f,
                     1, ImVec4(0.25f, 0.52f, 1.0f, 1.0f), "", {"Award-winning designs", "Brand innovation", "Creative strategy"}, "", 0, {}, "", 2, 1.0f, 0.15f},
                    {"Emily Rodriguez", "Lead Developer", "", "", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.45f, 0.50f, 0.60f, 1.0f), 24, 16, 600, 400, 0, 0, 0,
                     false, 0.15f, 15.0f, ImVec4(0.06f, 0.71f, 0.60f, 0.05f), 16.0f, 1.5f, ImVec4(0.06f, 0.71f, 0.60f, 0.1f), false, 0.15f,
                     1, ImVec4(0.20f, 0.73f, 0.42f, 1.0f), "", {"Full-stack expertise", "Clean code advocate", "Tech innovation"}, "", 0, {}, "", 2, 1.0f, 0.3f}
                };
                animation_type = ANIM_FADE_IN;
                animation_duration = 1.0f;
                animation_delay = 0.3f;
                break;

            case SEC_PRICING:
                name = "Pricing";
                title = "Choose Your Plan";
                subtitle = "Simple, transparent pricing that grows with you";
                height = 1200;
                bg_color = ImVec4(0.98f, 0.98f, 0.99f, 1.0f);
                // Modern elegant colors
                title_color = ImVec4(0.12f, 0.15f, 0.22f, 1.0f);
                subtitle_color = ImVec4(0.45f, 0.50f, 0.60f, 1.0f);
                // Typography
                title_font_size = 48;
                title_font_weight = 700;
                subtitle_font_size = 20;
                subtitle_font_weight = 400;
                card_width = 800;
                card_height = 1000;
                card_spacing = 40;
                cards_per_row = 3;
                padding = 70;
                items = {
                    {"Starter", "Perfect for individuals and small projects", "", "$19/mo", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.45f, 0.50f, 0.60f, 1.0f), 24, 16, 600, 400, 0, 0, 0,
                     false, 0.15f, 15.0f, ImVec4(0.37f, 0.51f, 0.99f, 0.05f), 16.0f, 1.5f, ImVec4(0.37f, 0.51f, 0.99f, 0.1f), false, 0.15f,
                     1, ImVec4(0.96f, 0.32f, 0.53f, 1.0f), "", {"5GB Storage", "Basic Support", "1 User"}, "", 0, {}, "", 2, 1.0f, 0.0f},
                    {"Professional", "Ideal for growing businesses", "", "$49/mo", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.45f, 0.50f, 0.60f, 1.0f), 24, 16, 600, 400, 0, 0, 0,
                     false, 0.15f, 15.0f, ImVec4(0.56f, 0.27f, 0.68f, 0.05f), 16.0f, 1.5f, ImVec4(0.56f, 0.27f, 0.68f, 0.1f), false, 0.15f,
                     1, ImVec4(0.25f, 0.52f, 1.0f, 1.0f), "", {"100GB Storage", "Priority Support", "10 Users"}, "", 0, {}, "", 2, 1.0f, 0.15f},
                    {"Enterprise", "Advanced features for large organizations", "", "$99/mo", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.45f, 0.50f, 0.60f, 1.0f), 24, 16, 600, 400, 0, 0, 0,
                     false, 0.15f, 15.0f, ImVec4(0.06f, 0.71f, 0.60f, 0.05f), 16.0f, 1.5f, ImVec4(0.06f, 0.71f, 0.60f, 0.1f), false, 0.15f,
                     1, ImVec4(0.20f, 0.73f, 0.42f, 1.0f), "", {"Unlimited Storage", "24/7 Support", "Unlimited Users"}, "", 0, {}, "", 2, 1.0f, 0.3f}
                };
                animation_type = ANIM_ZOOM_IN;
                animation_duration = 0.8f;
                animation_delay = 0.15f;
                break;

            case SEC_TESTIMONIALS:
                name = "Testimonials";
                title = "What Our Clients Say";
                subtitle = "Don't just take our word for it - hear from our satisfied customers";
                height = 480;
                bg_color = ImVec4(0.98f, 0.98f, 0.99f, 1.0f);
                // Modern colors
                title_color = ImVec4(0.12f, 0.15f, 0.22f, 1.0f);
                subtitle_color = ImVec4(0.45f, 0.50f, 0.60f, 1.0f);
                // Typography
                title_font_size = 48;
                title_font_weight = 700;
                subtitle_font_size = 20;
                subtitle_font_weight = 400;
                card_width = 380;
                card_height = 250;
                card_spacing = 25;
                cards_per_row = 3;
                padding = 70;
                items = {
                    {"\"Working with this team has been transformative for our business. Their attention to detail and creativity exceeded all expectations!\"", "Sarah Johnson, CEO at TechStart", "", "", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.37f, 0.51f, 0.99f, 1.0f), 18, 15, 500, 600, 0, 0, 0,
                     true, 0.10f, 12.0f, ImVec4(0.97f, 0.97f, 0.99f, 1.0f), 14.0f, 1.8f, ImVec4(0.37f, 0.51f, 0.99f, 0.12f), true, 0.15f},
                    {"\"The best investment we've made this year. Professional, responsive, and delivered exceptional results on time.\"", "Michael Chen, Founder of GrowthCo", "", "", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.37f, 0.51f, 0.99f, 1.0f), 18, 15, 500, 600, 0, 0, 0,
                     true, 0.10f, 12.0f, ImVec4(0.97f, 0.97f, 0.99f, 1.0f), 14.0f, 1.8f, ImVec4(0.37f, 0.51f, 0.99f, 0.12f), true, 0.15f},
                    {"\"Outstanding work from start to finish. They truly understood our vision and brought it to life beautifully.\"", "Emily Rodriguez, Marketing Director", "", "", "",
                     ImVec4(1.0f, 1.0f, 1.0f, 1.0f), ImVec4(0.12f, 0.15f, 0.22f, 1.0f), ImVec4(0.37f, 0.51f, 0.99f, 1.0f), 18, 15, 500, 600, 0, 0, 0,
                     true, 0.10f, 12.0f, ImVec4(0.97f, 0.97f, 0.99f, 1.0f), 14.0f, 1.8f, ImVec4(0.37f, 0.51f, 0.99f, 0.12f), true, 0.15f}
                };
                animation_type = ANIM_FADE_IN;
                animation_duration = 1.1f;
                animation_delay = 0.2f;
                break;

            case SEC_GALLERY:
                name = "Gallery";
                title = "Our Portfolio";
                subtitle = "Explore our latest projects and creative work";
                height = 1200;
                bg_color = ImVec4(0.99f, 0.99f, 1.0f, 1.0f);
                // Modern colors
                title_color = ImVec4(0.12f, 0.15f, 0.22f, 1.0f);
                subtitle_color = ImVec4(0.45f, 0.50f, 0.60f, 1.0f);
                // Typography
                title_font_size = 48;
                title_font_weight = 700;
                subtitle_font_size = 20;
                subtitle_font_weight = 400;
                card_width = 1200;
                card_height = 1000;
                card_spacing = 10;
                cards_per_row = 2;
                padding = 70;
                gallery_columns = 2;
                gallery_spacing = 10.0f;
                gallery_lightbox = true;
                items = {
                    {"Project 1", "Gallery image", "", "", "", ImVec4(0.96f,0.96f,0.98f,1), ImVec4(0.12f,0.15f,0.22f,1), ImVec4(0.45f,0.50f,0.60f,1), 20, 15, 600, 400, 0, 0, 0,
                     true, 0.08f, 12.0f, ImVec4(0.95f,0.95f,0.97f,1), 14.0f, 1.5f, ImVec4(0.85f,0.87f,0.92f,0.2f), true, 0.12f},
                    {"Project 2", "Gallery image", "", "", "", ImVec4(0.96f,0.96f,0.98f,1), ImVec4(0.12f,0.15f,0.22f,1), ImVec4(0.45f,0.50f,0.60f,1), 20, 15, 600, 400, 0, 0, 0,
                     true, 0.08f, 12.0f, ImVec4(0.95f,0.95f,0.97f,1), 14.0f, 1.5f, ImVec4(0.85f,0.87f,0.92f,0.2f), true, 0.12f},
                    {"Project 3", "Gallery image", "", "", "", ImVec4(0.96f,0.96f,0.98f,1), ImVec4(0.12f,0.15f,0.22f,1), ImVec4(0.45f,0.50f,0.60f,1), 20, 15, 600, 400, 0, 0, 0,
                     true, 0.08f, 12.0f, ImVec4(0.95f,0.95f,0.97f,1), 14.0f, 1.5f, ImVec4(0.85f,0.87f,0.92f,0.2f), true, 0.12f},
                    {"Project 4", "Gallery image", "", "", "", ImVec4(0.96f,0.96f,0.98f,1), ImVec4(0.12f,0.15f,0.22f,1), ImVec4(0.45f,0.50f,0.60f,1), 20, 15, 600, 400, 0, 0, 0,
                     true, 0.08f, 12.0f, ImVec4(0.95f,0.95f,0.97f,1), 14.0f, 1.5f, ImVec4(0.85f,0.87f,0.92f,0.2f), true, 0.12f}
                };
                animation_type = ANIM_ZOOM_IN;
                animation_duration = 0.7f;
                animation_delay = 0.1f;
                break;

            case SEC_CONTACT:
                name = "Contact";
                title = "Get In Touch";
                subtitle = "We'd love to hear from you";
                content = "Have a question or want to work together? Drop us a message and we'll get back to you within 24 hours.\n\nEmail: hello@company.com\nPhone: (555) 123-4567\nAddress: 123 Main Street, Suite 100\nNew York, NY 10001\n\nBusiness Hours:\nMon-Fri: 9:00 AM - 6:00 PM\nSat-Sun: Closed";
                height = 550;
                bg_color = ImVec4(0.98f, 0.98f, 0.99f, 1.0f);  // Light gray background
                // Modern elegant colors
                title_color = ImVec4(0.12f, 0.15f, 0.22f, 1.0f);  // Dark blue-gray
                subtitle_color = ImVec4(0.45f, 0.50f, 0.60f, 1.0f);  // Medium gray
                content_color = ImVec4(0.35f, 0.40f, 0.50f, 1.0f);
                // Professional typography
                title_font_size = 48;
                title_font_weight = 700;
                subtitle_font_size = 20;
                subtitle_font_weight = 400;
                content_font_size = 16;
                content_font_weight = 400;
                // Modern button
                button_text = "Send Message";
                button_bg_color = ImVec4(0.37f, 0.51f, 0.99f, 1.0f);  // Modern blue
                button_text_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                button_font_size = 17;
                button_font_weight = 600;
                button_glass_effect = false;
                button_glass_opacity = 0.25f;
                accent_color = ImVec4(0.37f, 0.51f, 0.99f, 1.0f);
                padding = 70;
                animation_type = ANIM_SLIDE_UP;
                animation_duration = 0.8f;
                break;

            case SEC_FOOTER:
                name = "Footer";
                title = "Your Company";
                subtitle = "Building the future, one project at a time";
                content = "© 2024 Your Company. All rights reserved.\n\nQuick Links: Home • About • Services • Contact\nLegal: Privacy Policy • Terms of Service • Cookie Policy\n\nConnect: LinkedIn • Twitter • Facebook • Instagram\nEmail: hello@yourcompany.com • Phone: (555) 123-4567";
                height = 280;
                // Modern dark footer
                bg_color = ImVec4(0.08f, 0.10f, 0.14f, 1.0f);  // Dark blue-gray
                title_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                subtitle_color = ImVec4(0.75f, 0.78f, 0.85f, 1.0f);
                content_color = ImVec4(0.60f, 0.65f, 0.75f, 1.0f);
                text_color = ImVec4(0.7f, 0.75f, 0.85f, 1.0f);
                // Typography
                title_font_size = 28;
                title_font_weight = 700;
                subtitle_font_size = 16;
                subtitle_font_weight = 400;
                content_font_size = 15;
                content_font_weight = 400;
                accent_color = ImVec4(0.37f, 0.51f, 0.99f, 1.0f);
                padding = 60;
                break;

            case SEC_FAQ:
                name = "FAQ";
                title = "Frequently Asked Questions";
                height = 400;
                title_font_size = 42;
                faq_items = {
                    {"What services do you offer?", "We offer web design, development, and SEO.",
                     ImVec4(0.1f,0.1f,0.1f,1), ImVec4(0.4f,0.4f,0.4f,1), 18, 15, 600, false},
                    {"How long does a project take?", "Typically 2-4 weeks depending on complexity.",
                     ImVec4(0.1f,0.1f,0.1f,1), ImVec4(0.4f,0.4f,0.4f,1), 18, 15, 600, false},
                    {"Do you offer support?", "Yes, we provide ongoing support and maintenance.",
                     ImVec4(0.1f,0.1f,0.1f,1), ImVec4(0.4f,0.4f,0.4f,1), 18, 15, 600, false}
                };
                break;

            case SEC_CTA:
                name = "Call to Action";
                title = "Ready to Transform Your Business?";
                subtitle = "Join over 10,000 companies already growing with us";
                content = "Start your free 14-day trial today. No credit card required.";
                button_text = "Get Started Free";
                button_link = "#contact";
                height = 350;
                // Modern gradient background
                bg_color = ImVec4(0.37f, 0.51f, 0.99f, 1.0f);  // Modern blue
                title_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                subtitle_color = ImVec4(0.92f, 0.94f, 0.98f, 1.0f);
                content_color = ImVec4(0.88f, 0.91f, 0.96f, 1.0f);
                // Modern typography
                title_font_size = 52;
                title_font_weight = 800;
                subtitle_font_size = 22;
                subtitle_font_weight = 500;
                content_font_size = 18;
                content_font_weight = 400;
                // Modern glass button
                button_bg_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                button_text_color = ImVec4(0.37f, 0.51f, 0.99f, 1.0f);
                button_font_size = 18;
                button_font_weight = 700;
                button_glass_effect = false;
                button_glass_opacity = 0.25f;
                button_glass_tint = ImVec4(1.0f, 1.0f, 1.0f, 0.15f);
                padding = 80;
                animation_type = ANIM_ZOOM_IN;
                animation_duration = 0.8f;
                break;

            case SEC_STATS:
                name = "Statistics";
                title = "Our Numbers";
                height = 200;
                bg_color = ImVec4(0.1f, 0.15f, 0.25f, 1.0f);
                title_color = ImVec4(1,1,1,1);
                text_color = ImVec4(1,1,1,1);
                items = {
                    {"500+", "Projects", "", "", "", ImVec4(0,0,0,0), ImVec4(1,1,1,1), ImVec4(0.8f,0.8f,0.8f,1), 48, 16, 700, 400, 0, 0, 0,
                     false, 0.25f, 10.0f, ImVec4(0.1f,0.15f,0.25f,1), 15.0f, 1.5f, ImVec4(1,1,1,0.2f), true, 0.3f},
                    {"100+", "Clients", "", "", "", ImVec4(0,0,0,0), ImVec4(1,1,1,1), ImVec4(0.8f,0.8f,0.8f,1), 48, 16, 700, 400, 0, 0, 0,
                     false, 0.25f, 10.0f, ImVec4(0.1f,0.15f,0.25f,1), 15.0f, 1.5f, ImVec4(1,1,1,0.2f), true, 0.3f},
                    {"10+", "Years", "", "", "", ImVec4(0,0,0,0), ImVec4(1,1,1,1), ImVec4(0.8f,0.8f,0.8f,1), 48, 16, 700, 400, 0, 0, 0,
                     false, 0.25f, 10.0f, ImVec4(0.1f,0.15f,0.25f,1), 15.0f, 1.5f, ImVec4(1,1,1,0.2f), true, 0.3f},
                    {"24/7", "Support", "", "", "", ImVec4(0,0,0,0), ImVec4(1,1,1,1), ImVec4(0.8f,0.8f,0.8f,1), 48, 16, 700, 400, 0, 0, 0,
                     false, 0.25f, 10.0f, ImVec4(0.1f,0.15f,0.25f,1), 15.0f, 1.5f, ImVec4(1,1,1,0.2f), true, 0.3f}
                };
                break;

            case SEC_LOGIN:
                name = "Login Card";
                title = "LOGIN";
                height = 600;
                bg_color = ImVec4(0.1f, 0.15f, 0.25f, 1.0f);
                title_color = ImVec4(1,1,1,1);
                text_color = ImVec4(1,1,1,1);
                title_font_size = 32;
                title_font_weight = 600;
                use_bg_image = true;
                bg_overlay_opacity = 0.0f;
                break;

            case SEC_IMAGE:
                name = "Image";
                title = "";
                height = 300;  // Default height, will adjust based on image
                bg_color = ImVec4(0,0,0,0);  // Transparent background
                break;

            case SEC_TEXTBOX:
                name = "Text Box";
                title = "Your Title Here";
                subtitle = "Your subtitle here";
                content = "Add your text content here. You can write paragraphs, descriptions, or any text you want to display.";
                height = 400;
                bg_color = ImVec4(0.95f, 0.95f, 0.95f, 1.0f);  // Light gray
                title_color = ImVec4(0.1f, 0.1f, 0.1f, 1.0f);
                subtitle_color = ImVec4(0.3f, 0.3f, 0.3f, 1.0f);
                content_color = ImVec4(0.2f, 0.2f, 0.2f, 1.0f);
                title_font_size = 32;
                subtitle_font_size = 18;
                content_font_size = 16;
                title_font_weight = 700;
                subtitle_font_weight = 500;
                content_font_weight = 400;
                text_align = 0;  // Left aligned
                padding = 40;
                break;

            default:
                name = "Custom Section";
                title = "Section Title";
                height = 300;
                break;
        }
    }
};

// ============================================================================
// FIGMA-STYLE LAYER SYSTEM
// ============================================================================
enum LayerType {
    LAYER_DIV,          // Generic container
    LAYER_TEXT,         // Text element (heading, paragraph, span)
    LAYER_IMAGE,        // Image element
    LAYER_BUTTON,       // Button or link styled as button
    LAYER_ICON,         // SVG or icon
    LAYER_INPUT,        // Form input
    LAYER_VIDEO,        // Video element
    LAYER_SHAPE         // Decorative shape
};

struct WebLayer {
    int id;
    LayerType type;
    std::string name;

    // Position (absolute, in pixels from top-left of canvas)
    float x, y;
    float width, height;
    int z_index;

    // Content
    std::string text;
    std::string image_path;
    std::string href;
    GLuint texture_id;

    // Colors
    ImVec4 bg_color;
    ImVec4 text_color;
    ImVec4 border_color;

    // Typography
    float font_size;
    float font_weight;
    std::string font_family;
    int text_align;             // 0=left, 1=center, 2=right
    float line_height;
    float letter_spacing;

    // Box model
    float padding_top, padding_right, padding_bottom, padding_left;
    float margin_top, margin_right, margin_bottom, margin_left;

    // Border & shape
    float border_width;
    float border_radius;
    std::string border_style;   // "solid", "dashed", "none"

    // Effects
    float opacity;
    std::string box_shadow;
    bool has_gradient;
    std::string gradient_css;

    // State
    bool selected;
    bool hovered;
    bool dragging;
    bool resizing;
    int resize_handle;          // 0-7 for 8 handles around the element
    float drag_offset_x, drag_offset_y;

    // Visibility
    bool visible;
    bool locked;

    // Parent-child relationship (for grouping)
    int parent_id;              // -1 if root level
    std::vector<int> child_ids;

    WebLayer() : id(0), type(LAYER_DIV), name("Layer"),
        x(0), y(0), width(100), height(50), z_index(0),
        texture_id(0),
        bg_color(1,1,1,0), text_color(0,0,0,1), border_color(0,0,0,1),
        font_size(16), font_weight(400), font_family("system-ui"), text_align(0),
        line_height(1.5f), letter_spacing(0),
        padding_top(0), padding_right(0), padding_bottom(0), padding_left(0),
        margin_top(0), margin_right(0), margin_bottom(0), margin_left(0),
        border_width(0), border_radius(0), border_style("none"),
        opacity(1.0f), box_shadow("none"), has_gradient(false),
        selected(false), hovered(false), dragging(false), resizing(false),
        resize_handle(-1), drag_offset_x(0), drag_offset_y(0),
        visible(true), locked(false), parent_id(-1) {}
};

// Figma-style project data
struct FigmaProject {
    std::string name;
    float canvas_width;
    float canvas_height;
    ImVec4 canvas_bg_color;
    std::string screenshot_path;    // Original website screenshot for reference
    GLuint screenshot_texture_id;
    std::vector<WebLayer> layers;
    int next_layer_id;

    // Viewport state
    float scroll_x, scroll_y;
    float zoom;

    // Selection state
    std::vector<int> selected_layer_ids;
    bool multi_select;

    // Grid/guide settings
    bool show_grid;
    float grid_size;
    bool snap_to_grid;
    bool show_guides;
    std::vector<float> horizontal_guides;
    std::vector<float> vertical_guides;

    // Reference image overlay
    bool show_reference;
    float reference_opacity;

    FigmaProject() : name("Untitled"),
        canvas_width(1920), canvas_height(3000),
        canvas_bg_color(1,1,1,1),
        screenshot_texture_id(0),
        next_layer_id(1),
        scroll_x(0), scroll_y(0), zoom(0.5f),
        multi_select(false),
        show_grid(true), grid_size(10), snap_to_grid(true),
        show_guides(false),
        show_reference(true), reference_opacity(1.0f) {}
};

// ============================================================================
// GLOBAL STATE
// ============================================================================
static GLFWwindow* g_Window = nullptr;
static int g_NextSectionId = 1;
static int g_SelectedSectionIndex = -1;
static float g_CanvasScrollY = 0;
static float g_Zoom = 1.0f;
static std::string g_ProjectName = "My Website";
static std::string g_CurrentPage = "Home";
static int g_CurrentPageIndex = 0;
static std::string g_ExportPath = "";
static bool g_ShowExportSuccess = false;
static float g_ExportSuccessTimer = 0;

// Template system state
static bool g_ShowTemplateGallery = false;
static bool g_ShowSaveTemplate = false;
static char g_TemplateNameBuffer[256] = "";

// URL Import state
static bool g_ShowURLImportDialog = false;
static char g_URLImportBuffer[512] = "";
static std::string g_URLImportStatus = "";
static bool g_URLImportInProgress = false;
static float g_URLImportProgress = 0.0f;
static int g_URLImportTimeout = 300; // Timeout in seconds (default 5 minutes)
static bool g_URLImportUseStealth = false; // Use Stealth Browser MCP for anti-bot bypass

// Local Download Import state
static int g_ImportMethod = 0; // 0 = Live Scrape, 1 = Local Download, 2 = Figma-style
static std::string g_DownloadedSitePath = "";
static bool g_DownloadComplete = false;

// Figma-style Editor State
static bool g_FigmaMode = false;                    // True = Figma editor, False = Section editor
static FigmaProject g_FigmaProject;                 // Current Figma project
static int g_SelectedLayerId = -1;                  // Currently selected layer
static bool g_ShowFigmaLayers = true;               // Show layers panel
static bool g_ShowFigmaProperties = true;           // Show properties panel
static bool g_FigmaImportInProgress = false;        // Import in progress
static std::string g_FigmaImportStatus = "";        // Import status message

// Template Picker Modal State
static bool g_ShowTemplatePicker = false;
static SectionType g_PickerSectionType = SEC_HERO;
static int g_SelectedStyleIndex = -1;

// Section Drag-and-Drop State
static bool g_DraggingSection = false;
static int g_DraggedSectionIndex = -1;
static int g_DropTargetIndex = -1;
static float g_DragOffsetY = 0;

// Template Style Preset Structure
struct StylePreset {
    std::string name;
    std::string description;
    std::string preview_emoji;  // Visual indicator for style
};

// Style presets for each section type (5 variations each)
static const std::map<SectionType, std::vector<StylePreset>> g_StylePresets = {
    {SEC_HERO, {
        {"Modern Gradient", "Deep blue gradient with glass buttons and elegant typography", "🌊"},
        {"Minimalist Light", "Clean white background with subtle shadows and modern fonts", "✨"},
        {"Dark Premium", "Luxury dark background with gold accents and premium feel", "👑"},
        {"Colorful Creative", "Vibrant gradient with playful animations and bold colors", "🎨"},
        {"Corporate Professional", "Traditional blue and white with trustworthy design", "💼"}
    }},
    {SEC_CONTACT, {
        {"Luxury Glass Form", "Dark background with frosted glass inputs and gold labels", "💎"},
        {"Minimalist White", "Clean white form with simple borders and modern typography", "📝"},
        {"Corporate Professional", "Traditional blue form with structured layout", "🏢"},
        {"Creative Colorful", "Vibrant gradient background with playful form elements", "🎨"},
        {"Elegant Dark", "Deep dark background with elegant white form fields", "🌙"}
    }},
    {SEC_SERVICES, {
        {"Glass Morph Cards", "Frosted glass cards with blur effects and modern design", "💫"},
        {"Solid Modern Cards", "Clean solid color cards with sharp borders", "📦"},
        {"Gradient Cards", "Cards with beautiful gradient backgrounds", "🌈"},
        {"Icon-First Cards", "Large icons with minimal text and modern feel", "🎯"},
        {"List Style", "Simple list layout with dividers and clean spacing", "📋"}
    }},
    {SEC_PRICING, {
        {"3-Tier Glass", "Three pricing tiers with glass effect and highlighted popular plan", "⭐"},
        {"Minimal Cards", "Simple white cards with subtle shadows", "📄"},
        {"Bold Colored", "Vibrant colored cards with strong CTAs", "🎯"},
        {"Enterprise Dark", "Dark professional cards for B2B", "💼"},
        {"Comparison Table", "Side-by-side comparison layout", "📊"}
    }},
    {SEC_TEAM, {
        {"Colorful Avatars", "Team cards with vibrant colored accent borders", "👥"},
        {"Professional Cards", "Clean white cards with subtle shadows", "🏢"},
        {"Circle Photos", "Circular avatar photos with minimal design", "⭕"},
        {"Glass Cards", "Frosted glass effect cards", "💎"},
        {"Grid Layout", "Simple grid with hover effects", "📐"}
    }},
    {SEC_TESTIMONIALS, {
        {"Quote Cards", "Cards with large quote marks and elegant design", "💬"},
        {"Minimal White", "Clean white cards with customer photos", "✨"},
        {"Colored Accents", "Cards with colored left border accent", "🎨"},
        {"Glass Effect", "Frosted glass cards", "💫"},
        {"Slider Layout", "Horizontal scrolling testimonials", "📱"}
    }},
    {SEC_GALLERY, {
        {"2x2 Grid", "Four images in square grid layout (2 rows × 2 columns)", "⬛"},
        {"1x4 Horizontal", "Four images in horizontal row layout", "▬"}
    }},
    {SEC_ABOUT, {
        {"Story Format", "Narrative layout with timeline", "📖"},
        {"Stats & Facts", "Data-driven about section", "📊"},
        {"Mission & Vision", "Split layout with core values", "🎯"},
        {"Team Intro", "About with team preview", "👥"},
        {"Minimal Clean", "Simple text-focused layout", "✨"}
    }},
    {SEC_CTA, {
        {"Bold Gradient", "Eye-catching gradient with large button", "🚀"},
        {"Minimal White", "Clean white with simple CTA", "✨"},
        {"Dark Impact", "Dark background with bright CTA", "⚡"},
        {"Glass Effect", "Frosted glass panel", "💎"},
        {"Split Layout", "Text on left, form on right", "📐"}
    }},
    {SEC_FOOTER, {
        {"Multi-Column", "4-column footer with links and social", "📚"},
        {"Minimal", "Simple single-row footer", "➖"},
        {"Newsletter", "Footer with newsletter signup", "📧"},
        {"Social Focus", "Large social icons and minimal text", "🔗"},
        {"Dark Premium", "Dark elegant footer", "🌙"}
    }},
    {SEC_NAVBAR, {
        {"Modern Transparent", "Transparent navbar with blur effect", "💎"},
        {"Solid White", "Clean white navbar with shadow", "📄"},
        {"Dark Professional", "Dark navbar with high contrast", "🌙"},
        {"Colorful Gradient", "Gradient background navbar", "🌈"},
        {"Minimal Border", "Simple with bottom border only", "➖"}
    }},
    {SEC_CARDS, {
        {"Glass Cards", "Frosted glass effect cards", "💎"},
        {"Modern White", "Clean white cards with shadows", "📄"},
        {"Colorful Gradient", "Vibrant gradient backgrounds", "🌈"},
        {"Minimal Border", "Simple bordered cards", "📐"},
        {"Dark Theme", "Dark cards with light text", "🌙"}
    }},
    {SEC_BLOG, {
        {"Magazine Style", "Large featured images with excerpts", "📰"},
        {"Minimal Cards", "Simple text-focused cards", "📝"},
        {"Grid Layout", "Equal-sized grid of posts", "📐"},
        {"Timeline", "Chronological timeline layout", "📅"},
        {"List View", "Full-width list with thumbnails", "📋"}
    }},
    {SEC_FAQ, {
        {"Accordion Style", "Expandable question cards", "📖"},
        {"Two Column", "Questions in two columns", "📐"},
        {"Minimal List", "Simple Q&A list", "📝"},
        {"Card Style", "Each FAQ in a card", "💳"},
        {"Search & Filter", "With search functionality", "🔍"}
    }},
    {SEC_STATS, {
        {"Big Numbers", "Large statistics with icons", "📊"},
        {"Counter Animation", "Animated counting numbers", "🔢"},
        {"Chart Style", "With progress bars", "📈"},
        {"Minimal Cards", "Clean stat cards", "💳"},
        {"Colorful Gradient", "Vibrant background stats", "🌈"}
    }},
    {SEC_LOGIN, {
        {"Luxury Glass", "Dark with glass effect", "💎"},
        {"Minimal White", "Clean white form", "📄"},
        {"Corporate Blue", "Professional blue theme", "🏢"},
        {"Gradient Background", "Colorful gradient", "🌈"},
        {"Split Screen", "Image on left, form on right", "📐"}
    }},
    {SEC_FEATURES, {
        {"Icon Grid", "Grid layout with icons and descriptions", "🎯"},
        {"List Style", "Vertical list with checkmarks", "✅"},
        {"Highlighted Cards", "Feature cards with accents", "💎"},
        {"Timeline View", "Features in timeline format", "📅"},
        {"Comparison Table", "Side-by-side feature comparison", "📊"}
    }},
    {SEC_CUSTOM, {
        {"Modern Default", "Modern clean layout", "✨"},
        {"Minimal", "Simple and minimal", "➖"},
        {"Colorful", "Vibrant and bold", "🎨"},
        {"Professional", "Corporate and trustworthy", "💼"},
        {"Creative", "Unique and artistic", "🎭"}
    }},
    {SEC_IMAGE, {
        {"Full Width", "Large full-width image", "🖼️"},
        {"Centered", "Centered image with padding", "📷"},
        {"Rounded Corners", "Image with rounded edges", "⭕"},
        {"With Shadow", "Image with drop shadow", "✨"},
        {"Minimal Border", "Simple bordered image", "📐"}
    }},
    {SEC_TEXTBOX, {
        {"Modern Card", "Text in modern card layout", "📝"},
        {"Minimal White", "Clean white background", "✨"},
        {"Gradient Background", "Vibrant gradient", "🌈"},
        {"Glass Effect", "Frosted glass card", "💎"},
        {"Bordered Style", "Simple bordered box", "📐"}
    }}
};

static char g_TemplateDescBuffer[512] = "";
struct TemplateInfo {
    std::string name;
    std::string filename;
    std::string description;
    std::string created_date;
};
static std::vector<TemplateInfo> g_AvailableTemplates;

// ============================================================================
// TEMPLATE SYSTEM - Save/Load Website Templates
// ============================================================================

// Helper: Escape string for JSON
std::string JsonEscape(const std::string& str) {
    std::string escaped;
    for (char c : str) {
        switch (c) {
            case '\"': escaped += "\\\""; break;
            case '\\': escaped += "\\\\"; break;
            case '\b': escaped += "\\b"; break;
            case '\f': escaped += "\\f"; break;
            case '\n': escaped += "\\n"; break;
            case '\r': escaped += "\\r"; break;
            case '\t': escaped += "\\t"; break;
            default: escaped += c; break;
        }
    }
    return escaped;
}

// Helper: Color to JSON
std::string ColorToJson(const ImVec4& color) {
    char buf[128];
    snprintf(buf, sizeof(buf), "{\"r\":%.3f,\"g\":%.3f,\"b\":%.3f,\"a\":%.3f}",
             color.x, color.y, color.z, color.w);
    return buf;
}

// Helper: JSON to Color
ImVec4 JsonToColor(const std::string& json) {
    ImVec4 color(1, 1, 1, 1);
    sscanf(json.c_str(), "{\"r\":%f,\"g\":%f,\"b\":%f,\"a\":%f}",
           &color.x, &color.y, &color.z, &color.w);
    return color;
}

// Save current website as a template
bool SaveTemplate(const std::string& name, const std::string& description) {
    // If using database, save to PostgreSQL
    if (g_UseDatabase && g_DBConnection) {
        // Insert or update template (PostgreSQL uses ON CONFLICT instead of ON DUPLICATE KEY)
        std::string query = "INSERT INTO templates (template_name, description, project_name) VALUES ('" +
            SQLEscape(name) + "', '" + SQLEscape(description) + "', '" + SQLEscape(g_ProjectName) + "') " +
            "ON CONFLICT (template_name) DO UPDATE SET description='" + SQLEscape(description) + "', " +
            "project_name='" + SQLEscape(g_ProjectName) + "', updated_date=NOW()";

        PGresult* result = PQexec(g_DBConnection, query.c_str());
        if (PQresultStatus(result) != PGRES_COMMAND_OK) {
            printf("Error inserting template: %s\n", PQerrorMessage(g_DBConnection));
            PQclear(result);
            return false;
        }
        PQclear(result);

        // Get template ID
        query = "SELECT id FROM templates WHERE template_name='" + SQLEscape(name) + "'";
        result = PQexec(g_DBConnection, query.c_str());
        if (PQresultStatus(result) != PGRES_TUPLES_OK) {
            printf("Error getting template ID: %s\n", PQerrorMessage(g_DBConnection));
            PQclear(result);
            return false;
        }

        int template_id = 0;
        if (PQntuples(result) > 0) {
            template_id = atoi(PQgetvalue(result, 0, 0));
        }
        PQclear(result);

        if (template_id == 0) return false;

        // Delete old sections for this template
        query = "DELETE FROM sections WHERE template_id=" + std::to_string(template_id);
        result = PQexec(g_DBConnection, query.c_str());
        PQclear(result);

        // Insert each section
        for (size_t i = 0; i < g_Sections.size(); i++) {
            const auto& sec = g_Sections[i];

            // Read image files as binary data
            std::vector<unsigned char> bg_image_data;
            std::vector<unsigned char> sec_image_data;

            if (!sec.background_image.empty()) {
                printf("Section '%s' has background_image path: '%s'\n", sec.name.c_str(), sec.background_image.c_str());
                bg_image_data = ReadImageFile(sec.background_image);
                if (!bg_image_data.empty()) {
                    printf("  -> Successfully read background image: %zu bytes\n", bg_image_data.size());
                } else {
                    printf("  -> Failed to read background image file!\n");
                }
            }

            if (!sec.section_image.empty()) {
                printf("Section '%s' has section_image path: '%s'\n", sec.name.c_str(), sec.section_image.c_str());
                sec_image_data = ReadImageFile(sec.section_image);
                if (!sec_image_data.empty()) {
                    printf("  -> Successfully read section image: %zu bytes\n", sec_image_data.size());
                } else {
                    printf("  -> Failed to read section image file!\n");
                }
            }

            std::ostringstream oss;
            oss << "INSERT INTO sections ("
                << "template_id, section_order, type, name, section_id, height, y_position, "
                << "title, subtitle, content, button_text, button_link, "
                << "title_font_size, title_font_weight, subtitle_font_size, subtitle_font_weight, "
                << "content_font_size, content_font_weight, button_font_size, button_font_weight, "
                << "nav_font_size, nav_font_weight, "
                << "title_color, subtitle_color, content_color, bg_color, text_color, "
                << "accent_color, button_bg_color, button_text_color, "
                << "nav_bg_color, nav_text_color, "
                << "padding, text_align, card_width, card_height, card_spacing, card_padding, cards_per_row, heading_to_cards_spacing, "
                << "background_image, background_image_data, section_image, section_image_data, "
                << "use_bg_image, bg_overlay_opacity, "
                << "section_width_percent, horizontal_align, use_manual_position, "
                << "hero_animation_images, hero_animation_images_data, enable_hero_animation, hero_animation_speed, "
                << "gallery_images, gallery_images_data, gallery_columns, gallery_spacing, "
                << "logo_path, logo_data, logo_size, brand_text_position, "
                << "animation_type, animation_duration, animation_delay, card_stagger_delay"
                << ") VALUES ("
                << template_id << ", " << i << ", " << (int)sec.type << ", "
                << "'" << SQLEscape(sec.name) << "', "
                << "'" << SQLEscape(sec.section_id) << "', "
                << sec.height << ", " << sec.y_position << ", "
                << "'" << SQLEscape(sec.title) << "', "
                << "'" << SQLEscape(sec.subtitle) << "', "
                << "'" << SQLEscape(sec.content) << "', "
                << "'" << SQLEscape(sec.button_text) << "', "
                << "'" << SQLEscape(sec.button_link) << "', "
                << sec.title_font_size << ", " << sec.title_font_weight << ", "
                << sec.subtitle_font_size << ", " << sec.subtitle_font_weight << ", "
                << sec.content_font_size << ", " << sec.content_font_weight << ", "
                << sec.button_font_size << ", " << sec.button_font_weight << ", "
                << sec.nav_font_size << ", " << sec.nav_font_weight << ", "
                << "'" << ColorToSQL(sec.title_color) << "', "
                << "'" << ColorToSQL(sec.subtitle_color) << "', "
                << "'" << ColorToSQL(sec.content_color) << "', "
                << "'" << ColorToSQL(sec.bg_color) << "', "
                << "'" << ColorToSQL(sec.text_color) << "', "
                << "'" << ColorToSQL(sec.accent_color) << "', "
                << "'" << ColorToSQL(sec.button_bg_color) << "', "
                << "'" << ColorToSQL(sec.button_text_color) << "', "
                << "'" << ColorToSQL(sec.nav_bg_color) << "', "
                << "'" << ColorToSQL(sec.nav_text_color) << "', "
                << sec.padding << ", " << sec.text_align << ", "
                << sec.card_width << ", " << sec.card_height << ", "
                << sec.card_spacing << ", " << sec.card_padding << ", " << sec.cards_per_row << ", " << sec.heading_to_cards_spacing << ", "
                << "'" << SQLEscape(sec.background_image) << "', "
                << (bg_image_data.empty() ? "NULL" : BinaryToHex(bg_image_data)) << ", "
                << "'" << SQLEscape(sec.section_image) << "', "
                << (sec_image_data.empty() ? "NULL" : BinaryToHex(sec_image_data)) << ", "
                << (sec.use_bg_image ? "TRUE" : "FALSE") << ", "
                << sec.bg_overlay_opacity << ", "
                << sec.section_width_percent << ", " << sec.horizontal_align << ", " << (sec.use_manual_position ? "TRUE" : "FALSE") << ", "
                << StringVectorToArray(sec.hero_animation_images) << ", "
                << ImageVectorToByteaArray(sec.hero_animation_images) << ", "
                << (sec.enable_hero_animation ? "TRUE" : "FALSE") << ", "
                << sec.hero_animation_speed << ", "
                << StringVectorToArray(sec.gallery_images) << ", "
                << ImageVectorToByteaArray(sec.gallery_images) << ", "
                << sec.gallery_columns << ", "
                << sec.gallery_spacing << ", "
                << "'" << SQLEscape(sec.logo_path) << "', "
                << (sec.logo_path.empty() ? "NULL" : BinaryToHex(ReadImageFile(sec.logo_path))) << ", "
                << sec.logo_size << ", "
                << sec.brand_text_position << ", "
                << (int)sec.animation_type << ", "
                << sec.animation_duration << ", "
                << sec.animation_delay << ", "
                << sec.card_stagger_delay
                << ")";

            PGresult* sec_result = PQexec(g_DBConnection, oss.str().c_str());
            if (PQresultStatus(sec_result) != PGRES_COMMAND_OK) {
                printf("Error inserting section: %s\n", PQerrorMessage(g_DBConnection));
                PQclear(sec_result);
                return false;
            }
            PQclear(sec_result);
        }

        printf("Template saved to database: %s\n", name.c_str());
        return true;
    }

    // Otherwise, save to JSON file
    std::string basePath = "/Users/imaging/Desktop/Website-Builder-v2.0/";
    std::string filename = basePath + "templates/" + name + ".json";

    std::ofstream file(filename);
    if (!file.is_open()) return false;

    // Get current date
    time_t now = time(0);
    char dateStr[64];
    strftime(dateStr, sizeof(dateStr), "%Y-%m-%d %H:%M:%S", localtime(&now));

    file << "{\n";
    file << "  \"template_name\": \"" << JsonEscape(name) << "\",\n";
    file << "  \"description\": \"" << JsonEscape(description) << "\",\n";
    file << "  \"created_date\": \"" << dateStr << "\",\n";
    file << "  \"project_name\": \"" << JsonEscape(g_ProjectName) << "\",\n";
    file << "  \"sections\": [\n";

    for (size_t i = 0; i < g_Sections.size(); i++) {
        const auto& sec = g_Sections[i];
        file << "    {\n";
        file << "      \"id\": " << sec.id << ",\n";
        file << "      \"type\": " << (int)sec.type << ",\n";
        file << "      \"name\": \"" << JsonEscape(sec.name) << "\",\n";
        file << "      \"section_id\": \"" << JsonEscape(sec.section_id) << "\",\n";
        file << "      \"height\": " << sec.height << ",\n";
        file << "      \"title\": \"" << JsonEscape(sec.title) << "\",\n";
        file << "      \"subtitle\": \"" << JsonEscape(sec.subtitle) << "\",\n";
        file << "      \"content\": \"" << JsonEscape(sec.content) << "\",\n";
        file << "      \"button_text\": \"" << JsonEscape(sec.button_text) << "\",\n";
        file << "      \"button_link\": \"" << JsonEscape(sec.button_link) << "\",\n";
        file << "      \"title_font_size\": " << sec.title_font_size << ",\n";
        file << "      \"subtitle_font_size\": " << sec.subtitle_font_size << ",\n";
        file << "      \"content_font_size\": " << sec.content_font_size << ",\n";
        file << "      \"title_font_weight\": " << sec.title_font_weight << ",\n";
        file << "      \"subtitle_font_weight\": " << sec.subtitle_font_weight << ",\n";
        file << "      \"content_font_weight\": " << sec.content_font_weight << ",\n";
        file << "      \"title_color\": " << ColorToJson(sec.title_color) << ",\n";
        file << "      \"subtitle_color\": " << ColorToJson(sec.subtitle_color) << ",\n";
        file << "      \"content_color\": " << ColorToJson(sec.content_color) << ",\n";
        file << "      \"bg_color\": " << ColorToJson(sec.bg_color) << ",\n";
        file << "      \"text_color\": " << ColorToJson(sec.text_color) << ",\n";
        file << "      \"accent_color\": " << ColorToJson(sec.accent_color) << ",\n";
        file << "      \"button_bg_color\": " << ColorToJson(sec.button_bg_color) << ",\n";
        file << "      \"button_text_color\": " << ColorToJson(sec.button_text_color) << ",\n";
        file << "      \"button_font_size\": " << sec.button_font_size << ",\n";
        file << "      \"button_font_weight\": " << sec.button_font_weight << ",\n";
        file << "      \"padding\": " << sec.padding << ",\n";
        file << "      \"text_align\": " << sec.text_align << ",\n";
        file << "      \"nav_font_size\": " << sec.nav_font_size << ",\n";
        file << "      \"nav_font_weight\": " << sec.nav_font_weight << ",\n";
        file << "      \"card_width\": " << sec.card_width << ",\n";
        file << "      \"card_height\": " << sec.card_height << ",\n";
        file << "      \"card_spacing\": " << sec.card_spacing << ",\n";
        file << "      \"cards_per_row\": " << sec.cards_per_row << ",\n";
        file << "      \"background_image\": \"" << JsonEscape(sec.background_image) << "\",\n";
        file << "      \"section_image\": \"" << JsonEscape(sec.section_image) << "\",\n";
        file << "      \"use_bg_image\": " << (sec.use_bg_image ? "true" : "false") << ",\n";
        file << "      \"bg_overlay_opacity\": " << sec.bg_overlay_opacity << "\n";
        file << "    }" << (i < g_Sections.size() - 1 ? "," : "") << "\n";
    }

    file << "  ]\n";
    file << "}\n";
    file.close();

    return true;
}

// ============================================================================
// CSS PARSING HELPER FUNCTIONS
// ============================================================================

// Helper function to extract a JSON string value
std::string ExtractJSONValue(const std::string& json, const std::string& key) {
    std::string search = "\"" + key + "\"";
    size_t pos = json.find(search);
    if (pos == std::string::npos) return "";

    // Find the colon after the key
    pos = json.find(':', pos);
    if (pos == std::string::npos) return "";
    pos++;

    // Skip whitespace
    while (pos < json.size() && (json[pos] == ' ' || json[pos] == '\t' || json[pos] == '\n')) pos++;

    // Extract value (handle strings with quotes and values without quotes)
    if (json[pos] == '"') {
        pos++;  // Skip opening quote
        size_t end = json.find('"', pos);
        if (end == std::string::npos) return "";
        return json.substr(pos, end - pos);
    } else {
        // Number or keyword (true/false/null)
        size_t end = pos;
        while (end < json.size() && json[end] != ',' && json[end] != '}' && json[end] != '\n') end++;
        std::string value = json.substr(pos, end - pos);
        // Trim whitespace
        size_t trimEnd = value.find_last_not_of(" \t\n\r");
        if (trimEnd != std::string::npos) value = value.substr(0, trimEnd + 1);
        return value;
    }
}

// ============================================================================
// CSS VALUE PARSING UTILITIES
// ============================================================================

// Parse CSS line-height value (e.g., "normal", "1.6", "24px") and return as float multiplier
float ParseLineHeight(const std::string& value, float fontSize) {
    if (value.empty() || value == "normal") return 1.2f;  // Default line-height

    // If it's a number without units (e.g., "1.6"), use it as multiplier
    if (value.find("px") == std::string::npos && value.find("%") == std::string::npos) {
        float multiplier = (float)atof(value.c_str());
        return (multiplier > 0.5f && multiplier < 5.0f) ? multiplier : 1.2f;
    }

    // If it has "px", convert to multiplier based on fontSize
    if (value.find("px") != std::string::npos) {
        float pixels = (float)atof(value.c_str());
        return pixels / fontSize;
    }

    return 1.2f;  // Default
}

// Parse CSS letter-spacing value (e.g., "normal", "0.5px", "0.05em") and return pixels
float ParseLetterSpacing(const std::string& value, float fontSize) {
    if (value.empty() || value == "normal") return 0.0f;

    // If it has "px"
    if (value.find("px") != std::string::npos) {
        return (float)atof(value.c_str());
    }

    // If it has "em"
    if (value.find("em") != std::string::npos) {
        float em = (float)atof(value.c_str());
        return em * fontSize;
    }

    return 0.0f;
}

// Parse background-position (e.g., "center center", "50% 50%", "left top")
void ParseBackgroundPosition(const std::string& value, float& xPercent, float& yPercent) {
    // Default to center
    xPercent = 0.5f;
    yPercent = 0.5f;

    if (value.empty() || value == "0% 0%") {
        xPercent = 0.0f;
        yPercent = 0.0f;
        return;
    }

    // Parse "center", "left", "right", "top", "bottom", or percentages
    if (value.find("center") != std::string::npos) {
        xPercent = 0.5f;
        yPercent = 0.5f;
    } else if (value.find("left") != std::string::npos) {
        xPercent = 0.0f;
    } else if (value.find("right") != std::string::npos) {
        xPercent = 1.0f;
    }

    if (value.find("top") != std::string::npos) {
        yPercent = 0.0f;
    } else if (value.find("bottom") != std::string::npos) {
        yPercent = 1.0f;
    }

    // Try to parse percentages (e.g., "50% 75%")
    size_t firstPercent = value.find('%');
    if (firstPercent != std::string::npos) {
        // Find start of number
        size_t start = 0;
        while (start < firstPercent && !isdigit(value[start]) && value[start] != '-') start++;
        if (start < firstPercent) {
            xPercent = (float)atof(value.substr(start).c_str()) / 100.0f;
        }

        // Find second percentage
        size_t secondPercent = value.find('%', firstPercent + 1);
        if (secondPercent != std::string::npos) {
            start = firstPercent + 1;
            while (start < secondPercent && !isdigit(value[start]) && value[start] != '-') start++;
            if (start < secondPercent) {
                yPercent = (float)atof(value.substr(start).c_str()) / 100.0f;
            }
        }
    }
}

// Parse CSS gradient string and extract colors
// Supports: linear-gradient(to right, #667eea 0%, #764ba2 100%)
bool ParseGradient(const std::string& gradientStr, std::vector<ImVec4>& colors, bool& isRadial, float& angle) {
    if (gradientStr.empty() || gradientStr == "none") return false;

    // Detect gradient type
    isRadial = (gradientStr.find("radial") != std::string::npos);
    angle = 0.0f; // Default: top to bottom (0 degrees)

    // Parse direction for linear gradients
    if (!isRadial) {
        if (gradientStr.find("to right") != std::string::npos) angle = 90.0f;
        else if (gradientStr.find("to left") != std::string::npos) angle = 270.0f;
        else if (gradientStr.find("to bottom") != std::string::npos) angle = 180.0f;
        else if (gradientStr.find("to top") != std::string::npos) angle = 0.0f;
        else if (gradientStr.find("to bottom right") != std::string::npos) angle = 135.0f;
        else if (gradientStr.find("to bottom left") != std::string::npos) angle = 225.0f;

        // Parse degree angle (e.g., "45deg")
        size_t degPos = gradientStr.find("deg");
        if (degPos != std::string::npos) {
            size_t start = degPos;
            while (start > 0 && (isdigit(gradientStr[start-1]) || gradientStr[start-1] == '.')) start--;
            if (start < degPos) {
                angle = (float)atof(gradientStr.substr(start, degPos - start).c_str());
            }
        }
    }

    // Extract colors (look for rgb/rgba/hex patterns)
    colors.clear();

    // Find all rgb/rgba color values
    size_t pos = 0;
    while ((pos = gradientStr.find("rgb", pos)) != std::string::npos) {
        size_t start = pos;
        size_t end = gradientStr.find(')', start);
        if (end == std::string::npos) break;

        std::string colorStr = gradientStr.substr(start, end - start + 1);
        ImVec4 color = SQLToColor(colorStr);
        colors.push_back(color);

        pos = end + 1;
    }

    // Parse hex colors (#667eea)
    pos = 0;
    while ((pos = gradientStr.find('#', pos)) != std::string::npos) {
        if (pos + 7 <= gradientStr.size()) {
            std::string hexStr = gradientStr.substr(pos, 7); // #RRGGBB

            // Simple hex parser
            if (hexStr.length() == 7) {
                int r, g, b;
                if (sscanf(hexStr.c_str(), "#%02x%02x%02x", &r, &g, &b) == 3) {
                    ImVec4 color(r / 255.0f, g / 255.0f, b / 255.0f, 1.0f);
                    colors.push_back(color);
                }
            }
        }
        pos++;
    }

    return !colors.empty();
}

// Calculate UV coordinates for background-size: cover
// This scales the image to fill the area while maintaining aspect ratio (cropping overflow)
void CalculateCoverUV(float containerW, float containerH, float imageW, float imageH,
                      float posX, float posY, ImVec2& uv0, ImVec2& uv1) {
    if (imageW <= 0 || imageH <= 0 || containerW <= 0 || containerH <= 0) {
        uv0 = ImVec2(0, 0);
        uv1 = ImVec2(1, 1);
        return;
    }

    float containerAspect = containerW / containerH;
    float imageAspect = imageW / imageH;

    float scaleX, scaleY;

    if (containerAspect > imageAspect) {
        // Container is wider than image - scale to width
        scaleX = 1.0f;
        scaleY = imageAspect / containerAspect;
    } else {
        // Container is taller than image - scale to height
        scaleX = containerAspect / imageAspect;
        scaleY = 1.0f;
    }

    // Apply background-position to center the visible part
    float offsetX = (1.0f - scaleX) * posX;
    float offsetY = (1.0f - scaleY) * posY;

    uv0 = ImVec2(offsetX, offsetY);
    uv1 = ImVec2(offsetX + scaleX, offsetY + scaleY);
}

// ============================================================================
// CSS PARSING FUNCTIONS
// ============================================================================

// Parse CSS JSON data and populate WebSection CSS properties
void ParseCSSData(WebSection& sec, const std::string& css_json) {
    if (css_json.empty() || css_json == "null") return;

    // Extract button CSS properties
    sec.button_border_radius = std::max(0.0f, (float)atof(ExtractJSONValue(css_json, "borderRadius").c_str()));
    sec.button_border_width = std::max(0.0f, (float)atof(ExtractJSONValue(css_json, "borderWidth").c_str()));

    std::string borderColor = ExtractJSONValue(css_json, "borderColor");
    if (!borderColor.empty() && borderColor.find("rgb") != std::string::npos) {
        sec.button_border_color = SQLToColor(borderColor);
    }

    sec.button_box_shadow = ExtractJSONValue(css_json, "boxShadow");
    if (sec.button_box_shadow.empty()) sec.button_box_shadow = "none";

    sec.button_padding = ExtractJSONValue(css_json, "padding");
    if (sec.button_padding.empty()) sec.button_padding = "10px 20px";

    // Extract section CSS properties (look for these after "section": marker)
    size_t section_marker = css_json.find("\"section\"");
    if (section_marker != std::string::npos) {
        std::string section_json = css_json.substr(section_marker);

        sec.section_border_radius = std::max(0.0f, (float)atof(ExtractJSONValue(section_json, "borderRadius").c_str()));
        sec.section_box_shadow = ExtractJSONValue(section_json, "boxShadow");
        if (sec.section_box_shadow.empty()) sec.section_box_shadow = "none";

        sec.section_border = ExtractJSONValue(section_json, "border");
        if (sec.section_border.empty()) sec.section_border = "none";

        std::string opacity_str = ExtractJSONValue(section_json, "opacity");
        if (!opacity_str.empty()) {
            sec.section_opacity = std::max(0.0f, std::min(1.0f, (float)atof(opacity_str.c_str())));
        }

        sec.section_line_height = ExtractJSONValue(section_json, "lineHeight");
        if (sec.section_line_height.empty()) sec.section_line_height = "normal";

        sec.section_letter_spacing = ExtractJSONValue(section_json, "letterSpacing");
        if (sec.section_letter_spacing.empty()) sec.section_letter_spacing = "normal";
    }
}

// Parse interactive_data JSON to load card items
void ParseInteractiveData(WebSection& sec, const std::string& json) {
    if (json.empty() || json == "null") return;

    // Look for "cards" array in JSON
    size_t cards_pos = json.find("\"cards\"");
    if (cards_pos == std::string::npos) return;

    // Find the opening bracket of the cards array
    size_t array_start = json.find('[', cards_pos);
    if (array_start == std::string::npos) return;

    // Parse each card item (simple manual parsing)
    size_t pos = array_start + 1;
    int card_count = 0;

    while (pos < json.size() && card_count < 12) {  // Limit to 12 cards
        // Find next card object
        size_t obj_start = json.find('{', pos);
        if (obj_start == std::string::npos) break;

        size_t obj_end = json.find('}', obj_start);
        if (obj_end == std::string::npos) break;

        std::string card_json = json.substr(obj_start, obj_end - obj_start + 1);

        // Create card item
        WebSection::CardItem card;
        card.title = ExtractJSONValue(card_json, "title");
        card.description = ExtractJSONValue(card_json, "description");
        card.link = ExtractJSONValue(card_json, "link");

        // Extract colors
        std::string bgColor = ExtractJSONValue(card_json, "bg_color");
        if (!bgColor.empty() && bgColor.find("rgb") != std::string::npos) {
            card.bg_color = SQLToColor(bgColor);
        } else {
            card.bg_color = ImVec4(1, 1, 1, 1);
        }

        std::string titleColor = ExtractJSONValue(card_json, "text_color");
        if (!titleColor.empty() && titleColor.find("rgb") != std::string::npos) {
            card.title_color = SQLToColor(titleColor);
        } else {
            card.title_color = ImVec4(0, 0, 0, 1);
        }

        card.desc_color = card.title_color;

        // Extract font sizes
        std::string titleSize = ExtractJSONValue(card_json, "title_font_size");
        card.title_font_size = titleSize.empty() ? 16.0f : (float)atof(titleSize.c_str());

        std::string titleWeight = ExtractJSONValue(card_json, "title_font_weight");
        card.title_font_weight = titleWeight.empty() ? 500.0f : (float)atof(titleWeight.c_str());

        card.desc_font_size = 14.0f;
        card.desc_font_weight = 400.0f;

        // Set default dimensions
        card.width = sec.card_width;
        card.height = sec.card_height;

        sec.items.push_back(card);
        card_count++;

        pos = obj_end + 1;

        // Check if there are more cards
        size_t comma = json.find(',', pos);
        if (comma == std::string::npos || comma > json.find(']', pos)) break;
        pos = comma + 1;
    }

    // Parse paragraphs array
    size_t paragraphs_pos = json.find("\"paragraphs\"");
    if (paragraphs_pos != std::string::npos) {
        size_t para_array_start = json.find('[', paragraphs_pos);
        if (para_array_start != std::string::npos) {
            size_t para_pos = para_array_start + 1;
            int para_count = 0;

            while (para_pos < json.size() && para_count < 10) {  // Limit to 10 paragraphs
                size_t obj_start = json.find('{', para_pos);
                if (obj_start == std::string::npos) break;

                size_t obj_end = json.find('}', obj_start);
                if (obj_end == std::string::npos) break;

                std::string para_json = json.substr(obj_start, obj_end - obj_start + 1);

                // Create paragraph
                WebSection::Paragraph para;
                para.text = ExtractJSONValue(para_json, "text");

                std::string fontSize = ExtractJSONValue(para_json, "fontSize");
                para.font_size = fontSize.empty() ? 16.0f : (float)atof(fontSize.c_str());

                std::string fontWeight = ExtractJSONValue(para_json, "fontWeight");
                para.font_weight = fontWeight.empty() ? 400.0f : (float)atof(fontWeight.c_str());

                std::string color = ExtractJSONValue(para_json, "color");
                if (!color.empty() && color.find("rgb") != std::string::npos) {
                    para.color = SQLToColor(color);
                } else {
                    para.color = ImVec4(0, 0, 0, 1);
                }

                para.font_family = ExtractJSONValue(para_json, "fontFamily");

                if (!para.text.empty()) {
                    sec.paragraphs.push_back(para);
                    para_count++;
                }

                para_pos = obj_end + 1;

                // Check if there are more paragraphs
                size_t comma = json.find(',', para_pos);
                if (comma == std::string::npos || comma > json.find(']', para_pos)) break;
                para_pos = comma + 1;
            }
        }
    }

    // Parse nav_items array (for navbar sections)
    size_t nav_items_pos = json.find("\"nav_items\"");
    if (nav_items_pos != std::string::npos) {
        size_t nav_array_start = json.find('[', nav_items_pos);
        if (nav_array_start != std::string::npos) {
            size_t nav_pos = nav_array_start + 1;
            int nav_count = 0;

            while (nav_pos < json.size() && nav_count < 10) {  // Limit to 10 nav items
                size_t obj_start = json.find('{', nav_pos);
                if (obj_start == std::string::npos) break;

                size_t obj_end = json.find('}', obj_start);
                if (obj_end == std::string::npos) break;

                std::string nav_json = json.substr(obj_start, obj_end - obj_start + 1);

                // Create nav item
                WebSection::NavItem nav;
                nav.label = ExtractJSONValue(nav_json, "text");
                nav.link = ExtractJSONValue(nav_json, "href");

                std::string fontSize = ExtractJSONValue(nav_json, "fontSize");
                nav.font_size = fontSize.empty() ? 16.0f : (float)atof(fontSize.c_str());

                std::string fontWeight = ExtractJSONValue(nav_json, "fontWeight");
                nav.font_weight = fontWeight.empty() ? 400.0f : (float)atof(fontWeight.c_str());

                std::string color = ExtractJSONValue(nav_json, "color");
                if (!color.empty() && color.find("rgb") != std::string::npos) {
                    nav.text_color = SQLToColor(color);
                } else {
                    nav.text_color = ImVec4(0, 0, 0, 1);
                }

                if (!nav.label.empty()) {
                    sec.nav_items.push_back(nav);
                    nav_count++;
                }

                nav_pos = obj_end + 1;

                // Check if there are more nav items
                size_t comma = json.find(',', nav_pos);
                if (comma == std::string::npos || comma > json.find(']', nav_pos)) break;
                nav_pos = comma + 1;
            }
        }
    }

    // Parse gallery_images array (for gallery sections)
    size_t gallery_pos = json.find("\"gallery_images\"");
    if (gallery_pos != std::string::npos) {
        size_t gallery_array_start = json.find('[', gallery_pos);
        if (gallery_array_start != std::string::npos) {
            size_t gal_pos = gallery_array_start + 1;
            int gal_count = 0;

            while (gal_pos < json.size() && gal_count < 12) {  // Limit to 12 gallery images
                size_t obj_start = json.find('{', gal_pos);
                if (obj_start == std::string::npos) break;

                size_t obj_end = json.find('}', obj_start);
                if (obj_end == std::string::npos) break;

                std::string gal_json = json.substr(obj_start, obj_end - obj_start + 1);

                // Extract image src
                std::string src = ExtractJSONValue(gal_json, "src");
                if (!src.empty()) {
                    sec.gallery_images.push_back(src);
                    gal_count++;
                }

                gal_pos = obj_end + 1;

                // Check if there are more gallery images
                size_t comma = json.find(',', gal_pos);
                if (comma == std::string::npos || comma > json.find(']', gal_pos)) break;
                gal_pos = comma + 1;
            }
        }
    }

    // Parse hero_animation_images array (for hero sections)
    size_t hero_anim_pos = json.find("\"hero_animation_images\"");
    if (hero_anim_pos != std::string::npos) {
        size_t hero_array_start = json.find('[', hero_anim_pos);
        if (hero_array_start != std::string::npos) {
            size_t hero_pos = hero_array_start + 1;
            int hero_count = 0;

            while (hero_pos < json.size() && hero_count < 5) {  // Limit to 5 hero animation images
                // Find next string value (images are stored as simple strings in array)
                size_t str_start = json.find('"', hero_pos);
                if (str_start == std::string::npos || str_start > json.find(']', hero_pos)) break;

                size_t str_end = json.find('"', str_start + 1);
                if (str_end == std::string::npos) break;

                std::string img_url = json.substr(str_start + 1, str_end - str_start - 1);
                if (!img_url.empty()) {
                    sec.hero_animation_images.push_back(img_url);
                    hero_count++;
                }

                hero_pos = str_end + 1;

                // Check if there are more images
                size_t comma = json.find(',', hero_pos);
                if (comma == std::string::npos || comma > json.find(']', hero_pos)) break;
                hero_pos = comma + 1;
            }

            // Enable hero animation if we have multiple images
            if (sec.hero_animation_images.size() > 1) {
                sec.enable_hero_animation = true;

                // Extract animation speed
                std::string speed = ExtractJSONValue(json, "hero_animation_speed");
                sec.hero_animation_speed = speed.empty() ? 2.0f : (float)atof(speed.c_str());
            }
        }
    }
}

// Parse layout_data JSON to load spacing, flexbox, grid, and positioning properties
void ParseLayoutData(WebSection& sec, const std::string& json) {
    if (json.empty() || json == "null") return;

    // Parse padding (4-sided)
    size_t padding_pos = json.find("\"padding\"");
    if (padding_pos != std::string::npos) {
        std::string top = ExtractJSONValue(json.substr(padding_pos), "top");
        std::string right = ExtractJSONValue(json.substr(padding_pos), "right");
        std::string bottom = ExtractJSONValue(json.substr(padding_pos), "bottom");
        std::string left = ExtractJSONValue(json.substr(padding_pos), "left");

        if (!top.empty()) sec.padding_top = std::max(0.0f, (float)atof(top.c_str()));
        if (!right.empty()) sec.padding_right = std::max(0.0f, (float)atof(right.c_str()));
        if (!bottom.empty()) sec.padding_bottom = std::max(0.0f, (float)atof(bottom.c_str()));
        if (!left.empty()) sec.padding_left = std::max(0.0f, (float)atof(left.c_str()));
    }

    // Parse flexbox properties
    size_t flexbox_pos = json.find("\"flexbox\"");
    if (flexbox_pos != std::string::npos) {
        std::string flexbox_json = json.substr(flexbox_pos);

        sec.display = ExtractJSONValue(flexbox_json, "display");
        if (sec.display.empty()) sec.display = "block";

        sec.flex_direction = ExtractJSONValue(flexbox_json, "flexDirection");
        if (sec.flex_direction.empty()) sec.flex_direction = "row";

        sec.justify_content = ExtractJSONValue(flexbox_json, "justifyContent");
        if (sec.justify_content.empty()) sec.justify_content = "normal";

        sec.align_items = ExtractJSONValue(flexbox_json, "alignItems");
        if (sec.align_items.empty()) sec.align_items = "normal";

        std::string gap_str = ExtractJSONValue(flexbox_json, "gap");
        if (!gap_str.empty()) sec.gap = std::max(0.0f, (float)atof(gap_str.c_str()));
    }

    // Parse grid properties
    size_t grid_pos = json.find("\"grid\"");
    if (grid_pos != std::string::npos) {
        std::string grid_json = json.substr(grid_pos);

        sec.grid_template_columns = ExtractJSONValue(grid_json, "gridTemplateColumns");
        if (sec.grid_template_columns.empty()) sec.grid_template_columns = "none";

        sec.grid_template_rows = ExtractJSONValue(grid_json, "gridTemplateRows");
        if (sec.grid_template_rows.empty()) sec.grid_template_rows = "none";
    }

    // Parse background positioning
    size_t bg_pos = json.find("\"background\"");
    if (bg_pos != std::string::npos) {
        std::string bg_json = json.substr(bg_pos);

        sec.background_position = ExtractJSONValue(bg_json, "backgroundPosition");
        if (sec.background_position.empty()) sec.background_position = "0% 0%";

        sec.background_repeat = ExtractJSONValue(bg_json, "backgroundRepeat");
        if (sec.background_repeat.empty()) sec.background_repeat = "repeat";

        sec.background_size = ExtractJSONValue(bg_json, "backgroundSize");
        if (sec.background_size.empty()) sec.background_size = "auto";

        sec.background_image_css = ExtractJSONValue(bg_json, "backgroundImage");
        if (sec.background_image_css.empty()) sec.background_image_css = "none";

        // Parse gradients from background-image
        if (sec.background_image_css.find("gradient") != std::string::npos) {
            float gradientAngle = 0.0f;
            sec.has_gradient = ParseGradient(sec.background_image_css, sec.gradient_colors,
                                            sec.gradient_is_radial, gradientAngle);
        }
    }

    // Parse position properties (for overlays)
    size_t pos_pos = json.find("\"position\"");
    if (pos_pos != std::string::npos) {
        std::string pos_json = json.substr(pos_pos);

        sec.css_position = ExtractJSONValue(pos_json, "position");
        if (sec.css_position.empty()) sec.css_position = "static";

        sec.css_top = ExtractJSONValue(pos_json, "top");
        if (sec.css_top.empty()) sec.css_top = "auto";

        sec.css_left = ExtractJSONValue(pos_json, "left");
        if (sec.css_left.empty()) sec.css_left = "auto";

        sec.css_right = ExtractJSONValue(pos_json, "right");
        if (sec.css_right.empty()) sec.css_right = "auto";

        sec.css_bottom = ExtractJSONValue(pos_json, "bottom");
        if (sec.css_bottom.empty()) sec.css_bottom = "auto";

        std::string z_str = ExtractJSONValue(pos_json, "zIndex");
        if (!z_str.empty() && z_str != "auto") sec.css_z_index = atoi(z_str.c_str());
    }

    // Parse typography
    size_t typo_pos = json.find("\"typography\"");
    if (typo_pos != std::string::npos) {
        std::string typo_json = json.substr(typo_pos);

        sec.font_family = ExtractJSONValue(typo_json, "fontFamily");
        if (sec.font_family.empty()) sec.font_family = "system-ui";
    }
}

// Load all available templates
void LoadAvailableTemplates() {
    g_AvailableTemplates.clear();

    // If using database, load from PostgreSQL
    if (g_UseDatabase && g_DBConnection) {
        std::string query = "SELECT template_name, description, created_date FROM templates ORDER BY created_date DESC";
        PGresult* result = PQexec(g_DBConnection, query.c_str());
        if (PQresultStatus(result) != PGRES_TUPLES_OK) {
            printf("Error loading templates: %s\n", PQerrorMessage(g_DBConnection));
            PQclear(result);
            return;
        }

        int nrows = PQntuples(result);
        for (int row_num = 0; row_num < nrows; row_num++) {
            TemplateInfo info;
            info.name = PQgetisnull(result, row_num, 0) ? "" : PQgetvalue(result, row_num, 0);
            info.filename = info.name;  // For database mode, filename is just the name
            info.description = PQgetisnull(result, row_num, 1) ? "Template" : PQgetvalue(result, row_num, 1);
            info.created_date = PQgetisnull(result, row_num, 2) ? "" : PQgetvalue(result, row_num, 2);
            g_AvailableTemplates.push_back(info);
        }
        PQclear(result);

        printf("Loaded %zu templates from database\n", g_AvailableTemplates.size());
        return;
    }

    // Otherwise, load from JSON files
    std::string basePath = "/Users/imaging/Desktop/Website-Builder-v2.0/";
    std::string cmd = "ls " + basePath + "templates/*.json 2>/dev/null";

    FILE* pipe = popen(cmd.c_str(), "r");
    if (!pipe) return;

    char buffer[1024];
    while (fgets(buffer, sizeof(buffer), pipe)) {
        std::string filepath = buffer;
        if (!filepath.empty() && filepath.back() == '\n') filepath.pop_back();

        // Extract filename
        size_t lastSlash = filepath.find_last_of('/');
        std::string filename = (lastSlash != std::string::npos) ? filepath.substr(lastSlash + 1) : filepath;
        std::string name = filename.substr(0, filename.find_last_of('.'));

        // Read template metadata
        std::ifstream file(filepath);
        if (file.is_open()) {
            TemplateInfo info;
            info.name = name;
            info.filename = filepath;
            info.description = "Template";
            info.created_date = "";

            std::string line;
            while (std::getline(file, line)) {
                if (line.find("\"description\"") != std::string::npos) {
                    size_t start = line.find(":") + 1;
                    size_t first_quote = line.find("\"", start);
                    size_t last_quote = line.find_last_of("\"");
                    if (first_quote != std::string::npos && last_quote != std::string::npos && first_quote < last_quote) {
                        info.description = line.substr(first_quote + 1, last_quote - first_quote - 1);
                    }
                }
                if (line.find("\"created_date\"") != std::string::npos) {
                    size_t start = line.find(":") + 1;
                    size_t first_quote = line.find("\"", start);
                    size_t last_quote = line.find_last_of("\"");
                    if (first_quote != std::string::npos && last_quote != std::string::npos && first_quote < last_quote) {
                        info.created_date = line.substr(first_quote + 1, last_quote - first_quote - 1);
                    }
                }
            }
            file.close();
            g_AvailableTemplates.push_back(info);
        }
    }
    pclose(pipe);
}

// Helper: Extract string value from JSON line
std::string ExtractJsonString(const std::string& line) {
    size_t first = line.find("\":");
    if (first == std::string::npos) return "";
    first = line.find("\"", first + 2);
    if (first == std::string::npos) return "";
    size_t last = line.find_last_of("\"");
    if (last == std::string::npos || last <= first) return "";
    return line.substr(first + 1, last - first - 1);
}

// Helper: Extract number value from JSON line
float ExtractJsonNumber(const std::string& line) {
    size_t pos = line.find(":");
    if (pos == std::string::npos) return 0;
    std::string numStr = line.substr(pos + 1);
    // Remove trailing comma and whitespace
    size_t end = numStr.find_first_of(",\n\r");
    if (end != std::string::npos) numStr = numStr.substr(0, end);
    return std::stof(numStr);
}

// Helper: Extract color from JSON object string
ImVec4 ExtractJsonColor(const std::string& line) {
    ImVec4 color(1, 1, 1, 1);
    size_t rPos = line.find("\"r\":");
    size_t gPos = line.find("\"g\":");
    size_t bPos = line.find("\"b\":");
    size_t aPos = line.find("\"a\":");

    if (rPos != std::string::npos) {
        std::string rStr = line.substr(rPos + 4);
        color.x = std::stof(rStr);
    }
    if (gPos != std::string::npos) {
        std::string gStr = line.substr(gPos + 4);
        color.y = std::stof(gStr);
    }
    if (bPos != std::string::npos) {
        std::string bStr = line.substr(bPos + 4);
        color.z = std::stof(bStr);
    }
    if (aPos != std::string::npos) {
        std::string aStr = line.substr(aPos + 4);
        color.w = std::stof(aStr);
    }
    return color;
}

// Load template from file
bool LoadTemplate(const std::string& filepath) {
    // Clear current sections
    g_Sections.clear();
    g_SelectedSectionIndex = -1;

    // If using database, load from PostgreSQL
    if (g_UseDatabase && g_DBConnection) {
        // Extract template name from filepath or use directly
        std::string template_name = filepath;
        size_t lastSlash = filepath.find_last_of('/');
        if (lastSlash != std::string::npos) {
            template_name = filepath.substr(lastSlash + 1);
            size_t dotPos = template_name.find_last_of('.');
            if (dotPos != std::string::npos) {
                template_name = template_name.substr(0, dotPos);
            }
        }

        printf("[LoadTemplate] Searching for template: '%s'\n", template_name.c_str());

        // Get template ID
        std::string query = "SELECT id, project_name FROM templates WHERE template_name='" + SQLEscape(template_name) + "'";
        printf("[LoadTemplate] Query: %s\n", query.c_str());

        PGresult* result = PQexec(g_DBConnection, query.c_str());
        if (PQresultStatus(result) != PGRES_TUPLES_OK) {
            printf("[LoadTemplate] ERROR: Query failed: %s\n", PQerrorMessage(g_DBConnection));
            PQclear(result);
            return false;
        }

        int nrows = PQntuples(result);
        printf("[LoadTemplate] Query returned %d rows\n", nrows);

        if (nrows == 0) {
            printf("[LoadTemplate] ERROR: Template not found in database!\n");
            printf("[LoadTemplate] Listing all templates in database:\n");

            // Debug: List all templates
            PGresult* debug_result = PQexec(g_DBConnection, "SELECT template_name FROM templates ORDER BY id DESC LIMIT 10");
            if (PQresultStatus(debug_result) == PGRES_TUPLES_OK) {
                int debug_rows = PQntuples(debug_result);
                for (int i = 0; i < debug_rows; i++) {
                    printf("  - %s\n", PQgetvalue(debug_result, i, 0));
                }
            }
            PQclear(debug_result);

            PQclear(result);
            return false;
        }

        int template_id = atoi(PQgetvalue(result, 0, 0));
        g_ProjectName = PQgetisnull(result, 0, 1) ? "" : PQgetvalue(result, 0, 1);
        PQclear(result);

        // Check if this is a Figma template
        query = "SELECT is_figma_template, figma_screenshot_path, figma_canvas_width, figma_canvas_height FROM templates WHERE id=" + std::to_string(template_id);
        result = PQexec(g_DBConnection, query.c_str());
        bool isFigmaTemplate = false;
        if (PQresultStatus(result) == PGRES_TUPLES_OK && PQntuples(result) > 0) {
            const char* figmaVal = PQgetvalue(result, 0, 0);
            isFigmaTemplate = (figmaVal && (figmaVal[0] == 't' || figmaVal[0] == 'T' || figmaVal[0] == '1'));

            if (isFigmaTemplate) {
                printf("[LoadTemplate] This is a Figma template, loading in Figma mode...\n");

                // Clear and setup Figma project
                g_FigmaProject = FigmaProject();
                g_FigmaProject.name = template_name;
                g_FigmaProject.screenshot_path = PQgetisnull(result, 0, 1) ? "" : PQgetvalue(result, 0, 1);
                g_FigmaProject.canvas_width = PQgetisnull(result, 0, 2) ? 1920 : atof(PQgetvalue(result, 0, 2));
                g_FigmaProject.canvas_height = PQgetisnull(result, 0, 3) ? 3000 : atof(PQgetvalue(result, 0, 3));
                PQclear(result);

                // Load screenshot texture
                if (!g_FigmaProject.screenshot_path.empty()) {
                    int w, h, n;
                    unsigned char* data = stbi_load(g_FigmaProject.screenshot_path.c_str(), &w, &h, &n, 4);
                    if (data) {
                        glGenTextures(1, &g_FigmaProject.screenshot_texture_id);
                        glBindTexture(GL_TEXTURE_2D, g_FigmaProject.screenshot_texture_id);
                        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
                        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
                        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
                        stbi_image_free(data);
                        printf("[LoadTemplate] Loaded Figma screenshot: %dx%d\n", w, h);
                    }
                }

                // Load figma_layers
                query = "SELECT layer_order, layer_type, name, x, y, width, height, text, font_size, opacity, image_path, bg_color, text_color FROM figma_layers WHERE template_id=" + std::to_string(template_id) + " ORDER BY layer_order";
                result = PQexec(g_DBConnection, query.c_str());
                if (PQresultStatus(result) == PGRES_TUPLES_OK) {
                    int layerCount = PQntuples(result);
                    g_FigmaProject.layers.clear();

                    for (int i = 0; i < layerCount; i++) {
                        WebLayer layer;
                        layer.id = g_FigmaProject.next_layer_id++;
                        layer.type = (LayerType)atoi(PQgetvalue(result, i, 1));
                        layer.name = PQgetisnull(result, i, 2) ? "" : PQgetvalue(result, i, 2);
                        layer.x = atof(PQgetvalue(result, i, 3));
                        layer.y = atof(PQgetvalue(result, i, 4));
                        layer.width = atof(PQgetvalue(result, i, 5));
                        layer.height = atof(PQgetvalue(result, i, 6));
                        layer.text = PQgetisnull(result, i, 7) ? "" : PQgetvalue(result, i, 7);
                        layer.font_size = PQgetisnull(result, i, 8) ? 16 : atof(PQgetvalue(result, i, 8));
                        layer.opacity = PQgetisnull(result, i, 9) ? 1.0f : atof(PQgetvalue(result, i, 9));
                        layer.image_path = PQgetisnull(result, i, 10) ? "" : PQgetvalue(result, i, 10);

                        // Load image texture if exists
                        if (layer.type == LAYER_IMAGE && !layer.image_path.empty()) {
                            int w, h, n;
                            unsigned char* imgData = stbi_load(layer.image_path.c_str(), &w, &h, &n, 4);
                            if (imgData) {
                                glGenTextures(1, &layer.texture_id);
                                glBindTexture(GL_TEXTURE_2D, layer.texture_id);
                                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
                                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
                                glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, imgData);
                                stbi_image_free(imgData);
                            }
                        }

                        g_FigmaProject.layers.push_back(layer);
                    }

                    printf("[LoadTemplate] Loaded %d Figma layers\n", layerCount);
                }
                PQclear(result);

                // Switch to Figma mode
                g_FigmaMode = true;
                g_SelectedLayerId = -1;

                printf("\n========================================\n");
                printf("[LoadTemplate] SUCCESS: Figma template '%s' loaded!\n", template_name.c_str());
                printf("[LoadTemplate] Canvas: %.0fx%.0f, Layers: %zu\n", g_FigmaProject.canvas_width, g_FigmaProject.canvas_height, g_FigmaProject.layers.size());
                printf("========================================\n\n");

                return true;
            }
        }
        PQclear(result);

        // Load sections - MUST match column order in code below (for non-Figma templates)
        query = "SELECT "
                "id, template_id, section_order, type, name, section_id, height, y_position, "
                "title, subtitle, content, button_text, button_link, "
                "title_font_size, title_font_weight, subtitle_font_size, subtitle_font_weight, "
                "content_font_size, content_font_weight, button_font_size, button_font_weight, "
                "nav_font_size, nav_font_weight, "
                "title_color, subtitle_color, content_color, bg_color, text_color, "
                "accent_color, button_bg_color, button_text_color, "
                "nav_bg_color, nav_text_color, "
                "padding, text_align, card_width, card_height, card_spacing, card_padding, cards_per_row, heading_to_cards_spacing, "
                "background_image, background_image_data, section_image, section_image_data, "
                "use_bg_image, bg_overlay_opacity, "
                "section_width_percent, horizontal_align, use_manual_position, "
                "hero_animation_images, hero_animation_images_data, enable_hero_animation, hero_animation_speed, "
                "gallery_images, gallery_images_data, gallery_columns, gallery_spacing, "
                "logo_path, logo_data, logo_size, brand_text_position, "
                "animation_type, animation_duration, animation_delay, card_stagger_delay, "
                "interactive_data, layout_data, css_data "
                "FROM sections WHERE template_id=" + std::to_string(template_id) + " ORDER BY section_order";
        result = PQexec(g_DBConnection, query.c_str());
        if (PQresultStatus(result) != PGRES_TUPLES_OK) {
            printf("Error loading sections: %s\n", PQerrorMessage(g_DBConnection));
            PQclear(result);
            return false;
        }

        int section_count = PQntuples(result);
        printf("[LoadTemplate] Loading %d sections\n", section_count);
        for (int row_num = 0; row_num < section_count; row_num++) {
            int type = atoi(PQgetvalue(result, row_num, 3));  // type column
            WebSection sec(g_NextSectionId++, (SectionType)type);

            sec.name = PQgetisnull(result, row_num, 4) ? "" : PQgetvalue(result, row_num, 4);
            sec.section_id = PQgetisnull(result, row_num, 5) ? "" : PQgetvalue(result, row_num, 5);
            sec.height = PQgetisnull(result, row_num, 6) ? 400 : atoi(PQgetvalue(result, row_num, 6));
            sec.y_position = PQgetisnull(result, row_num, 7) ? 0 : atof(PQgetvalue(result, row_num, 7));  // NEW
            sec.title = PQgetisnull(result, row_num, 8) ? "" : PQgetvalue(result, row_num, 8);
            sec.subtitle = PQgetisnull(result, row_num, 9) ? "" : PQgetvalue(result, row_num, 9);
            sec.content = PQgetisnull(result, row_num, 10) ? "" : PQgetvalue(result, row_num, 10);
            sec.button_text = PQgetisnull(result, row_num, 11) ? "" : PQgetvalue(result, row_num, 11);
            sec.button_link = PQgetisnull(result, row_num, 12) ? "" : PQgetvalue(result, row_num, 12);

            sec.title_font_size = PQgetisnull(result, row_num, 13) ? 42 : atoi(PQgetvalue(result, row_num, 13));
            sec.title_font_weight = PQgetisnull(result, row_num, 14) ? 700 : atoi(PQgetvalue(result, row_num, 14));
            sec.subtitle_font_size = PQgetisnull(result, row_num, 15) ? 20 : atoi(PQgetvalue(result, row_num, 15));
            sec.subtitle_font_weight = PQgetisnull(result, row_num, 16) ? 400 : atoi(PQgetvalue(result, row_num, 16));
            sec.content_font_size = PQgetisnull(result, row_num, 17) ? 16 : atoi(PQgetvalue(result, row_num, 17));
            sec.content_font_weight = PQgetisnull(result, row_num, 18) ? 400 : atoi(PQgetvalue(result, row_num, 18));
            sec.button_font_size = PQgetisnull(result, row_num, 19) ? 16 : atoi(PQgetvalue(result, row_num, 19));
            sec.button_font_weight = PQgetisnull(result, row_num, 20) ? 600 : atoi(PQgetvalue(result, row_num, 20));
            sec.nav_font_size = PQgetisnull(result, row_num, 21) ? 15 : atoi(PQgetvalue(result, row_num, 21));
            sec.nav_font_weight = PQgetisnull(result, row_num, 22) ? 500 : atoi(PQgetvalue(result, row_num, 22));

            sec.title_color = PQgetisnull(result, row_num, 23) ? ImVec4(0.1f, 0.1f, 0.1f, 1.0f) : SQLToColor(PQgetvalue(result, row_num, 23));
            sec.subtitle_color = PQgetisnull(result, row_num, 24) ? ImVec4(0.3f, 0.3f, 0.3f, 1.0f) : SQLToColor(PQgetvalue(result, row_num, 24));
            sec.content_color = PQgetisnull(result, row_num, 25) ? ImVec4(0.2f, 0.2f, 0.2f, 1.0f) : SQLToColor(PQgetvalue(result, row_num, 25));
            sec.bg_color = PQgetisnull(result, row_num, 26) ? ImVec4(1.0f, 1.0f, 1.0f, 1.0f) : SQLToColor(PQgetvalue(result, row_num, 26));
            sec.text_color = PQgetisnull(result, row_num, 27) ? ImVec4(0.1f, 0.1f, 0.1f, 1.0f) : SQLToColor(PQgetvalue(result, row_num, 27));
            sec.accent_color = PQgetisnull(result, row_num, 28) ? ImVec4(0.2f, 0.5f, 1.0f, 1.0f) : SQLToColor(PQgetvalue(result, row_num, 28));
            sec.button_bg_color = PQgetisnull(result, row_num, 29) ? ImVec4(0.2f, 0.5f, 1.0f, 1.0f) : SQLToColor(PQgetvalue(result, row_num, 29));
            sec.button_text_color = PQgetisnull(result, row_num, 30) ? ImVec4(1.0f, 1.0f, 1.0f, 1.0f) : SQLToColor(PQgetvalue(result, row_num, 30));
            sec.nav_bg_color = PQgetisnull(result, row_num, 31) ? ImVec4(1.0f, 1.0f, 1.0f, 1.0f) : SQLToColor(PQgetvalue(result, row_num, 31));
            sec.nav_text_color = PQgetisnull(result, row_num, 32) ? ImVec4(0.2f, 0.2f, 0.2f, 1.0f) : SQLToColor(PQgetvalue(result, row_num, 32));

            sec.padding = PQgetisnull(result, row_num, 33) ? 60 : atoi(PQgetvalue(result, row_num, 33));
            sec.text_align = PQgetisnull(result, row_num, 34) ? 1 : atoi(PQgetvalue(result, row_num, 34));

            // Apply modern card sizes for sections with card layouts
            // Type 3 (Services), 4 (Cards), 5 (Team), 6 (Pricing) typically have cards
            // Type 0 (Hero), 1 (Navbar), 10 (Footer) don't have cards
            if (type == SEC_SERVICES || type == SEC_CARDS || type == SEC_TEAM || type == SEC_PRICING) {
                sec.card_width = PQgetisnull(result, row_num, 35) ? 800 : atoi(PQgetvalue(result, row_num, 35));
                sec.card_height = PQgetisnull(result, row_num, 36) ? 1000 : atoi(PQgetvalue(result, row_num, 36));
                sec.card_spacing = PQgetisnull(result, row_num, 37) ? 40 : atoi(PQgetvalue(result, row_num, 37));
            } else {
                sec.card_width = PQgetisnull(result, row_num, 35) ? 300 : atoi(PQgetvalue(result, row_num, 35));
                sec.card_height = PQgetisnull(result, row_num, 36) ? 250 : atoi(PQgetvalue(result, row_num, 36));
                sec.card_spacing = PQgetisnull(result, row_num, 37) ? 20 : atoi(PQgetvalue(result, row_num, 37));
            }

            sec.card_padding = PQgetisnull(result, row_num, 38) ? 25 : atoi(PQgetvalue(result, row_num, 38));  // NEW
            sec.cards_per_row = PQgetisnull(result, row_num, 39) ? 3 : atoi(PQgetvalue(result, row_num, 39));
            sec.heading_to_cards_spacing = PQgetisnull(result, row_num, 40) ? 40 : atof(PQgetvalue(result, row_num, 40));  // NEW

            sec.background_image = PQgetisnull(result, row_num, 41) ? "" : PQgetvalue(result, row_num, 41);
            // column 42 = background_image_data (BYTEA)
            sec.section_image = PQgetisnull(result, row_num, 43) ? "" : PQgetvalue(result, row_num, 43);
            // column 44 = section_image_data (BYTEA)
            sec.use_bg_image = PQgetisnull(result, row_num, 45) ? false : (PQgetvalue(result, row_num, 45)[0] == 't');
            sec.bg_overlay_opacity = PQgetisnull(result, row_num, 46) ? 0.0f : atof(PQgetvalue(result, row_num, 46));

            // NEW WIDTH & POSITION FIELDS
            sec.section_width_percent = PQgetisnull(result, row_num, 47) ? 100.0f : atof(PQgetvalue(result, row_num, 47));
            sec.horizontal_align = PQgetisnull(result, row_num, 48) ? 0 : atoi(PQgetvalue(result, row_num, 48));
            sec.use_manual_position = PQgetisnull(result, row_num, 49) ? false : (PQgetvalue(result, row_num, 49)[0] == 't');

            // Load multi-image arrays (columns 50-59)
            // Hero Animation Images
            if (!PQgetisnull(result, row_num, 50)) {
                sec.hero_animation_images = ParsePostgresArray(PQgetvalue(result, row_num, 50));
                printf("Loaded %d hero animation image paths\n", (int)sec.hero_animation_images.size());
            }
            sec.enable_hero_animation = PQgetisnull(result, row_num, 52) ? false : (PQgetvalue(result, row_num, 52)[0] == 't');
            sec.hero_animation_speed = PQgetisnull(result, row_num, 53) ? 3.0f : atof(PQgetvalue(result, row_num, 53));

            // Gallery Images
            if (!PQgetisnull(result, row_num, 54)) {
                sec.gallery_images = ParsePostgresArray(PQgetvalue(result, row_num, 54));
                printf("Loaded %d gallery image paths\n", (int)sec.gallery_images.size());
            }
            sec.gallery_columns = PQgetisnull(result, row_num, 56) ? 3 : atoi(PQgetvalue(result, row_num, 56));
            sec.gallery_spacing = PQgetisnull(result, row_num, 57) ? 20.0f : atof(PQgetvalue(result, row_num, 57));

            // Logo
            sec.logo_path = PQgetisnull(result, row_num, 58) ? "" : PQgetvalue(result, row_num, 58);
            // column 59 = logo_data (BYTEA)
            sec.logo_size = PQgetisnull(result, row_num, 60) ? 50.0f : atof(PQgetvalue(result, row_num, 60));
            sec.brand_text_position = PQgetisnull(result, row_num, 61) ? 0 : atoi(PQgetvalue(result, row_num, 61));

            // FAST LOADING: Load from file paths instead of slow database BYTEA
            // Skip database image loading for performance - file loading is 10x faster
            if (!sec.background_image.empty()) {
                ImageTexture bgTex = LoadTexture(sec.background_image);
                sec.bg_texture_id = bgTex.id;
            }

            // FAST LOADING: Load from file paths instead of slow database BYTEA
            // Skip database image loading for performance - file loading is 10x faster
            if (!sec.section_image.empty()) {
                ImageTexture imgTex = LoadTexture(sec.section_image);
                sec.img_texture_id = imgTex.id;
            }

            // Load Hero Animation texture IDs from saved paths
            for (const auto& img_path : sec.hero_animation_images) {
                ImageTexture tex = LoadTexture(img_path);
                sec.hero_animation_texture_ids.push_back(tex.id);
            }

            // Load Gallery texture IDs from saved paths
            for (const auto& img_path : sec.gallery_images) {
                ImageTexture tex = LoadTexture(img_path);
                sec.gallery_texture_ids.push_back(tex.id);
            }

            // Load Logo texture
            if (!sec.logo_path.empty()) {
                ImageTexture tex = LoadTexture(sec.logo_path);
                sec.logo_texture_id = tex.id;
            }

            // Animation settings
            sec.animation_type = PQgetisnull(result, row_num, 62) ? ANIM_NONE : (AnimationType)atoi(PQgetvalue(result, row_num, 62));
            sec.animation_duration = PQgetisnull(result, row_num, 63) ? 1.0f : atof(PQgetvalue(result, row_num, 63));
            sec.animation_delay = PQgetisnull(result, row_num, 64) ? 0.0f : atof(PQgetvalue(result, row_num, 64));
            sec.card_stagger_delay = PQgetisnull(result, row_num, 65) ? 0.3f : atof(PQgetvalue(result, row_num, 65));

            // Parse CSS data from column 68 (css_data) - 0-based indexing
            if (!PQgetisnull(result, row_num, 68)) {
                std::string css_json = PQgetvalue(result, row_num, 68);
                if (!css_json.empty()) {
                    ParseCSSData(sec, css_json);
                }
            }

            // Parse interactive_data (card items) from column 66
            if (!PQgetisnull(result, row_num, 66)) {
                std::string interactive_json = PQgetvalue(result, row_num, 66);
                if (!interactive_json.empty() && interactive_json != "null") {
                    ParseInteractiveData(sec, interactive_json);
                }
            }

            // Parse layout_data (padding, flexbox, grid, positioning) from column 67
            if (!PQgetisnull(result, row_num, 67)) {
                std::string layout_json = PQgetvalue(result, row_num, 67);
                if (!layout_json.empty() && layout_json != "null") {
                    ParseLayoutData(sec, layout_json);
                }
            }

            g_Sections.push_back(sec);
        }
        PQclear(result);

        // Select first section if any
        if (!g_Sections.empty()) {
            g_SelectedSectionIndex = 0;
            g_Sections[0].selected = true;
        }

        printf("\n========================================\n");
        printf("[LoadTemplate] SUCCESS: Template '%s' loaded from database\n", template_name.c_str());
        printf("[LoadTemplate] Loaded %zu sections:\n", g_Sections.size());
        for (size_t i = 0; i < g_Sections.size(); i++) {
            printf("  %zu. %s - '%s'\n", i+1, g_Sections[i].name.c_str(), g_Sections[i].title.c_str());
        }
        printf("========================================\n\n");
        return true;
    }

    // Otherwise, load from JSON file
    std::ifstream file(filepath);
    if (!file.is_open()) return false;

    std::string line;
    WebSection* currentSection = nullptr;
    bool inSectionsArray = false;
    bool inSection = false;

    while (std::getline(file, line)) {
        // Check if we're in the sections array
        if (line.find("\"sections\"") != std::string::npos) {
            inSectionsArray = true;
            continue;
        }

        // Start of a new section object
        if (inSectionsArray && line.find("{") != std::string::npos && !inSection) {
            inSection = true;
            continue;
        }

        // End of a section object
        if (inSection && line.find("}") != std::string::npos) {
            if (currentSection) {
                g_Sections.push_back(*currentSection);
                delete currentSection;
                currentSection = nullptr;
            }
            inSection = false;
            continue;
        }

        // Parse section properties
        if (inSection) {
            if (line.find("\"type\":") != std::string::npos) {
                int type = (int)ExtractJsonNumber(line);
                currentSection = new WebSection(g_NextSectionId++, (SectionType)type);
            }
            else if (currentSection) {
                if (line.find("\"name\":") != std::string::npos) {
                    currentSection->name = ExtractJsonString(line);
                }
                else if (line.find("\"section_id\":") != std::string::npos) {
                    currentSection->section_id = ExtractJsonString(line);
                }
                else if (line.find("\"height\":") != std::string::npos) {
                    currentSection->height = ExtractJsonNumber(line);
                }
                else if (line.find("\"title\":") != std::string::npos) {
                    currentSection->title = ExtractJsonString(line);
                }
                else if (line.find("\"subtitle\":") != std::string::npos) {
                    currentSection->subtitle = ExtractJsonString(line);
                }
                else if (line.find("\"content\":") != std::string::npos) {
                    currentSection->content = ExtractJsonString(line);
                }
                else if (line.find("\"button_text\":") != std::string::npos) {
                    currentSection->button_text = ExtractJsonString(line);
                }
                else if (line.find("\"button_link\":") != std::string::npos) {
                    currentSection->button_link = ExtractJsonString(line);
                }
                else if (line.find("\"title_font_size\":") != std::string::npos) {
                    currentSection->title_font_size = ExtractJsonNumber(line);
                }
                else if (line.find("\"subtitle_font_size\":") != std::string::npos) {
                    currentSection->subtitle_font_size = ExtractJsonNumber(line);
                }
                else if (line.find("\"content_font_size\":") != std::string::npos) {
                    currentSection->content_font_size = ExtractJsonNumber(line);
                }
                else if (line.find("\"title_font_weight\":") != std::string::npos) {
                    currentSection->title_font_weight = ExtractJsonNumber(line);
                }
                else if (line.find("\"subtitle_font_weight\":") != std::string::npos) {
                    currentSection->subtitle_font_weight = ExtractJsonNumber(line);
                }
                else if (line.find("\"content_font_weight\":") != std::string::npos) {
                    currentSection->content_font_weight = ExtractJsonNumber(line);
                }
                else if (line.find("\"title_color\":") != std::string::npos) {
                    currentSection->title_color = ExtractJsonColor(line);
                }
                else if (line.find("\"subtitle_color\":") != std::string::npos) {
                    currentSection->subtitle_color = ExtractJsonColor(line);
                }
                else if (line.find("\"content_color\":") != std::string::npos) {
                    currentSection->content_color = ExtractJsonColor(line);
                }
                else if (line.find("\"bg_color\":") != std::string::npos) {
                    currentSection->bg_color = ExtractJsonColor(line);
                }
                else if (line.find("\"text_color\":") != std::string::npos) {
                    currentSection->text_color = ExtractJsonColor(line);
                }
                else if (line.find("\"accent_color\":") != std::string::npos) {
                    currentSection->accent_color = ExtractJsonColor(line);
                }
                else if (line.find("\"button_bg_color\":") != std::string::npos) {
                    currentSection->button_bg_color = ExtractJsonColor(line);
                }
                else if (line.find("\"button_text_color\":") != std::string::npos) {
                    currentSection->button_text_color = ExtractJsonColor(line);
                }
                else if (line.find("\"button_font_size\":") != std::string::npos) {
                    currentSection->button_font_size = ExtractJsonNumber(line);
                }
                else if (line.find("\"button_font_weight\":") != std::string::npos) {
                    currentSection->button_font_weight = ExtractJsonNumber(line);
                }
                else if (line.find("\"padding\":") != std::string::npos) {
                    currentSection->padding = ExtractJsonNumber(line);
                }
                else if (line.find("\"text_align\":") != std::string::npos) {
                    currentSection->text_align = (int)ExtractJsonNumber(line);
                }
                else if (line.find("\"nav_font_size\":") != std::string::npos) {
                    currentSection->nav_font_size = ExtractJsonNumber(line);
                }
                else if (line.find("\"nav_font_weight\":") != std::string::npos) {
                    currentSection->nav_font_weight = ExtractJsonNumber(line);
                }
                else if (line.find("\"card_width\":") != std::string::npos) {
                    currentSection->card_width = ExtractJsonNumber(line);
                }
                else if (line.find("\"card_height\":") != std::string::npos) {
                    currentSection->card_height = ExtractJsonNumber(line);
                }
                else if (line.find("\"card_spacing\":") != std::string::npos) {
                    currentSection->card_spacing = ExtractJsonNumber(line);
                }
                else if (line.find("\"cards_per_row\":") != std::string::npos) {
                    currentSection->cards_per_row = (int)ExtractJsonNumber(line);
                }
                else if (line.find("\"background_image\":") != std::string::npos) {
                    currentSection->background_image = ExtractJsonString(line);
                }
                else if (line.find("\"section_image\":") != std::string::npos) {
                    currentSection->section_image = ExtractJsonString(line);
                }
                else if (line.find("\"use_bg_image\":") != std::string::npos) {
                    currentSection->use_bg_image = (line.find("true") != std::string::npos);
                }
                else if (line.find("\"bg_overlay_opacity\":") != std::string::npos) {
                    currentSection->bg_overlay_opacity = ExtractJsonNumber(line);
                }
            }
        }

        // Check for project name
        if (line.find("\"project_name\":") != std::string::npos && !inSection) {
            g_ProjectName = ExtractJsonString(line);
        }
    }

    file.close();

    // Load textures for all sections with images
    for (auto& sec : g_Sections) {
        if (!sec.background_image.empty()) {
            ImageTexture bgTex = LoadTexture(sec.background_image);
            sec.bg_texture_id = bgTex.id;
        }
        if (!sec.section_image.empty()) {
            ImageTexture imgTex = LoadTexture(sec.section_image);
            sec.img_texture_id = imgTex.id;
        }
    }

    // Select first section if any
    if (!g_Sections.empty()) {
        g_SelectedSectionIndex = 0;
        g_Sections[0].selected = true;
    }

    return !g_Sections.empty();
}

// ============================================================================
// URL IMPORT FUNCTIONS
// ============================================================================
bool ValidateURL(const std::string& url);
std::string FetchHTML(const std::string& url);
std::string CaptureScreenshot(const std::string& url);
ColorPalette ExtractColors(const std::string& screenshot_path);
std::vector<DetectedSection> ParseAndIdentifySections(const std::string& html, const ColorPalette& colors);
SectionType MapToSectionType(const std::string& detected_type);
std::string DownloadImage(const std::string& image_url, const std::string& base_url);
WebSection CreateWebSection(const DetectedSection& detected, int section_id);
bool ImportFromURL(const std::string& url, int timeout_seconds = 300);

// Local Download Import Functions
bool DownloadWebsiteLocally(const std::string& url, const std::string& output_dir);
bool ParseLocalHTMLFile(const std::string& html_path, std::vector<WebSection>& sections);
std::map<std::string, std::string> ParseLocalCSSFile(const std::string& css_path);
bool ImportFromLocalDownload(const std::string& url);

// Figma-style Import Functions
bool ImportFigmaLayers(const std::string& url);
void RenderFigmaCanvas();
void RenderFigmaLayersPanel();
void RenderFigmaPropertiesPanel();
WebLayer* GetLayerById(int id);
void SelectLayer(int id);
void DeselectAllLayers();

// ============================================================================
// FILE DIALOGS
// ============================================================================
std::string OpenFileDialog(const char* title) {
    char cmd[1024];
    snprintf(cmd, sizeof(cmd),
        "osascript -e 'try' -e 'POSIX path of (choose file with prompt \"%s\")' -e 'end try' 2>/dev/null", title);
    FILE* pipe = popen(cmd, "r");
    if (!pipe) return "";
    char buffer[1024];
    std::string result;
    if (fgets(buffer, sizeof(buffer), pipe)) {
        result = buffer;
        if (!result.empty() && result.back() == '\n') result.pop_back();
    }
    pclose(pipe);
    return result;
}

std::string ChooseFolderDialog(const char* title) {
    char cmd[1024];
    snprintf(cmd, sizeof(cmd),
        "osascript -e 'try' -e 'POSIX path of (choose folder with prompt \"%s\")' -e 'end try' 2>/dev/null", title);
    FILE* pipe = popen(cmd, "r");
    if (!pipe) return "";
    char buffer[1024];
    std::string result;
    if (fgets(buffer, sizeof(buffer), pipe)) {
        result = buffer;
        if (!result.empty() && result.back() == '\n') result.pop_back();
    }
    pclose(pipe);
    return result;
}

// Open multiple file dialog (macOS)
std::vector<std::string> OpenMultipleFilesDialog() {
    std::vector<std::string> files;
    char buffer[8192] = {0};

    // AppleScript to select multiple files and return paths separated by newlines
    const char* script =
        "osascript -e '"
        "set theFiles to choose file with prompt \"Select image files\" with multiple selections allowed' "
        "-e 'set output to \"\"' "
        "-e 'repeat with aFile in theFiles' "
        "-e 'set output to output & POSIX path of aFile & linefeed' "
        "-e 'end repeat' "
        "-e 'return output' "
        "2>/dev/null";

    FILE* fp = popen(script, "r");
    if (fp) {
        // Read all output
        std::string allPaths;
        while (fgets(buffer, sizeof(buffer), fp) != nullptr) {
            allPaths += buffer;
        }
        pclose(fp);

        // Split by newline
        std::istringstream stream(allPaths);
        std::string line;
        while (std::getline(stream, line)) {
            // Remove any trailing whitespace or carriage returns
            while (!line.empty() && (line.back() == '\n' || line.back() == '\r' || line.back() == ' ')) {
                line.pop_back();
            }
            if (!line.empty()) {
                files.push_back(line);
            }
        }
    }
    return files;
}

// ============================================================================
// URL IMPORT IMPLEMENTATION
// ============================================================================

// Validate URL format (very lenient)
bool ValidateURL(const std::string& url) {
    if (url.empty()) return false;

    // Remove leading/trailing whitespace for checking
    std::string cleaned = url;
    size_t start = cleaned.find_first_not_of(" \t\n\r");
    size_t end = cleaned.find_last_not_of(" \t\n\r");
    if (start == std::string::npos) return false;
    cleaned = cleaned.substr(start, end - start + 1);

    // Must be at least 10 characters (http://a.b is minimum)
    if (cleaned.length() < 10) return false;

    // Must contain http:// or https:// somewhere near the beginning
    bool has_http = (cleaned.find("http://") != std::string::npos);
    bool has_https = (cleaned.find("https://") != std::string::npos);
    if (!has_http && !has_https) return false;

    // Must contain at least one dot (for domain)
    if (cleaned.find('.') == std::string::npos) return false;

    // Passed all checks
    return true;
}

// Fetch HTML content from URL
std::string FetchHTML(const std::string& url) {
    std::string temp_file = "/tmp/imgui_import_" + std::to_string(time(nullptr)) + ".html";
    std::string cmd = "curl -L -s --max-time 30 \"" + url + "\" -o \"" + temp_file + "\" 2>/dev/null";

    if (system(cmd.c_str()) != 0) return "";

    std::ifstream file(temp_file);
    if (!file.is_open()) return "";

    std::string html((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
    file.close();
    unlink(temp_file.c_str());

    return html;
}

// Capture screenshot of website (optional - requires Selenium)
std::string CaptureScreenshot(const std::string& url) {
    std::string output_path = "/tmp/imgui_screenshot_" + std::to_string(time(nullptr)) + ".png";

    // Create Python script for headless browser screenshot
    std::string python_script = "/tmp/capture_screenshot.py";
    std::ofstream script(python_script);
    script << "#!/usr/bin/env python3\n"
           << "import sys\n"
           << "try:\n"
           << "    from selenium import webdriver\n"
           << "    from selenium.webdriver.chrome.options import Options\n"
           << "    chrome_options = Options()\n"
           << "    chrome_options.add_argument('--headless')\n"
           << "    chrome_options.add_argument('--window-size=1920,1080')\n"
           << "    driver = webdriver.Chrome(options=chrome_options)\n"
           << "    driver.get(sys.argv[1])\n"
           << "    driver.save_screenshot(sys.argv[2])\n"
           << "    driver.quit()\n"
           << "except: sys.exit(1)\n";
    script.close();
    chmod(python_script.c_str(), 0755);

    std::string cmd = "python3 \"" + python_script + "\" \"" + url + "\" \"" + output_path + "\" 2>/dev/null";
    int result = system(cmd.c_str());
    unlink(python_script.c_str());

    return (result == 0 && access(output_path.c_str(), F_OK) == 0) ? output_path : "";
}

// Extract dominant colors from screenshot
ColorPalette ExtractColors(const std::string& screenshot_path) {
    ColorPalette palette;

    // Default palette
    palette.primary = ImVec4(0.37f, 0.51f, 0.99f, 1.0f);
    palette.secondary = ImVec4(0.56f, 0.27f, 0.68f, 1.0f);
    palette.accent = ImVec4(0.06f, 0.71f, 0.60f, 1.0f);
    palette.background = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
    palette.text = ImVec4(0.12f, 0.15f, 0.22f, 1.0f);

    if (screenshot_path.empty()) return palette;

    // Create Python script for color extraction
    std::string python_script = "/tmp/extract_colors.py";
    std::ofstream script(python_script);
    script << "#!/usr/bin/env python3\n"
           << "from PIL import Image\n"
           << "import sys\n"
           << "from collections import Counter\n"
           << "img = Image.open(sys.argv[1]).convert('RGB')\n"
           << "img = img.resize((100, 100))\n"
           << "pixels = list(img.getdata())\n"
           << "counter = Counter(pixels)\n"
           << "colors = [c for c, cnt in counter.most_common(10) if 30 < sum(c)/3 < 225]\n"
           << "for r, g, b in colors[:5]: print(f'{r} {g} {b}')\n";
    script.close();
    chmod(python_script.c_str(), 0755);

    std::string cmd = "python3 \"" + python_script + "\" \"" + screenshot_path + "\" 2>/dev/null";
    FILE* pipe = popen(cmd.c_str(), "r");
    if (pipe) {
        std::vector<ImVec4> extracted;
        char buffer[256];
        while (fgets(buffer, sizeof(buffer), pipe)) {
            int r, g, b;
            if (sscanf(buffer, "%d %d %d", &r, &g, &b) == 3) {
                extracted.push_back(ImVec4(r/255.0f, g/255.0f, b/255.0f, 1.0f));
            }
        }
        pclose(pipe);

        if (extracted.size() >= 1) palette.primary = extracted[0];
        if (extracted.size() >= 2) palette.secondary = extracted[1];
        if (extracted.size() >= 3) palette.accent = extracted[2];
        if (extracted.size() >= 4) palette.background = extracted[3];
        if (extracted.size() >= 5) palette.text = extracted[4];
    }

    unlink(python_script.c_str());
    return palette;
}

// Parse HTML and identify website sections
std::vector<DetectedSection> ParseAndIdentifySections(const std::string& html, const ColorPalette& colors) {
    std::vector<DetectedSection> sections;

    // Simple pattern matching for common sections
    std::string html_lower = html;
    std::transform(html_lower.begin(), html_lower.end(), html_lower.begin(), ::tolower);

    // Detect Navbar
    if (html_lower.find("<nav") != std::string::npos || html_lower.find("class=\"nav") != std::string::npos) {
        DetectedSection nav;
        nav.type = "navbar";
        nav.colors = colors;
        nav.estimated_height = 70;
        sections.push_back(nav);
    }

    // Detect Hero
    if (html_lower.find("hero") != std::string::npos || html_lower.find("jumbotron") != std::string::npos) {
        DetectedSection hero;
        hero.type = "hero";
        hero.colors = colors;
        hero.estimated_height = 600;

        // Extract title from first h1
        size_t h1_start = html.find("<h1");
        if (h1_start != std::string::npos) {
            size_t content_start = html.find(">", h1_start) + 1;
            size_t content_end = html.find("</h1>", content_start);
            if (content_end != std::string::npos && content_end > content_start) {
                hero.title = html.substr(content_start, content_end - content_start);
                // Remove HTML tags from title
                size_t tag_pos;
                while ((tag_pos = hero.title.find("<")) != std::string::npos) {
                    size_t end_pos = hero.title.find(">", tag_pos);
                    if (end_pos != std::string::npos) {
                        hero.title.erase(tag_pos, end_pos - tag_pos + 1);
                    } else break;
                }
            }
        }

        sections.push_back(hero);
    }

    // Detect Cards/Services
    size_t card_count = 0;
    size_t pos = 0;
    while ((pos = html_lower.find("class=\"card", pos)) != std::string::npos) {
        card_count++;
        pos++;
    }
    if (card_count > 2) {
        DetectedSection cards;
        cards.type = "cards";
        cards.colors = colors;
        cards.estimated_height = 500;
        sections.push_back(cards);
    }

    // Detect Footer
    if (html_lower.find("<footer") != std::string::npos) {
        DetectedSection footer;
        footer.type = "footer";
        footer.colors = colors;
        footer.estimated_height = 200;
        sections.push_back(footer);
    }

    // If no sections detected, create defaults
    if (sections.empty()) {
        DetectedSection hero;
        hero.type = "hero";
        hero.title = "Imported Website";
        hero.subtitle = "Design imported from URL";
        hero.colors = colors;
        hero.estimated_height = 600;
        sections.push_back(hero);

        DetectedSection about;
        about.type = "about";
        about.colors = colors;
        about.estimated_height = 400;
        sections.push_back(about);
    }

    return sections;
}

// Map detected type to SectionType enum
SectionType MapToSectionType(const std::string& detected_type) {
    if (detected_type == "navbar") return SEC_NAVBAR;
    if (detected_type == "hero") return SEC_HERO;
    if (detected_type == "about") return SEC_ABOUT;
    if (detected_type == "services") return SEC_SERVICES;
    if (detected_type == "cards") return SEC_CARDS;
    if (detected_type == "features") return SEC_FEATURES;
    if (detected_type == "footer") return SEC_FOOTER;
    if (detected_type == "contact") return SEC_CONTACT;
    if (detected_type == "pricing") return SEC_PRICING;
    return SEC_ABOUT;
}

// Download image from URL
std::string DownloadImage(const std::string& image_url, const std::string& base_url) {
    if (image_url.empty()) return "";

    // Make absolute URL if relative
    std::string full_url = image_url;
    if (image_url[0] == '/') {
        size_t protocol_end = base_url.find("://");
        if (protocol_end != std::string::npos) {
            size_t domain_end = base_url.find('/', protocol_end + 3);
            full_url = base_url.substr(0, domain_end) + image_url;
        }
    }

    std::string ext = ".jpg";
    if (full_url.find(".png") != std::string::npos) ext = ".png";

    std::string output_path = "/tmp/imgui_img_" + std::to_string(time(nullptr)) + ext;
    std::string cmd = "curl -L -s --max-time 10 \"" + full_url + "\" -o \"" + output_path + "\" 2>/dev/null";

    if (system(cmd.c_str()) != 0) return "";
    if (access(output_path.c_str(), F_OK) != 0) return "";

    return output_path;
}

// Create WebSection from detected section
WebSection CreateWebSection(const DetectedSection& detected, int section_id) {
    SectionType type = MapToSectionType(detected.type);
    WebSection sec(section_id, type);

    if (!detected.title.empty()) sec.title = detected.title;
    if (!detected.subtitle.empty()) sec.subtitle = detected.subtitle;
    if (!detected.content.empty()) sec.content = detected.content;

    sec.bg_color = detected.colors.background;
    sec.title_color = detected.colors.text;
    sec.subtitle_color = detected.colors.text;
    sec.accent_color = detected.colors.primary;
    sec.button_bg_color = detected.colors.accent;
    sec.height = detected.estimated_height;

    return sec;
}

// Main import function
bool ImportFromURL(const std::string& url, int timeout_seconds, bool use_stealth = false) {
    g_URLImportStatus = "Validating URL...";
    g_URLImportProgress = 0.1f;

    // Clean the URL (remove whitespace)
    std::string cleaned_url = url;
    size_t start = cleaned_url.find_first_not_of(" \t\n\r");
    size_t end = cleaned_url.find_last_not_of(" \t\n\r");
    if (start != std::string::npos) {
        cleaned_url = cleaned_url.substr(start, end - start + 1);
    }

    if (!ValidateURL(cleaned_url)) {
        g_URLImportStatus = "Error: Invalid URL format (must be http:// or https://)";
        return false;
    }

    // Use cleaned URL for all operations
    std::string final_url = cleaned_url;

    // Generate unique template name from URL
    std::string template_name = "imported_";
    size_t url_start = final_url.find("://");
    if (url_start != std::string::npos) {
        url_start += 3;
        size_t url_end = final_url.find("/", url_start);
        std::string domain = (url_end != std::string::npos) ? final_url.substr(url_start, url_end - url_start) : final_url.substr(url_start);
        // Remove www. and dots
        size_t www_pos = domain.find("www.");
        if (www_pos == 0) domain = domain.substr(4);
        for (char& c : domain) {
            if (c == '.') c = '_';
        }
        template_name += domain;
    } else {
        template_name += "website";
    }

    // Add timestamp to make unique
    time_t now = time(nullptr);
    template_name += "_" + std::to_string(now);

    if (use_stealth) {
        g_URLImportStatus = "Launching Stealth Browser MCP scraper (anti-bot bypass)...";
    } else {
        g_URLImportStatus = "Launching advanced scraper with Playwright...";
    }
    g_URLImportProgress = 0.2f;

    // Call Python scraper with virtual environment activated and custom timeout
    // Add --stealth flag for stealth browser MCP mode
    std::string stealth_flag = use_stealth ? " --stealth" : "";
    std::string command = "/bin/bash -c 'cd /Users/imaging/Desktop/Website-Builder-v2.0 && source playwright_env/bin/activate && source ~/stealth_env.sh && python3 import_website.py \"" + final_url + "\" \"" + template_name + "\" " + std::to_string(timeout_seconds) + stealth_flag + "' 2>&1";

    printf("[URL Import] Starting scraper for: %s\n", final_url.c_str());
    printf("[URL Import] Mode: %s\n", use_stealth ? "Stealth Browser MCP" : "Local Playwright");
    printf("[URL Import] Timeout: %d seconds (%d min %d sec)\n", timeout_seconds, timeout_seconds / 60, timeout_seconds % 60);
    printf("[URL Import] Command: %s\n", command.c_str());

    FILE* pipe = popen(command.c_str(), "r");
    if (!pipe) {
        g_URLImportStatus = "Error: Failed to launch scraper (Python not found?)";
        printf("[URL Import] ERROR: popen failed\n");
        return false;
    }

    if (use_stealth) {
        g_URLImportStatus = "Scraping via Stealth Browser (may take 1-2 minutes)...";
    } else {
        g_URLImportStatus = "Scraping website (this may take 30-60 seconds)...";
    }
    g_URLImportProgress = 0.5f;

    // Read output with detailed logging
    char buffer[256];
    std::string result = "";
    int lineCount = 0;
    while (fgets(buffer, sizeof(buffer), pipe) != nullptr) {
        result += buffer;
        lineCount++;
        if (lineCount % 10 == 0) {
            printf("[URL Import] Reading output... (%d lines)\n", lineCount);
        }
    }
    int status = pclose(pipe);

    printf("[URL Import] Scraper finished with exit code: %d\n", status);
    printf("[URL Import] Output length: %zu bytes\n", result.length());

    if (status != 0) {
        std::string error_msg = result.substr(0, std::min(size_t(200), result.length()));
        g_URLImportStatus = "Error: Scraping failed - " + error_msg;
        printf("[URL Import] ERROR OUTPUT:\n%s\n", result.c_str());
        return false;
    }

    g_URLImportStatus = "Importing to database...";
    g_URLImportProgress = 0.8f;

    // Import SQL to database
    std::string sql_file = "import_" + template_name + ".sql";
    std::string import_cmd = "cd /Users/imaging/Desktop/Website-Builder-v2.0 && psql -d website_builder < " + sql_file + " 2>&1";

    printf("[URL Import] Importing SQL file: %s\n", sql_file.c_str());

    pipe = popen(import_cmd.c_str(), "r");
    if (!pipe) {
        g_URLImportStatus = "Error: Failed to import to database (psql not found?)";
        printf("[URL Import] ERROR: Database import popen failed\n");
        return false;
    }

    result = "";
    while (fgets(buffer, sizeof(buffer), pipe) != nullptr) {
        result += buffer;
    }
    status = pclose(pipe);

    printf("[URL Import] Database import exit code: %d\n", status);
    printf("[URL Import] Database import output:\n%s\n", result.c_str());

    // Check for ROLLBACK or ERROR in output (even if exit code is 0)
    if (result.find("ROLLBACK") != std::string::npos ||
        result.find("ERROR") != std::string::npos) {
        std::string error_msg = result.substr(0, std::min(size_t(300), result.length()));
        g_URLImportStatus = "Error: Database import failed (transaction rolled back)";
        printf("[URL Import] Database ERROR detected in output:\n%s\n", result.c_str());
        return false;
    }

    if (status != 0) {
        std::string error_msg = result.substr(0, std::min(size_t(200), result.length()));
        g_URLImportStatus = "Error: Database import failed - " + error_msg;
        return false;
    }

    g_URLImportStatus = "Loading template from database...";
    g_URLImportProgress = 0.9f;

    // Refresh available templates list
    LoadAvailableTemplates();

    // Load the template from database
    bool loaded = LoadTemplate(template_name);

    if (!loaded) {
        g_URLImportStatus = "Error: Failed to load imported template";
        return false;
    }

    // Check if any sections were actually imported
    if (g_Sections.size() == 0) {
        g_URLImportStatus = "Warning: Import completed but found 0 sections. Site may have anti-bot protection or incompatible structure. Try increasing timeout or use a different site.";
        g_URLImportProgress = 1.0f;
        return false;  // Treat as failure
    } else if (g_Sections.size() < 3) {
        // Very few sections - might be partial failure
        g_URLImportStatus = "Warning: Only imported " + std::to_string(g_Sections.size()) + " section(s). Site might have limited content or detection issues.";
        g_URLImportProgress = 1.0f;
        return true;  // Still allow use
    }

    g_URLImportStatus = "Success! Imported " + std::to_string(g_Sections.size()) + " sections with images";
    g_URLImportProgress = 1.0f;

    return true;
}

// ============================================================================
// LOCAL DOWNLOAD IMPORT IMPLEMENTATION
// ============================================================================

// Helper: Extract domain from URL
std::string ExtractDomain(const std::string& url) {
    size_t start = url.find("://");
    if (start == std::string::npos) start = 0;
    else start += 3;

    size_t end = url.find("/", start);
    if (end == std::string::npos) end = url.length();

    return url.substr(start, end - start);
}

// Helper: Parse RGB color string to ImVec4
ImVec4 ParseCSSColor(const std::string& color) {
    ImVec4 result(0.1f, 0.1f, 0.1f, 1.0f);

    // Handle rgb(r, g, b) format
    if (color.find("rgb") != std::string::npos) {
        int r, g, b;
        if (sscanf(color.c_str(), "rgb(%d,%d,%d)", &r, &g, &b) == 3 ||
            sscanf(color.c_str(), "rgb( %d , %d , %d )", &r, &g, &b) == 3) {
            result = ImVec4(r/255.0f, g/255.0f, b/255.0f, 1.0f);
        }
    }
    // Handle #RRGGBB format
    else if (color[0] == '#' && color.length() >= 7) {
        int r, g, b;
        sscanf(color.c_str() + 1, "%02x%02x%02x", &r, &g, &b);
        result = ImVec4(r/255.0f, g/255.0f, b/255.0f, 1.0f);
    }
    // Handle #RGB format
    else if (color[0] == '#' && color.length() >= 4) {
        int r, g, b;
        sscanf(color.c_str() + 1, "%1x%1x%1x", &r, &g, &b);
        result = ImVec4(r/15.0f, g/15.0f, b/15.0f, 1.0f);
    }

    return result;
}

// Helper: Find all files matching pattern in directory
std::vector<std::string> FindFiles(const std::string& dir, const std::string& extension) {
    std::vector<std::string> files;
    std::string cmd = "find \"" + dir + "\" -name \"*" + extension + "\" -type f 2>/dev/null";

    FILE* pipe = popen(cmd.c_str(), "r");
    if (pipe) {
        char buffer[512];
        while (fgets(buffer, sizeof(buffer), pipe)) {
            std::string file = buffer;
            file.erase(file.find_last_not_of(" \n\r\t") + 1);
            if (!file.empty()) files.push_back(file);
        }
        pclose(pipe);
    }
    return files;
}

// Helper: Read file contents
std::string ReadFileContents(const std::string& path) {
    std::ifstream file(path);
    if (!file.is_open()) return "";
    std::stringstream buffer;
    buffer << file.rdbuf();
    return buffer.str();
}

// Download website using Python script (more reliable than wget)
bool DownloadWebsiteLocally(const std::string& url, const std::string& output_dir) {
    g_URLImportStatus = "Creating download directory...";
    g_URLImportProgress = 0.1f;

    // Create output directory
    std::string mkdir_cmd = "mkdir -p \"" + output_dir + "\"";
    system(mkdir_cmd.c_str());

    g_URLImportStatus = "Downloading website with Python...";
    g_URLImportProgress = 0.2f;

    // Create a Python script to download the website
    std::string python_script = R"(
import sys
import os
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin, urlparse
import re

url = sys.argv[1]
output_dir = sys.argv[2]

headers = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36'
}

print(f"Downloading: {url}")

try:
    # Download main page
    response = requests.get(url, headers=headers, timeout=30)
    response.raise_for_status()
    html = response.text

    # Parse domain for folder
    domain = urlparse(url).netloc
    site_dir = os.path.join(output_dir, domain)
    os.makedirs(site_dir, exist_ok=True)

    # Save main HTML
    html_path = os.path.join(site_dir, 'index.html')
    with open(html_path, 'w', encoding='utf-8') as f:
        f.write(html)
    print(f"Saved: {html_path}")

    # Parse HTML for resources
    soup = BeautifulSoup(html, 'html.parser')

    # Create subdirectories
    css_dir = os.path.join(site_dir, 'css')
    img_dir = os.path.join(site_dir, 'images')
    os.makedirs(css_dir, exist_ok=True)
    os.makedirs(img_dir, exist_ok=True)

    # Download CSS files
    for link in soup.find_all('link', rel='stylesheet'):
        href = link.get('href')
        if href:
            css_url = urljoin(url, href)
            try:
                css_resp = requests.get(css_url, headers=headers, timeout=10)
                filename = os.path.basename(urlparse(css_url).path) or 'style.css'
                css_path = os.path.join(css_dir, filename)
                with open(css_path, 'w', encoding='utf-8') as f:
                    f.write(css_resp.text)
                print(f"CSS: {filename}")
            except Exception as e:
                print(f"CSS error: {e}")

    # Download images
    img_count = 0
    for img in soup.find_all('img'):
        src = img.get('src') or img.get('data-src')
        if src and img_count < 50:  # Limit to 50 images
            img_url = urljoin(url, src)
            try:
                img_resp = requests.get(img_url, headers=headers, timeout=10)
                filename = os.path.basename(urlparse(img_url).path)
                if not filename or '.' not in filename:
                    filename = f'image_{img_count}.jpg'
                img_path = os.path.join(img_dir, filename)
                with open(img_path, 'wb') as f:
                    f.write(img_resp.content)
                print(f"Image: {filename}")
                img_count += 1
            except Exception as e:
                print(f"Image error: {e}")

    # Also get background images from style tags
    for style in soup.find_all('style'):
        if style.string:
            urls = re.findall(r'url\(["\']?([^"\')\s]+)["\']?\)', style.string)
            for bg_url in urls[:10]:
                if bg_url.startswith('data:'):
                    continue
                full_url = urljoin(url, bg_url)
                try:
                    bg_resp = requests.get(full_url, headers=headers, timeout=10)
                    filename = os.path.basename(urlparse(full_url).path)
                    if filename and '.' in filename:
                        bg_path = os.path.join(img_dir, filename)
                        with open(bg_path, 'wb') as f:
                            f.write(bg_resp.content)
                        print(f"BG Image: {filename}")
                except:
                    pass

    print("Download complete!")

except Exception as e:
    print(f"Error: {e}")
    sys.exit(1)
)";

    // Write Python script to temp file
    std::string script_path = "/tmp/download_site.py";
    FILE* script_file = fopen(script_path.c_str(), "w");
    if (script_file) {
        fprintf(script_file, "%s", python_script.c_str());
        fclose(script_file);
    }

    // Run Python script
    std::string python_cmd = "python3 \"" + script_path + "\" \"" + url + "\" \"" + output_dir + "\" 2>&1";

    printf("[LocalDownload] Running Python downloader...\n");

    FILE* pipe = popen(python_cmd.c_str(), "r");
    if (!pipe) {
        g_URLImportStatus = "Error: Failed to run Python";
        return false;
    }

    char buffer[256];
    int lineCount = 0;
    while (fgets(buffer, sizeof(buffer), pipe)) {
        lineCount++;
        printf("%s", buffer);
        if (lineCount % 5 == 0) {
            g_URLImportProgress = 0.2f + (lineCount / 100.0f) * 0.4f;
            if (g_URLImportProgress > 0.6f) g_URLImportProgress = 0.6f;
        }
    }

    int status = pclose(pipe);
    printf("[LocalDownload] Python finished with status: %d\n", status);

    if (status != 0) {
        g_URLImportStatus = "Error: Download failed";
        return false;
    }

    g_URLImportProgress = 0.6f;
    g_DownloadComplete = true;
    g_DownloadedSitePath = output_dir + "/" + ExtractDomain(url);

    return true;
}

// Parse CSS file and extract styles
std::map<std::string, std::string> ParseLocalCSSFile(const std::string& css_path) {
    std::map<std::string, std::string> styles;
    std::string css = ReadFileContents(css_path);

    // Simple CSS parsing - extract color, background, font properties
    // This is a basic parser, production would need a full CSS parser

    // Find body styles
    size_t bodyPos = css.find("body");
    if (bodyPos != std::string::npos) {
        size_t braceStart = css.find("{", bodyPos);
        size_t braceEnd = css.find("}", braceStart);
        if (braceStart != std::string::npos && braceEnd != std::string::npos) {
            std::string bodyCSS = css.substr(braceStart + 1, braceEnd - braceStart - 1);
            styles["body"] = bodyCSS;
        }
    }

    return styles;
}

// Parse local HTML and create sections
bool ParseLocalHTMLFile(const std::string& html_path, std::vector<WebSection>& sections) {
    try {
        std::string html = ReadFileContents(html_path);
        if (html.empty()) {
            printf("[LocalParse] Failed to read HTML file: %s\n", html_path.c_str());
            return false;
        }

        printf("[LocalParse] HTML file size: %zu bytes\n", html.length());

    // Extract title
    std::string pageTitle = "Imported Site";
    size_t titleStart = html.find("<title>");
    size_t titleEnd = html.find("</title>");
    if (titleStart != std::string::npos && titleEnd != std::string::npos) {
        titleStart += 7;
        pageTitle = html.substr(titleStart, titleEnd - titleStart);
    }

    // Find sections by common HTML5 semantic tags AND generic patterns
    std::vector<std::pair<std::string, SectionType>> sectionTags = {
        // Semantic tags
        {"<header", SEC_NAVBAR},
        {"<nav", SEC_NAVBAR},
        {"<footer", SEC_FOOTER},
        {"<main", SEC_HERO},
        // Hero patterns
        {"<section class=\"hero", SEC_HERO},
        {"<section id=\"hero", SEC_HERO},
        {"<div class=\"hero", SEC_HERO},
        {"class=\"hero-", SEC_HERO},
        {"class=\"banner", SEC_HERO},
        {"class=\"jumbotron", SEC_HERO},
        {"class=\"splash", SEC_HERO},
        // Services/Features patterns
        {"<section class=\"services", SEC_SERVICES},
        {"<section class=\"features", SEC_SERVICES},
        {"<section id=\"services", SEC_SERVICES},
        {"<section class=\"about", SEC_SERVICES},
        {"class=\"features", SEC_SERVICES},
        {"class=\"services", SEC_SERVICES},
        {"class=\"benefits", SEC_SERVICES},
        {"class=\"products", SEC_SERVICES},
        // Gallery patterns
        {"<section class=\"gallery", SEC_GALLERY},
        {"<section id=\"gallery", SEC_GALLERY},
        {"<section class=\"portfolio", SEC_GALLERY},
        {"class=\"gallery", SEC_GALLERY},
        {"class=\"portfolio", SEC_GALLERY},
        {"class=\"grid", SEC_GALLERY},
        // Contact patterns
        {"<section class=\"contact", SEC_CONTACT},
        {"<section id=\"contact", SEC_CONTACT},
        {"class=\"contact", SEC_CONTACT},
        {"class=\"form", SEC_CONTACT},
        // CTA patterns
        {"<section class=\"cta", SEC_CTA},
        {"class=\"cta", SEC_CTA},
        {"class=\"call-to-action", SEC_CTA},
        {"class=\"promo", SEC_CTA}
    };

    int sectionId = 1;
    std::string lowerHTML = html;
    std::transform(lowerHTML.begin(), lowerHTML.end(), lowerHTML.begin(), ::tolower);

    for (const auto& tag : sectionTags) {
        size_t pos = lowerHTML.find(tag.first);
        if (pos != std::string::npos && pos < html.length()) {
            // Find the closing tag
            std::string tagName = tag.first.substr(1);
            size_t spacePos = tagName.find(" ");
            if (spacePos != std::string::npos) tagName = tagName.substr(0, spacePos);

            size_t endPos = lowerHTML.find("</" + tagName + ">", pos);
            if (endPos == std::string::npos) endPos = pos + 2000; // Limit section size

            // Clamp endPos to html length
            if (endPos > html.length()) endPos = html.length();
            if (endPos <= pos) continue; // Skip invalid ranges

            std::string sectionHTML = html.substr(pos, endPos - pos);
            if (sectionHTML.empty()) continue;

            // Create section
            int secTypeIdx = (int)tag.second;
            if (secTypeIdx < 0 || secTypeIdx >= (int)g_SectionTypeNames.size()) continue;

            WebSection sec(g_NextSectionId++, tag.second);
            sec.name = g_SectionTypeNames[secTypeIdx];

            // Extract text content (strip HTML tags)
            std::string text = sectionHTML;
            // Simple tag removal
            std::string cleanText;
            bool inTag = false;
            for (char c : text) {
                if (c == '<') inTag = true;
                else if (c == '>') inTag = false;
                else if (!inTag && c != '\n' && c != '\r' && c != '\t') cleanText += c;
            }

            // Find headings (with bounds checking)
            size_t h1Start = sectionHTML.find("<h1");
            size_t h1End = sectionHTML.find("</h1>");
            if (h1Start != std::string::npos && h1End != std::string::npos && h1End > h1Start) {
                size_t textStart = sectionHTML.find(">", h1Start);
                if (textStart != std::string::npos && textStart + 1 < h1End) {
                    textStart += 1;
                    std::string h1Text = sectionHTML.substr(textStart, h1End - textStart);
                    // Strip inner tags
                    std::string clean;
                    bool inT = false;
                    for (char c : h1Text) {
                        if (c == '<') inT = true;
                        else if (c == '>') inT = false;
                        else if (!inT) clean += c;
                    }
                    sec.title = clean;
                }
            }

            size_t h2Start = sectionHTML.find("<h2");
            size_t h2End = sectionHTML.find("</h2>");
            if (h2Start != std::string::npos && h2End != std::string::npos && h2End > h2Start) {
                size_t textStart = sectionHTML.find(">", h2Start);
                if (textStart != std::string::npos && textStart + 1 < h2End) {
                    textStart += 1;
                    std::string h2Text = sectionHTML.substr(textStart, h2End - textStart);
                    std::string clean;
                    bool inT = false;
                    for (char c : h2Text) {
                        if (c == '<') inT = true;
                        else if (c == '>') inT = false;
                        else if (!inT) clean += c;
                    }
                    if (sec.title.empty()) sec.title = clean;
                    else sec.subtitle = clean;
                }
            }

            // Find paragraph content (with bounds checking)
            size_t pStart = sectionHTML.find("<p");
            size_t pEnd = sectionHTML.find("</p>");
            if (pStart != std::string::npos && pEnd != std::string::npos && pEnd > pStart) {
                size_t textStart = sectionHTML.find(">", pStart);
                if (textStart != std::string::npos && textStart + 1 < pEnd) {
                    textStart += 1;
                    std::string pText = sectionHTML.substr(textStart, pEnd - textStart);
                    std::string clean;
                    bool inT = false;
                    for (char c : pText) {
                        if (c == '<') inT = true;
                        else if (c == '>') inT = false;
                        else if (!inT) clean += c;
                    }
                    sec.content = clean;
                }
            }

            // Find images in this section (with bounds checking)
            size_t imgPos = 0;
            while ((imgPos = sectionHTML.find("<img", imgPos)) != std::string::npos) {
                size_t srcPos = sectionHTML.find("src=", imgPos);
                if (srcPos != std::string::npos && srcPos < imgPos + 200 && srcPos + 5 < sectionHTML.length()) {
                    char quote = sectionHTML[srcPos + 4];
                    if (quote == '"' || quote == '\'') {
                        size_t srcStart = srcPos + 5;
                        size_t srcEnd = sectionHTML.find(quote, srcStart);
                        if (srcEnd != std::string::npos && srcEnd > srcStart) {
                            std::string imgSrc = sectionHTML.substr(srcStart, srcEnd - srcStart);
                            if (sec.section_image.empty() && !imgSrc.empty()) {
                                sec.section_image = imgSrc;
                            }
                        }
                    }
                }
                imgPos++;
            }

            // Find buttons (with bounds checking)
            size_t btnPos = sectionHTML.find("<button");
            if (btnPos == std::string::npos) btnPos = sectionHTML.find("<a class=\"btn");
            if (btnPos == std::string::npos) btnPos = sectionHTML.find("<a class=\"button");
            if (btnPos != std::string::npos) {
                size_t btnEnd = sectionHTML.find(">", btnPos);
                if (btnEnd != std::string::npos && btnEnd + 1 < sectionHTML.length()) {
                    size_t btnTextEnd = sectionHTML.find("<", btnEnd + 1);
                    if (btnTextEnd != std::string::npos && btnTextEnd > btnEnd + 1) {
                        sec.button_text = sectionHTML.substr(btnEnd + 1, btnTextEnd - btnEnd - 1);
                        // Trim whitespace
                        size_t start = sec.button_text.find_first_not_of(" \t\n\r");
                        size_t end = sec.button_text.find_last_not_of(" \t\n\r");
                        if (start != std::string::npos && end != std::string::npos && end >= start) {
                            sec.button_text = sec.button_text.substr(start, end - start + 1);
                        }
                    }
                }
            }

            // Set default height based on section type
            if (tag.second == SEC_NAVBAR) sec.height = 80;
            else if (tag.second == SEC_HERO) sec.height = 600;
            else if (tag.second == SEC_FOOTER) sec.height = 200;
            else sec.height = 400;

            sections.push_back(sec);
            printf("[LocalParse] Found section: %s (type: %d)\n", sec.name.c_str(), (int)tag.second);
        }
    }

        // If too few sections found, create automatic sections by splitting content
        if (sections.size() < 3) {
            printf("[LocalParse] Only found %zu sections, creating automatic sections...\n", sections.size());
            sections.clear(); // Start fresh with auto-detection

            // Create Hero from page title
            WebSection hero(g_NextSectionId++, SEC_HERO);
            hero.title = pageTitle;
            hero.subtitle = "Welcome to our website";
            hero.height = 600;
            sections.push_back(hero);

            // Find all major content divs and create sections
            std::vector<std::string> majorDivs;
            size_t searchPos = 0;
            int divCount = 0;

            // Look for divs with substantial content
            while ((searchPos = html.find("<div", searchPos)) != std::string::npos && divCount < 10) {
                // Find the closing of this div's opening tag
                size_t tagEnd = html.find(">", searchPos);
                if (tagEnd == std::string::npos) break;

                // Check if this div has a class (likely important)
                std::string tagContent = html.substr(searchPos, tagEnd - searchPos);
                if (tagContent.find("class=") != std::string::npos) {
                    // Find a reasonable end point (next major div or limit)
                    size_t contentEnd = html.find("</div>", tagEnd);
                    if (contentEnd != std::string::npos) {
                        size_t contentLen = contentEnd - tagEnd;
                        // Only consider substantial divs (>500 chars of content)
                        if (contentLen > 500 && contentLen < 10000) {
                            std::string divContent = html.substr(tagEnd + 1, contentLen);

                            // Extract text from this div
                            std::string cleanText;
                            bool inT = false;
                            for (char c : divContent) {
                                if (c == '<') inT = true;
                                else if (c == '>') inT = false;
                                else if (!inT && c != '\n' && c != '\r' && c != '\t') cleanText += c;
                            }

                            // Only use if has meaningful text
                            if (cleanText.length() > 50) {
                                // Determine section type based on content or position
                                SectionType secType = SEC_SERVICES;
                                if (divCount == 0) secType = SEC_SERVICES;
                                else if (divCount == 1) secType = SEC_SERVICES;
                                else if (divCount == 2) secType = SEC_CTA;
                                else secType = SEC_SERVICES;

                                WebSection sec(g_NextSectionId++, secType);
                                sec.name = "Section " + std::to_string(divCount + 1);

                                // Extract first heading as title
                                size_t hStart = divContent.find("<h");
                                if (hStart != std::string::npos) {
                                    size_t hTagEnd = divContent.find(">", hStart);
                                    size_t hEnd = divContent.find("</h", hTagEnd);
                                    if (hTagEnd != std::string::npos && hEnd != std::string::npos) {
                                        std::string heading = divContent.substr(hTagEnd + 1, hEnd - hTagEnd - 1);
                                        // Strip tags from heading
                                        std::string cleanH;
                                        bool inHT = false;
                                        for (char c : heading) {
                                            if (c == '<') inHT = true;
                                            else if (c == '>') inHT = false;
                                            else if (!inHT) cleanH += c;
                                        }
                                        sec.title = cleanH.substr(0, 100); // Limit length
                                    }
                                }

                                if (sec.title.empty()) {
                                    sec.title = "Section " + std::to_string(divCount + 1);
                                }

                                sec.height = 400;
                                sections.push_back(sec);
                                divCount++;
                                printf("[LocalParse] Auto-created section: %s\n", sec.title.c_str());
                            }
                        }
                    }
                }
                searchPos = tagEnd + 1;
            }

            // Add a footer section
            WebSection footer(g_NextSectionId++, SEC_FOOTER);
            footer.title = pageTitle;
            footer.content = "Contact us for more information";
            footer.height = 200;
            sections.push_back(footer);
        }

        return true;
    } catch (const std::exception& e) {
        printf("[LocalParse] Exception: %s\n", e.what());
        return false;
    } catch (...) {
        printf("[LocalParse] Unknown exception\n");
        return false;
    }
}

// Main import from local download function
bool ImportFromLocalDownload(const std::string& url) {
    g_URLImportStatus = "Starting local download import...";
    g_URLImportProgress = 0.0f;

    // Validate URL
    if (!ValidateURL(url)) {
        g_URLImportStatus = "Error: Invalid URL format";
        return false;
    }

    // Create download directory
    std::string domain = ExtractDomain(url);
    std::string timestamp = std::to_string(time(nullptr));
    std::string download_dir = "/Users/imaging/Desktop/Website-Builder-v2.0/downloaded_sites/" + domain + "_" + timestamp;

    // Step 1: Download website
    if (!DownloadWebsiteLocally(url, download_dir)) {
        return false;
    }

    g_URLImportStatus = "Parsing downloaded files...";
    g_URLImportProgress = 0.7f;

    // Step 2: Find HTML files
    std::vector<std::string> htmlFiles = FindFiles(download_dir, ".html");
    if (htmlFiles.empty()) {
        // Try without extension (some servers serve without .html)
        htmlFiles = FindFiles(download_dir, "index.html");
    }

    // Also check for index.htm
    if (htmlFiles.empty()) {
        htmlFiles = FindFiles(download_dir, ".htm");
    }

    printf("[LocalDownload] Found %zu HTML files\n", htmlFiles.size());

    if (htmlFiles.empty()) {
        g_URLImportStatus = "Error: No HTML files found in download";
        return false;
    }

    // Step 3: Parse HTML and create sections
    std::vector<WebSection> newSections;

    // Parse main index.html first
    std::string mainHTML;
    for (const auto& file : htmlFiles) {
        if (file.find("index") != std::string::npos) {
            mainHTML = file;
            break;
        }
    }
    if (mainHTML.empty()) mainHTML = htmlFiles[0];

    printf("[LocalDownload] Parsing main HTML: %s\n", mainHTML.c_str());

    if (!ParseLocalHTMLFile(mainHTML, newSections)) {
        g_URLImportStatus = "Error: Failed to parse HTML file";
        return false;
    }

    g_URLImportStatus = "Extracting CSS styles...";
    g_URLImportProgress = 0.8f;

    // Step 4: Parse CSS files for styling
    std::vector<std::string> cssFiles = FindFiles(download_dir, ".css");
    printf("[LocalDownload] Found %zu CSS files\n", cssFiles.size());

    std::map<std::string, std::string> allStyles;
    for (const auto& cssFile : cssFiles) {
        auto styles = ParseLocalCSSFile(cssFile);
        allStyles.insert(styles.begin(), styles.end());
    }

    // Step 5: Copy images to app directory
    g_URLImportStatus = "Processing images...";
    g_URLImportProgress = 0.85f;

    std::string imagesDir = "/Users/imaging/Desktop/Website-Builder-v2.0/scraped_images/" + domain;
    std::string mkdirCmd = "mkdir -p \"" + imagesDir + "\"";
    system(mkdirCmd.c_str());

    // Find and copy images
    std::vector<std::string> imageExts = {".jpg", ".jpeg", ".png", ".gif", ".webp", ".svg"};
    for (const auto& ext : imageExts) {
        std::vector<std::string> images = FindFiles(download_dir, ext);
        for (const auto& img : images) {
            std::string filename = img.substr(img.find_last_of("/") + 1);
            std::string destPath = imagesDir + "/" + filename;
            std::string cpCmd = "cp \"" + img + "\" \"" + destPath + "\" 2>/dev/null";
            system(cpCmd.c_str());
        }
    }

    // Step 6: Update sections with local image paths
    std::vector<std::string> localImages = FindFiles(imagesDir, "");
    for (auto& sec : newSections) {
        if (!sec.section_image.empty()) {
            // Try to find matching image
            std::string imgName = sec.section_image;
            if (imgName.find("/") != std::string::npos) {
                imgName = imgName.substr(imgName.find_last_of("/") + 1);
            }

            for (const auto& localImg : localImages) {
                if (localImg.find(imgName) != std::string::npos) {
                    sec.section_image = localImg;
                    // Load texture
                    ImageTexture tex = LoadTexture(localImg);
                    sec.img_texture_id = tex.id;
                    break;
                }
            }
        }
    }

    g_URLImportStatus = "Creating template...";
    g_URLImportProgress = 0.9f;

    // Step 7: Save to database and load
    g_Sections.clear();
    g_Sections = newSections;

    // Generate template name
    std::string template_name = "local_" + domain + "_" + timestamp.substr(timestamp.length() - 6);

    // Save template
    g_ProjectName = template_name;
    SaveTemplate(template_name, "Imported from local download");

    // Reload to ensure proper state
    LoadTemplate(template_name);
    LoadAvailableTemplates();

    if (g_Sections.empty()) {
        g_URLImportStatus = "Error: No sections created";
        return false;
    }

    g_URLImportStatus = "Success! Imported " + std::to_string(g_Sections.size()) + " sections from local download";
    g_URLImportProgress = 1.0f;

    printf("[LocalDownload] Import complete: %zu sections\n", g_Sections.size());

    return true;
}

// ============================================================================
// FIGMA-STYLE LAYER IMPORT AND RENDERING
// ============================================================================

// Helper function to parse color string (rgb/rgba) to ImVec4
ImVec4 ParseColorString(const std::string& colorStr) {
    ImVec4 color(0, 0, 0, 1);
    if (colorStr.empty()) return color;

    // Try to parse rgba(r, g, b, a) or rgb(r, g, b)
    if (colorStr.find("rgba") != std::string::npos) {
        float r, g, b, a;
        if (sscanf(colorStr.c_str(), "rgba(%f, %f, %f, %f)", &r, &g, &b, &a) == 4 ||
            sscanf(colorStr.c_str(), "rgba(%f,%f,%f,%f)", &r, &g, &b, &a) == 4) {
            color = ImVec4(r/255.0f, g/255.0f, b/255.0f, a);
        }
    } else if (colorStr.find("rgb") != std::string::npos) {
        float r, g, b;
        if (sscanf(colorStr.c_str(), "rgb(%f, %f, %f)", &r, &g, &b) == 3 ||
            sscanf(colorStr.c_str(), "rgb(%f,%f,%f)", &r, &g, &b) == 3) {
            color = ImVec4(r/255.0f, g/255.0f, b/255.0f, 1.0f);
        }
    }
    return color;
}

WebLayer* GetLayerById(int id) {
    for (auto& layer : g_FigmaProject.layers) {
        if (layer.id == id) return &layer;
    }
    return nullptr;
}

void SelectLayer(int id) {
    DeselectAllLayers();
    if (WebLayer* layer = GetLayerById(id)) {
        layer->selected = true;
        g_SelectedLayerId = id;
    }
}

void DeselectAllLayers() {
    for (auto& layer : g_FigmaProject.layers) {
        layer.selected = false;
    }
    g_SelectedLayerId = -1;
}

bool ImportFigmaLayers(const std::string& url) {
    printf("[FigmaImport] Starting Figma-style import from: %s\n", url.c_str());
    g_FigmaImportInProgress = true;
    g_FigmaImportStatus = "Running layer extractor...";

    // Create output directory
    std::string outputDir = "/tmp/figma_import";
    std::string cmd = "mkdir -p " + outputDir;
    system(cmd.c_str());

    // Run Python scraper using playwright_env virtual environment
    std::string pythonCmd = "cd /Users/imaging/Desktop/Website-Builder-v2.0 && "
                           "source playwright_env/bin/activate && "
                           "python3 figma_layer_scraper.py \"" + url + "\" \"" + outputDir + "\" 2>&1";

    printf("[FigmaImport] Running: %s\n", pythonCmd.c_str());

    FILE* pipe = popen(pythonCmd.c_str(), "r");
    if (!pipe) {
        g_FigmaImportStatus = "Error: Failed to run scraper";
        g_FigmaImportInProgress = false;
        return false;
    }

    // Read output
    char buffer[256];
    std::string output;
    while (fgets(buffer, sizeof(buffer), pipe)) {
        output += buffer;
        printf("%s", buffer);
    }
    int result = pclose(pipe);

    if (result != 0) {
        g_FigmaImportStatus = "Error: Scraper failed";
        g_FigmaImportInProgress = false;
        return false;
    }

    // Parse JSON output
    std::string jsonPath = outputDir + "/layers.json";
    FILE* jsonFile = fopen(jsonPath.c_str(), "r");
    if (!jsonFile) {
        g_FigmaImportStatus = "Error: Could not open layers.json";
        g_FigmaImportInProgress = false;
        return false;
    }

    // Read JSON file
    fseek(jsonFile, 0, SEEK_END);
    long fileSize = ftell(jsonFile);
    fseek(jsonFile, 0, SEEK_SET);
    std::string jsonContent(fileSize, '\0');
    fread(&jsonContent[0], 1, fileSize, jsonFile);
    fclose(jsonFile);

    // Simple JSON parsing (for our specific format)
    g_FigmaProject = FigmaProject();
    g_FigmaProject.layers.clear();

    // Parse canvas dimensions
    size_t widthPos = jsonContent.find("\"canvas_width\":");
    size_t heightPos = jsonContent.find("\"canvas_height\":");
    if (widthPos != std::string::npos) {
        g_FigmaProject.canvas_width = std::stof(jsonContent.substr(widthPos + 15, 10));
    }
    if (heightPos != std::string::npos) {
        g_FigmaProject.canvas_height = std::stof(jsonContent.substr(heightPos + 16, 10));
    }

    // Parse screenshot path
    size_t ssPos = jsonContent.find("\"screenshot_path\":");
    if (ssPos != std::string::npos) {
        size_t start = jsonContent.find("\"", ssPos + 18) + 1;
        size_t end = jsonContent.find("\"", start);
        g_FigmaProject.screenshot_path = jsonContent.substr(start, end - start);

        // Load screenshot texture
        int w, h, n;
        unsigned char* data = stbi_load(g_FigmaProject.screenshot_path.c_str(), &w, &h, &n, 4);
        if (data) {
            glGenTextures(1, &g_FigmaProject.screenshot_texture_id);
            glBindTexture(GL_TEXTURE_2D, g_FigmaProject.screenshot_texture_id);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
            stbi_image_free(data);
            printf("[FigmaImport] Loaded screenshot: %dx%d\n", w, h);
        }
    }

    // Parse layers array (simplified parsing)
    size_t layersStart = jsonContent.find("\"layers\":");
    if (layersStart == std::string::npos) {
        g_FigmaImportStatus = "Error: No layers found in JSON";
        g_FigmaImportInProgress = false;
        return false;
    }

    // Find each layer object - look for "id": pattern (with possible whitespace)
    size_t pos = layersStart;
    int layerCount = 0;
    // Match both {"id": and {\n  "id": patterns
    while (true) {
        size_t idPos1 = jsonContent.find("\"id\":", pos);
        if (idPos1 == std::string::npos) break;
        pos = idPos1;
        WebLayer layer;

        // Parse id - skip whitespace after "id":
        size_t idStart = pos + 5;  // Skip "id":
        while (idStart < jsonContent.size() && (jsonContent[idStart] == ' ' || jsonContent[idStart] == '\t')) idStart++;
        layer.id = std::stoi(jsonContent.substr(idStart, 10));

        // Parse type
        size_t typePos = jsonContent.find("\"type\":", pos);
        if (typePos != std::string::npos && typePos < pos + 2000) {
            size_t typeStart = jsonContent.find("\"", typePos + 7) + 1;
            size_t typeEnd = jsonContent.find("\"", typeStart);
            std::string typeStr = jsonContent.substr(typeStart, typeEnd - typeStart);
            if (typeStr == "LAYER_TEXT") layer.type = LAYER_TEXT;
            else if (typeStr == "LAYER_IMAGE") layer.type = LAYER_IMAGE;
            else if (typeStr == "LAYER_BUTTON") layer.type = LAYER_BUTTON;
            else if (typeStr == "LAYER_INPUT") layer.type = LAYER_INPUT;
            else layer.type = LAYER_DIV;
        }

        // Parse position and size
        auto parseFloat = [&](const char* key) -> float {
            size_t keyPos = jsonContent.find(key, pos);
            if (keyPos != std::string::npos && keyPos < pos + 2000) {
                size_t valStart = keyPos + strlen(key);
                return std::stof(jsonContent.substr(valStart, 20));
            }
            return 0;
        };

        auto parseString = [&](const char* key) -> std::string {
            size_t keyPos = jsonContent.find(key, pos);
            if (keyPos != std::string::npos && keyPos < pos + 3000) {
                size_t start = jsonContent.find("\"", keyPos + strlen(key)) + 1;
                size_t end = jsonContent.find("\"", start);
                if (end > start && end - start < 1000) {
                    return jsonContent.substr(start, end - start);
                }
            }
            return "";
        };

        layer.x = parseFloat("\"x\":");
        layer.y = parseFloat("\"y\":");
        layer.width = parseFloat("\"width\":");
        layer.height = parseFloat("\"height\":");
        layer.z_index = (int)parseFloat("\"z_index\":");
        layer.font_size = parseFloat("\"font_size\":");
        layer.font_weight = parseFloat("\"font_weight\":");
        layer.opacity = parseFloat("\"opacity\":");
        layer.border_width = parseFloat("\"border_width\":");
        layer.border_radius = parseFloat("\"border_radius\":");

        layer.name = parseString("\"name\":");
        layer.text = parseString("\"text\":");
        layer.image_path = parseString("\"image_path\":");
        layer.href = parseString("\"href\":");
        layer.font_family = parseString("\"font_family\":");

        // Parse colors
        std::string bgColor = parseString("\"bg_color\":");
        std::string textColor = parseString("\"text_color\":");
        layer.bg_color = ParseColorString(bgColor);
        layer.text_color = ParseColorString(textColor);

        // Load image texture if needed
        if (!layer.image_path.empty() && layer.type == LAYER_IMAGE) {
            int w, h, n;
            unsigned char* data = stbi_load(layer.image_path.c_str(), &w, &h, &n, 4);
            if (data) {
                glGenTextures(1, &layer.texture_id);
                glBindTexture(GL_TEXTURE_2D, layer.texture_id);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
                glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
                stbi_image_free(data);
            }
        }

        g_FigmaProject.layers.push_back(layer);
        layerCount++;

        // Move pos forward to find the next layer (skip past current "id":)
        pos += 10;

        if (layerCount > 500) break;  // Safety limit
    }

    printf("[FigmaImport] Parsed %d layers\n", layerCount);

    g_FigmaMode = true;
    g_FigmaImportInProgress = false;
    g_FigmaImportStatus = "Success! Imported " + std::to_string(layerCount) + " layers";

    return true;
}

// Load a saved Figma project from JSON file
bool LoadFigmaProject(const std::string& filepath) {
    FILE* f = fopen(filepath.c_str(), "r");
    if (!f) {
        printf("[Figma] Failed to open project file: %s\n", filepath.c_str());
        return false;
    }

    // Read entire file
    fseek(f, 0, SEEK_END);
    long fileSize = ftell(f);
    fseek(f, 0, SEEK_SET);

    std::string content(fileSize, '\0');
    fread(&content[0], 1, fileSize, f);
    fclose(f);

    printf("[Figma] Loading project from: %s\n", filepath.c_str());

    // Clear current project
    g_FigmaProject = FigmaProject();
    g_FigmaProject.layers.clear();

    // Parse project info
    size_t namePos = content.find("\"name\":");
    if (namePos != std::string::npos) {
        size_t start = content.find("\"", namePos + 7) + 1;
        size_t end = content.find("\"", start);
        g_FigmaProject.name = content.substr(start, end - start);
    }

    size_t cwPos = content.find("\"canvas_width\":");
    if (cwPos != std::string::npos) {
        g_FigmaProject.canvas_width = atof(content.c_str() + cwPos + 15);
    }

    size_t chPos = content.find("\"canvas_height\":");
    if (chPos != std::string::npos) {
        g_FigmaProject.canvas_height = atof(content.c_str() + chPos + 16);
    }

    size_t ssPos = content.find("\"screenshot_path\":");
    if (ssPos != std::string::npos) {
        size_t start = content.find("\"", ssPos + 18) + 1;
        size_t end = content.find("\"", start);
        g_FigmaProject.screenshot_path = content.substr(start, end - start);
    }

    // Load screenshot texture
    if (!g_FigmaProject.screenshot_path.empty()) {
        int w, h, n;
        unsigned char* data = stbi_load(g_FigmaProject.screenshot_path.c_str(), &w, &h, &n, 4);
        if (data) {
            glGenTextures(1, &g_FigmaProject.screenshot_texture_id);
            glBindTexture(GL_TEXTURE_2D, g_FigmaProject.screenshot_texture_id);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
            stbi_image_free(data);
            printf("[Figma] Loaded screenshot: %dx%d\n", w, h);
        }
    }

    // Parse layers
    size_t layersPos = content.find("\"layers\":");
    if (layersPos == std::string::npos) {
        printf("[Figma] No layers found in project\n");
        g_FigmaMode = true;
        return true;
    }

    int layerCount = 0;
    size_t pos = layersPos;
    while ((pos = content.find("\"id\":", pos)) != std::string::npos) {
        WebLayer layer;

        // Parse id
        layer.id = atoi(content.c_str() + pos + 5);

        // Parse type
        size_t typePos = content.find("\"type\":", pos);
        if (typePos != std::string::npos && typePos < pos + 500) {
            size_t start = content.find("\"", typePos + 7) + 1;
            size_t end = content.find("\"", start);
            std::string typeStr = content.substr(start, end - start);
            if (typeStr == "LAYER_TEXT") layer.type = LAYER_TEXT;
            else if (typeStr == "LAYER_IMAGE") layer.type = LAYER_IMAGE;
            else if (typeStr == "LAYER_BUTTON") layer.type = LAYER_BUTTON;
            else layer.type = LAYER_DIV;
        }

        // Parse name
        size_t nameP = content.find("\"name\":", pos);
        if (nameP != std::string::npos && nameP < pos + 500) {
            size_t start = content.find("\"", nameP + 7) + 1;
            size_t end = content.find("\"", start);
            layer.name = content.substr(start, end - start);
        }

        // Parse x, y, width, height
        size_t xPos = content.find("\"x\":", pos);
        if (xPos != std::string::npos && xPos < pos + 500) {
            layer.x = atof(content.c_str() + xPos + 4);
        }
        size_t yPos = content.find("\"y\":", pos);
        if (yPos != std::string::npos && yPos < pos + 500) {
            layer.y = atof(content.c_str() + yPos + 4);
        }
        size_t wPos = content.find("\"width\":", pos);
        if (wPos != std::string::npos && wPos < pos + 500) {
            layer.width = atof(content.c_str() + wPos + 8);
        }
        size_t hPos = content.find("\"height\":", pos);
        if (hPos != std::string::npos && hPos < pos + 500) {
            layer.height = atof(content.c_str() + hPos + 9);
        }

        // Parse text
        size_t textPos = content.find("\"text\":", pos);
        if (textPos != std::string::npos && textPos < pos + 500) {
            size_t start = content.find("\"", textPos + 7) + 1;
            size_t end = content.find("\"", start);
            layer.text = content.substr(start, end - start);
        }

        // Parse font_size
        size_t fsPos = content.find("\"font_size\":", pos);
        if (fsPos != std::string::npos && fsPos < pos + 500) {
            layer.font_size = atof(content.c_str() + fsPos + 12);
        }

        // Parse opacity
        size_t opPos = content.find("\"opacity\":", pos);
        if (opPos != std::string::npos && opPos < pos + 500) {
            layer.opacity = atof(content.c_str() + opPos + 10);
        }

        // Parse image_path (if present)
        size_t imgPos = content.find("\"image_path\":", pos);
        if (imgPos != std::string::npos && imgPos < pos + 500) {
            size_t start = content.find("\"", imgPos + 13) + 1;
            size_t end = content.find("\"", start);
            layer.image_path = content.substr(start, end - start);

            // Load texture if image layer
            if (layer.type == LAYER_IMAGE && !layer.image_path.empty()) {
                int w, h, n;
                unsigned char* data = stbi_load(layer.image_path.c_str(), &w, &h, &n, 4);
                if (data) {
                    glGenTextures(1, &layer.texture_id);
                    glBindTexture(GL_TEXTURE_2D, layer.texture_id);
                    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
                    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
                    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
                    stbi_image_free(data);
                }
            }
        }

        g_FigmaProject.layers.push_back(layer);
        g_FigmaProject.next_layer_id = std::max(g_FigmaProject.next_layer_id, layer.id + 1);
        layerCount++;
        pos += 10;

        if (layerCount > 500) break;
    }

    printf("[Figma] Loaded %d layers\n", layerCount);
    g_FigmaMode = true;
    return true;
}

// Get list of saved projects
std::vector<std::string> GetSavedFigmaProjects() {
    std::vector<std::string> projects;
    std::string dir = "/Users/imaging/Desktop/Website-Builder-v2.0/figma_projects/";

    DIR* d = opendir(dir.c_str());
    if (d) {
        struct dirent* entry;
        while ((entry = readdir(d)) != NULL) {
            std::string name = entry->d_name;
            if (name.size() > 5 && name.substr(name.size() - 5) == ".json") {
                projects.push_back(dir + name);
            }
        }
        closedir(d);
    }
    return projects;
}

void RenderFigmaCanvas() {
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* drawList = ImGui::GetWindowDrawList();

    // Get canvas area
    ImVec2 canvasPos = ImGui::GetCursorScreenPos();
    ImVec2 canvasSize = ImGui::GetContentRegionAvail();

    // Background
    drawList->AddRectFilled(canvasPos,
        ImVec2(canvasPos.x + canvasSize.x, canvasPos.y + canvasSize.y),
        IM_COL32(40, 40, 45, 255));

    // Calculate visible area based on scroll and zoom
    float zoom = g_FigmaProject.zoom;
    float scrollX = g_FigmaProject.scroll_x;
    float scrollY = g_FigmaProject.scroll_y;

    // Draw reference screenshot if enabled
    if (g_FigmaProject.show_reference && g_FigmaProject.screenshot_texture_id) {
        float imgW = g_FigmaProject.canvas_width * zoom;
        float imgH = g_FigmaProject.canvas_height * zoom;
        ImVec2 imgPos(canvasPos.x - scrollX, canvasPos.y - scrollY);

        // Draw reference screenshot with opacity using drawlist (no SetCursorScreenPos needed)
        ImU32 tintCol = IM_COL32(255, 255, 255, (int)(g_FigmaProject.reference_opacity * 255));
        drawList->AddImage((ImTextureID)(intptr_t)g_FigmaProject.screenshot_texture_id,
            imgPos,
            ImVec2(imgPos.x + imgW, imgPos.y + imgH),
            ImVec2(0, 0), ImVec2(1, 1), tintCol);
    }

    // Draw grid if enabled
    if (g_FigmaProject.show_grid) {
        float gridSize = g_FigmaProject.grid_size * zoom;
        ImU32 gridColor = IM_COL32(60, 60, 65, 100);

        for (float x = fmod(-scrollX, gridSize); x < canvasSize.x; x += gridSize) {
            drawList->AddLine(
                ImVec2(canvasPos.x + x, canvasPos.y),
                ImVec2(canvasPos.x + x, canvasPos.y + canvasSize.y),
                gridColor);
        }
        for (float y = fmod(-scrollY, gridSize); y < canvasSize.y; y += gridSize) {
            drawList->AddLine(
                ImVec2(canvasPos.x, canvasPos.y + y),
                ImVec2(canvasPos.x + canvasSize.x, canvasPos.y + y),
                gridColor);
        }
    }

    // Draw layers - when reference screenshot is visible, layers are transparent overlays
    // Only show selection/hover outlines, not the actual layer content (since screenshot shows the real design)
    bool useOverlayMode = g_FigmaProject.show_reference && g_FigmaProject.reference_opacity > 0.5f;

    for (auto& layer : g_FigmaProject.layers) {
        if (!layer.visible) continue;

        // Calculate screen position
        float screenX = canvasPos.x + (layer.x * zoom) - scrollX;
        float screenY = canvasPos.y + (layer.y * zoom) - scrollY;
        float screenW = layer.width * zoom;
        float screenH = layer.height * zoom;

        // Skip if outside visible area
        if (screenX + screenW < canvasPos.x || screenX > canvasPos.x + canvasSize.x) continue;
        if (screenY + screenH < canvasPos.y || screenY > canvasPos.y + canvasSize.y) continue;

        ImVec2 p1(screenX, screenY);
        ImVec2 p2(screenX + screenW, screenY + screenH);

        // In overlay mode (reference visible), don't draw layer fills - let screenshot show through
        // Only draw content when reference is hidden or very transparent
        if (!useOverlayMode) {
            // Draw layer based on type
            ImU32 bgCol = ImGui::ColorConvertFloat4ToU32(layer.bg_color);

            // Background
            if (layer.bg_color.w > 0.01f) {
                if (layer.border_radius > 0) {
                    drawList->AddRectFilled(p1, p2, bgCol, layer.border_radius * zoom);
                } else {
                    drawList->AddRectFilled(p1, p2, bgCol);
                }
            }

            // Image - use drawList to avoid SetCursorScreenPos issues
            if (layer.type == LAYER_IMAGE && layer.texture_id) {
                drawList->AddImage((ImTextureID)(intptr_t)layer.texture_id,
                    p1, p2, ImVec2(0, 0), ImVec2(1, 1), IM_COL32(255, 255, 255, 255));
            }

            // Text
            if (!layer.text.empty() && (layer.type == LAYER_TEXT || layer.type == LAYER_BUTTON)) {
                ImU32 textCol = ImGui::ColorConvertFloat4ToU32(layer.text_color);
                // Simple text rendering (centered for buttons)
                ImVec2 textPos = p1;
                if (layer.type == LAYER_BUTTON) {
                    ImVec2 textSize = ImGui::CalcTextSize(layer.text.c_str());
                    textPos.x = screenX + (screenW - textSize.x) / 2;
                    textPos.y = screenY + (screenH - textSize.y) / 2;
                } else {
                    textPos.x += layer.padding_left * zoom;
                    textPos.y += layer.padding_top * zoom;
                }
                drawList->AddText(textPos, textCol, layer.text.c_str());
            }

            // Border
            if (layer.border_width > 0) {
                ImU32 borderCol = ImGui::ColorConvertFloat4ToU32(layer.border_color);
                if (layer.border_radius > 0) {
                    drawList->AddRect(p1, p2, borderCol, layer.border_radius * zoom, 0, layer.border_width);
                } else {
                    drawList->AddRect(p1, p2, borderCol, 0, 0, layer.border_width);
                }
            }
        }

        // Selection highlight (always show)
        if (layer.selected) {
            drawList->AddRect(p1, p2, IM_COL32(0, 150, 255, 255), 0, 0, 2.0f);

            // Resize handles
            float handleSize = 8;
            ImU32 handleColor = IM_COL32(255, 255, 255, 255);
            ImU32 handleBorder = IM_COL32(0, 150, 255, 255);

            // Corner handles
            ImVec2 handles[8] = {
                ImVec2(p1.x, p1.y),                      // Top-left
                ImVec2(p1.x + screenW/2, p1.y),         // Top-center
                ImVec2(p2.x, p1.y),                      // Top-right
                ImVec2(p2.x, p1.y + screenH/2),         // Right-center
                ImVec2(p2.x, p2.y),                      // Bottom-right
                ImVec2(p1.x + screenW/2, p2.y),         // Bottom-center
                ImVec2(p1.x, p2.y),                      // Bottom-left
                ImVec2(p1.x, p1.y + screenH/2)          // Left-center
            };

            for (int i = 0; i < 8; i++) {
                drawList->AddRectFilled(
                    ImVec2(handles[i].x - handleSize/2, handles[i].y - handleSize/2),
                    ImVec2(handles[i].x + handleSize/2, handles[i].y + handleSize/2),
                    handleColor);
                drawList->AddRect(
                    ImVec2(handles[i].x - handleSize/2, handles[i].y - handleSize/2),
                    ImVec2(handles[i].x + handleSize/2, handles[i].y + handleSize/2),
                    handleBorder);
            }
        }

        // Check for hover/click (simplified)
        ImVec2 mousePos = io.MousePos;
        bool isHovered = mousePos.x >= p1.x && mousePos.x <= p2.x &&
                        mousePos.y >= p1.y && mousePos.y <= p2.y;

        // Hover highlight (subtle in overlay mode)
        if (isHovered && !layer.selected) {
            if (useOverlayMode) {
                // Subtle highlight in overlay mode
                drawList->AddRect(p1, p2, IM_COL32(0, 150, 255, 100), 0, 0, 1.0f);
            } else {
                drawList->AddRect(p1, p2, IM_COL32(100, 150, 255, 150), 0, 0, 1.0f);
            }
        }

        // Handle click to select
        if (isHovered && ImGui::IsMouseClicked(0) && !io.KeyCtrl) {
            SelectLayer(layer.id);
        }

        // Handle dragging
        if (layer.selected && !layer.locked) {
            if (isHovered && ImGui::IsMouseClicked(0)) {
                layer.dragging = true;
                layer.drag_offset_x = mousePos.x - screenX;
                layer.drag_offset_y = mousePos.y - screenY;
            }

            if (layer.dragging) {
                if (ImGui::IsMouseDown(0)) {
                    float newX = (mousePos.x - layer.drag_offset_x - canvasPos.x + scrollX) / zoom;
                    float newY = (mousePos.y - layer.drag_offset_y - canvasPos.y + scrollY) / zoom;

                    // Snap to grid if enabled
                    if (g_FigmaProject.snap_to_grid) {
                        newX = round(newX / g_FigmaProject.grid_size) * g_FigmaProject.grid_size;
                        newY = round(newY / g_FigmaProject.grid_size) * g_FigmaProject.grid_size;
                    }

                    layer.x = newX;
                    layer.y = newY;
                } else {
                    layer.dragging = false;
                }
            }
        }
    }

    // Handle canvas panning and scrolling
    if (ImGui::IsWindowHovered()) {
        // Middle mouse drag = pan
        if (ImGui::IsMouseDragging(2)) {
            g_FigmaProject.scroll_x -= io.MouseDelta.x;
            g_FigmaProject.scroll_y -= io.MouseDelta.y;
        }

        // Scroll wheel behavior:
        // - Normal scroll = vertical scroll (up/down)
        // - Ctrl + scroll = zoom
        // - Shift + scroll = horizontal scroll (left/right)
        if (io.MouseWheel != 0) {
            if (io.KeyCtrl) {
                // Ctrl + scroll = zoom
                float zoomDelta = io.MouseWheel * 0.1f;
                g_FigmaProject.zoom = std::max(0.1f, std::min(3.0f, g_FigmaProject.zoom + zoomDelta));
            } else if (io.KeyShift) {
                // Shift + scroll = horizontal scroll
                g_FigmaProject.scroll_x -= io.MouseWheel * 50.0f;
            } else {
                // Normal scroll = vertical scroll
                g_FigmaProject.scroll_y -= io.MouseWheel * 50.0f;
            }
        }

        // Also handle horizontal scroll wheel (if available)
        if (io.MouseWheelH != 0) {
            g_FigmaProject.scroll_x -= io.MouseWheelH * 50.0f;
        }

        // Arrow keys for scrolling
        if (ImGui::IsKeyDown(ImGuiKey_UpArrow)) g_FigmaProject.scroll_y -= 10.0f;
        if (ImGui::IsKeyDown(ImGuiKey_DownArrow)) g_FigmaProject.scroll_y += 10.0f;
        if (ImGui::IsKeyDown(ImGuiKey_LeftArrow)) g_FigmaProject.scroll_x -= 10.0f;
        if (ImGui::IsKeyDown(ImGuiKey_RightArrow)) g_FigmaProject.scroll_x += 10.0f;
    }

    // Click on empty area to deselect
    if (ImGui::IsMouseClicked(0) && ImGui::IsWindowHovered()) {
        bool clickedOnLayer = false;
        for (auto& layer : g_FigmaProject.layers) {
            float screenX = canvasPos.x + (layer.x * zoom) - scrollX;
            float screenY = canvasPos.y + (layer.y * zoom) - scrollY;
            float screenW = layer.width * zoom;
            float screenH = layer.height * zoom;

            if (io.MousePos.x >= screenX && io.MousePos.x <= screenX + screenW &&
                io.MousePos.y >= screenY && io.MousePos.y <= screenY + screenH) {
                clickedOnLayer = true;
                break;
            }
        }
        if (!clickedOnLayer) {
            DeselectAllLayers();
        }
    }
}

void RenderFigmaLayersPanel() {
    ImGui::Begin("Layers", &g_ShowFigmaLayers);

    // Toolbar
    if (ImGui::Button("+ Add Layer")) {
        WebLayer newLayer;
        newLayer.id = g_FigmaProject.next_layer_id++;
        newLayer.name = "New Layer";
        newLayer.x = 100;
        newLayer.y = 100;
        newLayer.width = 200;
        newLayer.height = 100;
        newLayer.bg_color = ImVec4(0.9f, 0.9f, 0.9f, 1.0f);
        g_FigmaProject.layers.push_back(newLayer);
    }

    ImGui::SameLine();
    if (ImGui::Button("Delete") && g_SelectedLayerId >= 0) {
        g_FigmaProject.layers.erase(
            std::remove_if(g_FigmaProject.layers.begin(), g_FigmaProject.layers.end(),
                [](const WebLayer& l) { return l.id == g_SelectedLayerId; }),
            g_FigmaProject.layers.end());
        g_SelectedLayerId = -1;
    }

    ImGui::Separator();

    // Layer list (reverse order - top layers first)
    for (int i = g_FigmaProject.layers.size() - 1; i >= 0; i--) {
        WebLayer& layer = g_FigmaProject.layers[i];

        ImGuiTreeNodeFlags flags = ImGuiTreeNodeFlags_Leaf | ImGuiTreeNodeFlags_NoTreePushOnOpen;
        if (layer.selected) flags |= ImGuiTreeNodeFlags_Selected;

        // Type icon
        const char* icon = "[ ]";
        switch (layer.type) {
            case LAYER_TEXT: icon = "[T]"; break;
            case LAYER_IMAGE: icon = "[I]"; break;
            case LAYER_BUTTON: icon = "[B]"; break;
            case LAYER_INPUT: icon = "[F]"; break;
            default: icon = "[D]"; break;
        }

        // Visibility toggle
        ImGui::PushID(layer.id);
        if (ImGui::Checkbox("##vis", &layer.visible)) {}
        ImGui::SameLine();

        // Layer name
        char label[128];
        snprintf(label, sizeof(label), "%s %s", icon, layer.name.c_str());

        if (ImGui::Selectable(label, layer.selected)) {
            SelectLayer(layer.id);
        }

        ImGui::PopID();
    }

    ImGui::End();
}

void RenderFigmaPropertiesPanel() {
    ImGui::Begin("Properties", &g_ShowFigmaProperties);

    WebLayer* layer = GetLayerById(g_SelectedLayerId);
    if (!layer) {
        ImGui::TextDisabled("No layer selected");
        ImGui::End();
        return;
    }

    // Name
    char nameBuffer[256];
    strncpy(nameBuffer, layer->name.c_str(), sizeof(nameBuffer));
    if (ImGui::InputText("Name", nameBuffer, sizeof(nameBuffer))) {
        layer->name = nameBuffer;
    }

    ImGui::Separator();

    // Position & Size
    if (ImGui::CollapsingHeader("Transform", ImGuiTreeNodeFlags_DefaultOpen)) {
        ImGui::DragFloat("X", &layer->x, 1.0f);
        ImGui::DragFloat("Y", &layer->y, 1.0f);
        ImGui::DragFloat("Width", &layer->width, 1.0f, 1.0f, 10000.0f);
        ImGui::DragFloat("Height", &layer->height, 1.0f, 1.0f, 10000.0f);
    }

    // Appearance
    if (ImGui::CollapsingHeader("Appearance", ImGuiTreeNodeFlags_DefaultOpen)) {
        ImGui::ColorEdit4("Background", (float*)&layer->bg_color);
        ImGui::ColorEdit4("Text Color", (float*)&layer->text_color);
        ImGui::DragFloat("Opacity", &layer->opacity, 0.01f, 0.0f, 1.0f);
        ImGui::DragFloat("Border Radius", &layer->border_radius, 1.0f, 0.0f, 100.0f);
        ImGui::DragFloat("Border Width", &layer->border_width, 0.5f, 0.0f, 20.0f);
        if (layer->border_width > 0) {
            ImGui::ColorEdit4("Border Color", (float*)&layer->border_color);
        }
    }

    // Text (if text layer)
    if (layer->type == LAYER_TEXT || layer->type == LAYER_BUTTON) {
        if (ImGui::CollapsingHeader("Text", ImGuiTreeNodeFlags_DefaultOpen)) {
            char textBuffer[1024];
            strncpy(textBuffer, layer->text.c_str(), sizeof(textBuffer));
            if (ImGui::InputTextMultiline("Content", textBuffer, sizeof(textBuffer), ImVec2(-1, 100))) {
                layer->text = textBuffer;
            }
            ImGui::DragFloat("Font Size", &layer->font_size, 1.0f, 8.0f, 200.0f);
            ImGui::DragFloat("Font Weight", &layer->font_weight, 100.0f, 100.0f, 900.0f);
        }
    }

    // Lock
    ImGui::Separator();
    ImGui::Checkbox("Locked", &layer->locked);

    ImGui::End();
}

// ============================================================================
// TEMPLATE STYLE PRESET APPLICATION
// ============================================================================

// Apply a specific style preset to a WebSection
void ApplyStylePreset(WebSection& sec, int styleIndex) {
    // Gallery only has 2 styles, others have 5
    int maxStyles = (sec.type == SEC_GALLERY) ? 2 : 5;
    if (styleIndex < 0 || styleIndex >= maxStyles) return;

    // The section already has default values from SetDefaults()
    // Now we modify them based on the selected style

    // IMPORTANT: Set the layout_style so rendering knows which layout to use
    sec.layout_style = styleIndex;

    switch (sec.type) {
        case SEC_HERO:
            if (styleIndex == 0) {
                // "Modern Gradient" (default - already set)
                // No changes needed
            } else if (styleIndex == 1) {
                // "Minimalist Light"
                sec.bg_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                sec.title_color = ImVec4(0.1f, 0.1f, 0.1f, 1.0f);
                sec.subtitle_color = ImVec4(0.4f, 0.4f, 0.4f, 1.0f);
                sec.content_color = ImVec4(0.3f, 0.3f, 0.3f, 1.0f);
                sec.button_bg_color = ImVec4(0.1f, 0.1f, 0.1f, 1.0f);
                sec.button_glass_effect = false;
                sec.animation_type = ANIM_SLIDE_DOWN;
            } else if (styleIndex == 2) {
                // "Dark Premium"
                sec.bg_color = ImVec4(0.08f, 0.08f, 0.12f, 1.0f);
                sec.title_color = ImVec4(0.85f, 0.75f, 0.45f, 1.0f);  // Gold
                sec.subtitle_color = ImVec4(0.9f, 0.9f, 0.9f, 1.0f);
                sec.content_color = ImVec4(0.7f, 0.7f, 0.7f, 1.0f);
                sec.button_bg_color = ImVec4(0.85f, 0.75f, 0.45f, 1.0f);  // Gold
                sec.button_text_color = ImVec4(0.1f, 0.1f, 0.1f, 1.0f);
                sec.button_glass_effect = false;
                sec.animation_type = ANIM_FADE_IN;
            } else if (styleIndex == 3) {
                // "Colorful Creative"
                sec.bg_color = ImVec4(0.95f, 0.35f, 0.45f, 1.0f);  // Vibrant pink
                sec.title_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                sec.subtitle_color = ImVec4(0.95f, 0.95f, 1.0f, 1.0f);
                sec.content_color = ImVec4(0.9f, 0.9f, 0.9f, 1.0f);
                sec.button_bg_color = ImVec4(1.0f, 0.8f, 0.0f, 1.0f);  // Yellow
                sec.button_text_color = ImVec4(0.2f, 0.2f, 0.2f, 1.0f);
                sec.animation_type = ANIM_BOUNCE;
            } else if (styleIndex == 4) {
                // "Corporate Professional"
                sec.bg_color = ImVec4(0.15f, 0.25f, 0.45f, 1.0f);  // Corporate blue
                sec.title_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                sec.subtitle_color = ImVec4(0.9f, 0.9f, 0.9f, 1.0f);
                sec.content_color = ImVec4(0.8f, 0.8f, 0.8f, 1.0f);
                sec.button_bg_color = ImVec4(0.2f, 0.6f, 1.0f, 1.0f);
                sec.button_glass_effect = false;
                sec.animation_type = ANIM_SLIDE_UP;
            }
            break;

        case SEC_CONTACT:
            if (styleIndex == 0) {
                // "Luxury Glass Form" - Dark with gold labels
                sec.bg_color = ImVec4(0.08f, 0.08f, 0.15f, 1.0f);  // Dark navy
                sec.title_color = ImVec4(0.85f, 0.75f, 0.45f, 1.0f);  // Gold
                sec.subtitle_color = ImVec4(0.9f, 0.9f, 0.9f, 1.0f);
                sec.content_color = ImVec4(0.7f, 0.7f, 0.7f, 1.0f);
                sec.button_bg_color = ImVec4(0.85f, 0.75f, 0.45f, 1.0f);  // Gold button
                sec.button_text_color = ImVec4(0.1f, 0.1f, 0.1f, 1.0f);
                sec.button_glass_effect = false;
                sec.button_glass_opacity = 0.3f;
                sec.animation_type = ANIM_FADE_IN;
            } else if (styleIndex == 1) {
                // "Minimalist White"
                sec.bg_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                sec.title_color = ImVec4(0.1f, 0.1f, 0.1f, 1.0f);
                sec.subtitle_color = ImVec4(0.4f, 0.4f, 0.4f, 1.0f);
                sec.content_color = ImVec4(0.3f, 0.3f, 0.3f, 1.0f);
                sec.button_bg_color = ImVec4(0.37f, 0.51f, 0.99f, 1.0f);
                sec.button_glass_effect = false;
                sec.animation_type = ANIM_SLIDE_UP;
            } else if (styleIndex == 2) {
                // "Corporate Professional"
                sec.bg_color = ImVec4(0.96f, 0.97f, 0.99f, 1.0f);
                sec.title_color = ImVec4(0.15f, 0.25f, 0.45f, 1.0f);
                sec.subtitle_color = ImVec4(0.4f, 0.4f, 0.4f, 1.0f);
                sec.content_color = ImVec4(0.3f, 0.3f, 0.3f, 1.0f);
                sec.button_bg_color = ImVec4(0.15f, 0.25f, 0.45f, 1.0f);
                sec.button_glass_effect = false;
                sec.animation_type = ANIM_SLIDE_UP;
            } else if (styleIndex == 3) {
                // "Creative Colorful"
                sec.bg_color = ImVec4(0.5f, 0.3f, 0.8f, 1.0f);  // Purple gradient
                sec.title_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                sec.subtitle_color = ImVec4(0.95f, 0.95f, 1.0f, 1.0f);
                sec.content_color = ImVec4(0.9f, 0.9f, 0.9f, 1.0f);
                sec.button_bg_color = ImVec4(1.0f, 0.6f, 0.0f, 1.0f);  // Orange
                sec.button_glass_effect = false;
                sec.animation_type = ANIM_ZOOM_IN;
            } else if (styleIndex == 4) {
                // "Elegant Dark"
                sec.bg_color = ImVec4(0.1f, 0.1f, 0.15f, 1.0f);
                sec.title_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                sec.subtitle_color = ImVec4(0.85f, 0.85f, 0.85f, 1.0f);
                sec.content_color = ImVec4(0.7f, 0.7f, 0.7f, 1.0f);
                sec.button_bg_color = ImVec4(0.9f, 0.9f, 0.9f, 1.0f);
                sec.button_text_color = ImVec4(0.1f, 0.1f, 0.1f, 1.0f);
                sec.button_glass_effect = false;
                sec.animation_type = ANIM_FADE_IN;
            }
            break;

        case SEC_SERVICES:
        case SEC_FEATURES:
            if (styleIndex == 0) {
                // "Glass Morph Cards" (default - already has glass effect)
            } else if (styleIndex == 1) {
                // "Solid Modern Cards"
                for (auto& item : sec.items) {
                    item.glass_effect = false;
                    item.bg_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                    item.glass_border_width = 2.0f;
                    item.glass_border_color = ImVec4(0.85f, 0.85f, 0.85f, 1.0f);
                }
                sec.animation_type = ANIM_SLIDE_UP;
            } else if (styleIndex == 2) {
                // "Gradient Cards"
                ImVec4 gradients[] = {
                    ImVec4(0.37f, 0.51f, 0.99f, 1.0f),  // Blue
                    ImVec4(0.56f, 0.27f, 0.68f, 1.0f),  // Purple
                    ImVec4(0.06f, 0.71f, 0.60f, 1.0f)   // Teal
                };
                for (size_t i = 0; i < sec.items.size() && i < 3; i++) {
                    sec.items[i].bg_color = gradients[i];
                    sec.items[i].title_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                    sec.items[i].desc_color = ImVec4(0.95f, 0.95f, 0.95f, 1.0f);
                    sec.items[i].glass_effect = false;
                }
                sec.animation_type = ANIM_ZOOM_IN;
            } else if (styleIndex == 3) {
                // "Icon-First Cards"
                for (auto& item : sec.items) {
                    item.title_font_size = 28;
                    item.desc_font_size = 15;
                    item.glass_effect = false;
                }
                sec.animation_type = ANIM_FADE_IN;
            } else if (styleIndex == 4) {
                // "List Style"
                sec.cards_per_row = 1;
                sec.card_width = 700;
                sec.card_height = 120;
                for (auto& item : sec.items) {
                    item.glass_effect = false;
                }
                sec.animation_type = ANIM_SLIDE_LEFT;
            }
            break;

        case SEC_PRICING:
            if (styleIndex == 0) {
                // "3-Tier Glass" (default - already set)
            } else if (styleIndex == 1) {
                // "Minimal Cards"
                for (auto& item : sec.items) {
                    item.bg_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                    item.title_color = ImVec4(0.1f, 0.1f, 0.1f, 1.0f);
                    item.desc_color = ImVec4(0.4f, 0.4f, 0.4f, 1.0f);
                    item.glass_effect = false;
                }
                sec.animation_type = ANIM_SLIDE_UP;
            } else if (styleIndex == 2) {
                // "Bold Colored"
                ImVec4 colors[] = {
                    ImVec4(0.2f, 0.6f, 1.0f, 1.0f),   // Blue
                    ImVec4(0.5f, 0.2f, 0.9f, 1.0f),   // Purple
                    ImVec4(0.9f, 0.3f, 0.3f, 1.0f)    // Red
                };
                for (size_t i = 0; i < sec.items.size() && i < 3; i++) {
                    sec.items[i].bg_color = colors[i];
                    sec.items[i].title_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                    sec.items[i].desc_color = ImVec4(0.95f, 0.95f, 0.95f, 1.0f);
                    sec.items[i].glass_effect = false;
                }
                sec.animation_type = ANIM_BOUNCE;
            } else if (styleIndex == 3) {
                // "Enterprise Dark"
                sec.bg_color = ImVec4(0.1f, 0.1f, 0.15f, 1.0f);
                sec.title_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                sec.subtitle_color = ImVec4(0.8f, 0.8f, 0.8f, 1.0f);
                for (auto& item : sec.items) {
                    item.bg_color = ImVec4(0.15f, 0.15f, 0.2f, 1.0f);
                    item.title_color = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                    item.desc_color = ImVec4(0.8f, 0.8f, 0.8f, 1.0f);
                    item.glass_effect = false;
                }
                sec.animation_type = ANIM_FADE_IN;
            } else if (styleIndex == 4) {
                // "Comparison Table"
                sec.cards_per_row = 3;
                sec.card_height = 500;
                sec.animation_type = ANIM_SLIDE_DOWN;
            }
            break;

        case SEC_GALLERY:
            if (styleIndex == 0) {
                // "2x2 Grid" - 4 images in square grid (2 rows × 2 columns)
                sec.gallery_columns = 2;  // 2 columns
                sec.cards_per_row = 2;    // 2 images per row
                sec.card_width = 1200;    // Standard width
                sec.card_height = 1000;   // Standard height
                sec.card_spacing = 10;    // Standard spacing
                sec.height = 1200;        // Larger section height
                sec.animation_type = ANIM_FADE_IN;
            } else if (styleIndex == 1) {
                // "1x4 Horizontal" - 4 images in horizontal row
                sec.gallery_columns = 4;  // 4 columns
                sec.cards_per_row = 4;    // 4 images in one row
                sec.card_width = 1200;    // Standard width
                sec.card_height = 1000;   // Standard height
                sec.card_spacing = 10;    // Standard spacing
                sec.height = 1200;        // Same height for consistency
                sec.animation_type = ANIM_SLIDE_LEFT;
            }
            break;

        default:
            // For other section types, just modify animations
            if (styleIndex == 1) sec.animation_type = ANIM_SLIDE_UP;
            else if (styleIndex == 2) sec.animation_type = ANIM_FADE_IN;
            else if (styleIndex == 3) sec.animation_type = ANIM_ZOOM_IN;
            else if (styleIndex == 4) sec.animation_type = ANIM_BOUNCE;
            break;
    }
}

// Render the Template Picker Modal
void RenderTemplatePicker() {
    if (!g_ShowTemplatePicker) return;

    ImGui::OpenPopup("Choose Template Style");

    ImVec2 center = ImGui::GetMainViewport()->GetCenter();
    ImGui::SetNextWindowPos(center, ImGuiCond_Appearing, ImVec2(0.5f, 0.5f));
    ImGui::SetNextWindowSize(ImVec2(1320, 700), ImGuiCond_Appearing);

    bool open = true;
    if (ImGui::BeginPopupModal("Choose Template Style", &open, ImGuiWindowFlags_NoResize)) {
        // Header
        const char* section_names[] = {"Hero", "Navigation", "About", "Services", "Cards", "Team",
                                       "Pricing", "Testimonials", "Gallery", "Blog", "Contact",
                                       "Footer", "FAQ", "Call-to-Action", "Features", "Stats", "Login", "Custom"};
        ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.37f, 0.51f, 0.99f, 1.0f));
        ImGui::Text("Select a style for your %s section", section_names[g_PickerSectionType]);
        ImGui::PopStyleColor();
        ImGui::Separator();
        ImGui::Spacing();

        // Get style presets for this section type
        const auto& styles = g_StylePresets.at(g_PickerSectionType);
        int numStyles = (int)styles.size();

        // Display style options in MUCH LARGER cards with FULL preview
        float cardWidth = 250;
        float cardHeight = 320;
        float spacing = 15;

        for (int i = 0; i < numStyles; i++) {
            if (i > 0) ImGui::SameLine();

            ImGui::BeginGroup();

            // Get style-specific colors based on section type and style index
            ImVec4 cardBg, titleColor, subtitleColor;

            // Different visual appearance for each style
            if (g_PickerSectionType == SEC_HERO) {
                if (i == 0) { // Modern Gradient
                    cardBg = ImVec4(0.09f, 0.13f, 0.25f, 1.0f); titleColor = ImVec4(1.0f, 1.0f, 1.0f, 1.0f); subtitleColor = ImVec4(0.85f, 0.88f, 0.95f, 1.0f);
                } else if (i == 1) { // Minimalist Light
                    cardBg = ImVec4(1.0f, 1.0f, 1.0f, 1.0f); titleColor = ImVec4(0.1f, 0.1f, 0.1f, 1.0f); subtitleColor = ImVec4(0.4f, 0.4f, 0.4f, 1.0f);
                } else if (i == 2) { // Dark Premium
                    cardBg = ImVec4(0.08f, 0.08f, 0.12f, 1.0f); titleColor = ImVec4(0.85f, 0.75f, 0.45f, 1.0f); subtitleColor = ImVec4(0.9f, 0.9f, 0.9f, 1.0f);
                } else if (i == 3) { // Colorful Creative
                    cardBg = ImVec4(0.95f, 0.35f, 0.45f, 1.0f); titleColor = ImVec4(1.0f, 1.0f, 1.0f, 1.0f); subtitleColor = ImVec4(0.95f, 0.95f, 1.0f, 1.0f);
                } else { // Corporate Professional
                    cardBg = ImVec4(0.15f, 0.25f, 0.45f, 1.0f); titleColor = ImVec4(1.0f, 1.0f, 1.0f, 1.0f); subtitleColor = ImVec4(0.9f, 0.9f, 0.9f, 1.0f);
                }
            } else if (g_PickerSectionType == SEC_CONTACT) {
                if (i == 0) { // Luxury Glass Form
                    cardBg = ImVec4(0.08f, 0.08f, 0.15f, 1.0f); titleColor = ImVec4(0.85f, 0.75f, 0.45f, 1.0f); subtitleColor = ImVec4(0.9f, 0.9f, 0.9f, 1.0f);
                } else if (i == 1) { // Minimalist White
                    cardBg = ImVec4(1.0f, 1.0f, 1.0f, 1.0f); titleColor = ImVec4(0.1f, 0.1f, 0.1f, 1.0f); subtitleColor = ImVec4(0.4f, 0.4f, 0.4f, 1.0f);
                } else if (i == 2) { // Corporate Professional
                    cardBg = ImVec4(0.96f, 0.97f, 0.99f, 1.0f); titleColor = ImVec4(0.15f, 0.25f, 0.45f, 1.0f); subtitleColor = ImVec4(0.4f, 0.4f, 0.4f, 1.0f);
                } else if (i == 3) { // Creative Colorful
                    cardBg = ImVec4(0.5f, 0.3f, 0.8f, 1.0f); titleColor = ImVec4(1.0f, 1.0f, 1.0f, 1.0f); subtitleColor = ImVec4(0.95f, 0.95f, 1.0f, 1.0f);
                } else { // Elegant Dark
                    cardBg = ImVec4(0.1f, 0.1f, 0.15f, 1.0f); titleColor = ImVec4(1.0f, 1.0f, 1.0f, 1.0f); subtitleColor = ImVec4(0.85f, 0.85f, 0.85f, 1.0f);
                }
            } else if (g_PickerSectionType == SEC_SERVICES || g_PickerSectionType == SEC_FEATURES) {
                if (i == 0) { // Glass Morph
                    cardBg = ImVec4(0.97f, 0.97f, 0.99f, 1.0f); titleColor = ImVec4(0.12f, 0.15f, 0.22f, 1.0f); subtitleColor = ImVec4(0.37f, 0.51f, 0.99f, 1.0f);
                } else if (i == 1) { // Solid Modern
                    cardBg = ImVec4(1.0f, 1.0f, 1.0f, 1.0f); titleColor = ImVec4(0.1f, 0.1f, 0.1f, 1.0f); subtitleColor = ImVec4(0.4f, 0.4f, 0.4f, 1.0f);
                } else if (i == 2) { // Gradient Cards
                    cardBg = ImVec4(0.37f, 0.51f, 0.99f, 1.0f); titleColor = ImVec4(1.0f, 1.0f, 1.0f, 1.0f); subtitleColor = ImVec4(0.95f, 0.95f, 0.95f, 1.0f);
                } else if (i == 3) { // Icon-First
                    cardBg = ImVec4(0.99f, 0.99f, 1.0f, 1.0f); titleColor = ImVec4(0.2f, 0.2f, 0.2f, 1.0f); subtitleColor = ImVec4(0.5f, 0.5f, 0.5f, 1.0f);
                } else { // List Style
                    cardBg = ImVec4(0.98f, 0.98f, 0.99f, 1.0f); titleColor = ImVec4(0.15f, 0.15f, 0.15f, 1.0f); subtitleColor = ImVec4(0.45f, 0.45f, 0.45f, 1.0f);
                }
            } else if (g_PickerSectionType == SEC_PRICING) {
                if (i == 0) { // 3-Tier Glass
                    cardBg = ImVec4(0.98f, 0.98f, 0.99f, 1.0f); titleColor = ImVec4(0.12f, 0.15f, 0.22f, 1.0f); subtitleColor = ImVec4(0.37f, 0.51f, 0.99f, 1.0f);
                } else if (i == 1) { // Minimal Cards
                    cardBg = ImVec4(1.0f, 1.0f, 1.0f, 1.0f); titleColor = ImVec4(0.1f, 0.1f, 0.1f, 1.0f); subtitleColor = ImVec4(0.4f, 0.4f, 0.4f, 1.0f);
                } else if (i == 2) { // Bold Colored
                    cardBg = ImVec4(0.2f, 0.6f, 1.0f, 1.0f); titleColor = ImVec4(1.0f, 1.0f, 1.0f, 1.0f); subtitleColor = ImVec4(0.95f, 0.95f, 0.95f, 1.0f);
                } else if (i == 3) { // Enterprise Dark
                    cardBg = ImVec4(0.1f, 0.1f, 0.15f, 1.0f); titleColor = ImVec4(1.0f, 1.0f, 1.0f, 1.0f); subtitleColor = ImVec4(0.8f, 0.8f, 0.8f, 1.0f);
                } else { // Comparison Table
                    cardBg = ImVec4(0.95f, 0.95f, 0.97f, 1.0f); titleColor = ImVec4(0.15f, 0.15f, 0.15f, 1.0f); subtitleColor = ImVec4(0.4f, 0.4f, 0.4f, 1.0f);
                }
            } else if (g_PickerSectionType == SEC_GALLERY) {
                if (i == 0) { // 2x2 Grid
                    cardBg = ImVec4(0.99f, 0.99f, 1.0f, 1.0f); titleColor = ImVec4(0.12f, 0.15f, 0.22f, 1.0f); subtitleColor = ImVec4(0.45f, 0.50f, 0.60f, 1.0f);
                } else { // 1x4 Horizontal
                    cardBg = ImVec4(0.99f, 0.99f, 1.0f, 1.0f); titleColor = ImVec4(0.12f, 0.15f, 0.22f, 1.0f); subtitleColor = ImVec4(0.45f, 0.50f, 0.60f, 1.0f);
                }
            } else {
                // Default colors for other section types
                ImVec4 baseColors[] = {
                    ImVec4(0.37f, 0.51f, 0.99f, 1.0f),  // Blue
                    ImVec4(1.0f, 1.0f, 1.0f, 1.0f),     // White
                    ImVec4(0.1f, 0.1f, 0.15f, 1.0f),    // Dark
                    ImVec4(0.5f, 0.3f, 0.8f, 1.0f),     // Purple
                    ImVec4(0.98f, 0.98f, 0.99f, 1.0f)   // Light gray
                };
                cardBg = baseColors[i];
                titleColor = (i == 1 || i == 4) ? ImVec4(0.1f, 0.1f, 0.1f, 1.0f) : ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
                subtitleColor = (i == 1 || i == 4) ? ImVec4(0.4f, 0.4f, 0.4f, 1.0f) : ImVec4(0.9f, 0.9f, 0.9f, 1.0f);
            }

            // Style card with actual style colors
            bool selected = (g_SelectedStyleIndex == i);
            ImGui::PushStyleColor(ImGuiCol_ChildBg, cardBg);
            ImGui::PushStyleColor(ImGuiCol_Border, selected ?
                ImVec4(0.37f, 0.51f, 0.99f, 1.0f) : ImVec4(0.8f, 0.8f, 0.8f, 1.0f));
            ImGui::PushStyleVar(ImGuiStyleVar_ChildBorderSize, selected ? 4.0f : 2.0f);

            ImGui::BeginChild(i + 1000, ImVec2(cardWidth, cardHeight), true);

            // Draw COMPLETE FULL DESIGN PREVIEW with DIFFERENT LAYOUTS!
            if (g_PickerSectionType == SEC_CONTACT) {
                ImDrawList* draw = ImGui::GetWindowDrawList();
                ImVec2 cardPos = ImGui::GetCursorScreenPos();
                float miniW = cardWidth - 30;
                float startX = 15;
                float startY = 15;

                if (i == 0) { // LAYOUT 1: CENTERED CARD - Form in center with box around it
                    // Draw visual layout representation

                    // Background area
                    draw->AddRectFilled(cardPos, ImVec2(cardPos.x + cardWidth, cardPos.y + 60),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.08f, 0.08f, 0.15f, 1.0f)));

                    // Centered title
                    ImGui::SetCursorPos(ImVec2(startX, startY + 15));
                    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.85f, 0.75f, 0.45f, 1.0f));
                    float titleW = ImGui::CalcTextSize("CENTERED CARD").x;
                    ImGui::SetCursorPosX((cardWidth - titleW) / 2);
                    ImGui::Text("CENTERED CARD");
                    ImGui::PopStyleColor();

                    // Draw centered card/box
                    float boxW = 180;
                    float boxH = 200;
                    float boxX = cardPos.x + (cardWidth - boxW) / 2;
                    float boxY = cardPos.y + 70;

                    // Card background (glass effect)
                    draw->AddRectFilled(ImVec2(boxX, boxY), ImVec2(boxX + boxW, boxY + boxH),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.15f, 0.15f, 0.2f, 1.0f)), 8.0f);
                    draw->AddRect(ImVec2(boxX, boxY), ImVec2(boxX + boxW, boxY + boxH),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.85f, 0.75f, 0.45f, 0.5f)), 8.0f, 0, 2.0f);

                    // Form fields inside card
                    float fieldY = boxY + 15;
                    for (int f = 0; f < 3; f++) {
                        draw->AddRectFilled(ImVec2(boxX + 15, fieldY), ImVec2(boxX + boxW - 15, fieldY + 20),
                            ImGui::ColorConvertFloat4ToU32(ImVec4(1.0f, 1.0f, 1.0f, 0.12f)), 4.0f);
                        draw->AddRect(ImVec2(boxX + 15, fieldY), ImVec2(boxX + boxW - 15, fieldY + 20),
                            ImGui::ColorConvertFloat4ToU32(ImVec4(0.85f, 0.75f, 0.45f, 0.5f)), 4.0f, 0, 1.5f);
                        fieldY += 30;
                    }

                    // Button
                    draw->AddRectFilled(ImVec2(boxX + 15, fieldY + 20), ImVec2(boxX + boxW - 15, fieldY + 45),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.85f, 0.75f, 0.45f, 1.0f)), 15.0f);

                    // Label at bottom
                    ImGui::SetCursorPos(ImVec2(startX, cardHeight - 35));
                    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.85f, 0.75f, 0.45f, 1.0f));
                    float labelW = ImGui::CalcTextSize("Form in Center").x;
                    ImGui::SetCursorPosX((cardWidth - labelW) / 2);
                    ImGui::Text("Form in Center");
                    ImGui::PopStyleColor();

                } else if (i == 1) { // LAYOUT 2: SPLIT SCREEN - Left info panel, Right form
                    // Draw visual layout representation

                    // Background
                    draw->AddRectFilled(cardPos, ImVec2(cardPos.x + cardWidth, cardPos.y + 60),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.95f, 0.95f, 0.97f, 1.0f)));

                    // Title label
                    ImGui::SetCursorPos(ImVec2(startX, startY + 15));
                    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.2f, 0.4f, 0.8f, 1.0f));
                    float titleW = ImGui::CalcTextSize("SPLIT SCREEN").x;
                    ImGui::SetCursorPosX((cardWidth - titleW) / 2);
                    ImGui::Text("SPLIT SCREEN");
                    ImGui::PopStyleColor();

                    // LEFT PANEL (Info/Image area)
                    float leftW = 100;
                    float panelH = 200;
                    float leftX = cardPos.x + 20;
                    float leftY = cardPos.y + 70;

                    draw->AddRectFilled(ImVec2(leftX, leftY), ImVec2(leftX + leftW, leftY + panelH),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.2f, 0.4f, 0.8f, 1.0f)), 4.0f);

                    // Icon representation in left panel
                    float iconSize = 30;
                    float iconX = leftX + (leftW - iconSize) / 2;
                    float iconY = leftY + 30;
                    draw->AddCircleFilled(ImVec2(iconX + iconSize/2, iconY + iconSize/2), iconSize/2,
                        ImGui::ColorConvertFloat4ToU32(ImVec4(1.0f, 1.0f, 1.0f, 0.3f)));

                    // Text lines in left panel
                    for (int ln = 0; ln < 3; ln++) {
                        float lineY = iconY + 40 + (ln * 15);
                        float lineW = 70;
                        draw->AddRectFilled(ImVec2(leftX + 15, lineY), ImVec2(leftX + 15 + lineW, lineY + 8),
                            ImGui::ColorConvertFloat4ToU32(ImVec4(1.0f, 1.0f, 1.0f, 0.7f)), 2.0f);
                    }

                    // RIGHT PANEL (Form area)
                    float rightW = 110;
                    float rightX = leftX + leftW + 10;

                    draw->AddRectFilled(ImVec2(rightX, leftY), ImVec2(rightX + rightW, leftY + panelH),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(1.0f, 1.0f, 1.0f, 1.0f)), 4.0f);
                    draw->AddRect(ImVec2(rightX, leftY), ImVec2(rightX + rightW, leftY + panelH),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.8f, 0.8f, 0.8f, 1.0f)), 4.0f, 0, 1.0f);

                    // Form fields in right panel
                    float fieldY = leftY + 20;
                    for (int f = 0; f < 3; f++) {
                        draw->AddRectFilled(ImVec2(rightX + 10, fieldY), ImVec2(rightX + rightW - 10, fieldY + 18),
                            ImGui::ColorConvertFloat4ToU32(ImVec4(0.95f, 0.95f, 0.95f, 1.0f)), 3.0f);
                        draw->AddRect(ImVec2(rightX + 10, fieldY), ImVec2(rightX + rightW - 10, fieldY + 18),
                            ImGui::ColorConvertFloat4ToU32(ImVec4(0.7f, 0.7f, 0.7f, 1.0f)), 3.0f, 0, 1.0f);
                        fieldY += 28;
                    }

                    // Button in right panel
                    draw->AddRectFilled(ImVec2(rightX + 10, fieldY + 15), ImVec2(rightX + rightW - 10, fieldY + 40),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.2f, 0.4f, 0.8f, 1.0f)), 12.0f);

                    // Label at bottom
                    ImGui::SetCursorPos(ImVec2(startX, cardHeight - 35));
                    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.2f, 0.4f, 0.8f, 1.0f));
                    float labelW = ImGui::CalcTextSize("Info + Form").x;
                    ImGui::SetCursorPosX((cardWidth - labelW) / 2);
                    ImGui::Text("Info + Form");
                    ImGui::PopStyleColor();

                } else if (i == 2) { // LAYOUT 3: TWO COLUMN GRID - Fields in 2 columns
                    // Draw visual layout representation

                    // Background
                    draw->AddRectFilled(cardPos, ImVec2(cardPos.x + cardWidth, cardPos.y + 60),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.98f, 0.98f, 0.98f, 1.0f)));

                    // Title label
                    ImGui::SetCursorPos(ImVec2(startX, startY + 15));
                    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.15f, 0.25f, 0.45f, 1.0f));
                    float titleW = ImGui::CalcTextSize("TWO COLUMNS").x;
                    ImGui::SetCursorPosX((cardWidth - titleW) / 2);
                    ImGui::Text("TWO COLUMNS");
                    ImGui::PopStyleColor();

                    // Container box
                    float boxW = 210;
                    float boxH = 200;
                    float boxX = cardPos.x + (cardWidth - boxW) / 2;
                    float boxY = cardPos.y + 70;

                    draw->AddRectFilled(ImVec2(boxX, boxY), ImVec2(boxX + boxW, boxY + boxH),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(1.0f, 1.0f, 1.0f, 1.0f)), 6.0f);
                    draw->AddRect(ImVec2(boxX, boxY), ImVec2(boxX + boxW, boxY + boxH),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.15f, 0.25f, 0.45f, 0.3f)), 6.0f, 0, 2.0f);

                    // Title inside
                    float headerY = boxY + 15;
                    draw->AddRectFilled(ImVec2(boxX + 20, headerY), ImVec2(boxX + boxW - 20, headerY + 10),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.15f, 0.25f, 0.45f, 1.0f)), 2.0f);

                    // Two column form fields
                    float colW = 90;
                    float leftColX = boxX + 15;
                    float rightColX = boxX + 15 + colW + 10;
                    float rowY = headerY + 25;

                    // Row 1: Name | Email
                    draw->AddRectFilled(ImVec2(leftColX, rowY), ImVec2(leftColX + colW, rowY + 20),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.95f, 0.95f, 0.95f, 1.0f)), 3.0f);
                    draw->AddRect(ImVec2(leftColX, rowY), ImVec2(leftColX + colW, rowY + 20),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.15f, 0.25f, 0.45f, 1.0f)), 3.0f, 0, 1.0f);

                    draw->AddRectFilled(ImVec2(rightColX, rowY), ImVec2(rightColX + colW, rowY + 20),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.95f, 0.95f, 0.95f, 1.0f)), 3.0f);
                    draw->AddRect(ImVec2(rightColX, rowY), ImVec2(rightColX + colW, rowY + 20),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.15f, 0.25f, 0.45f, 1.0f)), 3.0f, 0, 1.0f);

                    // Row 2: Phone | Company
                    rowY += 30;
                    draw->AddRectFilled(ImVec2(leftColX, rowY), ImVec2(leftColX + colW, rowY + 20),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.95f, 0.95f, 0.95f, 1.0f)), 3.0f);
                    draw->AddRect(ImVec2(leftColX, rowY), ImVec2(leftColX + colW, rowY + 20),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.15f, 0.25f, 0.45f, 1.0f)), 3.0f, 0, 1.0f);

                    draw->AddRectFilled(ImVec2(rightColX, rowY), ImVec2(rightColX + colW, rowY + 20),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.95f, 0.95f, 0.95f, 1.0f)), 3.0f);
                    draw->AddRect(ImVec2(rightColX, rowY), ImVec2(rightColX + colW, rowY + 20),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.15f, 0.25f, 0.45f, 1.0f)), 3.0f, 0, 1.0f);

                    // Full width message field
                    rowY += 30;
                    draw->AddRectFilled(ImVec2(leftColX, rowY), ImVec2(rightColX + colW, rowY + 45),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.95f, 0.95f, 0.95f, 1.0f)), 3.0f);
                    draw->AddRect(ImVec2(leftColX, rowY), ImVec2(rightColX + colW, rowY + 45),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.15f, 0.25f, 0.45f, 1.0f)), 3.0f, 0, 1.0f);

                    // Button
                    rowY += 55;
                    draw->AddRectFilled(ImVec2(leftColX, rowY), ImVec2(rightColX + colW, rowY + 25),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.15f, 0.25f, 0.45f, 1.0f)), 15.0f);

                    // Label at bottom
                    ImGui::SetCursorPos(ImVec2(startX, cardHeight - 35));
                    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.15f, 0.25f, 0.45f, 1.0f));
                    float labelW = ImGui::CalcTextSize("Grid Layout").x;
                    ImGui::SetCursorPosX((cardWidth - labelW) / 2);
                    ImGui::Text("Grid Layout");
                    ImGui::PopStyleColor();

                } else if (i == 3) { // LAYOUT 4: HORIZONTAL WIDE - Full width with side image
                    // Draw visual layout representation

                    // Gradient background
                    draw->AddRectFilledMultiColor(cardPos, ImVec2(cardPos.x + cardWidth, cardPos.y + 60),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.9f, 0.3f, 0.5f, 1.0f)),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.5f, 0.2f, 0.8f, 1.0f)),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.5f, 0.2f, 0.8f, 1.0f)),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.9f, 0.3f, 0.5f, 1.0f)));

                    // Title label
                    ImGui::SetCursorPos(ImVec2(startX, startY + 15));
                    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.0f, 1.0f, 1.0f, 1.0f));
                    float titleW = ImGui::CalcTextSize("HORIZONTAL").x;
                    ImGui::SetCursorPosX((cardWidth - titleW) / 2);
                    ImGui::Text("HORIZONTAL");
                    ImGui::PopStyleColor();

                    // Wide container
                    float containerW = 220;
                    float containerH = 100;
                    float containerX = cardPos.x + (cardWidth - containerW) / 2;
                    float containerY = cardPos.y + 70;

                    // Top decorative image area
                    draw->AddRectFilled(ImVec2(containerX, containerY), ImVec2(containerX + containerW, containerY + 50),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.3f, 0.15f, 0.4f, 1.0f)), 8.0f);

                    // Circles in image area
                    for (int c = 0; c < 4; c++) {
                        float circleX = containerX + 30 + (c * 45);
                        draw->AddCircleFilled(ImVec2(circleX, containerY + 25), 15,
                            ImGui::ColorConvertFloat4ToU32(ImVec4(1.0f, 0.6f, 0.8f, 0.3f)));
                    }

                    // Form area below
                    float formY = containerY + 60;
                    draw->AddRectFilled(ImVec2(containerX, formY), ImVec2(containerX + containerW, formY + 100),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(1.0f, 1.0f, 1.0f, 1.0f)), 8.0f);

                    // Horizontal fields
                    float fieldW = 65;
                    float fieldH = 18;
                    float fieldY = formY + 15;

                    for (int row = 0; row < 2; row++) {
                        for (int col = 0; col < 3; col++) {
                            float fieldX = containerX + 10 + (col * (fieldW + 5));
                            draw->AddRectFilled(ImVec2(fieldX, fieldY), ImVec2(fieldX + fieldW, fieldY + fieldH),
                                ImGui::ColorConvertFloat4ToU32(ImVec4(0.95f, 0.9f, 0.95f, 1.0f)), 4.0f);
                            draw->AddRect(ImVec2(fieldX, fieldY), ImVec2(fieldX + fieldW, fieldY + fieldH),
                                ImGui::ColorConvertFloat4ToU32(ImVec4(0.9f, 0.3f, 0.5f, 0.6f)), 4.0f, 0, 1.5f);
                        }
                        fieldY += 25;
                    }

                    // Wide button
                    fieldY += 5;
                    draw->AddRectFilled(ImVec2(containerX + 10, fieldY), ImVec2(containerX + containerW - 10, fieldY + 25),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.9f, 0.3f, 0.5f, 1.0f)), 15.0f);

                    // Label at bottom
                    ImGui::SetCursorPos(ImVec2(startX, cardHeight - 35));
                    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.9f, 0.3f, 0.5f, 1.0f));
                    float labelW = ImGui::CalcTextSize("Wide Style").x;
                    ImGui::SetCursorPosX((cardWidth - labelW) / 2);
                    ImGui::Text("Wide Style");
                    ImGui::PopStyleColor();

                } else { // LAYOUT 5: CARD STACK - Overlapping cards style
                    // Draw visual layout representation

                    // Background
                    draw->AddRectFilled(cardPos, ImVec2(cardPos.x + cardWidth, cardPos.y + 60),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.12f, 0.12f, 0.18f, 1.0f)));

                    // Title label
                    ImGui::SetCursorPos(ImVec2(startX, startY + 15));
                    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.9f, 0.9f, 0.9f, 1.0f));
                    float titleW = ImGui::CalcTextSize("ELEGANT DARK").x;
                    ImGui::SetCursorPosX((cardWidth - titleW) / 2);
                    ImGui::Text("ELEGANT DARK");
                    ImGui::PopStyleColor();

                    // Back card (shadow effect)
                    float cardW = 170;
                    float cardH = 180;
                    float mainX = cardPos.x + (cardWidth - cardW) / 2;
                    float mainY = cardPos.y + 80;

                    draw->AddRectFilled(ImVec2(mainX + 8, mainY + 8), ImVec2(mainX + cardW + 8, mainY + cardH + 8),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.05f, 0.05f, 0.08f, 0.6f)), 10.0f);

                    // Main card
                    draw->AddRectFilled(ImVec2(mainX, mainY), ImVec2(mainX + cardW, mainY + cardH),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.18f, 0.18f, 0.24f, 1.0f)), 10.0f);
                    draw->AddRect(ImVec2(mainX, mainY), ImVec2(mainX + cardW, mainY + cardH),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.9f, 0.9f, 0.9f, 0.2f)), 10.0f, 0, 1.5f);

                    // Title inside card
                    float inCardY = mainY + 20;
                    draw->AddRectFilled(ImVec2(mainX + 20, inCardY), ImVec2(mainX + cardW - 20, inCardY + 12),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.9f, 0.9f, 0.9f, 1.0f)), 2.0f);

                    // Form fields with elegant borders
                    float fieldY = inCardY + 25;
                    for (int f = 0; f < 3; f++) {
                        draw->AddRectFilled(ImVec2(mainX + 20, fieldY), ImVec2(mainX + cardW - 20, fieldY + 18),
                            ImGui::ColorConvertFloat4ToU32(ImVec4(0.15f, 0.15f, 0.2f, 1.0f)), 4.0f);
                        draw->AddRect(ImVec2(mainX + 20, fieldY), ImVec2(mainX + cardW - 20, fieldY + 18),
                            ImGui::ColorConvertFloat4ToU32(ImVec4(0.9f, 0.9f, 0.9f, 0.3f)), 4.0f, 0, 1.0f);
                        fieldY += 26;
                    }

                    // Elegant button
                    fieldY += 10;
                    draw->AddRectFilled(ImVec2(mainX + 20, fieldY), ImVec2(mainX + cardW - 20, fieldY + 30),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.9f, 0.9f, 0.9f, 1.0f)), 15.0f);

                    // Label at bottom
                    ImGui::SetCursorPos(ImVec2(startX, cardHeight - 35));
                    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.9f, 0.9f, 0.9f, 1.0f));
                    float labelW = ImGui::CalcTextSize("Card Style").x;
                    ImGui::SetCursorPosX((cardWidth - labelW) / 2);
                    ImGui::Text("Card Style");
                    ImGui::PopStyleColor();
                }
            } else if (g_PickerSectionType == SEC_GALLERY) {
                ImDrawList* draw = ImGui::GetWindowDrawList();
                ImVec2 cardPos = ImGui::GetCursorScreenPos();
                float startX = 15;
                float startY = 15;

                if (i == 0) { // LAYOUT 1: 2x2 Grid
                    // Background
                    draw->AddRectFilled(cardPos, ImVec2(cardPos.x + cardWidth, cardPos.y + 60),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.99f, 0.99f, 1.0f, 1.0f)));

                    // Title label
                    ImGui::SetCursorPos(ImVec2(startX, startY + 15));
                    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.12f, 0.15f, 0.22f, 1.0f));
                    float titleW = ImGui::CalcTextSize("2x2 GRID").x;
                    ImGui::SetCursorPosX((cardWidth - titleW) / 2);
                    ImGui::Text("2x2 GRID");
                    ImGui::PopStyleColor();

                    // 2x2 Grid Layout
                    float gridSize = 90;
                    float gridSpacing = 10;
                    float gridStartX = cardPos.x + (cardWidth - (2 * gridSize + gridSpacing)) / 2;
                    float gridStartY = cardPos.y + 80;

                    // Row 1
                    // Image 1
                    draw->AddRectFilled(ImVec2(gridStartX, gridStartY),
                        ImVec2(gridStartX + gridSize, gridStartY + gridSize),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.85f, 0.88f, 0.92f, 1.0f)), 6.0f);
                    draw->AddRect(ImVec2(gridStartX, gridStartY),
                        ImVec2(gridStartX + gridSize, gridStartY + gridSize),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.12f, 0.15f, 0.22f, 0.3f)), 6.0f, 0, 1.5f);

                    // Image 2
                    draw->AddRectFilled(ImVec2(gridStartX + gridSize + gridSpacing, gridStartY),
                        ImVec2(gridStartX + 2*gridSize + gridSpacing, gridStartY + gridSize),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.85f, 0.88f, 0.92f, 1.0f)), 6.0f);
                    draw->AddRect(ImVec2(gridStartX + gridSize + gridSpacing, gridStartY),
                        ImVec2(gridStartX + 2*gridSize + gridSpacing, gridStartY + gridSize),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.12f, 0.15f, 0.22f, 0.3f)), 6.0f, 0, 1.5f);

                    // Row 2
                    // Image 3
                    draw->AddRectFilled(ImVec2(gridStartX, gridStartY + gridSize + gridSpacing),
                        ImVec2(gridStartX + gridSize, gridStartY + 2*gridSize + gridSpacing),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.85f, 0.88f, 0.92f, 1.0f)), 6.0f);
                    draw->AddRect(ImVec2(gridStartX, gridStartY + gridSize + gridSpacing),
                        ImVec2(gridStartX + gridSize, gridStartY + 2*gridSize + gridSpacing),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.12f, 0.15f, 0.22f, 0.3f)), 6.0f, 0, 1.5f);

                    // Image 4
                    draw->AddRectFilled(ImVec2(gridStartX + gridSize + gridSpacing, gridStartY + gridSize + gridSpacing),
                        ImVec2(gridStartX + 2*gridSize + gridSpacing, gridStartY + 2*gridSize + gridSpacing),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.85f, 0.88f, 0.92f, 1.0f)), 6.0f);
                    draw->AddRect(ImVec2(gridStartX + gridSize + gridSpacing, gridStartY + gridSize + gridSpacing),
                        ImVec2(gridStartX + 2*gridSize + gridSpacing, gridStartY + 2*gridSize + gridSpacing),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.12f, 0.15f, 0.22f, 0.3f)), 6.0f, 0, 1.5f);

                    // Label at bottom
                    ImGui::SetCursorPos(ImVec2(startX, cardHeight - 35));
                    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.12f, 0.15f, 0.22f, 1.0f));
                    float labelW = ImGui::CalcTextSize("Square Grid").x;
                    ImGui::SetCursorPosX((cardWidth - labelW) / 2);
                    ImGui::Text("Square Grid");
                    ImGui::PopStyleColor();

                } else { // LAYOUT 2: 1x4 Horizontal
                    // Background
                    draw->AddRectFilled(cardPos, ImVec2(cardPos.x + cardWidth, cardPos.y + 60),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.99f, 0.99f, 1.0f, 1.0f)));

                    // Title label
                    ImGui::SetCursorPos(ImVec2(startX, startY + 15));
                    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.12f, 0.15f, 0.22f, 1.0f));
                    float titleW = ImGui::CalcTextSize("1x4 HORIZONTAL").x;
                    ImGui::SetCursorPosX((cardWidth - titleW) / 2);
                    ImGui::Text("1x4 HORIZONTAL");
                    ImGui::PopStyleColor();

                    // 1x4 Horizontal Layout
                    float imgWidth = 50;
                    float imgHeight = 100;
                    float imgSpacing = 8;
                    float totalWidth = 4 * imgWidth + 3 * imgSpacing;
                    float imgStartX = cardPos.x + (cardWidth - totalWidth) / 2;
                    float imgStartY = cardPos.y + 90;

                    // Draw 4 images in horizontal row
                    for (int img = 0; img < 4; img++) {
                        float imgX = imgStartX + img * (imgWidth + imgSpacing);
                        draw->AddRectFilled(ImVec2(imgX, imgStartY),
                            ImVec2(imgX + imgWidth, imgStartY + imgHeight),
                            ImGui::ColorConvertFloat4ToU32(ImVec4(0.85f, 0.88f, 0.92f, 1.0f)), 6.0f);
                        draw->AddRect(ImVec2(imgX, imgStartY),
                            ImVec2(imgX + imgWidth, imgStartY + imgHeight),
                            ImGui::ColorConvertFloat4ToU32(ImVec4(0.12f, 0.15f, 0.22f, 0.3f)), 6.0f, 0, 1.5f);
                    }

                    // Label at bottom
                    ImGui::SetCursorPos(ImVec2(startX, cardHeight - 35));
                    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.12f, 0.15f, 0.22f, 1.0f));
                    float labelW = ImGui::CalcTextSize("Horizontal Row").x;
                    ImGui::SetCursorPosX((cardWidth - labelW) / 2);
                    ImGui::Text("Horizontal Row");
                    ImGui::PopStyleColor();
                }
            } else {
                // For other sections, show emoji + mini layout preview
                ImGui::SetCursorPosX((cardWidth - 40) / 2);
                ImGui::SetCursorPosY(15);
                ImGui::PushStyleColor(ImGuiCol_Text, titleColor);
                ImGui::Text("%s", styles[i].preview_emoji.c_str());
                ImGui::PopStyleColor();

                // Mini preview bars/shapes
                ImGui::SetCursorPos(ImVec2(15, 50));
                ImDrawList* draw = ImGui::GetWindowDrawList();
                ImVec2 pos = ImGui::GetCursorScreenPos();

                // Different layout previews for each style
                if (i == 0) { // Style 1 - centered layout
                    draw->AddRectFilled(pos, ImVec2(pos.x + 120, pos.y + 8), ImGui::ColorConvertFloat4ToU32(titleColor), 4.0f);
                    draw->AddRectFilled(ImVec2(pos.x + 20, pos.y + 15), ImVec2(pos.x + 100, pos.y + 20), ImGui::ColorConvertFloat4ToU32(subtitleColor), 2.0f);
                } else if (i == 1) { // Style 2 - left aligned
                    draw->AddRectFilled(pos, ImVec2(pos.x + 80, pos.y + 10), ImGui::ColorConvertFloat4ToU32(titleColor), 2.0f);
                    draw->AddRectFilled(ImVec2(pos.x, pos.y + 15), ImVec2(pos.x + 120, pos.y + 20), ImGui::ColorConvertFloat4ToU32(subtitleColor), 2.0f);
                } else if (i == 2) { // Style 3 - cards
                    draw->AddRectFilled(pos, ImVec2(pos.x + 35, pos.y + 25), ImGui::ColorConvertFloat4ToU32(titleColor), 4.0f);
                    draw->AddRectFilled(ImVec2(pos.x + 42, pos.y), ImVec2(pos.x + 77, pos.y + 25), ImGui::ColorConvertFloat4ToU32(titleColor), 4.0f);
                    draw->AddRectFilled(ImVec2(pos.x + 84, pos.y), ImVec2(pos.x + 119, pos.y + 25), ImGui::ColorConvertFloat4ToU32(titleColor), 4.0f);
                } else if (i == 3) { // Style 4 - gradient
                    draw->AddRectFilledMultiColor(pos, ImVec2(pos.x + 120, pos.y + 25),
                        ImGui::ColorConvertFloat4ToU32(titleColor),
                        ImGui::ColorConvertFloat4ToU32(subtitleColor),
                        ImGui::ColorConvertFloat4ToU32(subtitleColor),
                        ImGui::ColorConvertFloat4ToU32(titleColor));
                } else { // Style 5 - split
                    draw->AddRectFilled(pos, ImVec2(pos.x + 55, pos.y + 25), ImGui::ColorConvertFloat4ToU32(titleColor), 2.0f);
                    draw->AddRectFilled(ImVec2(pos.x + 65, pos.y), ImVec2(pos.x + 120, pos.y + 25), ImGui::ColorConvertFloat4ToU32(subtitleColor), 2.0f);
                }
            }

            // Style name at bottom
            ImGui::SetCursorPosY(cardHeight - 45);
            ImGui::PushTextWrapPos(cardWidth - 10);
            ImGui::PushStyleColor(ImGuiCol_Text, titleColor);
            float textWidth = ImGui::CalcTextSize(styles[i].name.c_str()).x;
            ImGui::SetCursorPosX((cardWidth - textWidth) / 2);
            ImGui::Text("%s", styles[i].name.c_str());
            ImGui::PopStyleColor();
            ImGui::PopTextWrapPos();

            ImGui::EndChild();
            ImGui::PopStyleVar();
            ImGui::PopStyleColor(2);

            // Select button
            char btnLabel[32];
            snprintf(btnLabel, sizeof(btnLabel), selected ? "Selected##%d" : "Select##%d", i);
            ImGui::PushStyleColor(ImGuiCol_Button, selected ?
                ImVec4(0.2f, 0.7f, 0.3f, 1.0f) : ImVec4(0.37f, 0.51f, 0.99f, 1.0f));
            if (ImGui::Button(btnLabel, ImVec2(cardWidth, 30))) {
                g_SelectedStyleIndex = i;
            }
            ImGui::PopStyleColor();

            ImGui::EndGroup();
        }

        ImGui::Spacing();
        ImGui::Separator();
        ImGui::Spacing();

        // Action buttons
        ImGui::SetCursorPosX(ImGui::GetWindowWidth() - 220);
        if (ImGui::Button("Cancel", ImVec2(100, 35))) {
            g_ShowTemplatePicker = false;
            g_SelectedStyleIndex = -1;
        }

        ImGui::SameLine();
        ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.37f, 0.51f, 0.99f, 1.0f));
        ImGui::PushStyleColor(ImGuiCol_ButtonHovered, ImVec4(0.42f, 0.56f, 1.0f, 1.0f));
        bool canApply = (g_SelectedStyleIndex >= 0);
        if (!canApply) ImGui::BeginDisabled();
        if (ImGui::Button("Apply Style", ImVec2(110, 35))) {
            // Create the section with the selected style
            WebSection newSection(g_NextSectionId++, g_PickerSectionType);
            ApplyStylePreset(newSection, g_SelectedStyleIndex);

            // SMART AUTO-POSITIONING: Fill remaining space
            if (!g_Sections.empty()) {
                // Get the last added section
                WebSection& lastSec = g_Sections.back();

                // If last section has width < 100%, try to fill remaining space
                if (lastSec.section_width_percent < 100.0f) {
                    float remainingSpace = 100.0f - lastSec.section_width_percent;

                    // Set new section width to fill remaining space
                    newSection.section_width_percent = remainingSpace;

                    // Determine alignment based on last section's position
                    if (lastSec.horizontal_align == 0) {
                        // Last section is LEFT aligned, place new section on RIGHT
                        newSection.horizontal_align = 2;  // Right
                    } else if (lastSec.horizontal_align == 2) {
                        // Last section is RIGHT aligned, place new section on LEFT
                        newSection.horizontal_align = 0;  // Left
                    } else {
                        // Last section is CENTER aligned, place new section on RIGHT
                        newSection.horizontal_align = 2;  // Right
                    }

                    // FORCE enable manual positioning for side-by-side layout
                    // Calculate Y position based on whether last section uses manual position
                    if (lastSec.use_manual_position) {
                        // Last section already has manual position, use same Y
                        newSection.use_manual_position = true;
                        newSection.y_position = lastSec.y_position;
                    } else {
                        // Last section doesn't have manual position, calculate current Y
                        // Sum up heights of all previous sections
                        float calculatedY = 0;
                        for (int i = 0; i < (int)g_Sections.size(); i++) {
                            if (i == (int)g_Sections.size() - 1) break; // Stop before last section
                            if (!g_Sections[i].use_manual_position) {
                                calculatedY += g_Sections[i].height;
                            }
                        }
                        // Enable manual position for BOTH sections
                        lastSec.use_manual_position = true;
                        lastSec.y_position = calculatedY;
                        newSection.use_manual_position = true;
                        newSection.y_position = calculatedY;
                    }

                    // Match height for better alignment
                    newSection.height = lastSec.height;
                }
            }

            g_Sections.push_back(newSection);
            g_SelectedSectionIndex = (int)g_Sections.size() - 1;
            for (int i = 0; i < (int)g_Sections.size(); i++) {
                g_Sections[i].selected = (i == g_SelectedSectionIndex);
            }

            g_ShowTemplatePicker = false;
            g_SelectedStyleIndex = -1;
        }
        if (!canApply) ImGui::EndDisabled();
        ImGui::PopStyleColor(2);

        ImGui::EndPopup();
    }

    if (!open) {
        g_ShowTemplatePicker = false;
        g_SelectedStyleIndex = -1;
    }
}

// ============================================================================
// HELPERS
// ============================================================================
std::string EscapeString(const std::string& s) {
    std::string result;
    for (char c : s) {
        if (c == '"') result += "\\\"";
        else if (c == '\\') result += "\\\\";
        else if (c == '\n') result += "\\n";
        else result += c;
    }
    return result;
}

std::string ColorToImVec4(const ImVec4& c) {
    char buf[128];
    snprintf(buf, sizeof(buf), "ImVec4(%.3ff, %.3ff, %.3ff, %.3ff)", c.x, c.y, c.z, c.w);
    return buf;
}

std::string ColorToU32(const ImVec4& c) {
    char buf[64];
    snprintf(buf, sizeof(buf), "IM_COL32(%d, %d, %d, %d)",
        (int)(c.x*255), (int)(c.y*255), (int)(c.z*255), (int)(c.w*255));
    return buf;
}

std::string GetFilename(const std::string& path) {
    size_t pos = path.find_last_of("/\\");
    return (pos != std::string::npos) ? path.substr(pos + 1) : path;
}

std::vector<std::pair<std::string, std::string>> GetAllSectionLinks() {
    std::vector<std::pair<std::string, std::string>> links;
    for (const auto& sec : g_Sections) {
        if (sec.type != SEC_NAVBAR) {
            links.push_back({sec.name, "#" + sec.section_id});
        }
    }
    return links;
}

// ============================================================================
// TEXT WRAPPING HELPER FOR LIVE PREVIEW
// ============================================================================
float DrawWrappedText(ImDrawList* dl, const std::string& text, float x, float y, float maxWidth, ImU32 color, bool center = false, float fontSize = 16.0f, float fontWeight = 400.0f, float lineHeightMultiplier = 1.2f, float letterSpacing = 0.0f) {
    if (text.empty() || maxWidth <= 0) return 0;

    // Ensure valid font size
    if (fontSize <= 0.0f) fontSize = 16.0f;
    if (fontWeight < 100.0f) fontWeight = 400.0f;

    // Calculate font scale based on desired font size (ImGui default is 13px)
    float fontScale = fontSize / 13.0f;
    ImFont* font = ImGui::GetFont();

    std::vector<std::string> lines;
    std::string currentLine;
    std::string word;

    for (size_t i = 0; i <= text.size(); i++) {
        char c = (i < text.size()) ? text[i] : ' ';

        if (c == ' ' || c == '\n' || i == text.size()) {
            if (!word.empty()) {
                std::string testLine = currentLine.empty() ? word : currentLine + " " + word;
                ImVec2 testSize = font->CalcTextSizeA(fontSize, FLT_MAX, 0.0f, testLine.c_str());

                if (testSize.x <= maxWidth) {
                    currentLine = testLine;
                } else {
                    if (!currentLine.empty()) {
                        lines.push_back(currentLine);
                    }
                    ImVec2 wordSize = font->CalcTextSizeA(fontSize, FLT_MAX, 0.0f, word.c_str());
                    if (wordSize.x > maxWidth) {
                        std::string truncated = word.substr(0, std::min((size_t)15, word.size())) + "...";
                        currentLine = truncated;
                    } else {
                        currentLine = word;
                    }
                }
                word.clear();
            }
            if (c == '\n' && !currentLine.empty()) {
                lines.push_back(currentLine);
                currentLine.clear();
            }
        } else {
            word += c;
        }
    }
    if (!currentLine.empty()) {
        lines.push_back(currentLine);
    }

    // Use provided line-height multiplier instead of hardcoded value
    float lineHeight = fontSize * lineHeightMultiplier;
    float totalHeight = 0;

    // Enhanced boldness simulation based on weight
    // Weight 100-400: Normal rendering
    // Weight 500-700: Medium bold (4 layers)
    // Weight 800-1200: Heavy bold (9 layers with larger offsets)
    float boldStrength = 0;
    int boldLayers = 1;

    if (fontWeight >= 800.0f) {
        boldStrength = 1.0f + ((fontWeight - 800.0f) / 400.0f) * 1.5f; // 1.0 to 2.5
        boldLayers = 9;
    } else if (fontWeight >= 500.0f) {
        boldStrength = 0.5f + ((fontWeight - 500.0f) / 300.0f) * 0.5f; // 0.5 to 1.0
        boldLayers = 4;
    }

    for (const auto& line : lines) {
        ImVec2 lineSize = font->CalcTextSizeA(fontSize, FLT_MAX, 0.0f, line.c_str());
        float drawX = center ? (x + (maxWidth - lineSize.x) / 2) : x;

        if (boldLayers > 1) {
            // Multiple layer rendering for boldness
            for (int layer = 0; layer < boldLayers; layer++) {
                float offsetX = (layer % 3) * boldStrength * 0.5f;
                float offsetY = (layer / 3) * boldStrength * 0.5f;
                dl->AddText(font, fontSize, ImVec2(drawX + offsetX, y + totalHeight + offsetY), color, line.c_str());
            }
        } else {
            dl->AddText(font, fontSize, ImVec2(drawX, y + totalHeight), color, line.c_str());
        }

        totalHeight += lineHeight;
    }

    return totalHeight;
}

// ============================================================================
// GENERATE IMGUI C++ CODE FOR WEBASSEMBLY
// ============================================================================
std::string GenerateImGuiCPP() {
    std::stringstream cpp;

    // Collect all unique image paths from sections FIRST (needed for rendering code)
    std::set<std::string> imagePaths;
    std::map<std::string, std::string> imageVarNames;
    int imgIdx = 0;

    for (const auto& sec : g_Sections) {
        if (!sec.background_image.empty() && sec.background_image != "none") {
            imagePaths.insert(sec.background_image);
        }
        for (const auto& img : sec.hero_animation_images) {
            if (!img.empty()) imagePaths.insert(img);
        }
        for (const auto& img : sec.gallery_images) {
            if (!img.empty()) imagePaths.insert(img);
        }
        if (!sec.section_image.empty() && sec.section_image != "none") {
            imagePaths.insert(sec.section_image);
        }
        if (!sec.logo_path.empty() && sec.logo_path != "none") {
            imagePaths.insert(sec.logo_path);
        }
    }

    // Generate variable names for each unique image
    for (const auto& imgPath : imagePaths) {
        size_t lastSlash = imgPath.find_last_of("/\\");
        std::string filename = (lastSlash != std::string::npos) ? imgPath.substr(lastSlash + 1) : imgPath;

        // Create safe variable name from filename
        std::string varName = "g_Texture_" + std::to_string(imgIdx++);
        imageVarNames[imgPath] = varName;
    }

    cpp << R"(// Auto-generated ImGui WebAssembly Website
// Generated by ImGui Website Designer

#include "imgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_opengl3.h"
#include <stdio.h>
#include <string.h>
#include <string>
#include <vector>

#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#include <emscripten/html5.h>
#endif

#include <GLFW/glfw3.h>

// STB Image for loading images
#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

// Embedded Inter font (auto-generated)
#include "inter_font.h"

// Global state
GLFWwindow* g_Window = nullptr;
ImVec4 g_ClearColor = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);  // White background for visibility

// Page state
static int g_CurrentPage = 0;
static char g_ContactName[128] = "";
static char g_ContactEmail[128] = "";
static char g_ContactMessage[512] = "";
static bool g_MessageSent = false;

// Scroll state
static float g_ScrollY = 0.0f;
static float g_ScrollTarget = 0.0f;
static float g_TotalHeight = 0.0f;

// Animation state for cards
static float g_AnimTime = 0.0f;  // Global time counter in seconds
static float g_DeltaTime = 0.016f;  // ~60 FPS

// Exported function for JavaScript wheel callback
#ifdef __EMSCRIPTEN__
#include <emscripten.h>
extern "C" {
    EMSCRIPTEN_KEEPALIVE
    void WheelCallback(int delta) {
        // delta > 0 means scroll down (increase scroll position)
        // delta < 0 means scroll up (decrease scroll position)
        g_ScrollTarget += delta * 80.0f;
    }
}
#endif
)";

    // Generate global texture variables
    if (!imagePaths.empty()) {
        cpp << "\n// Global texture variables for images\n";
        for (const auto& pair : imageVarNames) {
            const std::string& varName = pair.second;
            cpp << "static GLuint " << varName << " = 0;\n";
        }
    }

    cpp << "\n";

    // Generate FAQ state if needed
    bool hasFAQ = false;
    for (const auto& sec : g_Sections) {
        if (sec.type == SEC_FAQ) {
            hasFAQ = true;
            cpp << "static bool g_FAQExpanded[" << sec.faq_items.size() << "] = {false};\n";
            break;
        }
    }

    // Collect all unique font sizes from sections
    std::set<int> fontSizes;
    fontSizes.insert(16); // Default body
    fontSizes.insert(14); // Small
    for (const auto& sec : g_Sections) {
        fontSizes.insert((int)sec.title_font_size);
        fontSizes.insert((int)sec.subtitle_font_size);
        fontSizes.insert((int)sec.content_font_size);
        fontSizes.insert((int)sec.button_font_size);
        fontSizes.insert((int)sec.nav_font_size);
        for (const auto& item : sec.items) {
            fontSizes.insert((int)item.title_font_size);
            fontSizes.insert((int)item.desc_font_size);
        }
    }

    cpp << R"(
// Font cache - stores fonts by size
#include <map>
static std::map<int, ImFont*> g_FontCache;
static ImFont* g_FontDefault = nullptr;

// Get font by size (creates if not cached)
ImFont* GetFont(int size) {
    if (g_FontCache.count(size)) return g_FontCache[size];
    return g_FontDefault;
}

// Legacy font pointers for compatibility
static ImFont* g_FontTitle = nullptr;
static ImFont* g_FontSubtitle = nullptr;
static ImFont* g_FontBody = nullptr;
static ImFont* g_FontButton = nullptr;
static ImFont* g_FontSmall = nullptr;

// Image/Texture cache
static std::map<std::string, GLuint> g_TextureCache;

// Helper: Load image and create OpenGL texture
GLuint LoadImageTexture(const char* filename) {
    // Check cache first
    if (g_TextureCache.count(filename)) {
        return g_TextureCache[filename];
    }

    // Load image data
    int width, height, channels;
    unsigned char* data = stbi_load(filename, &width, &height, &channels, 4);
    if (!data) {
        printf("Failed to load image: %s\n", filename);
        return 0;
    }

    // Create OpenGL texture
    GLuint texture;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);

    stbi_image_free(data);

    // Cache it
    g_TextureCache[filename] = texture;
    printf("Loaded texture: %s (%dx%d, ID=%u)\n", filename, width, height, texture);

    return texture;
}

// Helper: Draw background image with 'cover' sizing (like CSS background-size: cover)
// Note: WebGL doesn't support querying texture dimensions, so we just stretch to fill
void DrawBackgroundImageCover(ImDrawList* dl, GLuint texture, float x, float y, float w, float h, float bgPosX = 0.5f, float bgPosY = 0.5f) {
    if (texture == 0) return;

    // Simply draw the image stretched to cover the entire area
    // This is equivalent to CSS background-size: cover with background-position: center
    dl->AddImage(
        (ImTextureID)(intptr_t)texture,
        ImVec2(x, y),
        ImVec2(x + w, y + h),
        ImVec2(0.0f, 0.0f),
        ImVec2(1.0f, 1.0f)
    );
}

// Custom styling - Modern, clean design
void SetupImGuiStyle() {
    ImGuiStyle& style = ImGui::GetStyle();

    // Smooth, modern rounding
    style.WindowRounding = 0.0f;
    style.FrameRounding = 8.0f;
    style.GrabRounding = 8.0f;
    style.PopupRounding = 8.0f;
    style.ScrollbarRounding = 8.0f;
    style.TabRounding = 6.0f;

    // Clean spacing - 8px grid system
    style.WindowPadding = ImVec2(0, 0);
    style.FramePadding = ImVec2(16, 12);
    style.ItemSpacing = ImVec2(12, 8);
    style.ItemInnerSpacing = ImVec2(8, 4);

    // Modern minimal borders
    style.WindowBorderSize = 0.0f;
    style.FrameBorderSize = 0.0f;
    style.PopupBorderSize = 1.0f;

    // Anti-aliasing for smooth edges
    style.AntiAliasedLines = true;
    style.AntiAliasedFill = true;

    ImVec4* colors = style.Colors;

    // Clean white/light gray backgrounds
    colors[ImGuiCol_WindowBg] = ImVec4(0.98f, 0.98f, 0.99f, 1.0f);
    colors[ImGuiCol_ChildBg] = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
    colors[ImGuiCol_PopupBg] = ImVec4(1.0f, 1.0f, 1.0f, 0.98f);

    // Modern blue accent (#4F6BF7 - vibrant but professional)
    colors[ImGuiCol_Button] = ImVec4(0.31f, 0.42f, 0.97f, 1.0f);
    colors[ImGuiCol_ButtonHovered] = ImVec4(0.38f, 0.50f, 1.0f, 1.0f);
    colors[ImGuiCol_ButtonActive] = ImVec4(0.25f, 0.35f, 0.90f, 1.0f);

    // Subtle input fields
    colors[ImGuiCol_FrameBg] = ImVec4(0.96f, 0.97f, 0.98f, 1.0f);
    colors[ImGuiCol_FrameBgHovered] = ImVec4(0.93f, 0.94f, 0.97f, 1.0f);
    colors[ImGuiCol_FrameBgActive] = ImVec4(0.90f, 0.92f, 0.96f, 1.0f);

    // Dark readable text
    colors[ImGuiCol_Text] = ImVec4(0.11f, 0.13f, 0.17f, 1.0f);
    colors[ImGuiCol_TextDisabled] = ImVec4(0.55f, 0.58f, 0.65f, 1.0f);

    // Accent colors
    colors[ImGuiCol_CheckMark] = ImVec4(0.31f, 0.42f, 0.97f, 1.0f);
    colors[ImGuiCol_SliderGrab] = ImVec4(0.31f, 0.42f, 0.97f, 1.0f);
    colors[ImGuiCol_SliderGrabActive] = ImVec4(0.25f, 0.35f, 0.90f, 1.0f);

    // Headers
    colors[ImGuiCol_Header] = ImVec4(0.31f, 0.42f, 0.97f, 0.15f);
    colors[ImGuiCol_HeaderHovered] = ImVec4(0.31f, 0.42f, 0.97f, 0.25f);
    colors[ImGuiCol_HeaderActive] = ImVec4(0.31f, 0.42f, 0.97f, 0.35f);

    // Subtle borders and separators
    colors[ImGuiCol_Border] = ImVec4(0.88f, 0.89f, 0.92f, 1.0f);
    colors[ImGuiCol_Separator] = ImVec4(0.90f, 0.91f, 0.93f, 1.0f);
}

// Helper: Draw modern card with layered shadow (like CSS box-shadow)
void DrawCardWithShadow(ImDrawList* dl, float x, float y, float w, float h, ImU32 color, float rounding = 12.0f) {
    // Modern multi-layer shadow (similar to CSS: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -2px rgba(0,0,0,0.1))
    // Layer 3 - Soft outer glow
    dl->AddRectFilled(ImVec2(x-2, y+8), ImVec2(x+w+2, y+h+12), IM_COL32(0,0,0,8), rounding+2);
    // Layer 2 - Medium shadow
    dl->AddRectFilled(ImVec2(x, y+4), ImVec2(x+w, y+h+6), IM_COL32(0,0,0,15), rounding+1);
    // Layer 1 - Tight shadow
    dl->AddRectFilled(ImVec2(x+1, y+2), ImVec2(x+w-1, y+h+2), IM_COL32(0,0,0,10), rounding);
    // Card background
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x+w, y+h), color, rounding);
    // Subtle top highlight (glass effect)
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x+w, y+2), IM_COL32(255,255,255,20), rounding, ImDrawFlags_RoundCornersTop);
}

// Helper: Draw vertical gradient rect
void DrawGradientRect(ImDrawList* dl, float x, float y, float w, float h, ImU32 colTop, ImU32 colBot) {
    dl->AddRectFilledMultiColor(ImVec2(x, y), ImVec2(x+w, y+h), colTop, colTop, colBot, colBot);
}

// Helper: Draw diagonal gradient (top-left to bottom-right)
void DrawDiagonalGradient(ImDrawList* dl, float x, float y, float w, float h, ImU32 col1, ImU32 col2) {
    dl->AddRectFilledMultiColor(ImVec2(x, y), ImVec2(x+w, y+h), col1, col2, col2, col1);
}

// Helper: Draw modern gradient with multiple color stops (simulated)
void DrawModernGradient(ImDrawList* dl, float x, float y, float w, float h, ImU32 colStart, ImU32 colMid, ImU32 colEnd) {
    // Top half - start to mid
    dl->AddRectFilledMultiColor(ImVec2(x, y), ImVec2(x+w, y+h*0.5f), colStart, colStart, colMid, colMid);
    // Bottom half - mid to end
    dl->AddRectFilledMultiColor(ImVec2(x, y+h*0.5f), ImVec2(x+w, y+h), colMid, colMid, colEnd, colEnd);
}

// Helper: Draw glassmorphism card (frosted glass effect)
void DrawGlassCard(ImDrawList* dl, float x, float y, float w, float h, float opacity, ImU32 tintColor, float rounding = 16.0f) {
    // Outer glow/shadow for depth
    dl->AddRectFilled(ImVec2(x-1, y+6), ImVec2(x+w+1, y+h+8), IM_COL32(0,0,0,15), rounding+2);

    // Glass background with transparency
    int tintR = (tintColor >> 0) & 0xFF;
    int tintG = (tintColor >> 8) & 0xFF;
    int tintB = (tintColor >> 16) & 0xFF;
    int alpha = (int)(opacity * 255);
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x+w, y+h), IM_COL32(tintR, tintG, tintB, alpha), rounding);

    // Frosted/blur simulation - multiple translucent layers
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x+w, y+h), IM_COL32(255, 255, 255, 8), rounding);

    // Top highlight (glass shine)
    dl->AddRectFilledMultiColor(
        ImVec2(x+2, y+2), ImVec2(x+w-2, y + h*0.35f),
        IM_COL32(255, 255, 255, 40), IM_COL32(255, 255, 255, 40),
        IM_COL32(255, 255, 255, 5), IM_COL32(255, 255, 255, 5)
    );

    // Glass border (subtle)
    dl->AddRect(ImVec2(x, y), ImVec2(x+w, y+h), IM_COL32(255, 255, 255, 50), rounding, 0, 1.0f);
    // Inner border highlight
    dl->AddRect(ImVec2(x+1, y+1), ImVec2(x+w-1, y+h-1), IM_COL32(255, 255, 255, 20), rounding-1, 0, 1.0f);
}

// Enhanced glass card with configurable border and highlight - FIXED OVERLAPPING
void DrawGlassCardEnhanced(ImDrawList* dl, float x, float y, float w, float h, float opacity, ImU32 tintColor,
    float rounding, float borderWidth, ImU32 borderColor, bool showHighlight, float highlightOpacity) {
    // Subtle shadow for depth (lighter to avoid dark overlap)
    dl->AddRectFilled(ImVec2(x, y+4), ImVec2(x+w, y+h+6), IM_COL32(0,0,0,12), rounding+1);

    // Glass background with transparency - SINGLE LAYER ONLY
    int tintR = (tintColor >> 0) & 0xFF;
    int tintG = (tintColor >> 8) & 0xFF;
    int tintB = (tintColor >> 16) & 0xFF;
    int alpha = (int)(opacity * 255);
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x+w, y+h), IM_COL32(tintR, tintG, tintB, alpha), rounding);

    // REMOVED: Multiple overlapping blur layers that caused messy appearance
    // Now using single clean glass background instead

    // Top highlight (glass shine) - ONLY if enabled
    if (showHighlight) {
        int hlAlpha = (int)(highlightOpacity * 255 * 0.4f);  // Reduced from 0.5f for subtlety
        dl->AddRectFilledMultiColor(
            ImVec2(x+2, y+2), ImVec2(x+w-2, y + h*0.35f),  // Smaller highlight area
            IM_COL32(255, 255, 255, hlAlpha), IM_COL32(255, 255, 255, hlAlpha),
            IM_COL32(255, 255, 255, 0), IM_COL32(255, 255, 255, 0)
        );
    }

    // Glass border - configurable
    if (borderWidth > 0) {
        dl->AddRect(ImVec2(x, y), ImVec2(x+w, y+h), borderColor, rounding, 0, borderWidth);
        // REMOVED: Inner border that caused double-border overlap
    }
}

// Helper: Draw glassmorphism button
void DrawGlassButton(ImDrawList* dl, const char* label, float x, float y, float w, float h, float opacity, ImU32 tintColor, ImU32 textColor, float rounding = 12.0f) {
    ImGuiIO& io = ImGui::GetIO();
    bool hovered = (io.MousePos.x >= x && io.MousePos.x <= x+w && io.MousePos.y >= y && io.MousePos.y <= y+h);
    bool pressed = hovered && ImGui::IsMouseDown(0);

    float effectiveOpacity = opacity + (hovered ? 0.1f : 0.0f);
    float pressOffset = pressed ? 1.0f : 0.0f;

    int tintR = (tintColor >> 0) & 0xFF;
    int tintG = (tintColor >> 8) & 0xFF;
    int tintB = (tintColor >> 16) & 0xFF;

    // Shadow
    if (!pressed) {
        dl->AddRectFilled(ImVec2(x+1, y+4), ImVec2(x+w+1, y+h+4), IM_COL32(0,0,0,20), rounding);
    }

    // Glass background
    int alpha = (int)(effectiveOpacity * 255);
    dl->AddRectFilled(ImVec2(x, y+pressOffset), ImVec2(x+w, y+h+pressOffset), IM_COL32(tintR, tintG, tintB, alpha), rounding);

    // Top highlight
    dl->AddRectFilledMultiColor(
        ImVec2(x+2, y+2+pressOffset), ImVec2(x+w-2, y + h*0.4f + pressOffset),
        IM_COL32(255, 255, 255, 50), IM_COL32(255, 255, 255, 50),
        IM_COL32(255, 255, 255, 0), IM_COL32(255, 255, 255, 0)
    );

    // Border
    dl->AddRect(ImVec2(x, y+pressOffset), ImVec2(x+w, y+h+pressOffset), IM_COL32(255, 255, 255, 60), rounding, 0, 1.0f);

    // Text
    if (g_FontButton) ImGui::PushFont(g_FontButton);
    ImVec2 sz = ImGui::CalcTextSize(label);
    dl->AddText(ImVec2(x + (w-sz.x)/2, y + (h-sz.y)/2 + pressOffset), textColor, label);
    if (g_FontButton) ImGui::PopFont();
}

// Helper: Draw glass panel (for drag-drop glass elements)
void DrawGlassPanel(ImDrawList* dl, float x, float y, float w, float h, const char* text, float textSize, ImU32 textColor, float opacity, ImU32 tintColor, float rounding = 16.0f) {
    // Draw the glass effect
    DrawGlassCard(dl, x, y, w, h, opacity, tintColor, rounding);

    // Draw text if provided
    if (text && *text) {
        ImFont* font = GetFont((int)textSize);
        if (font) ImGui::PushFont(font);
        ImVec2 sz = ImGui::CalcTextSize(text);
        float textX = x + (w - sz.x) / 2;
        float textY = y + (h - sz.y) / 2;
        dl->AddText(ImVec2(textX, textY), textColor, text);
        if (font) ImGui::PopFont();
    }
}

// Helper: Draw centered text with font
void DrawCenteredText(ImDrawList* dl, ImFont* font, const char* text, float x, float y, float width, ImU32 color) {
    if (font) ImGui::PushFont(font);
    ImVec2 sz = ImGui::CalcTextSize(text);
    dl->AddText(ImVec2(x + (width - sz.x)/2, y), color, text);
    if (font) ImGui::PopFont();
}

// Helper: Draw wrapped text (word wrap)
float DrawWrappedTextEx(ImDrawList* dl, ImFont* font, const char* text, float x, float y, float maxWidth, ImU32 color, bool centered = false) {
    if (!text || !*text) return 0;
    if (font) ImGui::PushFont(font);

    std::string str(text);
    std::vector<std::string> lines;
    std::string currentLine;
    float spaceWidth = ImGui::CalcTextSize(" ").x;
    float lineHeight = ImGui::GetTextLineHeight();

    // Split into words
    std::string word;
    for (size_t i = 0; i <= str.size(); i++) {
        char c = (i < str.size()) ? str[i] : ' ';
        if (c == ' ' || c == '\n' || i == str.size()) {
            if (!word.empty()) {
                ImVec2 wordSize = ImGui::CalcTextSize(word.c_str());
                ImVec2 lineSize = ImGui::CalcTextSize(currentLine.c_str());

                if (lineSize.x + wordSize.x > maxWidth && !currentLine.empty()) {
                    lines.push_back(currentLine);
                    currentLine = word;
                } else {
                    if (!currentLine.empty()) currentLine += " ";
                    currentLine += word;
                }
                word.clear();
            }
            if (c == '\n' && !currentLine.empty()) {
                lines.push_back(currentLine);
                currentLine.clear();
            }
        } else {
            word += c;
        }
    }
    if (!currentLine.empty()) lines.push_back(currentLine);

    // Draw lines
    float totalHeight = 0;
    for (const auto& line : lines) {
        ImVec2 lineSize = ImGui::CalcTextSize(line.c_str());
        float drawX = centered ? (x + (maxWidth - lineSize.x) / 2) : x;
        dl->AddText(ImVec2(drawX, y + totalHeight), color, line.c_str());
        totalHeight += lineHeight + 4;
    }

    if (font) ImGui::PopFont();
    return totalHeight;
}

// Modern Service Card with animation
void DrawModernServiceCard(ImDrawList* dl, float x, float y, float w, float h,
                          const char* title, const char* subtitle,
                          const char** bullets, int bulletCount,
                          ImU32 iconColor, float animProgress) {
    // Animation: slide in from right
    float slideOffset = (1.0f - animProgress) * 150.0f;
    x += slideOffset;
    float alpha = animProgress;

    // Card shadow (soft, modern)
    dl->AddRectFilled(ImVec2(x + 2, y + 8), ImVec2(x + w + 2, y + h + 8),
                     IM_COL32(0, 0, 0, (int)(15 * alpha)), 16.0f);

    // Card background (white)
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x + w, y + h),
                     IM_COL32(255, 255, 255, (int)(255 * alpha)), 16.0f);

    // Card border (light gray, complete)
    dl->AddRect(ImVec2(x, y), ImVec2(x + w, y + h),
               IM_COL32(230, 230, 230, (int)(255 * alpha)), 16.0f, 0, 1.0f);

    // Title (bold, dark) - starts from top
    ImFont* font = ImGui::GetFont();
    float textY = y + 32;
    dl->AddText(font, 22.0f, ImVec2(x + 24, textY),
               IM_COL32(18, 18, 18, (int)(255 * alpha)), title);
    textY += 32;

    // Subtitle (gray)
    dl->AddText(font, 15.0f, ImVec2(x + 24, textY),
               IM_COL32(115, 115, 128, (int)(255 * alpha)), subtitle);
    textY += 36;

    // Bullet points
    for (int i = 0; i < bulletCount && i < 3; i++) {
        // Bullet icon (small dark circle)
        dl->AddCircleFilled(ImVec2(x + 30, textY + 7), 3, IM_COL32(60, 60, 67, (int)(255 * alpha)));

        // Bullet text
        dl->AddText(font, 14.0f, ImVec2(x + 42, textY),
                   IM_COL32(60, 60, 67, (int)(255 * alpha)), bullets[i]);
        textY += 24;
    }

    // "Learn More" link with arrow at bottom
    textY = y + h - 40;
    dl->AddText(font, 15.0f, ImVec2(x + 24, textY),
               IM_COL32(0, 112, 243, (int)(255 * alpha)), "Learn More ->");
}

// Smooth animation state for buttons
static std::map<std::string, float> g_ButtonHoverState;

// Helper: Draw modern button with smooth hover effect
bool DrawStyledButton(ImDrawList* dl, const char* label, float x, float y, float w, float h, ImU32 bgColor, ImU32 textColor, float rounding = 10.0f) {
    ImGuiIO& io = ImGui::GetIO();
    bool hovered = (io.MousePos.x >= x && io.MousePos.x <= x+w && io.MousePos.y >= y && io.MousePos.y <= y+h);
    bool clicked = hovered && ImGui::IsMouseClicked(0);
    bool pressed = hovered && ImGui::IsMouseDown(0);

    // Get/create hover animation state
    std::string btnId = std::string(label) + std::to_string((int)x) + std::to_string((int)y);
    float& hoverAnim = g_ButtonHoverState[btnId];

    // Smooth hover transition (0.0 to 1.0)
    float targetHover = hovered ? 1.0f : 0.0f;
    hoverAnim += (targetHover - hoverAnim) * 0.15f;

    // Extract RGBA from bgColor
    int r = (bgColor >> 0) & 0xFF;
    int g = (bgColor >> 8) & 0xFF;
    int b = (bgColor >> 16) & 0xFF;

    // Hover effect - brighten and slightly saturate
    r = r + (int)(30 * hoverAnim); if (r > 255) r = 255;
    g = g + (int)(30 * hoverAnim); if (g > 255) g = 255;
    b = b + (int)(30 * hoverAnim); if (b > 255) b = 255;
    ImU32 finalBg = IM_COL32(r, g, b, 255);

    // Press effect - slight scale down simulation via position offset
    float pressOffset = pressed ? 1.0f : 0.0f;

    // Modern layered shadow (less shadow when pressed/hovered for "lift" effect)
    float shadowAlpha = 35 - (hoverAnim * 10) - (pressOffset * 15);
    dl->AddRectFilled(ImVec2(x+2-pressOffset, y+4-pressOffset*2), ImVec2(x+w+2-pressOffset, y+h+4-pressOffset*2), IM_COL32(0,0,0,(int)shadowAlpha), rounding);
    dl->AddRectFilled(ImVec2(x+1, y+2-pressOffset), ImVec2(x+w+1, y+h+2-pressOffset), IM_COL32(0,0,0,15), rounding);

    // Button background with hover glow
    float btnY = y + pressOffset;
    dl->AddRectFilled(ImVec2(x, btnY), ImVec2(x+w, btnY+h), finalBg, rounding);

    // Subtle inner highlight (top edge)
    dl->AddRectFilled(ImVec2(x+2, btnY+1), ImVec2(x+w-2, btnY+3), IM_COL32(255,255,255,25), rounding);

    // Border for definition (subtle)
    dl->AddRect(ImVec2(x, btnY), ImVec2(x+w, btnY+h), IM_COL32(0,0,0,15), rounding, 0, 1.0f);

    // Text with slight shadow for readability
    if (g_FontButton) ImGui::PushFont(g_FontButton);
    ImVec2 sz = ImGui::CalcTextSize(label);
    float textX = x + (w-sz.x)/2;
    float textY = btnY + (h-sz.y)/2;
    // Text shadow
    dl->AddText(ImVec2(textX+1, textY+1), IM_COL32(0,0,0,30), label);
    // Main text
    dl->AddText(ImVec2(textX, textY), textColor, label);
    if (g_FontButton) ImGui::PopFont();

    return clicked;
}

// Helper: Draw pill/rounded button (for secondary actions)
bool DrawPillButton(ImDrawList* dl, const char* label, float x, float y, float w, float h, ImU32 borderColor, ImU32 textColor) {
    ImGuiIO& io = ImGui::GetIO();
    bool hovered = (io.MousePos.x >= x && io.MousePos.x <= x+w && io.MousePos.y >= y && io.MousePos.y <= y+h);
    bool clicked = hovered && ImGui::IsMouseClicked(0);

    float rounding = h / 2.0f;  // Full pill shape
    ImU32 bgColor = hovered ? IM_COL32(245, 247, 250, 255) : IM_COL32(255, 255, 255, 255);

    // Background
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x+w, y+h), bgColor, rounding);
    // Border
    dl->AddRect(ImVec2(x, y), ImVec2(x+w, y+h), borderColor, rounding, 0, 1.5f);

    // Text
    if (g_FontButton) ImGui::PushFont(g_FontButton);
    ImVec2 sz = ImGui::CalcTextSize(label);
    dl->AddText(ImVec2(x + (w-sz.x)/2, y + (h-sz.y)/2), textColor, label);
    if (g_FontButton) ImGui::PopFont();

    return clicked;
}

// Drag scroll state
static bool g_IsDragging = false;
static float g_LastMouseY = 0.0f;
static float g_ScrollVelocity = 0.0f;

// Main website rendering
void RenderWebsite() {
    ImGuiIO& io = ImGui::GetIO();
    float winW = io.DisplaySize.x;
    float winH = io.DisplaySize.y;

    // Handle mouse wheel scrolling (optimized for Mac trackpad two-finger scrolling)
    if (io.MouseWheel != 0) {
        g_ScrollTarget -= io.MouseWheel * 100.0f;  // Increased from 80 to 100 for smoother trackpad scrolling
        g_ScrollVelocity = 0;  // Stop momentum when using wheel
    }

    // Handle mouse drag scrolling (like mobile/touch)
    if (ImGui::IsMouseDown(0)) {
        if (!g_IsDragging) {
            g_IsDragging = true;
            g_LastMouseY = io.MousePos.y;
            g_ScrollVelocity = 0;
        } else {
            float deltaY = g_LastMouseY - io.MousePos.y;
            g_ScrollTarget += deltaY;
            g_ScrollVelocity = deltaY;
            g_LastMouseY = io.MousePos.y;
        }
    } else {
        if (g_IsDragging) {
            g_IsDragging = false;
            // Apply momentum
            g_ScrollTarget += g_ScrollVelocity * 5.0f;
        }
        // Decay velocity
        g_ScrollVelocity *= 0.95f;
    }

    // Handle arrow keys for scrolling
    if (ImGui::IsKeyDown(ImGuiKey_DownArrow) || ImGui::IsKeyDown(ImGuiKey_PageDown)) {
        g_ScrollTarget += 20.0f;
    }
    if (ImGui::IsKeyDown(ImGuiKey_UpArrow) || ImGui::IsKeyDown(ImGuiKey_PageUp)) {
        g_ScrollTarget -= 20.0f;
    }
    if (ImGui::IsKeyPressed(ImGuiKey_Home)) {
        g_ScrollTarget = 0;
    }
    if (ImGui::IsKeyPressed(ImGuiKey_End)) {
        g_ScrollTarget = g_TotalHeight - winH;
    }

    // Smooth scrolling with optimized response for Mac trackpad
    g_ScrollY += (g_ScrollTarget - g_ScrollY) * 0.25f;  // Increased from 0.2f to 0.25f for smoother feel

    // Clamp scroll
    if (g_ScrollY < 0) { g_ScrollY = 0; g_ScrollTarget = 0; }
    float maxScroll = g_TotalHeight - winH;
    if (maxScroll < 0) maxScroll = 0;
    if (g_ScrollY > maxScroll) {
        g_ScrollY = maxScroll;
        g_ScrollTarget = maxScroll;
    }

    // Main fullscreen window
    ImGui::SetNextWindowPos(ImVec2(0, 0));
    ImGui::SetNextWindowSize(ImVec2(winW, winH));
    ImGui::Begin("##Website", nullptr,
        ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize |
        ImGuiWindowFlags_NoMove | ImGuiWindowFlags_NoScrollbar |
        ImGuiWindowFlags_NoBackground);

    ImDrawList* dl = ImGui::GetWindowDrawList();
    float yPos = -g_ScrollY;  // Apply scroll offset

)";

    // Generate rendering code for each section
    for (size_t secIdx = 0; secIdx < g_Sections.size(); secIdx++) {
        const auto& sec = g_Sections[secIdx];

        cpp << "    // ===== " << sec.name << " =====\n";
        cpp << "    {\n";
        cpp << "        float secY = yPos;\n";
        cpp << "        float secH = " << sec.height << ";\n";
        cpp << "        ImVec2 secMin(0, secY);\n";
        cpp << "        ImVec2 secMax(winW, secY + secH);\n\n";

        // Animation code generation
        if (sec.animation_type != ANIM_NONE) {
            cpp << "        // Animation: " << g_AnimationNames[sec.animation_type] << "\n";
            cpp << "        static float animTime" << secIdx << " = 0.0f;\n";
            cpp << "        static bool animStarted" << secIdx << " = false;\n";
            cpp << "        if (!animStarted" << secIdx << ") {\n";
            cpp << "            animTime" << secIdx << " = 0.0f;\n";
            cpp << "            animStarted" << secIdx << " = true;\n";
            cpp << "        }\n";
            cpp << "        animTime" << secIdx << " += io.DeltaTime;\n";
            // Format animation duration properly for C++ code
            char durationStr[32];
            snprintf(durationStr, sizeof(durationStr), "%.1ff", sec.animation_duration);
            // Use inline clamp instead of ImClamp (which may not be available in generated code)
            cpp << "        float animProgress = (animTime" << secIdx << " / " << durationStr << ");\n";
            cpp << "        animProgress = (animProgress < 0.0f) ? 0.0f : (animProgress > 1.0f) ? 1.0f : animProgress;\n";

            switch (sec.animation_type) {
                case ANIM_FADE_IN:
                    cpp << "        float animAlpha = animProgress;\n";
                    break;
                case ANIM_SLIDE_UP:
                    cpp << "        float animOffset = (1.0f - animProgress) * 100.0f;\n";
                    cpp << "        secY += animOffset;\n";
                    cpp << "        secMin.y += animOffset; secMax.y += animOffset;\n";
                    cpp << "        float animAlpha = animProgress;\n";
                    break;
                case ANIM_SLIDE_DOWN:
                    cpp << "        float animOffset = (1.0f - animProgress) * -100.0f;\n";
                    cpp << "        secY += animOffset;\n";
                    cpp << "        secMin.y += animOffset; secMax.y += animOffset;\n";
                    cpp << "        float animAlpha = animProgress;\n";
                    break;
                case ANIM_SLIDE_LEFT:
                    cpp << "        float animOffsetX = (1.0f - animProgress) * 200.0f;\n";
                    cpp << "        float animAlpha = animProgress;\n";
                    break;
                case ANIM_SLIDE_RIGHT:
                    cpp << "        float animOffsetX = (1.0f - animProgress) * -200.0f;\n";
                    cpp << "        float animAlpha = animProgress;\n";
                    break;
                case ANIM_ZOOM_IN:
                    cpp << "        float animScale = 0.5f + animProgress * 0.5f;\n";
                    cpp << "        float animAlpha = animProgress;\n";
                    break;
                case ANIM_ZOOM_OUT:
                    cpp << "        float animScale = 1.5f - animProgress * 0.5f;\n";
                    cpp << "        float animAlpha = animProgress;\n";
                    break;
                case ANIM_BOUNCE:
                    cpp << "        float animBounce = sinf(animProgress * 3.14159f * 2.0f) * (1.0f - animProgress) * 50.0f;\n";
                    cpp << "        secY -= animBounce;\n";
                    cpp << "        secMin.y -= animBounce; secMax.y -= animBounce;\n";
                    cpp << "        float animAlpha = animProgress;\n";
                    break;
                case ANIM_ROTATE_IN:
                    cpp << "        float animAlpha = animProgress;\n";
                    cpp << "        float animRotation = (1.0f - animProgress) * 360.0f;\n";
                    break;
                default:
                    cpp << "        float animAlpha = 1.0f;\n";
                    break;
            }

            if (sec.animation_repeat) {
                cpp << "        if (animProgress >= 1.0f) { animTime" << secIdx << " = 0.0f; animStarted" << secIdx << " = false; }\n";
            }
            cpp << "\n";
        }

        // Background
        cpp << "        // Background\n";

        // Check if section has background image
        bool hasBackgroundImage = !sec.background_image.empty() && sec.background_image != "none" && imageVarNames.count(sec.background_image);
        bool hasHeroAnimation = !sec.hero_animation_images.empty() && sec.enable_hero_animation;

        if (hasHeroAnimation) {
            // Generate hero animation code
            cpp << "        // Hero animation (slideshow)\n";
            cpp << "        static float animTimer" << secIdx << " = 0.0f;\n";
            cpp << "        static int animFrame" << secIdx << " = 0;\n";
            cpp << "        animTimer" << secIdx << " += io.DeltaTime;\n";
            cpp << "        if (animTimer" << secIdx << " >= " << std::fixed << std::setprecision(1) << sec.hero_animation_speed << "f) {\n";
            cpp << "            animTimer" << secIdx << " = 0.0f;\n";
            cpp << "            animFrame" << secIdx << "++;\n";
            cpp << "            if (animFrame" << secIdx << " >= " << sec.hero_animation_images.size() << ") animFrame" << secIdx << " = 0;\n";
            cpp << "        }\n";
            cpp << "        GLuint animTex = 0;\n";
            cpp << "        if (animFrame" << secIdx << " == 0) animTex = " << imageVarNames[sec.hero_animation_images[0]] << ";\n";
            for (size_t i = 1; i < sec.hero_animation_images.size(); i++) {
                cpp << "        else if (animFrame" << secIdx << " == " << i << ") animTex = " << imageVarNames[sec.hero_animation_images[i]] << ";\n";
            }
            cpp << "        DrawBackgroundImageCover(dl, animTex, 0, secY, winW, secH);\n";
        } else if (hasBackgroundImage) {
            // Single background image
            cpp << "        DrawBackgroundImageCover(dl, " << imageVarNames[sec.background_image] << ", 0, secY, winW, secH);\n";
        } else {
            // Solid color background
            cpp << "        dl->AddRectFilled(secMin, secMax, " << ColorToU32(sec.bg_color) << ");\n";
        }

        cpp << "\n";

        // Generate glass panels for this section
        if (!sec.glass_panels.empty()) {
            cpp << "        // Glass Panels\n";
            for (const auto& gp : sec.glass_panels) {
                cpp << "        DrawGlassPanel(dl, " << std::fixed << std::setprecision(1) << gp.x << "f, secY + " << gp.y << "f, " << gp.width << "f, " << gp.height << "f, \"" << EscapeString(gp.text) << "\", " << gp.text_size << "f, " << ColorToU32(gp.text_color) << ", " << std::setprecision(2) << gp.opacity << "f, " << ColorToU32(gp.tint) << ", " << std::setprecision(1) << gp.border_radius << "f);\n";
            }
            cpp << "\n";
        }

        switch (sec.type) {
            case SEC_NAVBAR: {
                cpp << "        // Modern Navbar with subtle shadow\n";
                cpp << "        float navH = secH;\n";
                cpp << "        // Navbar background\n";
                cpp << "        dl->AddRectFilled(secMin, secMax, " << ColorToU32(sec.nav_bg_color) << ");\n";
                cpp << "        // Bottom shadow for depth\n";
                cpp << "        dl->AddRectFilledMultiColor(ImVec2(0, secY + navH), ImVec2(winW, secY + navH + 4), IM_COL32(0,0,0,12), IM_COL32(0,0,0,12), IM_COL32(0,0,0,0), IM_COL32(0,0,0,0));\n";
                cpp << "        // Logo + Brand with modern font\n";
                cpp << "        ImFont* brandFont = GetFont(" << (int)sec.title_font_size << ");\n";
                cpp << "        if (brandFont) ImGui::PushFont(brandFont);\n";
                cpp << "        ImVec2 brandSize = ImGui::CalcTextSize(\"" << EscapeString(sec.title) << "\");\n";
                cpp << "        float startX = 40;\n";
                cpp << "        float centerY = secY + navH/2;\n";

                // Add logo rendering if exists
                if (sec.logo_texture_id != 0 && !sec.logo_path.empty()) {
                    auto it = imageVarNames.find(sec.logo_path);
                    if (it != imageVarNames.end()) {
                        cpp << "        // Render Logo\n";
                        cpp << "        if (" << it->second << " != 0) {\n";
                        cpp << "            float logoSize = " << sec.logo_size << ";\n";

                        if (sec.brand_text_position == 0) {
                            // SIDE: Logo left, text right
                            cpp << "            float logoY = centerY - logoSize/2;\n";
                            cpp << "            dl->AddImage((ImTextureID)(intptr_t)" << it->second << ", ImVec2(startX, logoY), ImVec2(startX + logoSize, logoY + logoSize));\n";
                            cpp << "            startX += logoSize + 15;\n";
                        } else if (sec.brand_text_position == 1) {
                            // ABOVE: Text above logo
                            cpp << "            float logoY = centerY;\n";
                            cpp << "            dl->AddImage((ImTextureID)(intptr_t)" << it->second << ", ImVec2(startX, logoY), ImVec2(startX + logoSize, logoY + logoSize));\n";
                            cpp << "            centerY = logoY - brandSize.y - 8;\n";
                        } else if (sec.brand_text_position == 2) {
                            // BELOW: Text below logo
                            cpp << "            float logoY = centerY - logoSize - brandSize.y/2 - 8;\n";
                            cpp << "            dl->AddImage((ImTextureID)(intptr_t)" << it->second << ", ImVec2(startX, logoY), ImVec2(startX + logoSize, logoY + logoSize));\n";
                            cpp << "            centerY = logoY + logoSize + 8;\n";
                        }

                        cpp << "        }\n";
                    }
                }

                cpp << "        dl->AddText(ImVec2(startX, centerY - brandSize.y/2), " << ColorToU32(sec.title_color) << ", \"" << EscapeString(sec.title) << "\");\n";
                cpp << "        if (brandFont) ImGui::PopFont();\n";
                cpp << "        // Nav items with hover effect\n";
                cpp << "        float navX = winW - 40;\n";
                cpp << "        ImFont* navFont = GetFont(" << (int)sec.nav_font_size << ");\n";
                for (int i = (int)sec.nav_items.size() - 1; i >= 0; i--) {
                    cpp << "        {\n";
                    cpp << "            if (navFont) ImGui::PushFont(navFont);\n";
                    cpp << "            const char* label = \"" << EscapeString(sec.nav_items[i].label) << "\";\n";
                    cpp << "            ImVec2 sz = ImGui::CalcTextSize(label);\n";
                    cpp << "            navX -= sz.x + 32;\n";
                    cpp << "            float itemY = secY + navH/2 - sz.y/2;\n";
                    cpp << "            // Check hover\n";
                    cpp << "            bool hovered = (io.MousePos.x >= navX - 8 && io.MousePos.x <= navX + sz.x + 8 && io.MousePos.y >= itemY - 4 && io.MousePos.y <= itemY + sz.y + 4);\n";
                    cpp << "            // Hover underline effect\n";
                    cpp << "            if (hovered) {\n";
                    cpp << "                dl->AddRectFilled(ImVec2(navX, itemY + sz.y + 2), ImVec2(navX + sz.x, itemY + sz.y + 4), " << ColorToU32(sec.accent_color) << ", 1.0f);\n";
                    cpp << "            }\n";
                    cpp << "            dl->AddText(ImVec2(navX, itemY), hovered ? " << ColorToU32(sec.accent_color) << " : " << ColorToU32(sec.nav_text_color) << ", label);\n";
                    cpp << "            if (navFont) ImGui::PopFont();\n";
                    cpp << "        }\n";
                }
                break;
            }

            case SEC_HERO:
            case SEC_CTA: {
                cpp << "        // Modern Hero/CTA with gradient background option\n";
                // Create a subtle gradient version of the bg color
                ImVec4 bgCol = sec.bg_color;
                ImVec4 gradEnd = ImVec4(
                    bgCol.x * 0.92f,
                    bgCol.y * 0.92f,
                    bgCol.z * 0.95f,
                    bgCol.w
                );
                cpp << "        // Gradient background (top to bottom)\n";
                cpp << "        DrawGradientRect(dl, 0, secY, winW, secH, " << ColorToU32(sec.bg_color) << ", " << ColorToU32(gradEnd) << ");\n";

                // Add section image rendering if exists
                if (!sec.section_image.empty() && sec.section_image != "none") {
                    auto it = imageVarNames.find(sec.section_image);
                    if (it != imageVarNames.end()) {
                        cpp << "        // Render section image\n";
                        cpp << "        if (" << it->second << " != 0) {\n";
                        cpp << "            float imgW = winW * 0.6f;  // 60% of window width\n";
                        cpp << "            float imgH = secH * 0.4f;  // 40% of section height\n";
                        cpp << "            float imgX = (winW - imgW) / 2;\n";
                        cpp << "            float imgY = secY + 40;\n";
                        cpp << "            dl->AddImage((ImTextureID)(intptr_t)" << it->second << ", ImVec2(imgX, imgY), ImVec2(imgX + imgW, imgY + imgH));\n";
                        cpp << "            // Border around image\n";
                        cpp << "            dl->AddRect(ImVec2(imgX, imgY), ImVec2(imgX + imgW, imgY + imgH), IM_COL32(255, 255, 255, 60), 4.0f, 0, 1.5f);\n";
                        cpp << "        }\n";
                    }
                }

                cpp << "        // Content centered with proper spacing\n";
                cpp << "        float contentY = secY + secH * 0.3f;\n";
                cpp << "        float centerX = winW / 2;\n";
                cpp << "        float maxTextWidth = winW * 0.65f;  // 65% of window width\n";
                cpp << "        if (maxTextWidth > 720) maxTextWidth = 720;  // Cap for readability\n";
                if (!sec.title.empty()) {
                    cpp << "        {\n";
                    cpp << "            const char* title = \"" << EscapeString(sec.title) << "\";\n";
                    cpp << "            float h = DrawWrappedTextEx(dl, GetFont(" << (int)sec.title_font_size << "), title, centerX - maxTextWidth/2, contentY, maxTextWidth, " << ColorToU32(sec.title_color) << ", true);\n";
                    cpp << "            contentY += h + 24;\n";
                    cpp << "        }\n";
                }
                if (!sec.subtitle.empty()) {
                    cpp << "        {\n";
                    cpp << "            const char* sub = \"" << EscapeString(sec.subtitle) << "\";\n";
                    cpp << "            float h = DrawWrappedTextEx(dl, GetFont(" << (int)sec.subtitle_font_size << "), sub, centerX - maxTextWidth/2, contentY, maxTextWidth, " << ColorToU32(sec.subtitle_color) << ", true);\n";
                    cpp << "            contentY += h + 40;\n";
                    cpp << "        }\n";
                }
                if (!sec.button_text.empty()) {
                    cpp << "        {\n";
                    cpp << "            ImFont* btnFont = GetFont(" << (int)sec.button_font_size << ");\n";
                    cpp << "            if (btnFont) ImGui::PushFont(btnFont);\n";
                    cpp << "            const char* btnText = \"" << EscapeString(sec.button_text) << "\";\n";
                    cpp << "            ImVec2 btnSize = ImGui::CalcTextSize(btnText);\n";
                    cpp << "            float btnW = btnSize.x + 64, btnH = 52;\n";
                    cpp << "            float btnX = centerX - btnW/2;\n";
                    if (sec.button_glass_effect) {
                        cpp << "            DrawGlassButton(dl, btnText, btnX, contentY, btnW, btnH, " << std::fixed << std::setprecision(2) << sec.button_glass_opacity << "f, " << ColorToU32(sec.button_glass_tint) << ", " << ColorToU32(sec.button_text_color) << ", 12.0f);\n";
                    } else {
                        cpp << "            DrawStyledButton(dl, btnText, btnX, contentY, btnW, btnH, " << ColorToU32(sec.button_bg_color) << ", " << ColorToU32(sec.button_text_color) << ", 10.0f);\n";
                    }
                    cpp << "            if (btnFont) ImGui::PopFont();\n";
                    cpp << "        }\n";
                }
                break;
            }

            case SEC_ABOUT: {
                cpp << "        // About section with text wrapping\n";
                cpp << "        float contentY = secY + 60;\n";
                cpp << "        float centerX = winW / 2;\n";
                cpp << "        float maxTextWidth = winW * 0.75f;\n";
                cpp << "        if (maxTextWidth > 900) maxTextWidth = 900;\n";
                if (!sec.title.empty()) {
                    cpp << "        {\n";
                    cpp << "            const char* title = \"" << EscapeString(sec.title) << "\";\n";
                    cpp << "            float h = DrawWrappedTextEx(dl, GetFont(" << (int)sec.title_font_size << "), title, centerX - maxTextWidth/2, contentY, maxTextWidth, " << ColorToU32(sec.title_color) << ", true);\n";
                    cpp << "            contentY += h + 25;\n";
                    cpp << "        }\n";
                }
                if (!sec.content.empty()) {
                    cpp << "        {\n";
                    cpp << "            const char* content = \"" << EscapeString(sec.content) << "\";\n";
                    cpp << "            DrawWrappedTextEx(dl, GetFont(" << (int)sec.content_font_size << "), content, centerX - maxTextWidth/2, contentY, maxTextWidth, " << ColorToU32(sec.content_color) << ", true);\n";
                    cpp << "        }\n";
                }
                break;
            }

            case SEC_CARDS:
            case SEC_SERVICES:
            case SEC_FEATURES:
            case SEC_PRICING:
            case SEC_TEAM: {
                cpp << "        // Modern Cards section with hover effects\n";
                cpp << "        float contentY = secY + 64;\n";
                cpp << "        float centerX = winW / 2;\n";
                if (!sec.title.empty()) {
                    cpp << "        {\n";
                    cpp << "            ImFont* titleFont = GetFont(" << (int)sec.title_font_size << ");\n";
                    cpp << "            if (titleFont) ImGui::PushFont(titleFont);\n";
                    cpp << "            const char* title = \"" << EscapeString(sec.title) << "\";\n";
                    cpp << "            ImVec2 sz = ImGui::CalcTextSize(title);\n";
                    cpp << "            dl->AddText(ImVec2(centerX - sz.x/2, contentY), " << ColorToU32(sec.title_color) << ", title);\n";
                    cpp << "            if (titleFont) ImGui::PopFont();\n";
                    cpp << "            contentY += sz.y + 48;\n";
                    cpp << "        }\n";
                }
                if (!sec.subtitle.empty()) {
                    cpp << "        {\n";
                    cpp << "            ImFont* subFont = GetFont(" << (int)sec.subtitle_font_size << ");\n";
                    cpp << "            if (subFont) ImGui::PushFont(subFont);\n";
                    cpp << "            const char* sub = \"" << EscapeString(sec.subtitle) << "\";\n";
                    cpp << "            ImVec2 sz = ImGui::CalcTextSize(sub);\n";
                    cpp << "            dl->AddText(ImVec2(centerX - sz.x/2, contentY), " << ColorToU32(sec.subtitle_color) << ", sub);\n";
                    cpp << "            if (subFont) ImGui::PopFont();\n";
                    cpp << "            contentY += sz.y + 40;\n";
                    cpp << "        }\n";
                }

                // Cards with modern styling - responsive
                int cardsPerRow = sec.cards_per_row;
                float cardW = sec.card_width;
                float cardH = sec.card_height;
                float spacing = sec.card_spacing;

                cpp << "        {\n";
                cpp << "            int cardsPerRow = " << cardsPerRow << ";\n";
                cpp << "            float baseCardW = " << std::fixed << std::setprecision(1) << cardW << "f;\n";
                cpp << "            float baseCardH = " << std::fixed << std::setprecision(1) << cardH << "f;\n";
                cpp << "            float spacing = " << std::fixed << std::setprecision(1) << spacing << "f;\n";
                cpp << "            // Responsive card sizing - fit to window width\n";
                cpp << "            float maxContentW = winW * 0.9f;  // 90% of window width\n";
                cpp << "            float maxCardW = (maxContentW - (cardsPerRow - 1) * spacing) / cardsPerRow;\n";
                cpp << "            float cardW = (baseCardW < maxCardW) ? baseCardW : maxCardW;\n";
                cpp << "            float cardH = baseCardH * (cardW / baseCardW);  // Maintain aspect ratio\n";
                cpp << "            float totalW = cardsPerRow * cardW + (cardsPerRow - 1) * spacing;\n";
                cpp << "            float startX = (winW - totalW) / 2;\n";

                for (size_t i = 0; i < sec.items.size(); i++) {
                    const auto& item = sec.items[i];
                    cpp << "            // Card " << i << " with continuous animation\n";
                    cpp << "            {\n";
                    cpp << "                int row = " << i << " / cardsPerRow;\n";
                    cpp << "                int col = " << i << " % cardsPerRow;\n";
                    cpp << "                float cardX = startX + col * (cardW + spacing);\n";
                    cpp << "                float cardY = contentY + row * (cardH + spacing + 16);\n";
                    cpp << "                // Calculate staggered animation progress\n";
                    cpp << "                float animDelay = " << std::fixed << std::setprecision(2) << sec.animation_delay << "f + " << i << " * " << std::fixed << std::setprecision(2) << sec.card_stagger_delay << "f;\n";
                    cpp << "                float animDuration = " << std::fixed << std::setprecision(2) << sec.animation_duration << "f;\n";
                    cpp << "                float animProgress = fmodf((g_AnimTime + animDelay) / animDuration, 1.0f);\n";

                    // Check if using modern card style
                    if (item.card_style == 1) {
                        // Modern service card with animation
                        cpp << "                // Modern Service Card with animation\n";
                        cpp << "                const char* bullets[] = {";
                        for (size_t b = 0; b < item.bullet_points.size() && b < 3; b++) {
                            if (b > 0) cpp << ", ";
                            cpp << "\"" << EscapeString(item.bullet_points[b]) << "\"";
                        }
                        cpp << "};\n";
                        cpp << "                DrawModernServiceCard(dl, cardX, cardY, cardW, cardH, ";
                        cpp << "\"" << EscapeString(item.title) << "\", ";
                        cpp << "\"" << EscapeString(item.description) << "\", ";
                        cpp << "bullets, " << std::min((int)item.bullet_points.size(), 3) << ", ";
                        cpp << ColorToU32(item.icon_color) << ", animProgress);\n";
                    } else {
                        // Old card style (fallback)
                        cpp << "                // Check hover for lift effect\n";
                        cpp << "                bool cardHovered = (io.MousePos.x >= cardX && io.MousePos.x <= cardX + cardW && io.MousePos.y >= cardY && io.MousePos.y <= cardY + cardH);\n";
                        cpp << "                float hoverOffset = cardHovered ? -4.0f : 0.0f;\n";
                        cpp << "                // Card with modern shadow (enhanced on hover)\n";
                        cpp << "                if (cardHovered) {\n";
                        cpp << "                    dl->AddRectFilled(ImVec2(cardX-4, cardY+12), ImVec2(cardX+cardW+4, cardY+cardH+16), IM_COL32(0,0,0,20), 14.0f);\n";
                        cpp << "                }\n";
                        if (item.glass_effect) {
                            cpp << "                DrawGlassCardEnhanced(dl, cardX, cardY + hoverOffset, cardW, cardH, "
                                << std::fixed << std::setprecision(2) << item.glass_opacity << "f, "
                                << ColorToU32(item.glass_tint) << ", "
                                << std::fixed << std::setprecision(1) << item.glass_border_radius << "f, "
                                << std::fixed << std::setprecision(1) << item.glass_border_width << "f, "
                                << ColorToU32(item.glass_border_color) << ", "
                                << (item.glass_highlight ? "true" : "false") << ", "
                                << std::fixed << std::setprecision(2) << item.glass_highlight_opacity << "f);\n";
                        } else {
                            cpp << "                DrawCardWithShadow(dl, cardX, cardY + hoverOffset, cardW, cardH, " << ColorToU32(item.bg_color) << ", 12.0f);\n";
                        }
                        // Render text for old style cards only
                        if (!item.title.empty()) {
                            cpp << "                {\n";
                            cpp << "                    ImFont* cardTitleFont = GetFont(" << (int)item.title_font_size << ");\n";
                            cpp << "                    if (cardTitleFont) ImGui::PushFont(cardTitleFont);\n";
                        cpp << "                    const char* cardTitle = \"" << EscapeString(item.title) << "\";\n";
                        cpp << "                    ImVec2 tsz = ImGui::CalcTextSize(cardTitle);\n";
                        cpp << "                    dl->AddText(ImVec2(cardX + cardW/2 - tsz.x/2, cardY + hoverOffset + 28), " << ColorToU32(item.title_color) << ", cardTitle);\n";
                        cpp << "                    if (cardTitleFont) ImGui::PopFont();\n";
                        cpp << "                }\n";
                        }
                        if (!item.description.empty()) {
                            cpp << "                {\n";
                            cpp << "                    const char* cardDesc = \"" << EscapeString(item.description) << "\";\n";
                            cpp << "                    DrawWrappedTextEx(dl, GetFont(" << (int)item.desc_font_size << "), cardDesc, cardX + 20, cardY + hoverOffset + 64, cardW - 40, " << ColorToU32(item.desc_color) << ", true);\n";
                            cpp << "                }\n";
                        }
                        if (!item.price.empty()) {
                            cpp << "                {\n";
                            cpp << "                    ImFont* priceFont = GetFont(" << (int)item.title_font_size << ");\n";
                            cpp << "                    if (priceFont) ImGui::PushFont(priceFont);\n";
                            cpp << "                    const char* price = \"" << EscapeString(item.price) << "\";\n";
                            cpp << "                    ImVec2 psz = ImGui::CalcTextSize(price);\n";
                            cpp << "                    dl->AddText(ImVec2(cardX + cardW/2 - psz.x/2, cardY + hoverOffset + cardH - 48), " << ColorToU32(item.title_color) << ", price);\n";
                            cpp << "                    if (priceFont) ImGui::PopFont();\n";
                            cpp << "                }\n";
                        }
                    }  // End of old style cards
                    cpp << "            }\n";
                }
                cpp << "        }\n";
                break;
            }

            case SEC_GALLERY: {
                cpp << "        // Gallery section with grid of images\n";
                cpp << "        float contentY = secY + 64;\n";
                cpp << "        float centerX = winW / 2;\n";
                if (!sec.title.empty()) {
                    cpp << "        {\n";
                    cpp << "            ImFont* titleFont = GetFont(" << (int)sec.title_font_size << ");\n";
                    cpp << "            if (titleFont) ImGui::PushFont(titleFont);\n";
                    cpp << "            const char* title = \"" << EscapeString(sec.title) << "\";\n";
                    cpp << "            ImVec2 sz = ImGui::CalcTextSize(title);\n";
                    cpp << "            dl->AddText(ImVec2(centerX - sz.x/2, contentY), " << ColorToU32(sec.title_color) << ", title);\n";
                    cpp << "            if (titleFont) ImGui::PopFont();\n";
                    cpp << "            contentY += sz.y + 48;\n";
                    cpp << "        }\n";
                }
                if (!sec.subtitle.empty()) {
                    cpp << "        {\n";
                    cpp << "            ImFont* subFont = GetFont(" << (int)sec.subtitle_font_size << ");\n";
                    cpp << "            if (subFont) ImGui::PushFont(subFont);\n";
                    cpp << "            const char* sub = \"" << EscapeString(sec.subtitle) << "\";\n";
                    cpp << "            ImVec2 sz = ImGui::CalcTextSize(sub);\n";
                    cpp << "            dl->AddText(ImVec2(centerX - sz.x/2, contentY), " << ColorToU32(sec.subtitle_color) << ", sub);\n";
                    cpp << "            if (subFont) ImGui::PopFont();\n";
                    cpp << "            contentY += sz.y + 40;\n";
                    cpp << "        }\n";
                }

                // Render gallery images in a grid
                if (!sec.gallery_images.empty()) {
                    int columns = sec.gallery_columns > 0 ? sec.gallery_columns : 3;
                    float imgSpacing = sec.gallery_spacing;
                    float maxImgW = 400.0f; // Base image width

                    cpp << "        {\n";
                    cpp << "            int columns = " << columns << ";\n";
                    cpp << "            float imgSpacing = " << std::fixed << std::setprecision(1) << imgSpacing << "f;\n";
                    cpp << "            float maxImgW = 400.0f;\n";
                    cpp << "            float maxContentW = winW * 0.9f;\n";
                    cpp << "            float maxImgWidth = (maxContentW - (columns - 1) * imgSpacing) / columns;\n";
                    cpp << "            float imgW = (maxImgW < maxImgWidth) ? maxImgW : maxImgWidth;\n";
                    cpp << "            float imgH = imgW * 1.0f;  // Square images\n";
                    cpp << "            float totalW = columns * imgW + (columns - 1) * imgSpacing;\n";
                    cpp << "            float startX = (winW - totalW) / 2;\n";

                    for (size_t i = 0; i < sec.gallery_images.size(); i++) {
                        const auto& galleryImg = sec.gallery_images[i];
                        if (galleryImg.empty()) continue;

                        // Check if this image has a texture variable name
                        auto it = imageVarNames.find(galleryImg);
                        if (it != imageVarNames.end()) {
                            cpp << "            // Gallery image " << i << "\n";
                            cpp << "            {\n";
                            cpp << "                int row = " << i << " / columns;\n";
                            cpp << "                int col = " << i << " % columns;\n";
                            cpp << "                float imgX = startX + col * (imgW + imgSpacing);\n";
                            cpp << "                float imgY = contentY + row * (imgH + imgSpacing);\n";
                            cpp << "                if (" << it->second << " != 0) {\n";
                            cpp << "                    dl->AddImage((ImTextureID)(intptr_t)" << it->second << ", ImVec2(imgX, imgY), ImVec2(imgX + imgW, imgY + imgH));\n";
                            cpp << "                }\n";
                            cpp << "            }\n";
                        }
                    }

                    cpp << "        }\n";
                }
                break;
            }

            case SEC_STATS: {
                cpp << "        // Modern Stats section with clean typography\n";
                cpp << "        int numStats = " << sec.items.size() << ";\n";
                cpp << "        float maxStatW = 200.0f;\n";
                cpp << "        float totalStatsW = numStats * maxStatW;\n";
                cpp << "        float startX = (winW - totalStatsW) / 2;\n";
                cpp << "        if (startX < 40) startX = 40;\n";
                for (size_t i = 0; i < sec.items.size(); i++) {
                    const auto& item = sec.items[i];
                    cpp << "        {\n";
                    cpp << "            float statX = startX + " << i << " * (winW - startX * 2) / numStats + (winW - startX * 2) / numStats / 2;\n";
                    cpp << "            // Stat number (big, bold)\n";
                    cpp << "            ImFont* numFont = GetFont(" << (int)item.title_font_size << ");\n";
                    cpp << "            if (numFont) ImGui::PushFont(numFont);\n";
                    cpp << "            const char* num = \"" << EscapeString(item.title) << "\";\n";
                    cpp << "            ImVec2 nsz = ImGui::CalcTextSize(num);\n";
                    cpp << "            dl->AddText(ImVec2(statX - nsz.x/2, secY + secH/2 - 28), " << ColorToU32(item.title_color) << ", num);\n";
                    cpp << "            if (numFont) ImGui::PopFont();\n";
                    cpp << "            // Stat label (smaller, muted)\n";
                    cpp << "            ImFont* labelFont = GetFont(" << (int)item.desc_font_size << ");\n";
                    cpp << "            if (labelFont) ImGui::PushFont(labelFont);\n";
                    cpp << "            const char* label = \"" << EscapeString(item.description) << "\";\n";
                    cpp << "            ImVec2 lsz = ImGui::CalcTextSize(label);\n";
                    cpp << "            dl->AddText(ImVec2(statX - lsz.x/2, secY + secH/2 + 12), " << ColorToU32(item.desc_color) << ", label);\n";
                    cpp << "            if (labelFont) ImGui::PopFont();\n";
                    // Add vertical separator between stats (except last)
                    if (i < sec.items.size() - 1) {
                        cpp << "            // Separator line\n";
                        cpp << "            float sepX = startX + (" << i + 1 << ") * (winW - startX * 2) / numStats;\n";
                        cpp << "            dl->AddRectFilled(ImVec2(sepX - 0.5f, secY + secH/2 - 30), ImVec2(sepX + 0.5f, secY + secH/2 + 30), IM_COL32(200, 200, 210, 60));\n";
                    }
                    cpp << "        }\n";
                }
                break;
            }

            case SEC_CONTACT: {
                // Add clipping to prevent contact form overlap during scrolling
                cpp << "        // Clip contact section to prevent overlap\n";
                cpp << "        dl->PushClipRect(ImVec2(0, secY), ImVec2(winW, secY + secH), true);\n";

                // Check if using split layout with image
                bool hasSplitImage = (sec.layout_style == 1 && !sec.section_image.empty());

                if (hasSplitImage) {
                    // SPLIT LAYOUT: Image on left, form on right
                    cpp << "        // Contact form - Split layout with image\n";
                    cpp << "        float sectionW = winW * " << (sec.section_width_percent / 100.0f) << "f;\n";
                    cpp << "        float leftPanelW = sectionW * 0.35f;\n";
                    cpp << "        float formW = sectionW * 0.4f;\n";
                    cpp << "        float leftX = (winW - sectionW) / 2 + sectionW * 0.1f;\n";
                    cpp << "        float rightX = leftX + leftPanelW + (sectionW * 0.1f);\n";
                    cpp << "        float panelH = " << sec.height * 0.6f << ";\n";
                    cpp << "        float panelY = secY + " << sec.padding_top << ";\n";

                    // Render image on left
                    auto it = imageVarNames.find(sec.section_image);
                    if (it != imageVarNames.end()) {
                        cpp << "        // Left panel - Contact image\n";
                        cpp << "        if (" << it->second << " != 0) {\n";
                        cpp << "            dl->AddImage((ImTextureID)(intptr_t)" << it->second << ", ImVec2(leftX, panelY), ImVec2(leftX + leftPanelW, panelY + panelH));\n";
                        cpp << "            dl->AddRect(ImVec2(leftX, panelY), ImVec2(leftX + leftPanelW, panelY + panelH), IM_COL32(200, 200, 200, 100), 4.0f, 0, 1.5f);\n";
                        cpp << "        }\n";
                    }

                    // Form on right
                    cpp << "        // Right panel - Contact form\n";
                    cpp << "        DrawCardWithShadow(dl, rightX - 10, panelY, formW + 20, panelH, IM_COL32(255,255,255,255), 8.0f);\n";
                    cpp << "        float formY = panelY + 30;\n";
                } else {
                    // DEFAULT CENTERED LAYOUT
                    cpp << "        // Modern Contact form with card styling\n";
                    cpp << "        float formW = 420;\n";
                    cpp << "        float formX = (winW - formW) / 2;\n";
                    cpp << "        float formY = secY + 100;\n";
                    cpp << "        float maxTextWidth = winW * 0.7f;\n";
                    cpp << "        if (maxTextWidth > 600) maxTextWidth = 600;\n";
                    if (!sec.title.empty()) {
                        cpp << "        {\n";
                        cpp << "            const char* title = \"" << EscapeString(sec.title) << "\";\n";
                        cpp << "            DrawWrappedTextEx(dl, GetFont(" << (int)sec.title_font_size << "), title, winW/2 - maxTextWidth/2, secY + 40, maxTextWidth, " << ColorToU32(sec.title_color) << ", true);\n";
                        cpp << "        }\n";
                    }
                    if (!sec.subtitle.empty()) {
                        cpp << "        {\n";
                        cpp << "            const char* sub = \"" << EscapeString(sec.subtitle) << "\";\n";
                        cpp << "            DrawWrappedTextEx(dl, GetFont(" << (int)sec.subtitle_font_size << "), sub, winW/2 - maxTextWidth/2, secY + 75, maxTextWidth, " << ColorToU32(sec.subtitle_color) << ", true);\n";
                        cpp << "        }\n";
                    }
                    cpp << "        // Form card background\n";
                    cpp << "        DrawCardWithShadow(dl, formX - 24, formY - 16, formW + 48, 290, IM_COL32(255,255,255,255), 12.0f);\n";
                }

                // Only reassign formX if using split layout
                if (hasSplitImage) {
                    cpp << "        formX = rightX;\n";
                }

                cpp << "        if (!g_MessageSent) {\n";
                cpp << "            // Input styling\n";
                cpp << "            ImGui::PushStyleVar(ImGuiStyleVar_FrameRounding, 6.0f);\n";
                cpp << "            ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(12, 10));\n";
                cpp << "            ImGui::PushStyleColor(ImGuiCol_FrameBg, ImVec4(0.96f, 0.97f, 0.98f, 1.0f));\n";
                cpp << "            ImGui::PushStyleColor(ImGuiCol_FrameBgHovered, ImVec4(0.94f, 0.95f, 0.97f, 1.0f));\n";
                cpp << "            ImGui::SetCursorPos(ImVec2(formX, formY));\n";
                cpp << "            ImGui::SetNextItemWidth(formW);\n";
                cpp << "            ImGui::InputTextWithHint(\"##name\", \"Your Name\", g_ContactName, sizeof(g_ContactName));\n";
                cpp << "            ImGui::SetCursorPos(ImVec2(formX, formY + 52));\n";
                cpp << "            ImGui::SetNextItemWidth(formW);\n";
                cpp << "            ImGui::InputTextWithHint(\"##email\", \"Your Email\", g_ContactEmail, sizeof(g_ContactEmail));\n";
                cpp << "            ImGui::SetCursorPos(ImVec2(formX, formY + 104));\n";
                cpp << "            ImGui::SetNextItemWidth(formW);\n";
                cpp << "            ImGui::InputTextMultiline(\"##msg\", g_ContactMessage, sizeof(g_ContactMessage), ImVec2(formW, 90));\n";
                cpp << "            ImGui::PopStyleColor(2);\n";
                cpp << "            ImGui::PopStyleVar(2);\n";
                cpp << "            // Submit button\n";
                if (sec.button_glass_effect) {
                    cpp << "            {\n";
                    cpp << "                float btnX = formX, btnY = formY + 210, btnW = formW, btnH = 46;\n";
                    cpp << "                DrawGlassButton(dl, \"" << EscapeString(sec.button_text) << "\", btnX, btnY, btnW, btnH, " << std::fixed << std::setprecision(2) << sec.button_glass_opacity << "f, " << ColorToU32(sec.button_glass_tint) << ", " << ColorToU32(sec.button_text_color) << ", 8.0f);\n";
                    cpp << "                ImVec2 mp = ImGui::GetMousePos();\n";
                    cpp << "                if (mp.x >= btnX && mp.x <= btnX + btnW && mp.y >= btnY && mp.y <= btnY + btnH && ImGui::IsMouseClicked(0)) {\n";
                    cpp << "                    if (strlen(g_ContactName) > 0 && strlen(g_ContactEmail) > 0) g_MessageSent = true;\n";
                    cpp << "                }\n";
                    cpp << "            }\n";
                } else {
                    cpp << "            ImGui::SetCursorPos(ImVec2(formX, formY + 210));\n";
                    cpp << "            ImGui::PushStyleVar(ImGuiStyleVar_FrameRounding, 8.0f);\n";
                    cpp << "            ImGui::PushStyleColor(ImGuiCol_Button, " << ColorToImVec4(sec.button_bg_color) << ");\n";
                    cpp << "            ImGui::PushStyleColor(ImGuiCol_ButtonHovered, ImVec4(" << sec.button_bg_color.x + 0.1f << "f, " << sec.button_bg_color.y + 0.1f << "f, " << sec.button_bg_color.z + 0.1f << "f, 1.0f));\n";
                    cpp << "            if (ImGui::Button(\"" << EscapeString(sec.button_text) << "\", ImVec2(formW, 46))) {\n";
                    cpp << "                if (strlen(g_ContactName) > 0 && strlen(g_ContactEmail) > 0) g_MessageSent = true;\n";
                    cpp << "            }\n";
                    cpp << "            ImGui::PopStyleColor(2);\n";
                    cpp << "            ImGui::PopStyleVar();\n";
                }
                cpp << "        } else {\n";
                cpp << "            // Success message\n";
                cpp << "            ImGui::SetCursorPos(ImVec2(formX, formY + 80));\n";
                cpp << "            ImGui::TextColored(ImVec4(0.2f, 0.75f, 0.4f, 1), \"Thank you! Your message has been sent.\");\n";
                cpp << "        }\n";
                cpp << "        // Remove clipping for contact section\n";
                cpp << "        dl->PopClipRect();\n";
                break;
            }

            case SEC_FOOTER: {
                cpp << "        // Modern Footer with clean layout\n";
                cpp << "        float centerX = winW / 2;\n";
                cpp << "        float maxTextWidth = winW * 0.85f;\n";
                cpp << "        if (maxTextWidth > 1000) maxTextWidth = 1000;\n";
                cpp << "        // Top border separator\n";
                cpp << "        dl->AddRectFilled(ImVec2(0, secY), ImVec2(winW, secY + 1), IM_COL32(200, 200, 205, 80));\n";
                if (!sec.title.empty()) {
                    cpp << "        {\n";
                    cpp << "            // Footer brand/title\n";
                    cpp << "            const char* title = \"" << EscapeString(sec.title) << "\";\n";
                    cpp << "            DrawWrappedTextEx(dl, GetFont(" << (int)sec.title_font_size << "), title, centerX - maxTextWidth/2, secY + 32, maxTextWidth, " << ColorToU32(sec.title_color) << ", true);\n";
                    cpp << "        }\n";
                }
                if (!sec.subtitle.empty()) {
                    cpp << "        {\n";
                    cpp << "            // Footer tagline\n";
                    cpp << "            const char* tagline = \"" << EscapeString(sec.subtitle) << "\";\n";
                    cpp << "            DrawWrappedTextEx(dl, GetFont(" << (int)sec.subtitle_font_size << "), tagline, centerX - maxTextWidth/2, secY + 70, maxTextWidth, " << ColorToU32(sec.subtitle_color) << ", true);\n";
                    cpp << "        }\n";
                }
                if (!sec.content.empty()) {
                    cpp << "        {\n";
                    cpp << "            // Copyright text at bottom\n";
                    cpp << "            const char* copy = \"" << EscapeString(sec.content) << "\";\n";
                    cpp << "            ImFont* copyFont = GetFont(" << (int)sec.content_font_size << ");\n";
                    cpp << "            if (copyFont) ImGui::PushFont(copyFont);\n";
                    cpp << "            ImVec2 sz = ImGui::CalcTextSize(copy);\n";
                    cpp << "            dl->AddText(ImVec2(centerX - sz.x/2, secY + secH - 40), " << ColorToU32(sec.content_color) << ", copy);\n";
                    cpp << "            if (copyFont) ImGui::PopFont();\n";
                    cpp << "        }\n";
                }
                break;
            }

            case SEC_IMAGE: {
                cpp << "        // Image Section - Display uploaded image\n";

                // Check if section has an image
                if (!sec.section_image.empty() && sec.section_image != "none") {
                    auto it = imageVarNames.find(sec.section_image);
                    if (it != imageVarNames.end()) {
                        cpp << "        if (" << it->second << " != 0) {\n";
                        cpp << "            // Render image filling the section\n";
                        cpp << "            dl->AddImage((ImTextureID)(intptr_t)" << it->second << ", ImVec2(0, secY), ImVec2(winW, secY + secH));\n";
                        cpp << "        } else {\n";
                        cpp << "            // Placeholder if image failed to load\n";
                        cpp << "            dl->AddRectFilled(ImVec2(0, secY), ImVec2(winW, secY + secH), IM_COL32(30, 30, 30, 255));\n";
                        cpp << "            const char* text = \"Image Loading...\";\n";
                        cpp << "            ImVec2 sz = ImGui::CalcTextSize(text);\n";
                        cpp << "            dl->AddText(ImVec2(winW/2 - sz.x/2, secY + secH/2), IM_COL32(150, 150, 150, 255), text);\n";
                        cpp << "        }\n";
                    } else {
                        cpp << "        // No image in cache\n";
                        cpp << "        dl->AddRectFilled(ImVec2(0, secY), ImVec2(winW, secY + secH), IM_COL32(30, 30, 30, 255));\n";
                    }
                } else {
                    cpp << "        // No image uploaded\n";
                    cpp << "        dl->AddRectFilled(ImVec2(0, secY), ImVec2(winW, secY + secH), IM_COL32(30, 30, 30, 255));\n";
                    cpp << "        const char* text = \"Upload Image\";\n";
                    cpp << "        ImVec2 sz = ImGui::CalcTextSize(text);\n";
                    cpp << "        dl->AddText(ImVec2(winW/2 - sz.x/2, secY + secH/2), IM_COL32(150, 150, 150, 255), text);\n";
                }
                break;
            }

            default:
                cpp << "        // Custom section\n";
                if (!sec.title.empty()) {
                    cpp << "        {\n";
                    cpp << "            const char* title = \"" << EscapeString(sec.title) << "\";\n";
                    cpp << "            ImVec2 sz = ImGui::CalcTextSize(title);\n";
                    cpp << "            dl->AddText(ImVec2(winW/2 - sz.x/2, secY + secH/2), " << ColorToU32(sec.title_color) << ", title);\n";
                    cpp << "        }\n";
                }
                break;
        }

        cpp << "        yPos += secH;\n";
        cpp << "    }\n\n";
    }

    cpp << R"(
    // Update total height for scrolling
    g_TotalHeight = yPos + g_ScrollY;

    ImGui::End();
}

// Main frame
void MainLoopStep() {
    glfwPollEvents();
    ImGui_ImplOpenGL3_NewFrame();
    ImGui_ImplGlfw_NewFrame();
    ImGui::NewFrame();

    // Update animation time for continuous card animations
    g_AnimTime += g_DeltaTime;

    // Handle scroll input
    ImGuiIO& io = ImGui::GetIO();

#ifdef __EMSCRIPTEN__
    // Get scroll delta from JavaScript
    float jsDelta = (float)EM_ASM_DOUBLE({
        if (Module.getScrollDelta) {
            return Module.getScrollDelta();
        }
        return 0;
    });
    if (jsDelta != 0) {
        g_ScrollTarget += jsDelta * 0.5f;  // Scale down for smoother scroll
    }
#endif

    // Also check ImGui mouse wheel (for non-Emscripten builds)
    if (io.MouseWheel != 0) {
        g_ScrollTarget -= io.MouseWheel * 80.0f;
    }

    // Smooth scrolling
    g_ScrollY += (g_ScrollTarget - g_ScrollY) * 0.2f;

    // Clamp scroll
    if (g_ScrollY < 0) { g_ScrollY = 0; g_ScrollTarget = 0; }
    float maxScroll = g_TotalHeight - io.DisplaySize.y;
    if (maxScroll < 0) maxScroll = 0;
    if (g_ScrollY > maxScroll) { g_ScrollY = maxScroll; g_ScrollTarget = maxScroll; }

    RenderWebsite();

    ImGui::Render();
    int display_w, display_h;
    glfwGetFramebufferSize(g_Window, &display_w, &display_h);
    glViewport(0, 0, display_w, display_h);
    glClearColor(g_ClearColor.x, g_ClearColor.y, g_ClearColor.z, g_ClearColor.w);
    glClear(GL_COLOR_BUFFER_BIT);
    ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
    glfwSwapBuffers(g_Window);
}

int main(int, char**) {
    if (!glfwInit()) {
        printf("Failed to initialize GLFW\n");
        return 1;
    }

    const char* glsl_version = "#version 300 es";
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 0);
    glfwWindowHint(GLFW_CLIENT_API, GLFW_OPENGL_ES_API);

    g_Window = glfwCreateWindow(1280, 720, ")" << EscapeString(g_ProjectName) << R"(", nullptr, nullptr);
    if (!g_Window) {
        printf("Failed to create window\n");
        glfwTerminate();
        return 1;
    }

    glfwMakeContextCurrent(g_Window);
    glfwSwapInterval(1);

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO();
    io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;

    // Load Inter font from embedded data at multiple sizes
    ImFontConfig fontConfig;
    fontConfig.FontDataOwnedByAtlas = false;  // Don't free the static data
)";

    // Generate dynamic font loading based on collected sizes
    for (int size : fontSizes) {
        cpp << "    g_FontCache[" << size << "] = io.Fonts->AddFontFromMemoryTTF((void*)inter_font_data, inter_font_size, " << size << ".0f, &fontConfig);\n";
    }
    cpp << "    g_FontDefault = g_FontCache[16];\n";

    // Set legacy font pointers based on default sizes
    cpp << "    // Legacy font pointers\n";
    cpp << "    g_FontTitle = g_FontCache.count(42) ? g_FontCache[42] : g_FontDefault;\n";
    cpp << "    g_FontSubtitle = g_FontCache.count(24) ? g_FontCache[24] : g_FontDefault;\n";
    cpp << "    g_FontBody = g_FontCache.count(16) ? g_FontCache[16] : g_FontDefault;\n";
    cpp << "    g_FontButton = g_FontCache.count(16) ? g_FontCache[16] : g_FontDefault;\n";
    cpp << "    g_FontSmall = g_FontCache.count(14) ? g_FontCache[14] : g_FontDefault;\n";

    // Generate texture loading code in main() (global declarations already generated earlier)
    if (!imagePaths.empty()) {
        cpp << "\n    // Load images\n";
        cpp << "    printf(\"Loading " << imagePaths.size() << " images...\\n\");\n";
        for (const auto& pair : imageVarNames) {
            const std::string& imgPath = pair.first;
            const std::string& varName = pair.second;

            // Extract just the filename
            size_t lastSlash = imgPath.find_last_of("/\\");
            std::string filename = (lastSlash != std::string::npos) ? imgPath.substr(lastSlash + 1) : imgPath;

            cpp << "    " << varName << " = LoadImageTexture(\"images/" << filename << "\");\n";
        }
        cpp << "\n";
    }

    cpp << R"(
    SetupImGuiStyle();

    ImGui_ImplGlfw_InitForOpenGL(g_Window, true);
    ImGui_ImplOpenGL3_Init(glsl_version);

    printf("Website Started!\n");

#ifdef __EMSCRIPTEN__
    emscripten_set_main_loop(MainLoopStep, 0, 1);
#else
    while (!glfwWindowShouldClose(g_Window)) {
        MainLoopStep();
    }
#endif

    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplGlfw_Shutdown();
    ImGui::DestroyContext();
    glfwDestroyWindow(g_Window);
    glfwTerminate();
    return 0;
}
)";

    return cpp.str();
}

// ============================================================================
// GENERATE BUILD SCRIPT
// ============================================================================
std::string GenerateBuildScript() {
    return R"(#!/bin/bash

echo "Building ImGui Website for WebAssembly..."

# Check if emsdk is available
if [ -z "$EMSDK" ]; then
    if [ -d "$HOME/emsdk" ]; then
        source $HOME/emsdk/emsdk_env.sh 2>/dev/null
    elif [ -d "/Users/imaging/emsdk" ]; then
        source /Users/imaging/emsdk/emsdk_env.sh 2>/dev/null
    else
        echo "ERROR: Emscripten SDK not found!"
        echo "Install it from: https://emscripten.org/docs/getting_started/downloads.html"
        exit 1
    fi
fi

# Cache directory for pre-compiled ImGui
CACHE_DIR="$HOME/.imgui_wasm_cache"
IMGUI_LIB="$CACHE_DIR/libimgui.a"

# Check if we need to build ImGui library (only once)
if [ ! -f "$IMGUI_LIB" ]; then
    echo "First run: Pre-compiling ImGui library (this only happens once)..."
    mkdir -p "$CACHE_DIR"

    # Compile each ImGui source to object file
    emcc -std=c++17 -O2 -c -I./imgui -I./imgui/backends imgui/imgui.cpp -o "$CACHE_DIR/imgui.o" -s USE_GLFW=3
    emcc -std=c++17 -O2 -c -I./imgui -I./imgui/backends imgui/imgui_draw.cpp -o "$CACHE_DIR/imgui_draw.o" -s USE_GLFW=3
    emcc -std=c++17 -O2 -c -I./imgui -I./imgui/backends imgui/imgui_tables.cpp -o "$CACHE_DIR/imgui_tables.o" -s USE_GLFW=3
    emcc -std=c++17 -O2 -c -I./imgui -I./imgui/backends imgui/imgui_widgets.cpp -o "$CACHE_DIR/imgui_widgets.o" -s USE_GLFW=3
    emcc -std=c++17 -O2 -c -I./imgui -I./imgui/backends imgui/imgui_demo.cpp -o "$CACHE_DIR/imgui_demo.o" -s USE_GLFW=3
    emcc -std=c++17 -O2 -c -I./imgui -I./imgui/backends imgui/backends/imgui_impl_glfw.cpp -o "$CACHE_DIR/imgui_impl_glfw.o" -s USE_GLFW=3
    emcc -std=c++17 -O2 -c -I./imgui -I./imgui/backends imgui/backends/imgui_impl_opengl3.cpp -o "$CACHE_DIR/imgui_impl_opengl3.o" -s USE_GLFW=3

    # Create static library
    emar rcs "$IMGUI_LIB" "$CACHE_DIR"/*.o
    echo "ImGui library cached! Future builds will be much faster."
fi

echo "Compiling website (using cached ImGui)..."

# Only compile main.cpp and link with cached library (FAST!)
emcc -std=c++17 -O2 \
    -I./imgui \
    -I./imgui/backends \
    main.cpp \
    "$IMGUI_LIB" \
    -s USE_GLFW=3 \
    -s USE_WEBGL2=1 \
    -s FULL_ES3=1 \
    -s WASM=1 \
    -s ALLOW_MEMORY_GROWTH=1 \
    -s NO_EXIT_RUNTIME=1 \
    -s ASYNCIFY \
    --preload-file images \
    --shell-file shell.html \
    -o index.html

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "Build successful!"
    echo "=========================================="
    echo ""
    echo "To view your website:"
    echo "1. Run: python3 -m http.server 8080"
    echo "2. Open: http://localhost:8080"
    echo ""
else
    echo "Build failed!"
    exit 1
fi
)";
}

// ============================================================================
// GENERATE SHELL HTML
// ============================================================================
std::string GenerateShellHTML() {
    std::stringstream html;
    html << "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n";
    html << "    <meta charset=\"utf-8\">\n";
    html << "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n";
    html << "    <title>" << g_ProjectName << "</title>\n";
    html << "    <style>\n";
    html << "        * { margin: 0; padding: 0; box-sizing: border-box; }\n";
    html << "        body { background: #1a1a1f; overflow: hidden; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; }\n";
    html << "        #loading { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: #1a1a1f; display: flex; flex-direction: column; justify-content: center; align-items: center; z-index: 1000; }\n";
    html << "        #loading h1 { color: #4d85ff; font-size: 2rem; margin-bottom: 20px; }\n";
    html << "        #loading .spinner { width: 50px; height: 50px; border: 4px solid #333; border-top-color: #4d85ff; border-radius: 50%; animation: spin 1s linear infinite; }\n";
    html << "        @keyframes spin { to { transform: rotate(360deg); } }\n";
    html << "        #loading p { color: #888; margin-top: 20px; }\n";
    html << "        .emscripten { position: fixed; top: 0; left: 0; }\n";
    html << "        canvas.emscripten { display: block; width: 100vw; height: 100vh; outline: none; }\n";
    html << "    </style>\n</head>\n<body>\n";
    html << "    <div id=\"loading\">\n";
    html << "        <h1>" << g_ProjectName << "</h1>\n";
    html << "        <div class=\"spinner\"></div>\n";
    html << "        <p>Loading...</p>\n";
    html << "    </div>\n";
    html << "    <canvas class=\"emscripten\" id=\"canvas\" oncontextmenu=\"event.preventDefault()\" tabindex=\"-1\"></canvas>\n";
    html << "    <script type='text/javascript'>\n";
    html << "        var Module = {\n";
    html << "            preRun: [], postRun: [],\n";
    html << "            print: function(text) { console.log(text); },\n";
    html << "            printErr: function(text) { console.error(text); },\n";
    html << "            canvas: (function() {\n";
    html << "                var canvas = document.getElementById('canvas');\n";
    html << "                canvas.addEventListener(\"webglcontextlost\", function(e) { alert('WebGL context lost. Reload the page.'); e.preventDefault(); }, false);\n";
    html << "                return canvas;\n";
    html << "            })(),\n";
    html << "            setStatus: function(text) { if (text === '') document.getElementById('loading').style.display = 'none'; },\n";
    html << "            totalDependencies: 0,\n";
    html << "            monitorRunDependencies: function(left) { this.totalDependencies = Math.max(this.totalDependencies, left); }\n";
    html << "        };\n";
    html << "        function resizeCanvas() { var c = document.getElementById('canvas'); c.width = window.innerWidth; c.height = window.innerHeight; }\n";
    html << "        window.addEventListener('resize', resizeCanvas);\n";
    html << "        resizeCanvas();\n";
    html << "        \n";
    html << "        // Ensure canvas gets focus for scroll/keyboard events\n";
    html << "        var canvas = document.getElementById('canvas');\n";
    html << "        \n";
    html << "        // Give canvas focus immediately and on any click\n";
    html << "        window.addEventListener('load', function() {\n";
    html << "            canvas.focus();\n";
    html << "        });\n";
    html << "        \n";
    html << "        canvas.addEventListener('click', function() {\n";
    html << "            canvas.focus();\n";
    html << "        });\n";
    html << "        \n";
    html << "        // Scroll handling - store scroll delta for the app to read\n";
    html << "        var scrollDelta = 0;\n";
    html << "        canvas.addEventListener('wheel', function(e) {\n";
    html << "            e.preventDefault();\n";
    html << "            e.stopPropagation();\n";
    html << "            scrollDelta = e.deltaY;\n";
    html << "        }, { passive: false });\n";
    html << "        // Expose scroll delta to Module\n";
    html << "        Module.getScrollDelta = function() { var d = scrollDelta; scrollDelta = 0; return d; };\n";
    html << "    </script>\n";
    html << "    {{{ SCRIPT }}}\n";
    html << "</body>\n</html>\n";
    return html.str();
}

// ============================================================================
// EXPORT TO IMGUI WEBASSEMBLY PROJECT
// ============================================================================
void ExportImGuiWebsite() {
    std::string folder = ChooseFolderDialog("Choose export folder");
    if (folder.empty()) return;
    if (folder.back() == '/') folder.pop_back();

    std::string webFolder = folder + "/" + g_ProjectName + "_ImGui";
    std::string imguiFolder = webFolder + "/imgui";
    std::string backendsFolder = imguiFolder + "/backends";
    mkdir(webFolder.c_str(), 0755);
    mkdir(imguiFolder.c_str(), 0755);
    mkdir(backendsFolder.c_str(), 0755);

    // Copy ImGui files
    std::vector<std::string> imguiFiles = {"imgui.cpp", "imgui.h", "imgui_demo.cpp",
        "imgui_draw.cpp", "imgui_internal.h", "imgui_tables.cpp", "imgui_widgets.cpp",
        "imconfig.h", "imstb_rectpack.h", "imstb_textedit.h", "imstb_truetype.h"};
    for (const auto& f : imguiFiles) {
        std::ifstream src("imgui/" + f, std::ios::binary);
        std::ofstream dst(imguiFolder + "/" + f, std::ios::binary);
        dst << src.rdbuf();
    }
    std::vector<std::string> backendFiles = {"imgui_impl_glfw.cpp", "imgui_impl_glfw.h",
        "imgui_impl_opengl3.cpp", "imgui_impl_opengl3.h", "imgui_impl_opengl3_loader.h"};
    for (const auto& f : backendFiles) {
        std::ifstream src("imgui/backends/" + f, std::ios::binary);
        std::ofstream dst(backendsFolder + "/" + f, std::ios::binary);
        dst << src.rdbuf();
    }

    // Write generated files
    std::ofstream(webFolder + "/main.cpp") << GenerateImGuiCPP();
    std::ofstream(webFolder + "/build_web.sh") << GenerateBuildScript();
    std::ofstream(webFolder + "/shell.html") << GenerateShellHTML();

    // Copy Inter font header
    {
        std::ifstream src("inter_font.h", std::ios::binary);
        std::ofstream dst(webFolder + "/inter_font.h", std::ios::binary);
        dst << src.rdbuf();
    }

    // Make build script executable
    chmod((webFolder + "/build_web.sh").c_str(), 0755);

    // Create README
    std::ofstream readme(webFolder + "/README.txt");
    readme << "==========================================\n";
    readme << "   " << g_ProjectName << " - ImGui Website\n";
    readme << "==========================================\n\n";
    readme << "This is an ImGui website that runs in the browser via WebAssembly.\n\n";
    readme << "TO BUILD:\n";
    readme << "1. Install Emscripten: https://emscripten.org/docs/getting_started/downloads.html\n";
    readme << "2. Run: ./build_web.sh\n";
    readme << "3. Start server: python3 -m http.server 8080\n";
    readme << "4. Open: http://localhost:8080\n\n";
    readme << "REQUIREMENTS:\n";
    readme << "- Emscripten SDK (emsdk)\n";
    readme << "- Python 3 (for local server)\n";
    readme.close();

    g_ExportPath = webFolder;
    g_ShowExportSuccess = true;
    g_ExportSuccessTimer = 3.0f;

    system(("open \"" + webFolder + "\"").c_str());
}

void PreviewImGuiWebsite() {
    // Check if we have sections to preview
    if (g_Sections.empty()) {
        printf("[Preview] ERROR: No sections to preview!\n");
        g_ShowExportSuccess = true;
        g_ExportSuccessTimer = 3.0f;
        g_ExportPath = "Error: No sections to preview! Create or load a template first.";
        return;
    }

    printf("\n========================================\n");
    printf("[Preview] Starting preview with %zu sections\n", g_Sections.size());
    printf("[Preview] Sections being previewed:\n");
    for (size_t i = 0; i < g_Sections.size(); i++) {
        printf("  %zu. %s - '%s'\n", i+1, g_Sections[i].name.c_str(), g_Sections[i].title.c_str());
    }
    printf("========================================\n\n");

    std::string basePath = "/Users/imaging/Desktop/Website-Builder-v2.0/";
    std::string tmp = "/tmp/imgui_website_preview";
    std::string imguiFolder = tmp + "/imgui";
    std::string backendsFolder = imguiFolder + "/backends";
    mkdir(tmp.c_str(), 0755);
    mkdir(imguiFolder.c_str(), 0755);
    mkdir(backendsFolder.c_str(), 0755);

    // Copy ImGui files
    std::vector<std::string> imguiFiles = {"imgui.cpp", "imgui.h", "imgui_demo.cpp",
        "imgui_draw.cpp", "imgui_internal.h", "imgui_tables.cpp", "imgui_widgets.cpp",
        "imconfig.h", "imstb_rectpack.h", "imstb_textedit.h", "imstb_truetype.h"};
    for (const auto& f : imguiFiles) {
        std::ifstream src(basePath + "imgui/" + f, std::ios::binary);
        std::ofstream dst(imguiFolder + "/" + f, std::ios::binary);
        dst << src.rdbuf();
    }
    std::vector<std::string> backendFiles = {"imgui_impl_glfw.cpp", "imgui_impl_glfw.h",
        "imgui_impl_opengl3.cpp", "imgui_impl_opengl3.h", "imgui_impl_opengl3_loader.h"};
    for (const auto& f : backendFiles) {
        std::ifstream src(basePath + "imgui/backends/" + f, std::ios::binary);
        std::ofstream dst(backendsFolder + "/" + f, std::ios::binary);
        dst << src.rdbuf();
    }

    std::ofstream(tmp + "/main.cpp") << GenerateImGuiCPP();
    std::ofstream(tmp + "/build_web.sh") << GenerateBuildScript();
    std::ofstream(tmp + "/shell.html") << GenerateShellHTML();
    chmod((tmp + "/build_web.sh").c_str(), 0755);

    // Copy Inter font header
    {
        std::ifstream src(basePath + "inter_font.h", std::ios::binary);
        std::ofstream dst(tmp + "/inter_font.h", std::ios::binary);
        dst << src.rdbuf();
    }

    // Copy stb_image.h for image loading
    {
        std::ifstream src(basePath + "stb_image.h", std::ios::binary);
        std::ofstream dst(tmp + "/stb_image.h", std::ios::binary);
        dst << src.rdbuf();
    }

    // Create images directory and copy all section images
    std::string imagesFolder = tmp + "/images";
    mkdir(imagesFolder.c_str(), 0755);

    std::set<std::string> imagesToCopy;
    printf("[Preview] Collecting images from %zu sections...\n", g_Sections.size());

    for (const auto& sec : g_Sections) {
        // Collect background image
        if (!sec.background_image.empty() && sec.background_image != "none") {
            imagesToCopy.insert(sec.background_image);
        }

        // Collect hero animation images
        for (const auto& img : sec.hero_animation_images) {
            if (!img.empty()) {
                imagesToCopy.insert(img);
            }
        }

        // Collect gallery images
        for (const auto& img : sec.gallery_images) {
            if (!img.empty()) {
                imagesToCopy.insert(img);
            }
        }

        // Collect section image
        if (!sec.section_image.empty() && sec.section_image != "none") {
            imagesToCopy.insert(sec.section_image);
        }

        // Collect logo image
        if (!sec.logo_path.empty() && sec.logo_path != "none") {
            imagesToCopy.insert(sec.logo_path);
        }
    }

    printf("[Preview] Copying %zu unique images...\n", imagesToCopy.size());
    int copiedCount = 0;
    for (const auto& imgPath : imagesToCopy) {
        // Extract filename from path
        size_t lastSlash = imgPath.find_last_of("/\\");
        std::string filename = (lastSlash != std::string::npos) ? imgPath.substr(lastSlash + 1) : imgPath;

        // Determine source path - check if imgPath is absolute
        std::string srcPath;
        if (!imgPath.empty() && imgPath[0] == '/') {
            // Absolute path - use as-is
            srcPath = imgPath;
        } else {
            // Relative path - prepend basePath
            srcPath = basePath + imgPath;
        }
        std::string dstPath = imagesFolder + "/" + filename;

        std::ifstream src(srcPath, std::ios::binary);
        if (src.good()) {
            std::ofstream dst(dstPath, std::ios::binary);
            dst << src.rdbuf();
            copiedCount++;
        } else {
            printf("[Preview] WARNING: Could not find image: %s\n", srcPath.c_str());
        }
    }
    printf("[Preview] Copied %d images to preview directory\n", copiedCount);

    // Build and serve
    printf("[Preview] Building WebAssembly...\n");
    std::string buildCmd = "cd \"" + tmp + "\" && ./build_web.sh 2>&1";
    int result = system(buildCmd.c_str());

    if (result == 0) {
        printf("[Preview] Build successful! Starting server...\n");
        // Kill any existing server on 8080
        system("lsof -ti:8080 | xargs kill -9 2>/dev/null");
        sleep(1);  // Wait for port to be freed

        // Create custom HTTP server with no-cache headers
        std::ofstream serverScript(tmp + "/server.py");
        serverScript << "#!/usr/bin/env python3\n";
        serverScript << "import http.server\n";
        serverScript << "import socketserver\n";
        serverScript << "class NoCacheHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):\n";
        serverScript << "    def end_headers(self):\n";
        serverScript << "        self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate, max-age=0')\n";
        serverScript << "        self.send_header('Pragma', 'no-cache')\n";
        serverScript << "        self.send_header('Expires', '0')\n";
        serverScript << "        super().end_headers()\n";
        serverScript << "PORT = 8080\n";
        serverScript << "with socketserver.TCPServer(('', PORT), NoCacheHTTPRequestHandler) as httpd:\n";
        serverScript << "    httpd.serve_forever()\n";
        serverScript.close();
        chmod((tmp + "/server.py").c_str(), 0755);

        // Start custom server with no-cache headers
        std::string serveCmd = "cd \"" + tmp + "\" && python3 server.py > /dev/null 2>&1 &";
        system(serveCmd.c_str());
        sleep(2);  // Wait for server to start

        // Close any existing browser tabs with localhost:8080 to clear cache
        system("osascript -e 'tell application \"Google Chrome\" to close (every tab of every window whose URL contains \"localhost:8080\")' 2>/dev/null");
        system("osascript -e 'tell application \"Safari\" to close (every tab of every window whose URL contains \"localhost:8080\")' 2>/dev/null");
        sleep(1);

        // Clear Chrome cache for localhost
        system("osascript -e 'tell application \"Google Chrome\" to tell the active tab of window 1 to execute javascript \"window.location.reload(true)\"' 2>/dev/null");

        // Open in private/incognito mode to bypass cache completely
        std::string url = "http://localhost:8080/index.html";
        system(("open -na 'Google Chrome' --args --incognito \"" + url + "\"").c_str());

        printf("\n========================================\n");
        printf("✅ Preview opened in browser!\n");
        printf("⚠️  If you see old/wrong content:\n");
        printf("   Press: Cmd+Shift+R (Mac) to force refresh\n");
        printf("========================================\n\n");

        g_ShowExportSuccess = true;
        g_ExportSuccessTimer = 3.0f;
        g_ExportPath = "Preview opened! Press Cmd+Shift+R if you see old content.";
    } else {
        printf("[Preview] ERROR: Build failed with code %d\n", result);
        g_ShowExportSuccess = true;
        g_ExportSuccessTimer = 3.0f;
        g_ExportPath = "Error: Build failed! Check console for details.";
    }
}

// ============================================================================
// PREVIEW HELPER FUNCTIONS
// ============================================================================
// Enhanced glass card for preview (configurable border and highlight)
void DrawGlassCardEnhanced(ImDrawList* dl, float x, float y, float w, float h, float opacity, ImU32 tintColor,
    float rounding, float borderWidth, ImU32 borderColor, bool showHighlight, float highlightOpacity) {
    // Outer glow/shadow for depth
    dl->AddRectFilled(ImVec2(x-1, y+6), ImVec2(x+w+1, y+h+8), IM_COL32(0,0,0,20), rounding+2);

    // Glass background with transparency
    int tintR = (tintColor >> 0) & 0xFF;
    int tintG = (tintColor >> 8) & 0xFF;
    int tintB = (tintColor >> 16) & 0xFF;
    int alpha = (int)(opacity * 255);
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x+w, y+h), IM_COL32(tintR, tintG, tintB, alpha), rounding);

    // Frosted/blur simulation - multiple translucent layers
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x+w, y+h), IM_COL32(255, 255, 255, 12), rounding);
    dl->AddRectFilled(ImVec2(x+2, y+2), ImVec2(x+w-2, y+h-2), IM_COL32(200, 200, 255, 6), rounding > 2 ? rounding-2 : 1);

    // Top highlight (glass shine) - configurable
    if (showHighlight) {
        int hlAlpha = (int)(highlightOpacity * 255 * 0.5f);
        dl->AddRectFilledMultiColor(
            ImVec2(x+3, y+3), ImVec2(x+w-3, y + h*0.4f),
            IM_COL32(255, 255, 255, hlAlpha), IM_COL32(255, 255, 255, hlAlpha),
            IM_COL32(255, 255, 255, 0), IM_COL32(255, 255, 255, 0)
        );
    }

    // Glass border - configurable
    if (borderWidth > 0) {
        dl->AddRect(ImVec2(x, y), ImVec2(x+w, y+h), borderColor, rounding, 0, borderWidth);
        // Inner border for extra depth
        int br = (borderColor >> 0) & 0xFF;
        int bg = (borderColor >> 8) & 0xFF;
        int bb = (borderColor >> 16) & 0xFF;
        int ba = ((borderColor >> 24) & 0xFF) / 2;
        dl->AddRect(ImVec2(x+1, y+1), ImVec2(x+w-1, y+h-1), IM_COL32(br, bg, bb, ba), rounding > 1 ? rounding-1 : 1, 0, borderWidth * 0.5f);
    }
}

// Forward declarations for modern card renderers (defined before main)
void DrawModernServiceCard(ImDrawList* dl, float x, float y, float w, float h,
                          const std::string& title, const std::string& subtitle,
                          const std::vector<std::string>& bullets, const std::string& icon_emoji,
                          ImVec4 icon_color, ImVec4 text_color, float anim_progress);

void DrawModernPortfolioCard(ImDrawList* dl, float x, float y, float w, float h,
                             const std::string& title, const std::string& subtitle,
                             const std::vector<std::string>& tech_tags, const std::string& badge_text,
                             GLuint thumbnail_id, ImVec4 text_color, float anim_progress);

// ============================================================================
// RENDER SECTION PREVIEW (Same as Website Builder V1)
// ============================================================================
void RenderSectionPreview(ImDrawList* dl, WebSection& sec, ImVec2 pos, float w, float yOff) {
    // Apply width and horizontal alignment (for ALL sections)
    float canvasW = w;  // Original canvas width
    float sectionW = canvasW * (sec.section_width_percent / 100.0f);
    float sectionX = pos.x;

    // Apply horizontal alignment
    if (sec.horizontal_align == 1) {  // Center
        sectionX = pos.x + (canvasW - sectionW) / 2;
    } else if (sec.horizontal_align == 2) {  // Right
        sectionX = pos.x + canvasW - sectionW;
    }
    // else: Left (default, sectionX = pos.x)

    // Use adjusted width and x position for rendering
    float x = sectionX, y = pos.y + yOff, h = sec.height * g_Zoom;
    ImVec2 mn(x, y), mx(x + sectionW, y + h);
    float cx = x + sectionW / 2;

    // Helper lambda to ensure valid font sizes
    auto ValidFontSize = [](float size) { return (size > 0.0f) ? size : 16.0f; };

    // Draw section box shadow FIRST (behind the section)
    if (sec.section_box_shadow != "none" && !sec.section_box_shadow.empty()) {
        // Simple box shadow: draw darker rectangles offset and larger
        float shadowOffset = 6.0f;
        ImVec4 shadowColor = ImVec4(0, 0, 0, 0.1f);

        // Draw 3 layers for blur effect
        for (int i = 0; i < 3; i++) {
            float alpha = shadowColor.w * (1.0f - i * 0.25f);
            ImVec4 layerColor = ImVec4(shadowColor.x, shadowColor.y, shadowColor.z, alpha);
            float spread = i * 3.0f;
            float offset = shadowOffset + i;
            dl->AddRectFilled(
                ImVec2(mn.x - spread, mn.y + offset - spread),
                ImVec2(mx.x + spread, mx.y + offset + spread),
                ImGui::ColorConvertFloat4ToU32(layerColor),
                sec.section_border_radius + spread
            );
        }
    }

    // Background with Animation Support (with border radius)
    if (sec.enable_hero_animation && !sec.hero_animation_texture_ids.empty()) {
        // Hero Animation: Update timer and cycle through images
        sec.animation_timer += ImGui::GetIO().DeltaTime;
        if (sec.animation_timer >= sec.hero_animation_speed) {
            sec.animation_timer = 0.0f;
            sec.current_animation_frame++;
            if (sec.current_animation_frame >= (int)sec.hero_animation_texture_ids.size()) {
                sec.current_animation_frame = 0;
            }
        }

        // Render current animation frame with background-size: cover
        GLuint animTexId = sec.hero_animation_texture_ids[sec.current_animation_frame];

        // Parse background-position
        float bgPosX = 0.5f, bgPosY = 0.5f;
        ParseBackgroundPosition(sec.background_position, bgPosX, bgPosY);

        // Get texture dimensions
        GLint texW = 0, texH = 0;
        GLuint oldTex;
        glGetIntegerv(GL_TEXTURE_BINDING_2D, (GLint*)&oldTex);
        glBindTexture(GL_TEXTURE_2D, animTexId);
        glGetTexLevelParameteriv(GL_TEXTURE_2D, 0, GL_TEXTURE_WIDTH, &texW);
        glGetTexLevelParameteriv(GL_TEXTURE_2D, 0, GL_TEXTURE_HEIGHT, &texH);
        glBindTexture(GL_TEXTURE_2D, oldTex);

        // Calculate UV for cover
        ImVec2 uv0, uv1;
        if (texW > 0 && texH > 0) {
            CalculateCoverUV(sectionW, h, (float)texW, (float)texH, bgPosX, bgPosY, uv0, uv1);
        } else {
            uv0 = ImVec2(0, 0);
            uv1 = ImVec2(1, 1);
        }

        dl->AddImageRounded((ImTextureID)(intptr_t)animTexId, mn, mx, uv0, uv1,
                           IM_COL32(255,255,255,255), sec.section_border_radius);
        // Only draw overlay if opacity > 0
        if (sec.bg_overlay_opacity > 0.01f) {
            dl->AddRectFilled(mn, mx, ImGui::ColorConvertFloat4ToU32(ImVec4(0, 0, 0, sec.bg_overlay_opacity)), sec.section_border_radius);
        }
    } else if (sec.use_bg_image && sec.bg_texture_id) {
        // Static background image with background-size: cover support
        // Parse background-position for proper alignment
        float bgPosX = 0.5f, bgPosY = 0.5f;  // Default: center
        ParseBackgroundPosition(sec.background_position, bgPosX, bgPosY);

        // Get texture dimensions to calculate proper UV coordinates
        GLint texW = 0, texH = 0;
        GLuint oldTex;
        glGetIntegerv(GL_TEXTURE_BINDING_2D, (GLint*)&oldTex);
        glBindTexture(GL_TEXTURE_2D, sec.bg_texture_id);
        glGetTexLevelParameteriv(GL_TEXTURE_2D, 0, GL_TEXTURE_WIDTH, &texW);
        glGetTexLevelParameteriv(GL_TEXTURE_2D, 0, GL_TEXTURE_HEIGHT, &texH);
        glBindTexture(GL_TEXTURE_2D, oldTex);

        // Calculate UV coordinates for background-size: cover
        ImVec2 uv0, uv1;
        float containerW = sectionW;
        float containerH = h;
        if (texW > 0 && texH > 0) {
            CalculateCoverUV(containerW, containerH, (float)texW, (float)texH, bgPosX, bgPosY, uv0, uv1);
        } else {
            // Fallback if texture dimensions unavailable
            uv0 = ImVec2(0, 0);
            uv1 = ImVec2(1, 1);
        }

        // Render with calculated UV coordinates (background-size: cover effect)
        dl->AddImageRounded((ImTextureID)(intptr_t)sec.bg_texture_id, mn, mx, uv0, uv1,
                           IM_COL32(255,255,255,255), sec.section_border_radius);
        // Only draw overlay if opacity > 0
        if (sec.bg_overlay_opacity > 0.01f) {
            dl->AddRectFilled(mn, mx, ImGui::ColorConvertFloat4ToU32(ImVec4(0, 0, 0, sec.bg_overlay_opacity)), sec.section_border_radius);
        }
    } else {
        // Check for CSS gradient first
        if (sec.has_gradient && sec.gradient_colors.size() >= 2) {
            // Render CSS gradient background
            ImVec4 color1 = sec.gradient_colors[0];
            ImVec4 color2 = sec.gradient_colors[sec.gradient_colors.size() - 1];

            // Apply opacity
            color1.w *= sec.section_opacity;
            color2.w *= sec.section_opacity;

            // For now, support simple linear gradients (top-to-bottom or left-to-right)
            // Direction based on CSS gradient angle (simplified)
            if (sec.gradient_is_radial) {
                // Radial gradient: draw from center outward (simplified as vertical gradient)
                ImU32 col1 = ImGui::ColorConvertFloat4ToU32(color1);
                ImU32 col2 = ImGui::ColorConvertFloat4ToU32(color2);
                dl->AddRectFilledMultiColor(mn, mx, col1, col1, col2, col2);
            } else {
                // Linear gradient
                // Most common: top-to-bottom or left-to-right
                ImU32 col1 = ImGui::ColorConvertFloat4ToU32(color1);
                ImU32 col2 = ImGui::ColorConvertFloat4ToU32(color2);

                // Determine direction from gradient string
                if (sec.background_image_css.find("to right") != std::string::npos) {
                    // Left to right gradient
                    dl->AddRectFilledMultiColor(mn, mx, col1, col2, col2, col1);
                } else if (sec.background_image_css.find("to left") != std::string::npos) {
                    // Right to left gradient
                    dl->AddRectFilledMultiColor(mn, mx, col2, col1, col1, col2);
                } else if (sec.background_image_css.find("to top") != std::string::npos) {
                    // Bottom to top gradient
                    dl->AddRectFilledMultiColor(mn, mx, col2, col2, col1, col1);
                } else {
                    // Default: top to bottom gradient
                    dl->AddRectFilledMultiColor(mn, mx, col1, col1, col2, col2);
                }
            }

            // If section has border radius, we need to clip (simplified - just note it)
            // Full implementation would need stencil buffer or custom shader
        } else {
            // Solid color background (with border radius and opacity)
            ImVec4 bgColor = sec.bg_color;
            bgColor.w *= sec.section_opacity;  // Apply section opacity
            dl->AddRectFilled(mn, mx, ImGui::ColorConvertFloat4ToU32(bgColor), sec.section_border_radius);
        }
    }

    // === RENDER SECTION BORDER (from CSS) ===
    if (sec.section_border != "none" && !sec.section_border.empty()) {
        // Parse border: "1px solid rgb(200,200,200)" or similar
        // For now, simple implementation: just draw a border
        ImU32 borderColor = IM_COL32(200, 200, 200, 255); // Default gray
        float borderWidth = 1.0f;

        // Try to parse border width
        if (sec.section_border.find("2px") != std::string::npos) borderWidth = 2.0f;
        else if (sec.section_border.find("3px") != std::string::npos) borderWidth = 3.0f;

        dl->AddRect(mn, mx, borderColor, sec.section_border_radius, 0, borderWidth);
    }

    if (sec.selected) dl->AddRect(mn, mx, ImGui::ColorConvertFloat4ToU32(ImVec4(0.3f, 0.6f, 1.0f, 1.0f)), 0, 0, 3.0f);

    dl->AddRectFilled(ImVec2(x + 5, y + 5), ImVec2(x + 80, y + 22), ImGui::ColorConvertFloat4ToU32(ImVec4(0, 0, 0, 0.4f)), 3.0f);
    dl->AddText(ImVec2(x + 10, y + 6), IM_COL32(255, 255, 255, 200), sec.name.c_str());

    // Render glass panels for this section
    for (auto& gp : sec.glass_panels) {
        float gpX = x + gp.x * g_Zoom * 0.4f;
        float gpY = y + gp.y * g_Zoom * 0.4f;
        float gpW = gp.width * g_Zoom * 0.4f;
        float gpH = gp.height * g_Zoom * 0.4f;
        float gpR = gp.border_radius * g_Zoom * 0.4f;
        // Glass background
        ImU32 tintColor = ImGui::ColorConvertFloat4ToU32(gp.tint);
        int tintR = (tintColor >> 0) & 0xFF;
        int tintG = (tintColor >> 8) & 0xFF;
        int tintB = (tintColor >> 16) & 0xFF;
        int alpha = (int)(gp.opacity * 255);
        dl->AddRectFilled(ImVec2(gpX, gpY), ImVec2(gpX + gpW, gpY + gpH), IM_COL32(tintR, tintG, tintB, alpha), gpR);
        dl->AddRectFilled(ImVec2(gpX, gpY), ImVec2(gpX + gpW, gpY + gpH), IM_COL32(255, 255, 255, 15), gpR);
        // Top highlight
        dl->AddRectFilledMultiColor(ImVec2(gpX + 2, gpY + 2), ImVec2(gpX + gpW - 2, gpY + gpH * 0.35f),
            IM_COL32(255, 255, 255, 30), IM_COL32(255, 255, 255, 30),
            IM_COL32(255, 255, 255, 5), IM_COL32(255, 255, 255, 5));
        // Glass border
        dl->AddRect(ImVec2(gpX, gpY), ImVec2(gpX + gpW, gpY + gpH), IM_COL32(255, 255, 255, 40), gpR, 0, 1.0f);
        // Text
        if (!gp.text.empty()) {
            ImVec2 textSize = ImGui::CalcTextSize(gp.text.c_str());
            float textX = gpX + (gpW - textSize.x) / 2;
            float textY = gpY + (gpH - textSize.y) / 2;
            dl->AddText(ImVec2(textX, textY), ImGui::ColorConvertFloat4ToU32(gp.text_color), gp.text.c_str());
        }
        // Selection border
        if (gp.selected) {
            dl->AddRect(ImVec2(gpX - 2, gpY - 2), ImVec2(gpX + gpW + 2, gpY + gpH + 2), IM_COL32(100, 150, 255, 255), gpR + 2, 0, 2.0f);
        }
    }

    // Navbar
    if (sec.type == SEC_NAVBAR) {
        // Check for gradient on navbar
        if (sec.has_gradient && sec.gradient_colors.size() >= 2) {
            ImVec4 color1 = sec.gradient_colors[0];
            ImVec4 color2 = sec.gradient_colors[sec.gradient_colors.size() - 1];
            ImU32 col1 = ImGui::ColorConvertFloat4ToU32(color1);
            ImU32 col2 = ImGui::ColorConvertFloat4ToU32(color2);

            if (sec.background_image_css.find("to right") != std::string::npos) {
                dl->AddRectFilledMultiColor(mn, mx, col1, col2, col2, col1);
            } else {
                dl->AddRectFilledMultiColor(mn, mx, col1, col1, col2, col2);
            }
        } else {
            dl->AddRectFilled(mn, mx, ImGui::ColorConvertFloat4ToU32(sec.nav_bg_color));
        }

        // Logo + Brand/Title with font properties
        ImFont* font = ImGui::GetFont();
        float titleFS = ValidFontSize(sec.title_font_size);
        ImVec2 brandSize = font->CalcTextSizeA(titleFS, FLT_MAX, 0.0f, sec.title.c_str());

        float startX = x + 25;
        float centerY = y + h / 2;

        // Render Logo if exists
        if (sec.logo_texture_id != 0) {
            float logoH = sec.logo_size;
            float logoW = sec.logo_size; // Square aspect, can be adjusted

            if (sec.brand_text_position == 0) {
                // SIDE: Logo on left, text on right
                float logoY = centerY - logoH / 2;
                dl->AddImage((ImTextureID)(intptr_t)sec.logo_texture_id,
                    ImVec2(startX, logoY),
                    ImVec2(startX + logoW, logoY + logoH));
                startX += logoW + 15; // Move text right after logo
            } else if (sec.brand_text_position == 1) {
                // ABOVE: Text above logo
                float logoY = centerY;
                dl->AddImage((ImTextureID)(intptr_t)sec.logo_texture_id,
                    ImVec2(startX, logoY),
                    ImVec2(startX + logoW, logoY + logoH));
                centerY = logoY - brandSize.y - 8; // Move text above logo
            } else if (sec.brand_text_position == 2) {
                // BELOW: Text below logo
                float logoY = centerY - logoH - brandSize.y / 2 - 8;
                dl->AddImage((ImTextureID)(intptr_t)sec.logo_texture_id,
                    ImVec2(startX, logoY),
                    ImVec2(startX + logoW, logoY + logoH));
                centerY = logoY + logoH + 8; // Move text below logo
            }
        }

        // Boldness layers for brand text
        int titleLayers = (sec.title_font_weight >= 800.0f) ? 9 : ((sec.title_font_weight >= 500.0f) ? 4 : 1);
        float titleBoldStrength = (sec.title_font_weight >= 800.0f) ? 1.0f : ((sec.title_font_weight >= 500.0f) ? 0.5f : 0.0f);

        float textY = centerY - brandSize.y / 2;
        if (titleLayers > 1) {
            for (int layer = 0; layer < titleLayers; layer++) {
                float offsetX = (layer % 3) * titleBoldStrength * 0.5f;
                float offsetY = (layer / 3) * titleBoldStrength * 0.5f;
                dl->AddText(font, titleFS, ImVec2(startX + offsetX, textY + offsetY), ImGui::ColorConvertFloat4ToU32(sec.title_color), sec.title.c_str());
            }
        } else {
            dl->AddText(font, titleFS, ImVec2(startX, textY), ImGui::ColorConvertFloat4ToU32(sec.title_color), sec.title.c_str());
        }

        // Navigation items with individual font properties
        float nx = x + sectionW - 30;
        for (int i = (int)sec.nav_items.size() - 1; i >= 0; i--) {
            float itemFS = ValidFontSize(sec.nav_items[i].font_size);
            ImVec2 itemSize = font->CalcTextSizeA(itemFS, FLT_MAX, 0.0f, sec.nav_items[i].label.c_str());
            nx -= itemSize.x + 30;

            int itemLayers = (sec.nav_items[i].font_weight >= 800.0f) ? 9 : ((sec.nav_items[i].font_weight >= 500.0f) ? 4 : 1);
            float itemBoldStrength = (sec.nav_items[i].font_weight >= 800.0f) ? 1.0f : ((sec.nav_items[i].font_weight >= 500.0f) ? 0.5f : 0.0f);

            if (itemLayers > 1) {
                for (int layer = 0; layer < itemLayers; layer++) {
                    float offsetX = (layer % 3) * itemBoldStrength * 0.5f;
                    float offsetY = (layer / 3) * itemBoldStrength * 0.5f;
                    dl->AddText(font, itemFS, ImVec2(nx + offsetX, y + h / 2 - itemSize.y / 2 + offsetY), ImGui::ColorConvertFloat4ToU32(sec.nav_items[i].text_color), sec.nav_items[i].label.c_str());
                }
            } else {
                dl->AddText(font, itemFS, ImVec2(nx, y + h / 2 - itemSize.y / 2), ImGui::ColorConvertFloat4ToU32(sec.nav_items[i].text_color), sec.nav_items[i].label.c_str());
            }
        }
        return;
    }

    // Hero/CTA
    if (sec.type == SEC_HERO || sec.type == SEC_CTA) {
        // === RENDER SECTION IMAGE FIRST (if exists) ===
        float imageEndY = y + sec.padding_top;
        if (sec.img_texture_id != 0) {
            // Render image (debug logging removed to prevent spam)

            float imageW = sectionW * 0.8f;  // 80% of section width
            float imageH = h * 0.5f;         // 50% of section height
            float imageX = x + (sectionW - imageW) / 2;
            float imageY = y + sec.padding_top;

            // Render image
            dl->AddImage((ImTextureID)(intptr_t)sec.img_texture_id,
                         ImVec2(imageX, imageY),
                         ImVec2(imageX + imageW, imageY + imageH));

            // Add border around image
            dl->AddRect(ImVec2(imageX, imageY),
                       ImVec2(imageX + imageW, imageY + imageH),
                       IM_COL32(255, 255, 255, 60), 4.0f, 0, 1.5f);

            imageEndY = imageY + imageH + 30;  // Space after image
        }

        // Use 4-sided padding for proper spacing
        float contentY = imageEndY;
        float textMaxWidth = sectionW - sec.padding_left - sec.padding_right;
        float textStartX = x + sec.padding_left;
        bool centerText = (sec.text_align == 1);

        // Parse line-height and letter-spacing from CSS
        float titleLineHeight = ParseLineHeight(sec.section_line_height, sec.title_font_size);
        float subtitleLineHeight = ParseLineHeight(sec.section_line_height, sec.subtitle_font_size);
        float letterSpacing = ParseLetterSpacing(sec.section_letter_spacing, sec.title_font_size);

        // Apply flexbox justify-content for vertical alignment
        if (sec.justify_content == "center") {
            // Center content vertically - calculate total height and offset
            float totalContentHeight = 0;
            if (!sec.title.empty()) {
                ImFont* font = ImGui::GetFont();
                ImVec2 titleSize = font->CalcTextSizeA(sec.title_font_size, FLT_MAX, textMaxWidth, sec.title.c_str());
                totalContentHeight += titleSize.y * titleLineHeight + 10;
            }
            if (!sec.subtitle.empty()) {
                ImFont* font = ImGui::GetFont();
                ImVec2 subtitleSize = font->CalcTextSizeA(sec.subtitle_font_size, FLT_MAX, textMaxWidth, sec.subtitle.c_str());
                totalContentHeight += subtitleSize.y * subtitleLineHeight + 20;
            }
            if (!sec.button_text.empty()) {
                totalContentHeight += 32;  // Button height
            }

            // Center vertically based on available height
            float availableHeight = h - sec.padding_top - sec.padding_bottom;
            if (totalContentHeight < availableHeight) {
                contentY = y + sec.padding_top + (availableHeight - totalContentHeight) / 2;
            }
        }

        if (!sec.title.empty()) {
            float titleHeight = DrawWrappedText(dl, sec.title, textStartX, contentY, textMaxWidth, ImGui::ColorConvertFloat4ToU32(sec.title_color), centerText, sec.title_font_size, sec.title_font_weight, titleLineHeight, letterSpacing);
            contentY += titleHeight + 10;
        }
        if (!sec.subtitle.empty()) {
            float subHeight = DrawWrappedText(dl, sec.subtitle, textStartX, contentY, textMaxWidth, ImGui::ColorConvertFloat4ToU32(sec.subtitle_color), centerText, sec.subtitle_font_size, sec.subtitle_font_weight, subtitleLineHeight, letterSpacing);
            contentY += subHeight + 20;
        }
        if (!sec.button_text.empty()) {
            // Calculate button size with font
            ImFont* font = ImGui::GetFont();
            ImVec2 btnSize = font->CalcTextSizeA(ValidFontSize(sec.button_font_size), FLT_MAX, 0.0f, sec.button_text.c_str());

            float btnW = btnSize.x + 50, btnH = 32;
            float btnX = centerText ? (x + w/2 - btnW/2) : textStartX;

            // Draw button box shadow (if not "none")
            if (sec.button_box_shadow != "none" && !sec.button_box_shadow.empty()) {
                // Simple box shadow: draw a darker rectangle offset below the button
                float shadowOffset = 4.0f;
                float shadowBlur = 8.0f;
                ImVec4 shadowColor = ImVec4(0, 0, 0, 0.15f);

                // Draw multiple shadow layers for blur effect
                for (int i = 0; i < 3; i++) {
                    float alpha = shadowColor.w * (1.0f - i * 0.3f);
                    ImVec4 layerColor = ImVec4(shadowColor.x, shadowColor.y, shadowColor.z, alpha);
                    float offset = shadowOffset + i * 2.0f;
                    dl->AddRectFilled(
                        ImVec2(btnX - i, contentY + offset - i),
                        ImVec2(btnX + btnW + i, contentY + btnH + offset + i),
                        ImGui::ColorConvertFloat4ToU32(layerColor),
                        sec.button_border_radius + i
                    );
                }
            }

            // Draw button with border radius from CSS
            dl->AddRectFilled(ImVec2(btnX, contentY), ImVec2(btnX + btnW, contentY + btnH), ImGui::ColorConvertFloat4ToU32(sec.button_bg_color), sec.button_border_radius);

            // Draw button border if specified
            if (sec.button_border_width > 0) {
                dl->AddRect(ImVec2(btnX, contentY), ImVec2(btnX + btnW, contentY + btnH),
                           ImGui::ColorConvertFloat4ToU32(sec.button_border_color),
                           sec.button_border_radius, 0, sec.button_border_width);
            }

            // Draw button text with font size and weight
            int btnLayers = (sec.button_font_weight >= 800.0f) ? 9 : ((sec.button_font_weight >= 500.0f) ? 4 : 1);
            float btnBoldStrength = (sec.button_font_weight >= 800.0f) ? 1.0f : ((sec.button_font_weight >= 500.0f) ? 0.5f : 0.0f);

            if (btnLayers > 1) {
                for (int layer = 0; layer < btnLayers; layer++) {
                    float offsetX = (layer % 3) * btnBoldStrength * 0.5f;
                    float offsetY = (layer / 3) * btnBoldStrength * 0.5f;
                    dl->AddText(font, ValidFontSize(sec.button_font_size), ImVec2(btnX + 25 + offsetX, contentY + 8 + offsetY), ImGui::ColorConvertFloat4ToU32(sec.button_text_color), sec.button_text.c_str());
                }
            } else {
                dl->AddText(font, ValidFontSize(sec.button_font_size), ImVec2(btnX + 25, contentY + 8), ImGui::ColorConvertFloat4ToU32(sec.button_text_color), sec.button_text.c_str());
            }
        }
        return;
    }

    // Cards sections (also render if section has image but no cards - for imported templates)
    if ((sec.type == SEC_CARDS || sec.type == SEC_SERVICES || sec.type == SEC_FEATURES ||
         sec.type == SEC_TEAM || sec.type == SEC_PRICING || sec.type == SEC_TESTIMONIALS || sec.type == SEC_GALLERY) && (!sec.items.empty() || sec.img_texture_id != 0)) {
        float titleY = y + 40;
        if (!sec.title.empty()) {
            ImFont* font = ImGui::GetFont();
            ImVec2 titleSize = font->CalcTextSizeA(ValidFontSize(sec.title_font_size), FLT_MAX, 0.0f, sec.title.c_str());

            int titleLayers = (sec.title_font_weight >= 800.0f) ? 9 : ((sec.title_font_weight >= 500.0f) ? 4 : 1);
            float titleBoldStrength = (sec.title_font_weight >= 800.0f) ? 1.0f : ((sec.title_font_weight >= 500.0f) ? 0.5f : 0.0f);

            if (titleLayers > 1) {
                for (int layer = 0; layer < titleLayers; layer++) {
                    float offsetX = (layer % 3) * titleBoldStrength * 0.5f;
                    float offsetY = (layer / 3) * titleBoldStrength * 0.5f;
                    dl->AddText(font, ValidFontSize(sec.title_font_size), ImVec2(cx - titleSize.x / 2 + offsetX, titleY + offsetY), ImGui::ColorConvertFloat4ToU32(sec.title_color), sec.title.c_str());
                }
            } else {
                dl->AddText(font, ValidFontSize(sec.title_font_size), ImVec2(cx - titleSize.x / 2, titleY), ImGui::ColorConvertFloat4ToU32(sec.title_color), sec.title.c_str());
            }
        }

        // Show section image if it exists (for imported templates with images)
        float imageY = y + 40;
        if (sec.img_texture_id != 0) {
            float imageH = h * 0.4f;  // Use 40% of section height for image
            float imageW = sectionW * 0.9f;  // Use 90% of section width
            float imageX = x + (sectionW - imageW) / 2;
            imageY = y + 50;

            // Render image
            dl->AddImage((ImTextureID)(intptr_t)sec.img_texture_id,
                         ImVec2(imageX, imageY),
                         ImVec2(imageX + imageW, imageY + imageH));

            // Add subtle border around image
            dl->AddRect(ImVec2(imageX, imageY), ImVec2(imageX + imageW, imageY + imageH),
                       IM_COL32(255, 255, 255, 40), 4.0f, 0, 1.0f);

            imageY += imageH + 30;  // Update Y position for title/cards below image
        }

        // Only render cards if there are items
        if (!sec.items.empty()) {
            int cardsPerRow = std::max(1, std::min(sec.cards_per_row, 6));
            int showCards = std::min((int)sec.items.size(), cardsPerRow * 2);

            // Use fixed card dimensions from section settings (properly scaled for preview)
            float previewScale = 0.35f;  // Fixed scale for consistent preview
            float cardW = sec.card_width * previewScale;
            float cardH = sec.card_height * previewScale;
            // Use flexbox gap if specified, otherwise use card_spacing
            float cardSpacing = (sec.gap > 0) ? (sec.gap * previewScale) : (sec.card_spacing * previewScale);

            // Make sure cards fit within available space (use 4-sided padding)
            float availableWidth = sectionW - sec.padding_left - sec.padding_right;
            float totalGridWidth = cardsPerRow * cardW + (cardsPerRow - 1) * cardSpacing;

            // If cards don't fit, scale them down
            if (totalGridWidth > availableWidth) {
                float scaleDown = availableWidth / totalGridWidth;
                cardW *= scaleDown;
                cardH *= scaleDown;
                cardSpacing *= scaleDown;
                totalGridWidth = availableWidth;
            }

            // Use padding_left for left alignment or center if needed
            float startX = x + sec.padding_left + (availableWidth - totalGridWidth) / 2;
            // Position cards below image if image exists, otherwise use padding_top
            float cardY = (sec.img_texture_id != 0) ? imageY : (y + sec.padding_top + sec.heading_to_cards_spacing);

        // Special rendering for Gallery - show image boxes with strong borders
        if (sec.type == SEC_GALLERY) {
            // Render 4 image placeholders (or use items)
            int numImages = std::max(4, (int)sec.items.size());
            for (int i = 0; i < std::min(numImages, showCards); i++) {
                int row = i / cardsPerRow;
                int col = i % cardsPerRow;
                float cardX = startX + col * (cardW + cardSpacing);
                float thisCardY = cardY + row * (cardH + cardSpacing);
                if (thisCardY + cardH > y + h - 10) continue;

                // Check if we have uploaded gallery image
                bool hasGalleryImage = (i < (int)sec.gallery_texture_ids.size() && sec.gallery_texture_ids[i] != 0);

                if (hasGalleryImage) {
                    // Render uploaded image
                    dl->AddImage((ImTextureID)(intptr_t)sec.gallery_texture_ids[i],
                                ImVec2(cardX, thisCardY),
                                ImVec2(cardX + cardW, thisCardY + cardH));
                } else {
                    // Render placeholder box
                    dl->AddRectFilled(ImVec2(cardX, thisCardY), ImVec2(cardX + cardW, thisCardY + cardH),
                                     IM_COL32(240, 242, 245, 255), 4.0f);
                }

                // Add strong border for Gallery images
                dl->AddRect(ImVec2(cardX, thisCardY), ImVec2(cardX + cardW, thisCardY + cardH),
                           IM_COL32(180, 185, 195, 255), 4.0f, 0, 2.0f);

                // Add label if no image uploaded
                if (!hasGalleryImage && i < (int)sec.items.size()) {
                    ImFont* font = ImGui::GetFont();
                    const char* label = sec.items[i].title.c_str();
                    ImVec2 labelSize = font->CalcTextSizeA(14.0f, FLT_MAX, 0.0f, label);
                    float labelX = cardX + (cardW - labelSize.x) / 2;
                    float labelY = thisCardY + (cardH - labelSize.y) / 2;
                    dl->AddText(font, 14.0f, ImVec2(labelX, labelY),
                               IM_COL32(120, 130, 140, 255), label);
                }
            }
        } else {
            // Regular card rendering for non-Gallery sections
            // === USE LAYOUT ENGINE FOR PROPER CSS POSITIONING ===
            std::vector<LayoutRect> cardBoxes;

            // Check if section uses Flexbox or Grid
            if (sec.display == "flex") {
                // === FLEXBOX LAYOUT ===
                printf("🎨 Using FLEXBOX: justify=%s, align=%s, gap=%.0f\n",
                       sec.justify_content.c_str(), sec.align_items.c_str(), sec.gap);

                FlexboxLayout flexProps;
                flexProps.flex_direction = sec.flex_direction.empty() ? "row" : sec.flex_direction;
                flexProps.justify_content = sec.justify_content.empty() ? "flex-start" : sec.justify_content;
                flexProps.align_items = sec.align_items.empty() ? "flex-start" : sec.align_items;
                flexProps.gap = cardSpacing;

                // Prepare item sizes
                std::vector<float> itemWidths, itemHeights;
                for (int i = 0; i < showCards; i++) {
                    itemWidths.push_back(cardW);
                    itemHeights.push_back(cardH);
                }

                // Calculate positions using Flexbox engine
                cardBoxes = FlexboxEngine::CalculateLayout(
                    startX, cardY, availableWidth, h - cardY - y,
                    flexProps, itemWidths, itemHeights
                );
            }
            else if (sec.display == "grid") {
                // === GRID LAYOUT ===
                printf("📐 Using GRID: columns=%s, gap=%.0f\n",
                       sec.grid_template_columns.c_str(), sec.gap);

                GridLayout gridProps;
                gridProps.grid_template_columns = sec.grid_template_columns;
                gridProps.grid_template_rows = sec.grid_template_rows;
                gridProps.column_gap = cardSpacing;
                gridProps.row_gap = cardSpacing;

                // Calculate positions using Grid engine
                cardBoxes = GridEngine::CalculateLayout(
                    startX, cardY, availableWidth, h - cardY - y,
                    gridProps, showCards
                );
            }
            else {
                // === FALLBACK: Manual positioning (old way) ===
                for (int i = 0; i < showCards; i++) {
                    int row = i / cardsPerRow;
                    int col = i % cardsPerRow;
                    float cardX = startX + col * (cardW + cardSpacing);
                    float thisCardY = cardY + row * (cardH + cardSpacing);
                    cardBoxes.push_back(LayoutRect(cardX, thisCardY, cardW, cardH));
                }
            }

            // === CAROUSEL ANIMATION ===
            float carouselScrollOffset = 0.0f;
            float totalCardsWidth = 0.0f;
            bool isCarousel = (sec.animation_type == ANIM_CAROUSEL && showCards > 0);

            if (isCarousel) {
                // Calculate total width of carousel (all cards + gaps)
                for (int j = 0; j < showCards && j < (int)cardBoxes.size(); j++) {
                    totalCardsWidth += cardBoxes[j].width + cardSpacing;
                }

                // Continuous animation
                AnimationState& carouselAnim = AnimationEngine::UpdateAnimation(
                    sec.id, ANIM_CAROUSEL,
                    sec.animation_duration > 0 ? sec.animation_duration : 5.0f,
                    0.0f, true, ImGui::GetIO().DeltaTime
                );

                // Seamless scroll offset with modulo for perfect loop
                carouselScrollOffset = -fmod(carouselAnim.progress * totalCardsWidth, totalCardsWidth);

                // CRITICAL: Push clip rect ONCE for entire carousel
                // This keeps ALL cards INSIDE the section boundaries
                float sectionLeft = x + sec.padding_left;
                float sectionRight = x + w - sec.padding_right;
                float sectionTop = y + sec.padding_top;
                float sectionBottom = y + h - sec.padding_bottom;

                dl->PushClipRect(ImVec2(sectionLeft, sectionTop),
                                ImVec2(sectionRight, sectionBottom),
                                true);
            }

            // === RENDER CARDS ===
        for (int i = 0; i < showCards && i < (int)cardBoxes.size(); i++) {
            const auto& item = sec.items[i];
            float cardX = cardBoxes[i].x;
            float thisCardY = cardBoxes[i].y;
            float thisCardW = cardBoxes[i].width;
            float thisCardH = cardBoxes[i].height;
            float animOpacity = 1.0f;

            // Different handling for carousel vs other animations
            if (sec.animation_type == ANIM_CAROUSEL) {
                // CAROUSEL: Render at wrapped positions for seamless loop
                float sectionLeft = x + sec.padding_left;
                float sectionRight = x + w - sec.padding_right;

                // Each card can appear at multiple positions (wrapping)
                for (int wrapOffset = -1; wrapOffset <= 1; wrapOffset++) {
                    float cardX = cardBoxes[i].x + carouselScrollOffset + (wrapOffset * totalCardsWidth);

                    // Skip if not visible
                    if (cardX + thisCardW < sectionLeft || cardX > sectionRight) continue;

                    // RENDER THIS CARD (carousel visible copy)
                    if (item.card_style == 1) {
                        DrawModernServiceCard(dl, cardX, thisCardY, thisCardW, thisCardH,
                                             item.title, item.description, item.bullet_points,
                                             item.icon_emoji, item.icon_color, item.title_color,
                                             item.anim_progress);
                    } else if (item.card_style == 2) {
                        DrawModernPortfolioCard(dl, cardX, thisCardY, thisCardW, thisCardH,
                                               item.title, item.description, item.tech_tags,
                                               item.category_badge, item.thumbnail_texture_id,
                                               item.title_color, item.anim_progress);
                    } else {
                        // Classic card rendering
                        ImVec4 cardBgColor = item.bg_color;
                        dl->AddRectFilled(ImVec2(cardX, thisCardY),
                                        ImVec2(cardX + thisCardW, thisCardY + thisCardH),
                                        ImGui::ColorConvertFloat4ToU32(cardBgColor), 8.0f);

                        // Card content
                        float contentX = cardX + sec.card_padding;
                        float contentY = thisCardY + sec.card_padding;
                        float contentW = thisCardW - 2 * sec.card_padding;

                        if (!item.icon_emoji.empty()) {
                            dl->AddText(ImGui::GetFont(), 32,
                                      ImVec2(contentX, contentY),
                                      IM_COL32(255, 255, 255, 255),
                                      item.icon_emoji.c_str());
                            contentY += 45;
                        }

                        ImVec4 titleCol = item.title_color;
                        dl->AddText(ImGui::GetFont(), 20,
                                  ImVec2(contentX, contentY),
                                  ImGui::ColorConvertFloat4ToU32(titleCol),
                                  item.title.c_str());
                        contentY += 28;

                        if (!item.description.empty()) {
                            ImVec4 descCol = item.desc_color;
                            dl->AddText(ImGui::GetFont(), 14,
                                      ImVec2(contentX, contentY),
                                      ImGui::ColorConvertFloat4ToU32(descCol),
                                      item.description.c_str());
                        }
                    }
                }

                // Continue to next card (carousel rendering done)
                continue;
            }
            else if (sec.animation_type != ANIM_NONE) {
                // STAGGERED ANIMATION (original behavior for other types)
                // Calculate stagger delay for smooth continuous animation
                // Each card starts after previous card (based on card index)
                float staggerDelay = i * sec.card_stagger_delay;  // User-configurable stagger

                // For continuous loop: use modulo to cycle smoothly
                float totalCycleTime = sec.animation_duration + (showCards * sec.card_stagger_delay);

                // Update animation for this card (always repeat for continuous effect)
                AnimationState& anim = AnimationEngine::UpdateAnimation(
                    sec.id * 1000 + i,           // Unique ID per card
                    sec.animation_type,
                    sec.animation_duration,      // User's custom duration
                    staggerDelay,                // Staggered start
                    true,                        // Always repeat for continuous
                    ImGui::GetIO().DeltaTime
                );

                // Apply animation transform
                LayoutRect animatedBox(cardX, thisCardY, thisCardW, thisCardH);
                animatedBox = AnimationEngine::ApplyAnimationTransform(animatedBox, anim);
                cardX = animatedBox.x;
                thisCardY = animatedBox.y;
                thisCardW = animatedBox.width;
                thisCardH = animatedBox.height;

                // Get opacity for fade effects
                animOpacity = anim.opacity;
            }

            if (thisCardY + thisCardH > y + h - 10) continue;

            // Check card style and use appropriate renderer
            if (item.card_style == 1) {
                // Modern service card (Screenshot 1 style)
                DrawModernServiceCard(dl, cardX, thisCardY, thisCardW, thisCardH,
                                     item.title, item.description,
                                     item.bullet_points, item.icon_emoji,
                                     item.icon_color, item.title_color,
                                     item.anim_progress);
            } else if (item.card_style == 2) {
                // Modern portfolio card (Screenshot 2 style)
                DrawModernPortfolioCard(dl, cardX, thisCardY, thisCardW, thisCardH,
                                       item.title, item.description,
                                       item.tech_tags, item.category_badge,
                                       item.thumbnail_texture_id, item.title_color,
                                       item.anim_progress);
            } else {
                // Old/classic card style (style 0 or default)
                if (item.glass_effect) {
                    // Use enhanced glass card effect
                    ImU32 tintCol = ImGui::ColorConvertFloat4ToU32(item.glass_tint);
                    ImU32 borderCol = ImGui::ColorConvertFloat4ToU32(item.glass_border_color);
                    DrawGlassCardEnhanced(dl, cardX, thisCardY, thisCardW, thisCardH,
                        item.glass_opacity, tintCol, item.glass_border_radius,
                        item.glass_border_width, borderCol, item.glass_highlight, item.glass_highlight_opacity);
                } else {
                    // Apply animation opacity to card background
                    ImVec4 cardBgColor = item.bg_color;
                    cardBgColor.w *= animOpacity;  // Apply fade animation

                    dl->AddRectFilled(ImVec2(cardX, thisCardY), ImVec2(cardX + thisCardW, thisCardY + thisCardH),
                                     ImGui::ColorConvertFloat4ToU32(cardBgColor), 8.0f);

                    // Border with animation opacity
                    ImU32 borderColor = IM_COL32(0, 0, 0, (int)(30 * animOpacity));
                    dl->AddRect(ImVec2(cardX, thisCardY), ImVec2(cardX + thisCardW, thisCardY + thisCardH),
                               borderColor, 8.0f);
                }

                // Clip text to card bounds to prevent overflow
                dl->PushClipRect(ImVec2(cardX, thisCardY), ImVec2(cardX + thisCardW, thisCardY + thisCardH), true);

                float textPadding = 12;  // Increased from 8 to 12 for better spacing
                float textMaxWidth = thisCardW - textPadding * 2;
                float contentStartY = thisCardY + textPadding;
                float availableHeight = thisCardH - textPadding * 2;

                if (!item.title.empty()) {
                    float titleHeight = DrawWrappedText(dl, item.title, cardX + textPadding, contentStartY, textMaxWidth, ImGui::ColorConvertFloat4ToU32(item.title_color), true, item.title_font_size, item.title_font_weight);
                    contentStartY += titleHeight + 6;  // Increased spacing between title and description
                    availableHeight -= (titleHeight + 6);
                }
                if (!item.description.empty() && availableHeight > 20) {
                    // Only draw description if there's enough space left
                    DrawWrappedText(dl, item.description, cardX + textPadding, contentStartY, textMaxWidth, ImGui::ColorConvertFloat4ToU32(item.desc_color), true, item.desc_font_size, item.desc_font_weight);
                }

                dl->PopClipRect();  // Remove clipping
            }
        }

        // Pop carousel clipping if it was active
        if (isCarousel) {
            dl->PopClipRect();
        }

        }  // End of else (non-Gallery sections)
        }  // End of if (!sec.items.empty())

        // If no cards but has paragraphs, render them below title
        if (sec.items.empty() && !sec.paragraphs.empty()) {
            float paraY = (sec.img_texture_id != 0) ? imageY : (y + sec.padding_top + 80);
            float paraMaxWidth = sectionW - sec.padding_left - sec.padding_right;
            float paraX = x + sec.padding_left;

            for (const auto& para : sec.paragraphs) {
                if (para.text.empty()) continue;

                // Render wrapped paragraph text
                float paraHeight = DrawWrappedText(dl, para.text, paraX, paraY, paraMaxWidth,
                                                   ImGui::ColorConvertFloat4ToU32(para.color),
                                                   true, para.font_size, para.font_weight);
                paraY += paraHeight + 16;  // Add spacing between paragraphs

                // Stop if we run out of space
                if (paraY > y + h - 20) break;
            }
        }

        return;
    }

    // Stats
    if (sec.type == SEC_STATS && !sec.items.empty()) {
        int n = (int)sec.items.size();
        float sw = (w - 60) / n;
        for (int i = 0; i < n; i++) {
            float ssx = x + 30 + i * sw;
            float centerX = ssx + sw / 2;

            // Title/Number with font properties
            ImFont* font = ImGui::GetFont();
            ImVec2 numSize = font->CalcTextSizeA(ValidFontSize(sec.items[i].title_font_size), FLT_MAX, 0.0f, sec.items[i].title.c_str());

            int titleLayers = (sec.items[i].title_font_weight >= 800.0f) ? 9 : ((sec.items[i].title_font_weight >= 500.0f) ? 4 : 1);
            float titleBoldStrength = (sec.items[i].title_font_weight >= 800.0f) ? 1.0f : ((sec.items[i].title_font_weight >= 500.0f) ? 0.5f : 0.0f);

            if (titleLayers > 1) {
                for (int layer = 0; layer < titleLayers; layer++) {
                    float offsetX = (layer % 3) * titleBoldStrength * 0.5f;
                    float offsetY = (layer / 3) * titleBoldStrength * 0.5f;
                    dl->AddText(font, ValidFontSize(sec.items[i].title_font_size), ImVec2(centerX - numSize.x / 2 + offsetX, y + h / 2 - 20 + offsetY), ImGui::ColorConvertFloat4ToU32(sec.items[i].title_color), sec.items[i].title.c_str());
                }
            } else {
                dl->AddText(font, ValidFontSize(sec.items[i].title_font_size), ImVec2(centerX - numSize.x / 2, y + h / 2 - 20), ImGui::ColorConvertFloat4ToU32(sec.items[i].title_color), sec.items[i].title.c_str());
            }

            // Description/Label with font properties
            ImVec2 lblSize = font->CalcTextSizeA(ValidFontSize(sec.items[i].desc_font_size), FLT_MAX, 0.0f, sec.items[i].description.c_str());

            int descLayers = (sec.items[i].desc_font_weight >= 800.0f) ? 9 : ((sec.items[i].desc_font_weight >= 500.0f) ? 4 : 1);
            float descBoldStrength = (sec.items[i].desc_font_weight >= 800.0f) ? 1.0f : ((sec.items[i].desc_font_weight >= 500.0f) ? 0.5f : 0.0f);

            if (descLayers > 1) {
                for (int layer = 0; layer < descLayers; layer++) {
                    float offsetX = (layer % 3) * descBoldStrength * 0.5f;
                    float offsetY = (layer / 3) * descBoldStrength * 0.5f;
                    dl->AddText(font, ValidFontSize(sec.items[i].desc_font_size), ImVec2(centerX - lblSize.x / 2 + offsetX, y + h / 2 + 10 + offsetY), ImGui::ColorConvertFloat4ToU32(sec.items[i].desc_color), sec.items[i].description.c_str());
                }
            } else {
                dl->AddText(font, ValidFontSize(sec.items[i].desc_font_size), ImVec2(centerX - lblSize.x / 2, y + h / 2 + 10), ImGui::ColorConvertFloat4ToU32(sec.items[i].desc_color), sec.items[i].description.c_str());
            }
        }
        return;
    }

    // Contact - Different layouts based on layout_style
    if (sec.type == SEC_CONTACT) {
        // Clip contact section content to prevent overlap during scrolling
        dl->PushClipRect(mn, mx, true);

        float contentY = y + 50;

        // Render title (common to all layouts)
        if (!sec.title.empty()) {
            ImFont* font = ImGui::GetFont();
            ImVec2 titleSize = font->CalcTextSizeA(ValidFontSize(sec.title_font_size), FLT_MAX, 0.0f, sec.title.c_str());
            int titleLayers = (sec.title_font_weight >= 800.0f) ? 9 : ((sec.title_font_weight >= 500.0f) ? 4 : 1);
            float titleBoldStrength = (sec.title_font_weight >= 800.0f) ? 1.0f : ((sec.title_font_weight >= 500.0f) ? 0.5f : 0.0f);

            if (titleLayers > 1) {
                for (int layer = 0; layer < titleLayers; layer++) {
                    float offsetX = (layer % 3) * titleBoldStrength * 0.5f;
                    float offsetY = (layer / 3) * titleBoldStrength * 0.5f;
                    dl->AddText(font, ValidFontSize(sec.title_font_size), ImVec2(cx - titleSize.x / 2 + offsetX, contentY + offsetY), ImGui::ColorConvertFloat4ToU32(sec.title_color), sec.title.c_str());
                }
            } else {
                dl->AddText(font, ValidFontSize(sec.title_font_size), ImVec2(cx - titleSize.x / 2, contentY), ImGui::ColorConvertFloat4ToU32(sec.title_color), sec.title.c_str());
            }
            contentY += titleSize.y + 25;
        }

        // Render different layouts based on layout_style
        if (sec.layout_style == 0) {
            // LAYOUT 0: CENTERED CARD
            float cardW = sectionW * 0.45f;
            float cardH = 180;
            float cardX = x + (sectionW - cardW) / 2;
            float cardY = contentY + 20;

            // Card background with glass effect
            dl->AddRectFilled(ImVec2(cardX, cardY), ImVec2(cardX + cardW, cardY + cardH),
                ImGui::ColorConvertFloat4ToU32(ImVec4(0.15f, 0.15f, 0.2f, 1.0f)), 8.0f);
            dl->AddRect(ImVec2(cardX, cardY), ImVec2(cardX + cardW, cardY + cardH),
                ImGui::ColorConvertFloat4ToU32(sec.title_color), 8.0f, 0, 2.0f);

            // Form fields with labels (using user-controlled sizes)
            float fieldY = cardY + 15;
            const char* labels[] = {"Name", "Email", "Message"};
            float inputW = cardW * (sec.contact_input_width / 100.0f);
            float inputH = sec.contact_input_height;
            float fieldSpacing = sec.contact_field_spacing;
            float inputX = cardX + (cardW - inputW) / 2;

            for (int f = 0; f < 3; f++) {
                dl->AddRectFilled(ImVec2(inputX, fieldY), ImVec2(inputX + inputW, fieldY + inputH),
                    IM_COL32(255, 255, 255, 30), 4.0f);
                dl->AddRect(ImVec2(inputX, fieldY), ImVec2(inputX + inputW, fieldY + inputH),
                    ImGui::ColorConvertFloat4ToU32(sec.title_color), 4.0f, 0, 1.5f);
                // Label text
                dl->AddText(ImVec2(inputX + 10, fieldY + (inputH - 14) / 2), IM_COL32(200, 200, 200, 180), labels[f]);
                fieldY += fieldSpacing;
            }

            // Button with text (using user-controlled sizes)
            float btnW = cardW * (sec.contact_button_width / 100.0f);
            float btnH = sec.contact_button_height;
            float btnX = cardX + (cardW - btnW) / 2;
            dl->AddRectFilled(ImVec2(btnX, fieldY + 10), ImVec2(btnX + btnW, fieldY + 10 + btnH),
                ImGui::ColorConvertFloat4ToU32(sec.button_bg_color), 15.0f);
            dl->AddText(ImVec2(btnX + btnW/2 - 20, fieldY + 10 + (btnH - 14) / 2), IM_COL32(255, 255, 255, 255), "SEND");

        } else if (sec.layout_style == 1) {
            // LAYOUT 1: SPLIT SCREEN (Left image/info panel, Right form)
            float panelW = sectionW * 0.35f;
            float formW = sectionW * 0.4f;
            float leftX = x + sectionW * 0.1f;
            float rightX = x + sectionW * 0.55f;
            float panelH = 180;
            float panelY = contentY + 20;

            // LEFT PANEL - Show image if uploaded, else blue background
            if (sec.img_texture_id != 0) {
                // Render uploaded image filling the left panel
                dl->AddImage((ImTextureID)(intptr_t)sec.img_texture_id,
                    ImVec2(leftX, panelY),
                    ImVec2(leftX + panelW, panelY + panelH),
                    ImVec2(0,0), ImVec2(1,1));
                // Optional: border around image
                dl->AddRect(ImVec2(leftX, panelY), ImVec2(leftX + panelW, panelY + panelH),
                    IM_COL32(200, 200, 200, 100), 4.0f, 0, 1.5f);
            } else {
                // Default: Blue background with placeholder
                dl->AddRectFilled(ImVec2(leftX, panelY), ImVec2(leftX + panelW, panelY + panelH),
                    ImGui::ColorConvertFloat4ToU32(ImVec4(0.2f, 0.4f, 0.8f, 1.0f)), 4.0f);

                // Icon/placeholder circle in left panel
                float circleR = 25;
                float circleX = leftX + panelW / 2;
                float circleY = panelY + 40;
                dl->AddCircleFilled(ImVec2(circleX, circleY), circleR, IM_COL32(255, 255, 255, 60));

                // Info lines in left panel
                for (int ln = 0; ln < 3; ln++) {
                    float lineY = circleY + 35 + (ln * 15);
                    dl->AddRectFilled(ImVec2(leftX + 15, lineY), ImVec2(leftX + panelW - 15, lineY + 6),
                        IM_COL32(255, 255, 255, 180), 2.0f);
                }
            }

            // RIGHT PANEL (Form area) - White
            dl->AddRectFilled(ImVec2(rightX, panelY), ImVec2(rightX + formW, panelY + panelH),
                IM_COL32(255, 255, 255, 255), 4.0f);
            dl->AddRect(ImVec2(rightX, panelY), ImVec2(rightX + formW, panelY + panelH),
                IM_COL32(200, 200, 200, 255), 4.0f, 0, 1.0f);

            // Form fields in right panel with labels (using user-controlled sizes)
            float fieldY = panelY + 20;
            const char* labels2[] = {"Name", "Email", "Message"};
            float inputW2 = formW * (sec.contact_input_width / 100.0f);
            float inputH2 = sec.contact_input_height;
            float fieldSpacing2 = sec.contact_field_spacing;
            float inputX2 = rightX + (formW - inputW2) / 2;

            for (int f = 0; f < 3; f++) {
                dl->AddRectFilled(ImVec2(inputX2, fieldY), ImVec2(inputX2 + inputW2, fieldY + inputH2),
                    IM_COL32(245, 245, 245, 255), 3.0f);
                dl->AddRect(ImVec2(inputX2, fieldY), ImVec2(inputX2 + inputW2, fieldY + inputH2),
                    IM_COL32(180, 180, 180, 255), 3.0f, 0, 1.0f);
                // Label text
                dl->AddText(ImVec2(inputX2 + 8, fieldY + (inputH2 - 14) / 2), IM_COL32(120, 120, 120, 255), labels2[f]);
                fieldY += fieldSpacing2;
            }

            // Button in right panel with text (using user-controlled sizes)
            float btnW2 = formW * (sec.contact_button_width / 100.0f);
            float btnH2 = sec.contact_button_height;
            float btnX2 = rightX + (formW - btnW2) / 2;
            dl->AddRectFilled(ImVec2(btnX2, fieldY + 10), ImVec2(btnX2 + btnW2, fieldY + 10 + btnH2),
                ImGui::ColorConvertFloat4ToU32(ImVec4(0.2f, 0.4f, 0.8f, 1.0f)), 12.0f);
            dl->AddText(ImVec2(btnX2 + btnW2/2 - 20, fieldY + 10 + (btnH2 - 14) / 2), IM_COL32(255, 255, 255, 255), "SEND");

        } else if (sec.layout_style == 2) {
            // LAYOUT 2: TWO COLUMN GRID
            float boxW = sectionW * 0.55f;
            float boxH = 180;
            float boxX = x + (sectionW - boxW) / 2;
            float boxY = contentY + 20;

            // Container box
            dl->AddRectFilled(ImVec2(boxX, boxY), ImVec2(boxX + boxW, boxY + boxH),
                IM_COL32(255, 255, 255, 255), 6.0f);
            dl->AddRect(ImVec2(boxX, boxY), ImVec2(boxX + boxW, boxY + boxH),
                ImGui::ColorConvertFloat4ToU32(sec.title_color), 6.0f, 0, 2.0f);

            // Title bar inside
            float headerY = boxY + 15;
            dl->AddRectFilled(ImVec2(boxX + 20, headerY), ImVec2(boxX + boxW - 20, headerY + 8),
                ImGui::ColorConvertFloat4ToU32(sec.title_color), 2.0f);

            // Two column fields (using user-controlled sizes)
            float inputH3 = sec.contact_input_height;
            float fieldSpacing3 = sec.contact_field_spacing;
            float colW = (boxW - 50) / 2;
            float leftColX = boxX + 15;
            float rightColX = boxX + 15 + colW + 20;
            float rowY = headerY + 25;

            // Row 1: Name | Email
            const char* row1Labels[] = {"Name", "Email"};
            for (int col = 0; col < 2; col++) {
                float fieldX = (col == 0) ? leftColX : rightColX;
                dl->AddRectFilled(ImVec2(fieldX, rowY), ImVec2(fieldX + colW, rowY + inputH3),
                    IM_COL32(245, 245, 245, 255), 3.0f);
                dl->AddRect(ImVec2(fieldX, rowY), ImVec2(fieldX + colW, rowY + inputH3),
                    ImGui::ColorConvertFloat4ToU32(sec.title_color), 3.0f, 0, 1.0f);
                // Label text
                dl->AddText(ImVec2(fieldX + 8, rowY + (inputH3 - 14) / 2), IM_COL32(100, 100, 100, 255), row1Labels[col]);
            }

            // Row 2: Phone | Company
            rowY += fieldSpacing3;
            const char* row2Labels[] = {"Phone", "Company"};
            for (int col = 0; col < 2; col++) {
                float fieldX = (col == 0) ? leftColX : rightColX;
                dl->AddRectFilled(ImVec2(fieldX, rowY), ImVec2(fieldX + colW, rowY + inputH3),
                    IM_COL32(245, 245, 245, 255), 3.0f);
                dl->AddRect(ImVec2(fieldX, rowY), ImVec2(fieldX + colW, rowY + inputH3),
                    ImGui::ColorConvertFloat4ToU32(sec.title_color), 3.0f, 0, 1.0f);
                // Label text
                dl->AddText(ImVec2(fieldX + 8, rowY + (inputH3 - 14) / 2), IM_COL32(100, 100, 100, 255), row2Labels[col]);
            }

            // Full width message field
            rowY += fieldSpacing3;
            dl->AddRectFilled(ImVec2(leftColX, rowY), ImVec2(rightColX + colW, rowY + inputH3),
                IM_COL32(245, 245, 245, 255), 3.0f);
            dl->AddRect(ImVec2(leftColX, rowY), ImVec2(rightColX + colW, rowY + inputH3),
                ImGui::ColorConvertFloat4ToU32(sec.title_color), 3.0f, 0, 1.0f);
            // Message label
            dl->AddText(ImVec2(leftColX + 8, rowY + (inputH3 - 14) / 2), IM_COL32(100, 100, 100, 255), "Message");

            // Button with text (using user-controlled sizes)
            rowY += fieldSpacing3;
            float btnW3 = (rightColX + colW - leftColX) * (sec.contact_button_width / 100.0f);
            float btnH3 = sec.contact_button_height;
            float btnX3 = leftColX + ((rightColX + colW - leftColX) - btnW3) / 2;
            dl->AddRectFilled(ImVec2(btnX3, rowY), ImVec2(btnX3 + btnW3, rowY + btnH3),
                ImGui::ColorConvertFloat4ToU32(sec.button_bg_color), 15.0f);
            float btnTextX = btnX3 + btnW3/2 - 25;
            dl->AddText(ImVec2(btnTextX, rowY + (btnH3 - 14) / 2), IM_COL32(255, 255, 255, 255), "SUBMIT");

        } else if (sec.layout_style == 3) {
            // LAYOUT 3: HORIZONTAL WIDE with top decorative area
            float containerW = sectionW * 0.6f;
            float containerX = x + (sectionW - containerW) / 2;
            float containerY = contentY + 20;

            // Top decorative image area
            float topH = 50;
            dl->AddRectFilled(ImVec2(containerX, containerY), ImVec2(containerX + containerW, containerY + topH),
                ImGui::ColorConvertFloat4ToU32(ImVec4(0.3f, 0.15f, 0.4f, 1.0f)), 8.0f);

            // Circles in decorative area
            for (int c = 0; c < 4; c++) {
                float circleX = containerX + 60 + (c * (containerW - 120) / 3);
                dl->AddCircleFilled(ImVec2(circleX, containerY + topH/2), 15, IM_COL32(255, 150, 200, 80));
            }

            // Form area below
            float formY = containerY + topH + 10;
            float formH = 100;
            dl->AddRectFilled(ImVec2(containerX, formY), ImVec2(containerX + containerW, formY + formH),
                IM_COL32(255, 255, 255, 255), 8.0f);

            // Horizontal fields in rows with labels (using user-controlled sizes)
            float inputH4 = sec.contact_input_height;
            float fieldSpacing4 = sec.contact_field_spacing;
            float fieldW = (containerW - 40) / 3;
            float fieldY = formY + 15;

            const char* horizLabels[] = {"Name", "Email", "Phone", "Company", "Subject", "City"};
            for (int row = 0; row < 2; row++) {
                for (int col = 0; col < 3; col++) {
                    float fieldX = containerX + 10 + (col * (fieldW + 5));
                    dl->AddRectFilled(ImVec2(fieldX, fieldY), ImVec2(fieldX + fieldW, fieldY + inputH4),
                        IM_COL32(245, 240, 245, 255), 4.0f);
                    dl->AddRect(ImVec2(fieldX, fieldY), ImVec2(fieldX + fieldW, fieldY + inputH4),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.9f, 0.3f, 0.5f, 0.6f)), 4.0f, 0, 1.5f);
                    // Label text
                    int labelIdx = row * 3 + col;
                    dl->AddText(ImVec2(fieldX + 6, fieldY + (inputH4 - 14) / 2), IM_COL32(120, 80, 120, 255), horizLabels[labelIdx]);
                }
                fieldY += fieldSpacing4;
            }

            // Wide button with text (using user-controlled sizes)
            fieldY += 10;
            float btnW4 = (containerW - 20) * (sec.contact_button_width / 100.0f);
            float btnH4 = sec.contact_button_height;
            float btnX4 = containerX + (containerW - btnW4) / 2;
            dl->AddRectFilled(ImVec2(btnX4, fieldY), ImVec2(btnX4 + btnW4, fieldY + btnH4),
                ImGui::ColorConvertFloat4ToU32(sec.button_bg_color), 15.0f);
            float sendBtnX = btnX4 + btnW4/2 - 25;
            dl->AddText(ImVec2(sendBtnX, fieldY + (btnH4 - 14) / 2), IM_COL32(255, 255, 255, 255), "SEND");

        } else {
            // LAYOUT 4: ELEGANT DARK CARD with shadow
            float cardW = sectionW * 0.4f;
            float cardH = 160;
            float cardX = x + (sectionW - cardW) / 2;
            float cardY = contentY + 20;

            // Back shadow
            dl->AddRectFilled(ImVec2(cardX + 8, cardY + 8), ImVec2(cardX + cardW + 8, cardY + cardH + 8),
                IM_COL32(10, 10, 15, 150), 10.0f);

            // Main card
            dl->AddRectFilled(ImVec2(cardX, cardY), ImVec2(cardX + cardW, cardY + cardH),
                ImGui::ColorConvertFloat4ToU32(ImVec4(0.18f, 0.18f, 0.24f, 1.0f)), 10.0f);
            dl->AddRect(ImVec2(cardX, cardY), ImVec2(cardX + cardW, cardY + cardH),
                IM_COL32(230, 230, 230, 50), 10.0f, 0, 1.5f);

            // Title bar inside card
            float inCardY = cardY + 20;
            dl->AddRectFilled(ImVec2(cardX + 20, inCardY), ImVec2(cardX + cardW - 20, inCardY + 10),
                IM_COL32(230, 230, 230, 255), 2.0f);

            // Form fields with elegant borders and labels (using user-controlled sizes)
            float inputW5 = cardW * (sec.contact_input_width / 100.0f);
            float inputH5 = sec.contact_input_height;
            float fieldSpacing5 = sec.contact_field_spacing;
            float fieldY = inCardY + 25;
            float inputX5 = cardX + (cardW - inputW5) / 2;
            const char* darkLabels[] = {"Name", "Email", "Message"};
            for (int f = 0; f < 3; f++) {
                dl->AddRectFilled(ImVec2(inputX5, fieldY), ImVec2(inputX5 + inputW5, fieldY + inputH5),
                    ImGui::ColorConvertFloat4ToU32(ImVec4(0.15f, 0.15f, 0.2f, 1.0f)), 4.0f);
                dl->AddRect(ImVec2(inputX5, fieldY), ImVec2(inputX5 + inputW5, fieldY + inputH5),
                    IM_COL32(230, 230, 230, 80), 4.0f, 0, 1.0f);
                // Label text (light colored for dark background)
                dl->AddText(ImVec2(inputX5 + 8, fieldY + (inputH5 - 14) / 2), IM_COL32(200, 200, 200, 200), darkLabels[f]);
                fieldY += fieldSpacing5;
            }

            // Elegant button with text (using user-controlled sizes)
            fieldY += 10;
            float btnW5 = cardW * (sec.contact_button_width / 100.0f);
            float btnH5 = sec.contact_button_height;
            float btnX5 = cardX + (cardW - btnW5) / 2;
            dl->AddRectFilled(ImVec2(btnX5, fieldY), ImVec2(btnX5 + btnW5, fieldY + btnH5),
                ImGui::ColorConvertFloat4ToU32(sec.button_bg_color), 15.0f);
            float elegantBtnX = btnX5 + btnW5/2 - 25;
            dl->AddText(ImVec2(elegantBtnX, fieldY + (btnH5 - 14) / 2), IM_COL32(20, 20, 20, 255), "SEND");
        }

        // Remove clipping for contact section
        dl->PopClipRect();

        return;
    }

    // Footer
    if (sec.type == SEC_FOOTER) {
        ImFont* font = ImGui::GetFont();
        if (!sec.title.empty()) {
            ImVec2 titleSize = font->CalcTextSizeA(ValidFontSize(sec.title_font_size), FLT_MAX, 0.0f, sec.title.c_str());

            int titleLayers = (sec.title_font_weight >= 800.0f) ? 9 : ((sec.title_font_weight >= 500.0f) ? 4 : 1);
            float titleBoldStrength = (sec.title_font_weight >= 800.0f) ? 1.0f : ((sec.title_font_weight >= 500.0f) ? 0.5f : 0.0f);

            if (titleLayers > 1) {
                for (int layer = 0; layer < titleLayers; layer++) {
                    float offsetX = (layer % 3) * titleBoldStrength * 0.5f;
                    float offsetY = (layer / 3) * titleBoldStrength * 0.5f;
                    dl->AddText(font, ValidFontSize(sec.title_font_size), ImVec2(cx - titleSize.x / 2 + offsetX, y + h * 0.3f + offsetY), ImGui::ColorConvertFloat4ToU32(sec.title_color), sec.title.c_str());
                }
            } else {
                dl->AddText(font, ValidFontSize(sec.title_font_size), ImVec2(cx - titleSize.x / 2, y + h * 0.3f), ImGui::ColorConvertFloat4ToU32(sec.title_color), sec.title.c_str());
            }
        }
        if (!sec.content.empty()) {
            std::string copyright = "© " + sec.content;
            ImVec2 cSize = font->CalcTextSizeA(ValidFontSize(sec.content_font_size), FLT_MAX, 0.0f, copyright.c_str());

            int contentLayers = (sec.content_font_weight >= 800.0f) ? 9 : ((sec.content_font_weight >= 500.0f) ? 4 : 1);
            float contentBoldStrength = (sec.content_font_weight >= 800.0f) ? 1.0f : ((sec.content_font_weight >= 500.0f) ? 0.5f : 0.0f);

            if (contentLayers > 1) {
                for (int layer = 0; layer < contentLayers; layer++) {
                    float offsetX = (layer % 3) * contentBoldStrength * 0.5f;
                    float offsetY = (layer / 3) * contentBoldStrength * 0.5f;
                    dl->AddText(font, ValidFontSize(sec.content_font_size), ImVec2(cx - cSize.x / 2 + offsetX, y + h * 0.75f + offsetY), ImGui::ColorConvertFloat4ToU32(sec.content_color), copyright.c_str());
                }
            } else {
                dl->AddText(font, ValidFontSize(sec.content_font_size), ImVec2(cx - cSize.x / 2, y + h * 0.75f), ImGui::ColorConvertFloat4ToU32(sec.content_color), copyright.c_str());
            }
        }
        return;
    }

    // Image Section - Standalone moveable image with width control
    if (sec.type == SEC_IMAGE) {
        // Width and alignment already calculated at top of function
        ImVec2 section_min(x, y);
        ImVec2 section_max(x + sectionW, y + h);

        if (sec.img_texture_id != 0) {
            // Render the image filling the section area (works for both file and database images)
            dl->AddImage((ImTextureID)(intptr_t)sec.img_texture_id, section_min, section_max);

            // Show "Image" label
            dl->AddRectFilled(ImVec2(x + 5, y + 5), ImVec2(x + 60, y + 22),
                            ImGui::ColorConvertFloat4ToU32(ImVec4(0.3f, 0.7f, 0.9f, 0.8f)), 3.0f);
            dl->AddText(ImVec2(x + 10, y + 6), IM_COL32(255, 255, 255, 255), "IMAGE");
        } else {
            // No image uploaded yet - show placeholder
            dl->AddRectFilled(section_min, section_max, ImGui::ColorConvertFloat4ToU32(ImVec4(0.15f, 0.15f, 0.15f, 1.0f)));
            dl->AddRect(section_min, section_max, ImGui::ColorConvertFloat4ToU32(ImVec4(0.4f, 0.4f, 0.4f, 1.0f)), 0, 0, 2.0f);

            // Centered text
            const char* placeholder_text = "Upload Image";
            ImFont* font = ImGui::GetFont();
            ImVec2 textSize = font->CalcTextSizeA(14.0f, FLT_MAX, 0.0f, placeholder_text);
            float textX = x + (sectionW - textSize.x) / 2;
            float textY = y + (h - textSize.y) / 2;
            dl->AddText(font, 14.0f, ImVec2(textX, textY),
                       ImGui::ColorConvertFloat4ToU32(ImVec4(0.6f, 0.6f, 0.6f, 1.0f)), placeholder_text);

            // Show "Image" label
            dl->AddRectFilled(ImVec2(x + 5, y + 5), ImVec2(x + 60, y + 22),
                            ImGui::ColorConvertFloat4ToU32(ImVec4(0.3f, 0.7f, 0.9f, 0.8f)), 3.0f);
            dl->AddText(ImVec2(x + 10, y + 6), IM_COL32(255, 255, 255, 255), "IMAGE");
        }

        // Show width indicator border
        dl->AddRect(section_min, section_max, IM_COL32(100, 200, 255, 150), 0, 0, 1.0f);

        return;
    }

    // Text Box Section - Standalone text area with width control
    if (sec.type == SEC_TEXTBOX) {
        // Width and alignment already calculated at top of function
        ImVec2 section_min(x, y);
        ImVec2 section_max(x + sectionW, y + h);

        // Background color
        dl->AddRectFilled(section_min, section_max, ImGui::ColorConvertFloat4ToU32(sec.bg_color));

        ImFont* font = ImGui::GetFont();
        // Use 4-sided padding for proper spacing
        float padLeft = sec.padding_left;
        float padRight = sec.padding_right;
        float padTop = sec.padding_top;
        float padBottom = sec.padding_bottom;

        float contentX = x + padLeft;
        float currentY = y + padTop;
        float sectionCenterX = x + sectionW / 2;

        // Helper for text alignment (within this section)
        auto GetAlignedX = [&](float textWidth) {
            if (sec.text_align == 1) return sectionCenterX - textWidth / 2;  // Center
            if (sec.text_align == 2) return x + sectionW - padRight - textWidth;  // Right
            return contentX;  // Left (default)
        };

        // Render Title
        if (!sec.title.empty()) {
            float titleFS = ValidFontSize(sec.title_font_size);
            ImVec2 titleSize = font->CalcTextSizeA(titleFS, FLT_MAX, 0.0f, sec.title.c_str());

            int titleLayers = (sec.title_font_weight >= 800.0f) ? 9 : ((sec.title_font_weight >= 500.0f) ? 4 : 1);
            float titleBoldStrength = (sec.title_font_weight >= 800.0f) ? 1.0f : ((sec.title_font_weight >= 500.0f) ? 0.5f : 0.0f);

            float titleX = GetAlignedX(titleSize.x);

            if (titleLayers > 1) {
                for (int layer = 0; layer < titleLayers; layer++) {
                    float offsetX = (layer % 3) * titleBoldStrength * 0.5f;
                    float offsetY = (layer / 3) * titleBoldStrength * 0.5f;
                    dl->AddText(font, titleFS, ImVec2(titleX + offsetX, currentY + offsetY),
                               ImGui::ColorConvertFloat4ToU32(sec.title_color), sec.title.c_str());
                }
            } else {
                dl->AddText(font, titleFS, ImVec2(titleX, currentY),
                           ImGui::ColorConvertFloat4ToU32(sec.title_color), sec.title.c_str());
            }

            currentY += titleSize.y + 15;
        }

        // Render Subtitle
        if (!sec.subtitle.empty()) {
            float subtitleFS = ValidFontSize(sec.subtitle_font_size);
            ImVec2 subtitleSize = font->CalcTextSizeA(subtitleFS, FLT_MAX, 0.0f, sec.subtitle.c_str());

            int subtitleLayers = (sec.subtitle_font_weight >= 800.0f) ? 9 : ((sec.subtitle_font_weight >= 500.0f) ? 4 : 1);
            float subtitleBoldStrength = (sec.subtitle_font_weight >= 800.0f) ? 1.0f : ((sec.subtitle_font_weight >= 500.0f) ? 0.5f : 0.0f);

            float subtitleX = GetAlignedX(subtitleSize.x);

            if (subtitleLayers > 1) {
                for (int layer = 0; layer < subtitleLayers; layer++) {
                    float offsetX = (layer % 3) * subtitleBoldStrength * 0.5f;
                    float offsetY = (layer / 3) * subtitleBoldStrength * 0.5f;
                    dl->AddText(font, subtitleFS, ImVec2(subtitleX + offsetX, currentY + offsetY),
                               ImGui::ColorConvertFloat4ToU32(sec.subtitle_color), sec.subtitle.c_str());
                }
            } else {
                dl->AddText(font, subtitleFS, ImVec2(subtitleX, currentY),
                           ImGui::ColorConvertFloat4ToU32(sec.subtitle_color), sec.subtitle.c_str());
            }

            currentY += subtitleSize.y + 10;
        }

        // Render Content (with word wrap)
        if (!sec.content.empty()) {
            float contentFS = ValidFontSize(sec.content_font_size);
            float wrapWidth = sectionW - padLeft - padRight;

            int contentLayers = (sec.content_font_weight >= 800.0f) ? 9 : ((sec.content_font_weight >= 500.0f) ? 4 : 1);
            float contentBoldStrength = (sec.content_font_weight >= 800.0f) ? 1.0f : ((sec.content_font_weight >= 500.0f) ? 0.5f : 0.0f);

            // Simple word wrap implementation
            std::string text = sec.content;
            std::string line;
            float lineY = currentY;

            std::istringstream words(text);
            std::string word;
            while (words >> word) {
                std::string testLine = line.empty() ? word : line + " " + word;
                ImVec2 testSize = font->CalcTextSizeA(contentFS, FLT_MAX, 0.0f, testLine.c_str());

                if (testSize.x > wrapWidth && !line.empty()) {
                    // Draw current line
                    float lineX = GetAlignedX(font->CalcTextSizeA(contentFS, FLT_MAX, 0.0f, line.c_str()).x);

                    if (contentLayers > 1) {
                        for (int layer = 0; layer < contentLayers; layer++) {
                            float offsetX = (layer % 3) * contentBoldStrength * 0.5f;
                            float offsetY = (layer / 3) * contentBoldStrength * 0.5f;
                            dl->AddText(font, contentFS, ImVec2(lineX + offsetX, lineY + offsetY),
                                       ImGui::ColorConvertFloat4ToU32(sec.content_color), line.c_str());
                        }
                    } else {
                        dl->AddText(font, contentFS, ImVec2(lineX, lineY),
                                   ImGui::ColorConvertFloat4ToU32(sec.content_color), line.c_str());
                    }

                    lineY += contentFS + 5;
                    line = word;
                } else {
                    line = testLine;
                }
            }

            // Draw last line
            if (!line.empty()) {
                float lineX = GetAlignedX(font->CalcTextSizeA(contentFS, FLT_MAX, 0.0f, line.c_str()).x);

                if (contentLayers > 1) {
                    for (int layer = 0; layer < contentLayers; layer++) {
                        float offsetX = (layer % 3) * contentBoldStrength * 0.5f;
                        float offsetY = (layer / 3) * contentBoldStrength * 0.5f;
                        dl->AddText(font, contentFS, ImVec2(lineX + offsetX, lineY + offsetY),
                                   ImGui::ColorConvertFloat4ToU32(sec.content_color), line.c_str());
                    }
                } else {
                    dl->AddText(font, contentFS, ImVec2(lineX, lineY),
                               ImGui::ColorConvertFloat4ToU32(sec.content_color), line.c_str());
                }
            }
        }

        // Show "TEXT BOX" label
        dl->AddRectFilled(ImVec2(x + 5, y + 5), ImVec2(x + 80, y + 22),
                        ImGui::ColorConvertFloat4ToU32(ImVec4(0.9f, 0.6f, 0.2f, 0.8f)), 3.0f);
        dl->AddText(ImVec2(x + 10, y + 6), IM_COL32(255, 255, 255, 255), "TEXT BOX");

        // Show width indicator border
        dl->AddRect(section_min, section_max, IM_COL32(255, 180, 80, 150), 0, 0, 1.0f);

        return;
    }

    // Default - render title and paragraphs
    float contentY = y + sec.padding_top;

    if (!sec.title.empty()) {
        ImFont* font = ImGui::GetFont();
        ImVec2 titleSize = font->CalcTextSizeA(ValidFontSize(sec.title_font_size), FLT_MAX, 0.0f, sec.title.c_str());

        int titleLayers = (sec.title_font_weight >= 800.0f) ? 9 : ((sec.title_font_weight >= 500.0f) ? 4 : 1);
        float titleBoldStrength = (sec.title_font_weight >= 800.0f) ? 1.0f : ((sec.title_font_weight >= 500.0f) ? 0.5f : 0.0f);

        if (titleLayers > 1) {
            for (int layer = 0; layer < titleLayers; layer++) {
                float offsetX = (layer % 3) * titleBoldStrength * 0.5f;
                float offsetY = (layer / 3) * titleBoldStrength * 0.5f;
                dl->AddText(font, ValidFontSize(sec.title_font_size), ImVec2(cx - titleSize.x / 2 + offsetX, contentY + offsetY), ImGui::ColorConvertFloat4ToU32(sec.title_color), sec.title.c_str());
            }
        } else {
            dl->AddText(font, ValidFontSize(sec.title_font_size), ImVec2(cx - titleSize.x / 2, contentY), ImGui::ColorConvertFloat4ToU32(sec.title_color), sec.title.c_str());
        }
        contentY += titleSize.y + 30;  // Move down for paragraphs
    }

    // Render paragraphs below title
    if (!sec.paragraphs.empty()) {
        float paraMaxWidth = sectionW - sec.padding_left - sec.padding_right;
        float paraX = x + sec.padding_left;

        for (const auto& para : sec.paragraphs) {
            if (para.text.empty()) continue;

            // Render wrapped paragraph text
            float paraHeight = DrawWrappedText(dl, para.text, paraX, contentY, paraMaxWidth,
                                               ImGui::ColorConvertFloat4ToU32(para.color),
                                               true, para.font_size, para.font_weight);
            contentY += paraHeight + 16;  // Add spacing between paragraphs

            // Stop if we run out of space
            if (contentY > y + h - 20) break;
        }
    }

    // ========================================================================
    // RENDER MOVEABLE IMAGES (on top of all content)
    // ========================================================================
    // MOVEABLE IMAGES RENDERING - DISABLED PER USER REQUEST
    // (Rendering code removed from preview but data structure preserved)

    /* COMMENTED OUT - Moveable Images Feature
    ImVec2 mouse_pos = ImGui::GetMousePos();
    bool mouse_down = ImGui::IsMouseDown(0);
    bool mouse_released = ImGui::IsMouseReleased(0);

    for (auto& img : sec.moveable_images) {
        // ... rendering code removed ...
    }
    */
}

// ============================================================================
// MAIN UI (Same as Website Builder V1)
// ============================================================================
void RenderUI() {
    ImGuiIO& io = ImGui::GetIO();
    ImGuiStyle& style = ImGui::GetStyle();

    style.Colors[ImGuiCol_WindowBg] = ImVec4(0.11f, 0.11f, 0.14f, 1.0f);
    style.Colors[ImGuiCol_ChildBg] = ImVec4(0.14f, 0.14f, 0.17f, 1.0f);
    style.Colors[ImGuiCol_Button] = ImVec4(0.2f, 0.22f, 0.27f, 1.0f);
    style.Colors[ImGuiCol_ButtonHovered] = ImVec4(0.28f, 0.30f, 0.38f, 1.0f);
    style.Colors[ImGuiCol_FrameBg] = ImVec4(0.18f, 0.18f, 0.22f, 1.0f);
    style.WindowRounding = 0;
    style.FrameRounding = 5;

    // TOP BAR - Made taller to fit all buttons
    ImGui::SetNextWindowPos(ImVec2(0, 0));
    ImGui::SetNextWindowSize(ImVec2(io.DisplaySize.x, 60));
    ImGui::Begin("##Top", nullptr, ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove | ImGuiWindowFlags_NoScrollbar);

    // First row - Title and Project Name
    ImGui::SetCursorPosY(8);
    ImGui::TextColored(ImVec4(0.4f, 0.7f, 1.0f, 1.0f), "ImGui Website Designer");
    ImGui::SameLine(200);
    ImGui::SetNextItemWidth(150);
    char pn[128];
    strncpy(pn, g_ProjectName.c_str(), sizeof(pn) - 1);
    pn[sizeof(pn) - 1] = '\0';
    if (ImGui::InputText("##PN", pn, sizeof(pn))) g_ProjectName = pn;

    // Zoom control on first row
    ImGui::SameLine(io.DisplaySize.x - 120);
    ImGui::Text("Zoom:");
    ImGui::SameLine();
    ImGui::SetNextItemWidth(50);
    int zp = (int)(g_Zoom * 100);
    if (ImGui::SliderInt("##Z", &zp, 50, 150, "%d%%")) g_Zoom = zp / 100.0f;

    // Second row - All action buttons
    ImGui::SetCursorPosY(32);
    ImGui::SetCursorPosX(10);
    ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.8f, 0.3f, 0.5f, 1));
    if (ImGui::Button("Templates", ImVec2(80, 26))) {
        LoadAvailableTemplates();
        g_ShowTemplateGallery = true;
    }
    ImGui::PopStyleColor();
    ImGui::SameLine();
    ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.2f, 0.7f, 0.4f, 1));
    if (ImGui::Button("New Template", ImVec2(100, 26))) {
        // Clear all sections and start fresh
        g_Sections.clear();
        g_SelectedSectionIndex = -1;
        g_ProjectName = "My Website";
        g_CurrentPage = "Home";
        g_CurrentPageIndex = 0;
        g_FigmaMode = false;  // Exit Figma mode when creating new template
        printf("New template created - starting fresh!\n");
    }
    ImGui::PopStyleColor();
    ImGui::SameLine();
    ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.9f, 0.5f, 0.2f, 1));
    if (ImGui::Button("Import URL", ImVec2(85, 26))) {
        g_ShowURLImportDialog = true;
        g_URLImportBuffer[0] = '\0';
        g_URLImportStatus = "";
        g_URLImportInProgress = false;
    }
    ImGui::PopStyleColor();
    ImGui::SameLine();
    ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.5f, 0.3f, 0.8f, 1));
    if (ImGui::Button("Save Template", ImVec2(105, 26))) {
        g_ShowSaveTemplate = true;
        strncpy(g_TemplateNameBuffer, g_ProjectName.c_str(), sizeof(g_TemplateNameBuffer) - 1);
        g_TemplateNameBuffer[sizeof(g_TemplateNameBuffer) - 1] = '\0';
        g_TemplateDescBuffer[0] = '\0';
    }
    ImGui::PopStyleColor();
    ImGui::SameLine();
    ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.2f, 0.5f, 0.3f, 1));
    if (ImGui::Button("Preview", ImVec2(65, 26))) PreviewImGuiWebsite();
    ImGui::PopStyleColor();
    ImGui::SameLine();
    ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.3f, 0.5f, 0.8f, 1));
    if (ImGui::Button("Export", ImVec2(65, 26))) ExportImGuiWebsite();
    ImGui::PopStyleColor();
    ImGui::End();

    // LEFT PANEL
    float lpw = 180;
    ImGui::SetNextWindowPos(ImVec2(0, 60));
    ImGui::SetNextWindowSize(ImVec2(lpw, io.DisplaySize.y - 60));
    ImGui::Begin("##Left", nullptr, ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove);
    ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "SECTIONS");
    ImGui::Separator();

    struct SB { const char* n; SectionType t; };
    SB btns[] = {{"+ Hero", SEC_HERO}, {"+ Navigation", SEC_NAVBAR}, {"+ Cards", SEC_CARDS}, {"+ Team", SEC_TEAM}, {"+ Pricing", SEC_PRICING},
                 {"+ Stats", SEC_STATS}, {"+ Gallery", SEC_GALLERY}, {"+ Contact", SEC_CONTACT}, {"+ CTA", SEC_CTA}, {"+ Image", SEC_IMAGE}, {"+ Text Box", SEC_TEXTBOX}, {"+ Footer", SEC_FOOTER}};
    for (auto& b : btns) {
        if (ImGui::Button(b.n, ImVec2(-1, 26))) {
            // For these sections, directly create without template picker
            if (b.t == SEC_IMAGE || b.t == SEC_TEXTBOX || b.t == SEC_HERO || b.t == SEC_NAVBAR || b.t == SEC_TEAM || b.t == SEC_FOOTER || b.t == SEC_CARDS || b.t == SEC_PRICING || b.t == SEC_STATS || b.t == SEC_CTA) {
                WebSection sec(g_NextSectionId++, b.t);

                // SMART AUTO-POSITIONING: Fill remaining space
                if (!g_Sections.empty()) {
                    // Get the last added section
                    WebSection& lastSec = g_Sections.back();

                    // If last section has width < 100%, try to fill remaining space
                    if (lastSec.section_width_percent < 100.0f) {
                        float remainingSpace = 100.0f - lastSec.section_width_percent;

                        // Set new section width to fill remaining space
                        sec.section_width_percent = remainingSpace;

                        // Determine alignment based on last section's position
                        if (lastSec.horizontal_align == 0) {
                            // Last section is LEFT aligned, place new section on RIGHT
                            sec.horizontal_align = 2;  // Right
                        } else if (lastSec.horizontal_align == 2) {
                            // Last section is RIGHT aligned, place new section on LEFT
                            sec.horizontal_align = 0;  // Left
                        } else {
                            // Last section is CENTER aligned, place new section on RIGHT
                            sec.horizontal_align = 2;  // Right
                        }

                        // FORCE enable manual positioning for side-by-side layout
                        // Calculate Y position based on whether last section uses manual position
                        if (lastSec.use_manual_position) {
                            // Last section already has manual position, use same Y
                            sec.use_manual_position = true;
                            sec.y_position = lastSec.y_position;
                        } else {
                            // Last section doesn't have manual position, calculate current Y
                            // Sum up heights of all previous sections
                            float calculatedY = 0;
                            for (int i = 0; i < (int)g_Sections.size(); i++) {
                                if (i == (int)g_Sections.size() - 1) break; // Stop before last section
                                if (!g_Sections[i].use_manual_position) {
                                    calculatedY += g_Sections[i].height;
                                }
                            }
                            // Enable manual position for BOTH sections
                            lastSec.use_manual_position = true;
                            lastSec.y_position = calculatedY;
                            sec.use_manual_position = true;
                            sec.y_position = calculatedY;
                        }

                        // Match height for better alignment
                        sec.height = lastSec.height;
                    }
                }

                g_Sections.push_back(sec);
                g_SelectedSectionIndex = (int)g_Sections.size() - 1;
                for (int j = 0; j < (int)g_Sections.size(); j++) g_Sections[j].selected = (j == g_SelectedSectionIndex);
            } else {
                // Open template picker modal for other sections
                g_PickerSectionType = b.t;
                g_ShowTemplatePicker = true;
                g_SelectedStyleIndex = -1;
            }
        }
    }

    ImGui::Spacing();
    ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "LAYERS");
    ImGui::Separator();
    for (int i = 0; i < (int)g_Sections.size(); i++) {
        char lbl[64];
        snprintf(lbl, sizeof(lbl), "%d. %s", i + 1, g_Sections[i].name.c_str());
        if (ImGui::Selectable(lbl, i == g_SelectedSectionIndex)) {
            g_SelectedSectionIndex = i;
            for (int j = 0; j < (int)g_Sections.size(); j++) g_Sections[j].selected = (j == i);
        }
        if (ImGui::BeginPopupContextItem()) {
            if (ImGui::MenuItem("Move Up") && i > 0) std::swap(g_Sections[i], g_Sections[i - 1]);
            if (ImGui::MenuItem("Move Down") && i < (int)g_Sections.size() - 1) std::swap(g_Sections[i], g_Sections[i + 1]);
            ImGui::Separator();
            if (ImGui::MenuItem("Duplicate")) {
                WebSection cp = g_Sections[i];
                cp.id = g_NextSectionId++;
                g_Sections.insert(g_Sections.begin() + i + 1, cp);
            }
            if (ImGui::MenuItem("Delete")) {
                g_Sections.erase(g_Sections.begin() + i);
                g_SelectedSectionIndex = std::min(g_SelectedSectionIndex, (int)g_Sections.size() - 1);
            }
            ImGui::EndPopup();
        }
    }

    // Glass Panel Tool
    ImGui::Spacing();
    ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "GLASS PANELS");
    ImGui::Separator();
    if (g_SelectedSectionIndex >= 0 && g_SelectedSectionIndex < (int)g_Sections.size()) {
        WebSection& sec = g_Sections[g_SelectedSectionIndex];
        if (ImGui::Button("+ Add Glass Panel", ImVec2(-1, 26))) {
            WebSection::GlassPanel gp;
            gp.x = 50;
            gp.y = 50;
            gp.width = 200;
            gp.height = 100;
            gp.text = "Glass Panel";
            gp.text_size = 16;
            gp.text_color = ImVec4(1, 1, 1, 1);
            gp.opacity = 0.25f;
            gp.blur = 10.0f;
            gp.tint = ImVec4(1, 1, 1, 0.15f);
            gp.border_radius = 16.0f;
            gp.selected = false;
            sec.glass_panels.push_back(gp);
        }
        // List glass panels in current section
        for (int gpi = 0; gpi < (int)sec.glass_panels.size(); gpi++) {
            ImGui::PushID(gpi + 10000);
            char gpLabel[64];
            snprintf(gpLabel, sizeof(gpLabel), "Panel %d", gpi + 1);
            if (ImGui::Selectable(gpLabel, sec.glass_panels[gpi].selected)) {
                // Deselect all, select this one
                for (auto& p : sec.glass_panels) p.selected = false;
                sec.glass_panels[gpi].selected = true;
            }
            if (ImGui::BeginPopupContextItem()) {
                if (ImGui::MenuItem("Delete")) {
                    sec.glass_panels.erase(sec.glass_panels.begin() + gpi);
                    gpi--;
                }
                ImGui::EndPopup();
            }
            ImGui::PopID();
        }
    } else {
        ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 0.7f), "Select a section first");
    }
    ImGui::End();

    // CENTER CANVAS
    float rpw = (g_SelectedSectionIndex >= 0) ? 300 : 0;
    float cw = io.DisplaySize.x - lpw - rpw, ch = io.DisplaySize.y - 60;
    ImGui::SetNextWindowPos(ImVec2(lpw, 60));
    ImGui::SetNextWindowSize(ImVec2(cw, ch));
    ImGui::Begin("##Canvas", nullptr, ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove);

    // Check if in Figma mode
    if (g_FigmaMode) {
        // Static variables for UI state
        static bool showLayersDropdown = false;
        static bool showPropertiesDropdown = false;

        // ==================== TOP TOOLBAR ====================
        float toolbarHeight = 50;
        ImGui::SetCursorPos(ImVec2(0, 0));
        ImGui::PushStyleColor(ImGuiCol_ChildBg, ImVec4(0.12f, 0.12f, 0.15f, 1.0f));
        ImGui::PushStyleVar(ImGuiStyleVar_ChildRounding, 0);
        ImGui::BeginChild("##FigmaTopBar", ImVec2(cw, toolbarHeight), true);

        // Static for load popup
        static bool showLoadPopup = false;
        static std::vector<std::string> savedProjects;

        // Left section: Exit, Save, Load, basic controls
        if (ImGui::Button("Exit")) {
            g_FigmaMode = false;
        }
        ImGui::SameLine();

        // Save button with project name input
        static char projectNameBuf[128] = "Untitled";
        if (g_FigmaProject.name != projectNameBuf) {
            strncpy(projectNameBuf, g_FigmaProject.name.c_str(), sizeof(projectNameBuf));
        }
        ImGui::SetNextItemWidth(120);
        if (ImGui::InputText("##ProjName", projectNameBuf, sizeof(projectNameBuf))) {
            g_FigmaProject.name = projectNameBuf;
        }
        ImGui::SameLine();

        if (ImGui::Button("Save")) {
            std::string savePath = "/Users/imaging/Desktop/Website-Builder-v2.0/figma_projects/" + g_FigmaProject.name + ".json";
            system("mkdir -p /Users/imaging/Desktop/Website-Builder-v2.0/figma_projects");
            FILE* f = fopen(savePath.c_str(), "w");
            if (f) {
                fprintf(f, "{\n  \"project\": {\n");
                fprintf(f, "    \"name\": \"%s\",\n", g_FigmaProject.name.c_str());
                fprintf(f, "    \"canvas_width\": %.0f,\n", g_FigmaProject.canvas_width);
                fprintf(f, "    \"canvas_height\": %.0f,\n", g_FigmaProject.canvas_height);
                fprintf(f, "    \"screenshot_path\": \"%s\"\n", g_FigmaProject.screenshot_path.c_str());
                fprintf(f, "  },\n  \"layers\": [\n");
                for (size_t i = 0; i < g_FigmaProject.layers.size(); i++) {
                    auto& l = g_FigmaProject.layers[i];
                    const char* typeStr = "LAYER_DIV";
                    if (l.type == LAYER_TEXT) typeStr = "LAYER_TEXT";
                    else if (l.type == LAYER_IMAGE) typeStr = "LAYER_IMAGE";
                    else if (l.type == LAYER_BUTTON) typeStr = "LAYER_BUTTON";
                    fprintf(f, "    {\n");
                    fprintf(f, "      \"id\": %d,\n", l.id);
                    fprintf(f, "      \"type\": \"%s\",\n", typeStr);
                    fprintf(f, "      \"name\": \"%s\",\n", l.name.c_str());
                    fprintf(f, "      \"x\": %.0f,\n", l.x);
                    fprintf(f, "      \"y\": %.0f,\n", l.y);
                    fprintf(f, "      \"width\": %.0f,\n", l.width);
                    fprintf(f, "      \"height\": %.0f,\n", l.height);
                    fprintf(f, "      \"text\": \"%s\",\n", l.text.c_str());
                    fprintf(f, "      \"font_size\": %.0f,\n", l.font_size);
                    fprintf(f, "      \"opacity\": %.2f,\n", l.opacity);
                    fprintf(f, "      \"image_path\": \"%s\"\n", l.image_path.c_str());
                    fprintf(f, "    }%s\n", (i < g_FigmaProject.layers.size() - 1) ? "," : "");
                }
                fprintf(f, "  ]\n}\n");
                fclose(f);
                printf("[Figma] Saved project to: %s\n", savePath.c_str());

                // Also save as last project for auto-load
                FILE* lastProj = fopen("/Users/imaging/Desktop/Website-Builder-v2.0/figma_projects/.last_project", "w");
                if (lastProj) {
                    fprintf(lastProj, "%s", savePath.c_str());
                    fclose(lastProj);
                }
            }
        }
        ImGui::SameLine();

        // Load button
        if (ImGui::Button("Load")) {
            savedProjects = GetSavedFigmaProjects();
            showLoadPopup = true;
        }

        // Load popup
        if (showLoadPopup) {
            ImGui::OpenPopup("Load Project");
        }
        if (ImGui::BeginPopup("Load Project")) {
            ImGui::Text("Saved Projects:");
            ImGui::Separator();
            for (const auto& proj : savedProjects) {
                // Extract just the filename
                size_t lastSlash = proj.rfind('/');
                std::string filename = (lastSlash != std::string::npos) ? proj.substr(lastSlash + 1) : proj;
                // Remove .json extension
                if (filename.size() > 5) filename = filename.substr(0, filename.size() - 5);

                if (ImGui::MenuItem(filename.c_str())) {
                    LoadFigmaProject(proj);
                    showLoadPopup = false;
                }
            }
            if (savedProjects.empty()) {
                ImGui::TextDisabled("No saved projects found");
            }
            ImGui::Separator();
            if (ImGui::MenuItem("Cancel")) {
                showLoadPopup = false;
            }
            ImGui::EndPopup();
        } else {
            showLoadPopup = false;
        }

        ImGui::SameLine();

        // Save to Database button
        if (ImGui::Button("Save to DB")) {
            if (g_UseDatabase && g_DBConnection && !g_FigmaProject.name.empty()) {
                // Create permanent storage directory for this template
                std::string permanentDir = "/Users/imaging/Desktop/Website-Builder-v2.0/figma_templates/" + g_FigmaProject.name + "/";
                system(("mkdir -p \"" + permanentDir + "\"").c_str());
                system(("mkdir -p \"" + permanentDir + "images/\"").c_str());

                // Copy screenshot to permanent location
                std::string permanentScreenshotPath = permanentDir + "screenshot.png";
                if (!g_FigmaProject.screenshot_path.empty()) {
                    std::string copyCmd = "cp \"" + g_FigmaProject.screenshot_path + "\" \"" + permanentScreenshotPath + "\"";
                    system(copyCmd.c_str());
                    g_FigmaProject.screenshot_path = permanentScreenshotPath;
                }

                // Copy layer images to permanent locations
                for (size_t i = 0; i < g_FigmaProject.layers.size(); i++) {
                    WebLayer& layer = g_FigmaProject.layers[i];
                    if (!layer.image_path.empty() && layer.image_path.find("/tmp/") != std::string::npos) {
                        // Extract filename from original path
                        size_t lastSlash = layer.image_path.rfind('/');
                        std::string filename = (lastSlash != std::string::npos) ?
                            layer.image_path.substr(lastSlash + 1) : layer.image_path;
                        std::string permanentImagePath = permanentDir + "images/" + filename;
                        std::string copyCmd = "cp \"" + layer.image_path + "\" \"" + permanentImagePath + "\"";
                        system(copyCmd.c_str());
                        layer.image_path = permanentImagePath;
                    }
                }

                // Read screenshot as binary data
                std::vector<unsigned char> screenshotData;
                if (!g_FigmaProject.screenshot_path.empty()) {
                    screenshotData = ReadImageFile(g_FigmaProject.screenshot_path);
                }

                // First, ensure the is_figma_template column exists
                std::string alterQuery = "ALTER TABLE templates ADD COLUMN IF NOT EXISTS is_figma_template BOOLEAN DEFAULT FALSE";
                PGresult* alterResult = PQexec(g_DBConnection, alterQuery.c_str());
                PQclear(alterResult);

                // Create template in database (without is_figma_template in INSERT to avoid issues)
                std::string query = "INSERT INTO templates (template_name, description, project_name) VALUES ('" +
                    SQLEscape(g_FigmaProject.name) + "', 'Figma-style imported template', '" +
                    SQLEscape(g_FigmaProject.name) + "') " +
                    "ON CONFLICT (template_name) DO UPDATE SET description='Figma-style imported template', " +
                    "project_name='" + SQLEscape(g_FigmaProject.name) + "', updated_date=NOW()";

                PGresult* result = PQexec(g_DBConnection, query.c_str());
                if (PQresultStatus(result) != PGRES_COMMAND_OK) {
                    printf("[Figma DB] Error creating template: %s\n", PQerrorMessage(g_DBConnection));
                    PQclear(result);
                } else {
                    PQclear(result);

                    // Get template ID
                    query = "SELECT id FROM templates WHERE template_name='" + SQLEscape(g_FigmaProject.name) + "'";
                    result = PQexec(g_DBConnection, query.c_str());
                    int template_id = 0;
                    if (PQresultStatus(result) == PGRES_TUPLES_OK && PQntuples(result) > 0) {
                        template_id = atoi(PQgetvalue(result, 0, 0));
                    }
                    PQclear(result);

                    if (template_id > 0) {
                        // Delete old figma_layers for this template
                        query = "DELETE FROM figma_layers WHERE template_id=" + std::to_string(template_id);
                        result = PQexec(g_DBConnection, query.c_str());
                        PQclear(result);

                        // Check if figma_layers table exists, create if not
                        query = "CREATE TABLE IF NOT EXISTS figma_layers ("
                                "id SERIAL PRIMARY KEY, "
                                "template_id INTEGER REFERENCES templates(id), "
                                "layer_order INTEGER, "
                                "layer_type INTEGER, "
                                "name VARCHAR(255), "
                                "x REAL, y REAL, width REAL, height REAL, "
                                "text TEXT, "
                                "font_size REAL, "
                                "opacity REAL, "
                                "image_path TEXT, "
                                "image_data BYTEA, "
                                "bg_color VARCHAR(64), "
                                "text_color VARCHAR(64)"
                                ")";
                        result = PQexec(g_DBConnection, query.c_str());
                        PQclear(result);

                        // Add screenshot columns to templates if not exists
                        query = "ALTER TABLE templates ADD COLUMN IF NOT EXISTS figma_screenshot_path TEXT";
                        result = PQexec(g_DBConnection, query.c_str());
                        PQclear(result);

                        query = "ALTER TABLE templates ADD COLUMN IF NOT EXISTS figma_screenshot_data BYTEA";
                        result = PQexec(g_DBConnection, query.c_str());
                        PQclear(result);

                        query = "ALTER TABLE templates ADD COLUMN IF NOT EXISTS figma_canvas_width REAL";
                        result = PQexec(g_DBConnection, query.c_str());
                        PQclear(result);

                        query = "ALTER TABLE templates ADD COLUMN IF NOT EXISTS figma_canvas_height REAL";
                        result = PQexec(g_DBConnection, query.c_str());
                        PQclear(result);

                        query = "ALTER TABLE templates ADD COLUMN IF NOT EXISTS is_figma_template BOOLEAN DEFAULT FALSE";
                        result = PQexec(g_DBConnection, query.c_str());
                        PQclear(result);

                        // Update template with screenshot and canvas info
                        std::ostringstream updateQuery;
                        updateQuery << "UPDATE templates SET "
                                    << "figma_screenshot_path='" << SQLEscape(g_FigmaProject.screenshot_path) << "', "
                                    << "figma_canvas_width=" << g_FigmaProject.canvas_width << ", "
                                    << "figma_canvas_height=" << g_FigmaProject.canvas_height << ", "
                                    << "is_figma_template=TRUE";
                        if (!screenshotData.empty()) {
                            updateQuery << ", figma_screenshot_data=" << BinaryToHex(screenshotData);
                        }
                        updateQuery << " WHERE id=" << template_id;
                        result = PQexec(g_DBConnection, updateQuery.str().c_str());
                        PQclear(result);

                        // Insert each layer
                        for (size_t i = 0; i < g_FigmaProject.layers.size(); i++) {
                            const auto& l = g_FigmaProject.layers[i];

                            // Read image data if exists
                            std::vector<unsigned char> imgData;
                            if (!l.image_path.empty()) {
                                imgData = ReadImageFile(l.image_path);
                            }

                            std::ostringstream layerQuery;
                            layerQuery << "INSERT INTO figma_layers ("
                                       << "template_id, layer_order, layer_type, name, x, y, width, height, "
                                       << "text, font_size, opacity, image_path, image_data, bg_color, text_color"
                                       << ") VALUES ("
                                       << template_id << ", " << i << ", " << (int)l.type << ", "
                                       << "'" << SQLEscape(l.name) << "', "
                                       << l.x << ", " << l.y << ", " << l.width << ", " << l.height << ", "
                                       << "'" << SQLEscape(l.text) << "', "
                                       << l.font_size << ", " << l.opacity << ", "
                                       << "'" << SQLEscape(l.image_path) << "', "
                                       << (imgData.empty() ? "NULL" : BinaryToHex(imgData)) << ", "
                                       << "'" << ColorToSQL(l.bg_color) << "', "
                                       << "'" << ColorToSQL(l.text_color) << "'"
                                       << ")";

                            result = PQexec(g_DBConnection, layerQuery.str().c_str());
                            if (PQresultStatus(result) != PGRES_COMMAND_OK) {
                                printf("[Figma DB] Error inserting layer %zu: %s\n", i, PQerrorMessage(g_DBConnection));
                            }
                            PQclear(result);
                        }

                        printf("[Figma DB] Saved template '%s' with %zu layers to database!\n",
                               g_FigmaProject.name.c_str(), g_FigmaProject.layers.size());
                    }
                }
            } else {
                printf("[Figma DB] Database not connected or project name empty\n");
            }
        }

        ImGui::SameLine();
        ImGui::TextDisabled("|");
        ImGui::SameLine();

        // Layers dropdown button
        ImGui::PushStyleColor(ImGuiCol_Button, showLayersDropdown ? ImVec4(0.3f, 0.3f, 0.4f, 1.0f) : ImVec4(0.2f, 0.2f, 0.25f, 1.0f));
        if (ImGui::Button("Layers")) {
            showLayersDropdown = !showLayersDropdown;
            if (showLayersDropdown) showPropertiesDropdown = false;
        }
        ImGui::PopStyleColor();

        ImGui::SameLine();

        // Properties dropdown button
        ImGui::PushStyleColor(ImGuiCol_Button, showPropertiesDropdown ? ImVec4(0.3f, 0.3f, 0.4f, 1.0f) : ImVec4(0.2f, 0.2f, 0.25f, 1.0f));
        if (ImGui::Button("Properties")) {
            showPropertiesDropdown = !showPropertiesDropdown;
            if (showPropertiesDropdown) showLayersDropdown = false;
        }
        ImGui::PopStyleColor();

        ImGui::SameLine();
        ImGui::TextDisabled("|");
        ImGui::SameLine();

        // Quick layer actions
        if (ImGui::Button("+ Add")) {
            WebLayer newLayer;
            newLayer.id = g_FigmaProject.next_layer_id++;
            newLayer.name = "New Layer";
            newLayer.x = 100 - g_FigmaProject.scroll_x;
            newLayer.y = 100 - g_FigmaProject.scroll_y;
            newLayer.width = 200;
            newLayer.height = 100;
            newLayer.bg_color = ImVec4(0.9f, 0.9f, 0.9f, 1.0f);
            g_FigmaProject.layers.push_back(newLayer);
            SelectLayer(newLayer.id);
        }
        ImGui::SameLine();
        ImGui::BeginDisabled(g_SelectedLayerId < 0);
        if (ImGui::Button("Delete")) {
            g_FigmaProject.layers.erase(
                std::remove_if(g_FigmaProject.layers.begin(), g_FigmaProject.layers.end(),
                    [](const WebLayer& l) { return l.id == g_SelectedLayerId; }),
                g_FigmaProject.layers.end());
            g_SelectedLayerId = -1;
        }
        ImGui::EndDisabled();

        ImGui::SameLine();
        ImGui::TextDisabled("|");
        ImGui::SameLine();

        // View toggles
        ImGui::Checkbox("Grid", &g_FigmaProject.show_grid);
        ImGui::SameLine();
        ImGui::Checkbox("Ref", &g_FigmaProject.show_reference);
        if (g_FigmaProject.show_reference) {
            ImGui::SameLine();
            ImGui::SetNextItemWidth(60);
            ImGui::SliderFloat("##RefOp", &g_FigmaProject.reference_opacity, 0.1f, 1.0f, "%.1f");
        }

        ImGui::SameLine();
        ImGui::TextDisabled("|");
        ImGui::SameLine();

        // Zoom controls (right side)
        ImGui::Text("Zoom:");
        ImGui::SameLine();
        if (ImGui::Button("-##ZoomOut")) {
            g_FigmaProject.zoom = std::max(0.1f, g_FigmaProject.zoom - 0.1f);
        }
        ImGui::SameLine();
        ImGui::SetNextItemWidth(100);
        float zoomPercent = g_FigmaProject.zoom * 100.0f;
        if (ImGui::SliderFloat("##ZoomSlider", &zoomPercent, 10.0f, 300.0f, "%.0f%%")) {
            g_FigmaProject.zoom = zoomPercent / 100.0f;
        }
        ImGui::SameLine();
        if (ImGui::Button("+##ZoomIn")) {
            g_FigmaProject.zoom = std::min(3.0f, g_FigmaProject.zoom + 0.1f);
        }
        ImGui::SameLine();
        if (ImGui::Button("100%")) {
            g_FigmaProject.zoom = 1.0f;
        }
        ImGui::SameLine();
        if (ImGui::Button("Fit")) {
            ImVec2 cs = ImGui::GetContentRegionAvail();
            g_FigmaProject.zoom = (cw - 100) / g_FigmaProject.canvas_width;
        }

        ImGui::EndChild();
        ImGui::PopStyleVar();
        ImGui::PopStyleColor();

        // ==================== LAYERS DROPDOWN PANEL ====================
        if (showLayersDropdown) {
            ImGui::SetCursorPos(ImVec2(70, toolbarHeight));
            ImGui::PushStyleColor(ImGuiCol_ChildBg, ImVec4(0.15f, 0.15f, 0.18f, 0.98f));
            ImGui::BeginChild("##LayersPanel", ImVec2(250, std::min(400.0f, ch - toolbarHeight - 20)), true);

            ImGui::Text("LAYERS (%zu)", g_FigmaProject.layers.size());
            ImGui::Separator();

            // Layer list (reverse order - top layers first)
            for (int i = g_FigmaProject.layers.size() - 1; i >= 0; i--) {
                WebLayer& layer = g_FigmaProject.layers[i];
                ImGui::PushID(layer.id);

                // Visibility toggle
                if (ImGui::Checkbox("##vis", &layer.visible)) {}
                ImGui::SameLine();

                // Type icon
                const char* icon = "[D]";
                switch (layer.type) {
                    case LAYER_TEXT: icon = "[T]"; break;
                    case LAYER_IMAGE: icon = "[I]"; break;
                    case LAYER_BUTTON: icon = "[B]"; break;
                    case LAYER_INPUT: icon = "[F]"; break;
                    default: break;
                }

                char label[128];
                snprintf(label, sizeof(label), "%s %s", icon, layer.name.c_str());

                if (ImGui::Selectable(label, layer.selected)) {
                    SelectLayer(layer.id);
                }

                ImGui::PopID();
            }

            ImGui::EndChild();
            ImGui::PopStyleColor();
        }

        // ==================== PROPERTIES DROPDOWN PANEL ====================
        if (showPropertiesDropdown) {
            ImGui::SetCursorPos(ImVec2(140, toolbarHeight));
            ImGui::PushStyleColor(ImGuiCol_ChildBg, ImVec4(0.15f, 0.15f, 0.18f, 0.98f));
            ImGui::BeginChild("##PropertiesPanel", ImVec2(300, std::min(450.0f, ch - toolbarHeight - 20)), true);

            WebLayer* layer = GetLayerById(g_SelectedLayerId);
            if (!layer) {
                ImGui::TextDisabled("No layer selected");
                ImGui::TextDisabled("Select a layer on canvas");
                ImGui::TextDisabled("or from Layers panel");
            } else {
                ImGui::Text("PROPERTIES: %s", layer->name.c_str());
                ImGui::Separator();

                // Name
                char nameBuffer[256];
                strncpy(nameBuffer, layer->name.c_str(), sizeof(nameBuffer));
                ImGui::SetNextItemWidth(-1);
                if (ImGui::InputText("##Name", nameBuffer, sizeof(nameBuffer))) {
                    layer->name = nameBuffer;
                }

                ImGui::Spacing();

                // Transform
                if (ImGui::CollapsingHeader("Transform", ImGuiTreeNodeFlags_DefaultOpen)) {
                    ImGui::SetNextItemWidth(100);
                    ImGui::DragFloat("X", &layer->x, 1.0f);
                    ImGui::SameLine();
                    ImGui::SetNextItemWidth(100);
                    ImGui::DragFloat("Y", &layer->y, 1.0f);
                    ImGui::SetNextItemWidth(100);
                    ImGui::DragFloat("W", &layer->width, 1.0f, 1.0f, 10000.0f);
                    ImGui::SameLine();
                    ImGui::SetNextItemWidth(100);
                    ImGui::DragFloat("H", &layer->height, 1.0f, 1.0f, 10000.0f);
                }

                // Appearance
                if (ImGui::CollapsingHeader("Appearance", ImGuiTreeNodeFlags_DefaultOpen)) {
                    ImGui::ColorEdit4("BG Color", (float*)&layer->bg_color, ImGuiColorEditFlags_NoInputs);
                    ImGui::ColorEdit4("Text Color", (float*)&layer->text_color, ImGuiColorEditFlags_NoInputs);
                    ImGui::SetNextItemWidth(150);
                    ImGui::SliderFloat("Opacity", &layer->opacity, 0.0f, 1.0f, "%.2f");
                    ImGui::SetNextItemWidth(150);
                    ImGui::DragFloat("Border Radius", &layer->border_radius, 1.0f, 0.0f, 100.0f);
                }

                // Text (for text/button layers)
                if (layer->type == LAYER_TEXT || layer->type == LAYER_BUTTON) {
                    if (ImGui::CollapsingHeader("Text", ImGuiTreeNodeFlags_DefaultOpen)) {
                        char textBuffer[1024];
                        strncpy(textBuffer, layer->text.c_str(), sizeof(textBuffer));
                        if (ImGui::InputTextMultiline("##Content", textBuffer, sizeof(textBuffer), ImVec2(-1, 60))) {
                            layer->text = textBuffer;
                        }
                        ImGui::SetNextItemWidth(100);
                        ImGui::DragFloat("Font Size", &layer->font_size, 1.0f, 8.0f, 200.0f);
                    }
                }

                ImGui::Spacing();
                ImGui::Checkbox("Locked", &layer->locked);
            }

            ImGui::EndChild();
            ImGui::PopStyleColor();
        }

        // ==================== CANVAS (below toolbar) ====================
        ImGui::SetCursorPos(ImVec2(0, toolbarHeight));
        ImGui::BeginChild("##FigmaCanvasArea", ImVec2(cw, ch - toolbarHeight), false, ImGuiWindowFlags_NoScrollbar);

        // Render the actual Figma canvas
        RenderFigmaCanvas();

        ImGui::EndChild();

        ImGui::End();
        // Don't return - let popup dialogs render below
    } else {
        // Normal section-based rendering
    ImVec2 cp = ImGui::GetCursorScreenPos();
    ImVec2 cs = ImGui::GetContentRegionAvail();
    ImDrawList* dl = ImGui::GetWindowDrawList();

    float ww = std::min(cs.x - 40, 900.0f) * g_Zoom;
    float wx = cp.x + (cs.x - ww) / 2;
    dl->AddRectFilled(ImVec2(wx, cp.y), ImVec2(wx + ww, cp.y + cs.y), ImGui::ColorConvertFloat4ToU32(ImVec4(1, 1, 1, 1)));

    float yOff = -g_CanvasScrollY;
    ImVec2 mouse_pos = ImGui::GetMousePos();
    bool mouse_down = ImGui::IsMouseDown(0);
    bool mouse_released = ImGui::IsMouseReleased(0);

    // Calculate drop target index based on mouse position
    if (g_DraggingSection) {
        g_DropTargetIndex = -1;
        float checkY = -g_CanvasScrollY;
        for (int i = 0; i < (int)g_Sections.size(); i++) {
            float sectionMidY = cp.y + checkY + (g_Sections[i].height * g_Zoom) / 2;
            if (mouse_pos.y < sectionMidY) {
                g_DropTargetIndex = i;
                break;
            }
            checkY += g_Sections[i].height * g_Zoom;
        }
        if (g_DropTargetIndex == -1) {
            g_DropTargetIndex = (int)g_Sections.size();
        }
    }

    // Render sections
    for (int i = 0; i < (int)g_Sections.size(); i++) {
        auto& sec = g_Sections[i];

        // Auto-upgrade old cards to modern style (for Cards and Services sections)
        if ((sec.type == SEC_CARDS || sec.type == SEC_SERVICES || sec.type == SEC_FEATURES) && !sec.items.empty()) {
            for (auto& item : sec.items) {
                // If old card style (0) and no modern properties set, auto-upgrade
                if (item.card_style == 0 && item.icon_emoji.empty()) {
                    item.card_style = 1;  // Set to Service style
                    // Set default icon based on position
                    static const char* default_icons[] = {"⚡", "🌐", "📱", "💼", "🚀", "🎯"};
                    static ImVec4 default_colors[] = {
                        ImVec4(0.96f, 0.32f, 0.53f, 1.0f),  // Pink
                        ImVec4(0.25f, 0.52f, 1.0f, 1.0f),   // Blue
                        ImVec4(0.20f, 0.73f, 0.42f, 1.0f),  // Green
                        ImVec4(0.96f, 0.55f, 0.23f, 1.0f),  // Orange
                        ImVec4(0.56f, 0.27f, 0.68f, 1.0f),  // Purple
                        ImVec4(0.20f, 0.80f, 0.80f, 1.0f)   // Cyan
                    };
                    int idx = (&item - &sec.items[0]) % 6;
                    item.icon_emoji = default_icons[idx];
                    item.icon_color = default_colors[idx];
                    // Set default bullet points
                    item.bullet_points = {"Feature 1", "Feature 2", "Feature 3"};
                    item.anim_direction = 2;  // Right to left
                    item.anim_progress = 0.0f;  // Start animation
                    item.anim_delay = idx * 0.15f;  // Stagger animation
                }
            }
        }

        // No animation during design time - cards are static in editor
        // Animation only happens in Preview/Export
        for (auto& item : sec.items) {
            item.anim_progress = 1.0f;  // Fully visible, no animation in editor
        }

        // Determine render Y position: manual or auto
        float renderY;
        if (sec.use_manual_position) {
            renderY = (sec.y_position * g_Zoom) - g_CanvasScrollY;
        } else {
            renderY = yOff;
        }

        // Skip rendering dragged section in original position
        if (g_DraggingSection && i == g_DraggedSectionIndex) {
            if (!sec.use_manual_position) {
                yOff += sec.height * g_Zoom;
            }
            continue;
        }

        // Show drop target indicator
        if (g_DraggingSection && i == g_DropTargetIndex) {
            float lineY = cp.y + renderY;
            dl->AddLine(ImVec2(wx, lineY), ImVec2(wx + ww, lineY),
                       IM_COL32(100, 200, 255, 255), 4.0f);
            dl->AddCircleFilled(ImVec2(wx, lineY), 6.0f, IM_COL32(100, 200, 255, 255));
            dl->AddCircleFilled(ImVec2(wx + ww, lineY), 6.0f, IM_COL32(100, 200, 255, 255));
        }

        RenderSectionPreview(dl, sec, ImVec2(wx, cp.y), ww, renderY);
        ImVec2 sm(wx, cp.y + renderY), sx(wx + ww, cp.y + renderY + sec.height * g_Zoom);

        // Mouse interaction
        if (ImGui::IsMouseHoveringRect(sm, sx)) {
            if (ImGui::IsMouseClicked(0)) {
                g_SelectedSectionIndex = i;
                for (int j = 0; j < (int)g_Sections.size(); j++) g_Sections[j].selected = (j == i);

                // Start dragging
                g_DraggingSection = true;
                g_DraggedSectionIndex = i;
                g_DragOffsetY = mouse_pos.y - (cp.y + renderY);
            }
        }

        // Only increment yOff for auto-positioned sections
        if (!sec.use_manual_position) {
            yOff += sec.height * g_Zoom;
        }
    }

    // Show drop indicator at end
    if (g_DraggingSection && g_DropTargetIndex == (int)g_Sections.size()) {
        float lineY = cp.y + yOff;
        dl->AddLine(ImVec2(wx, lineY), ImVec2(wx + ww, lineY),
                   IM_COL32(100, 200, 255, 255), 4.0f);
        dl->AddCircleFilled(ImVec2(wx, lineY), 6.0f, IM_COL32(100, 200, 255, 255));
        dl->AddCircleFilled(ImVec2(wx + ww, lineY), 6.0f, IM_COL32(100, 200, 255, 255));
    }

    // Render dragged section at mouse position
    if (g_DraggingSection && g_DraggedSectionIndex >= 0 && g_DraggedSectionIndex < (int)g_Sections.size()) {
        auto& draggedSec = g_Sections[g_DraggedSectionIndex];
        float dragY = mouse_pos.y - cp.y - g_DragOffsetY;

        // Semi-transparent overlay
        dl->AddRectFilled(ImVec2(wx, mouse_pos.y - g_DragOffsetY),
                         ImVec2(wx + ww, mouse_pos.y - g_DragOffsetY + draggedSec.height * g_Zoom),
                         IM_COL32(100, 200, 255, 100));

        RenderSectionPreview(dl, draggedSec, ImVec2(wx, cp.y), ww, dragY);

        // Border around dragged section
        dl->AddRect(ImVec2(wx, mouse_pos.y - g_DragOffsetY),
                   ImVec2(wx + ww, mouse_pos.y - g_DragOffsetY + draggedSec.height * g_Zoom),
                   IM_COL32(100, 200, 255, 255), 0, 0, 3.0f);
    }

    // Handle drop
    if (g_DraggingSection && mouse_released) {
        if (g_DropTargetIndex >= 0 && g_DraggedSectionIndex >= 0) {
            // Reorder sections
            WebSection draggedSection = g_Sections[g_DraggedSectionIndex];
            g_Sections.erase(g_Sections.begin() + g_DraggedSectionIndex);

            int insertIndex = g_DropTargetIndex;
            if (g_DraggedSectionIndex < g_DropTargetIndex) {
                insertIndex--;
            }

            g_Sections.insert(g_Sections.begin() + insertIndex, draggedSection);
            g_SelectedSectionIndex = insertIndex;

            // Update selection
            for (int j = 0; j < (int)g_Sections.size(); j++) {
                g_Sections[j].selected = (j == insertIndex);
            }
        }

        // Reset drag state
        g_DraggingSection = false;
        g_DraggedSectionIndex = -1;
        g_DropTargetIndex = -1;
    }
    if (ImGui::IsWindowHovered()) {
        g_CanvasScrollY -= io.MouseWheel * 40;
        g_CanvasScrollY = std::max(0.0f, g_CanvasScrollY);
    }
    if (g_Sections.empty()) {
        const char* t = "Click a section to start";
        ImVec2 ts = ImGui::CalcTextSize(t);
        dl->AddText(ImVec2(wx + ww / 2 - ts.x / 2, cp.y + cs.y / 2), ImGui::ColorConvertFloat4ToU32(ImVec4(0.5f, 0.5f, 0.5f, 1)), t);
    }
    ImGui::End();

    // RIGHT PANEL - PROPERTIES (Same as Website Builder V1)
    if (g_SelectedSectionIndex >= 0 && g_SelectedSectionIndex < (int)g_Sections.size()) {
        WebSection& sec = g_Sections[g_SelectedSectionIndex];
        ImGui::SetNextWindowPos(ImVec2(io.DisplaySize.x - rpw, 60));
        ImGui::SetNextWindowSize(ImVec2(rpw, io.DisplaySize.y - 60));
        ImGui::Begin("##Props", nullptr, ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove);

        ImGui::TextColored(ImVec4(0.4f, 0.7f, 1.0f, 1), "PROPERTIES");
        ImGui::Separator();

        // IMAGE SECTION OR CONTACT - Image Upload
        if (sec.type == SEC_IMAGE || sec.type == SEC_CONTACT) {
            ImGui::Spacing();
            if (sec.type == SEC_IMAGE) {
                ImGui::TextColored(ImVec4(0.3f, 0.8f, 0.9f, 1), "IMAGE PROPERTIES");
            } else {
                ImGui::TextColored(ImVec4(0.3f, 0.8f, 0.9f, 1), "CONTACT IMAGE");
                ImGui::TextColored(ImVec4(0.6f, 0.6f, 0.6f, 1), "(Shows in split layout)");
            }
            ImGui::Separator();

            // Upload image button
            if (ImGui::Button("Upload Image", ImVec2(-1, 35))) {
                std::string path = OpenFileDialog("Select image file");
                if (!path.empty()) {
                    sec.section_image = path;
                    ImageTexture imgTex = LoadTexture(path);
                    sec.img_texture_id = imgTex.id;
                    // Auto-adjust height based on image aspect ratio (only for image sections)
                    if (imgTex.loaded && sec.type == SEC_IMAGE) {
                        float aspect = (float)imgTex.height / (float)imgTex.width;
                        sec.height = 400 * aspect;  // Base width of 400
                    }
                }
            }

            if (!sec.section_image.empty()) {
                ImGui::TextWrapped("Current: %s", sec.section_image.c_str());

                if (sec.type == SEC_IMAGE) {
                    ImGui::Spacing();
                    ImGui::Text("Image Height:");
                    ImGui::SetNextItemWidth(200);
                    ImGui::SliderFloat("##ImgH", &sec.height, 50.0f, 800.0f, "%.0fpx");
                }

                if (ImGui::Button("Remove Image", ImVec2(-1, 25))) {
                    sec.section_image = "";
                    sec.img_texture_id = 0;
                    if (sec.type == SEC_IMAGE) {
                        sec.height = 300;
                    }
                }
            } else {
                if (sec.type == SEC_CONTACT) {
                    ImGui::TextColored(ImVec4(0.7f, 0.7f, 0.0f, 1), "No image uploaded (optional)");
                } else {
                    ImGui::TextColored(ImVec4(0.7f, 0.7f, 0.0f, 1), "No image uploaded yet");
                }
            }

            // Width and Alignment Controls
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "WIDTH & POSITION");
            ImGui::Separator();

            ImGui::Text("Width:");
            ImGui::SetNextItemWidth(200);
            ImGui::SliderFloat("##ImgWidth", &sec.section_width_percent, 30.0f, 100.0f, "%.0f%%");
            if (ImGui::IsItemHovered()) {
                ImGui::SetTooltip("30%% = narrow, 50%% = half screen, 100%% = full width");
            }

            ImGui::Text("Horizontal Align:");
            const char* h_align_items[] = {"Left", "Center", "Right"};
            ImGui::Combo("##ImgHAlign", &sec.horizontal_align, h_align_items, 3);
            if (ImGui::IsItemHovered()) {
                ImGui::SetTooltip("Position: Left side, Center, or Right side");
            }

            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "You can drag this image section up/down to position it anywhere on the page!");
        }
        // TEXT BOX SECTION - Special Properties
        else if (sec.type == SEC_TEXTBOX) {
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.9f, 0.6f, 0.2f, 1), "TEXT BOX PROPERTIES");
            ImGui::Separator();

            // Text content inputs
            char tb[256], sb[256], cb[1024];
            strncpy(tb, sec.title.c_str(), sizeof(tb) - 1);
            tb[sizeof(tb) - 1] = '\0';
            strncpy(sb, sec.subtitle.c_str(), sizeof(sb) - 1);
            sb[sizeof(sb) - 1] = '\0';
            strncpy(cb, sec.content.c_str(), sizeof(cb) - 1);
            cb[sizeof(cb) - 1] = '\0';

            ImGui::Text("Title");
            if (ImGui::InputText("##T", tb, sizeof(tb))) sec.title = tb;

            ImGui::Text("Subtitle");
            if (ImGui::InputText("##S", sb, sizeof(sb))) sec.subtitle = sb;

            ImGui::Text("Content (Text)");
            if (ImGui::InputTextMultiline("##C", cb, sizeof(cb), ImVec2(-1, 100))) sec.content = cb;

            // Size controls
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "SIZE");
            ImGui::Separator();

            ImGui::Text("Height:");
            ImGui::SetNextItemWidth(200);
            ImGui::SliderFloat("##TBH", &sec.height, 100.0f, 800.0f, "%.0fpx");

            ImGui::Text("Padding:");
            ImGui::SetNextItemWidth(200);
            ImGui::SliderFloat("##TBP", &sec.padding, 10.0f, 100.0f, "%.0fpx");

            // Text alignment
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "ALIGNMENT");
            ImGui::Separator();

            const char* align_items[] = {"Left", "Center", "Right"};
            ImGui::Combo("Text Align", &sec.text_align, align_items, 3);

            // Colors
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "COLORS");
            ImGui::Separator();

            ImGui::Text("Background:");
            ImGui::ColorEdit4("##TBBg", (float*)&sec.bg_color, ImGuiColorEditFlags_NoInputs);

            ImGui::Text("Title Color:");
            ImGui::ColorEdit4("##TBTitleC", (float*)&sec.title_color, ImGuiColorEditFlags_NoInputs);

            ImGui::Text("Subtitle Color:");
            ImGui::ColorEdit4("##TBSubC", (float*)&sec.subtitle_color, ImGuiColorEditFlags_NoInputs);

            ImGui::Text("Content Color:");
            ImGui::ColorEdit4("##TBContC", (float*)&sec.content_color, ImGuiColorEditFlags_NoInputs);

            // Typography
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "TYPOGRAPHY");
            ImGui::Separator();

            ImGui::Text("Title Font Size:");
            ImGui::SetNextItemWidth(150);
            ImGui::SliderFloat("##TBTitleFS", &sec.title_font_size, 16.0f, 64.0f, "%.0fpx");

            ImGui::Text("Subtitle Font Size:");
            ImGui::SetNextItemWidth(150);
            ImGui::SliderFloat("##TBSubFS", &sec.subtitle_font_size, 12.0f, 32.0f, "%.0fpx");

            ImGui::Text("Content Font Size:");
            ImGui::SetNextItemWidth(150);
            ImGui::SliderFloat("##TBContFS", &sec.content_font_size, 10.0f, 24.0f, "%.0fpx");

            // Width and Alignment Controls
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "WIDTH & POSITION");
            ImGui::Separator();

            ImGui::Text("Width:");
            ImGui::SetNextItemWidth(200);
            ImGui::SliderFloat("##TBWidth", &sec.section_width_percent, 30.0f, 100.0f, "%.0f%%");
            if (ImGui::IsItemHovered()) {
                ImGui::SetTooltip("30%% = narrow, 50%% = half screen, 100%% = full width");
            }

            ImGui::Text("Horizontal Align:");
            const char* h_align_items_tb[] = {"Left", "Center", "Right"};
            ImGui::Combo("##TBHAlign", &sec.horizontal_align, h_align_items_tb, 3);
            if (ImGui::IsItemHovered()) {
                ImGui::SetTooltip("Position: Left side, Center, or Right side");
            }

            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "You can drag this text box section up/down to position it anywhere!");
        }
        // Regular section content
        else {
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "CONTENT");
            ImGui::Separator();

            char tb[256], sb[256], cb[512];
            strncpy(tb, sec.title.c_str(), sizeof(tb) - 1);
            tb[sizeof(tb) - 1] = '\0';
            strncpy(sb, sec.subtitle.c_str(), sizeof(sb) - 1);
            sb[sizeof(sb) - 1] = '\0';
            strncpy(cb, sec.content.c_str(), sizeof(cb) - 1);
            cb[sizeof(cb) - 1] = '\0';
            ImGui::Text("Title");
            if (ImGui::InputText("##T", tb, sizeof(tb))) sec.title = tb;
            ImGui::Text("Subtitle");
            if (ImGui::InputText("##S", sb, sizeof(sb))) sec.subtitle = sb;
            if (sec.type == SEC_ABOUT || sec.type == SEC_FOOTER) {
                ImGui::Text("Content");
                if (ImGui::InputTextMultiline("##C", cb, sizeof(cb), ImVec2(-1, 50))) sec.content = cb;
            }
        }

        // Button
        if (sec.type == SEC_HERO || sec.type == SEC_CTA || sec.type == SEC_CONTACT) {
            char btb[128];
            strncpy(btb, sec.button_text.c_str(), sizeof(btb) - 1);
            btb[sizeof(btb) - 1] = '\0';
            ImGui::Text("Button Text");
            if (ImGui::InputText("##BT", btb, sizeof(btb))) sec.button_text = btb;
            ImGui::Text("Button Colors");
            ImGui::ColorEdit4("BG##BB", (float*)&sec.button_bg_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);
            ImGui::SameLine();
            ImGui::ColorEdit4("Text##BT", (float*)&sec.button_text_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);

            // Glass button option
            ImGui::Checkbox("Glass Button##GBT", &sec.button_glass_effect);
            if (sec.button_glass_effect) {
                ImGui::SameLine();
                ImGui::SetNextItemWidth(60);
                ImGui::SliderFloat("##GBO", &sec.button_glass_opacity, 0.1f, 0.6f, "%.2f");
                if (ImGui::IsItemHovered()) ImGui::SetTooltip("Glass Opacity");
                ImGui::SameLine();
                ImGui::ColorEdit4("##GBTint", (float*)&sec.button_glass_tint, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);
                if (ImGui::IsItemHovered()) ImGui::SetTooltip("Glass Tint");
            }
        }

        // Contact Form Size Controls
        if (sec.type == SEC_CONTACT) {
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "CONTACT FORM SIZES");
            ImGui::Separator();

            ImGui::Text("Input Width:");
            ImGui::SetNextItemWidth(200);
            ImGui::SliderFloat("##CIW", &sec.contact_input_width, 50.0f, 100.0f, "%.0f%%");

            ImGui::Text("Input Height:");
            ImGui::SetNextItemWidth(200);
            ImGui::SliderFloat("##CIH", &sec.contact_input_height, 20.0f, 60.0f, "%.0fpx");

            ImGui::Text("Button Width:");
            ImGui::SetNextItemWidth(200);
            ImGui::SliderFloat("##CBW", &sec.contact_button_width, 30.0f, 100.0f, "%.0f%%");

            ImGui::Text("Button Height:");
            ImGui::SetNextItemWidth(200);
            ImGui::SliderFloat("##CBH", &sec.contact_button_height, 25.0f, 60.0f, "%.0fpx");

            ImGui::Text("Field Spacing:");
            ImGui::SetNextItemWidth(200);
            ImGui::SliderFloat("##CFS", &sec.contact_field_spacing, 20.0f, 60.0f, "%.0fpx");
        }

        // Navigation
        if (sec.type == SEC_NAVBAR) {
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "NAVIGATION");
            ImGui::Separator();
            ImGui::Text("Nav Background & Text");
            ImGui::ColorEdit4("NavBG", (float*)&sec.nav_bg_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);
            ImGui::SameLine();
            ImGui::ColorEdit4("NavTxt", (float*)&sec.nav_text_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);

            // Logo Upload Section
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.3f, 0.8f, 0.9f, 1), "LOGO");
            ImGui::Separator();

            if (ImGui::Button("Upload Logo Image", ImVec2(-1, 35))) {
                std::string path = OpenFileDialog("Select logo image");
                if (!path.empty()) {
                    sec.logo_path = path;
                    ImageTexture imgTex = LoadTexture(path);
                    sec.logo_texture_id = imgTex.id;
                }
            }

            if (!sec.logo_path.empty()) {
                ImGui::TextColored(ImVec4(0.3f, 0.9f, 0.3f, 1), "✓ Logo loaded");
                if (ImGui::Button("Remove Logo", ImVec2(-1, 25))) {
                    sec.logo_path = "";
                    sec.logo_texture_id = 0;
                }
            }

            ImGui::Text("Logo Size:");
            ImGui::SetNextItemWidth(200);
            ImGui::SliderFloat("##LogoSize", &sec.logo_size, 30.0f, 150.0f, "%.0fpx");

            ImGui::Text("Brand Text Position:");
            const char* positions[] = { "Side (Next to Logo)", "Above Logo", "Below Logo" };
            ImGui::SetNextItemWidth(200);
            ImGui::Combo("##BrandPos", &sec.brand_text_position, positions, 3);

            ImGui::Spacing();
            ImGui::Separator();
            ImGui::Text("Menu Items");
            for (int i = 0; i < (int)sec.nav_items.size(); i++) {
                ImGui::PushID(i);

                // Label and color
                char lb[64];
                strncpy(lb, sec.nav_items[i].label.c_str(), sizeof(lb) - 1);
                lb[sizeof(lb) - 1] = '\0';
                ImGui::SetNextItemWidth(100);
                if (ImGui::InputText("##L", lb, sizeof(lb))) sec.nav_items[i].label = lb;
                ImGui::SameLine();
                ImGui::ColorEdit4("##NC", (float*)&sec.nav_items[i].text_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);
                ImGui::SameLine();
                if (ImGui::Button("X", ImVec2(20, 0))) {
                    sec.nav_items.erase(sec.nav_items.begin() + i);
                    i--;
                    ImGui::PopID();
                    continue;
                }

                // Font Size Control
                ImGui::Text("  Size:");
                ImGui::SameLine();
                ImGui::SetNextItemWidth(120);
                ImGui::SliderFloat("##NFS", &sec.nav_items[i].font_size, 10, 60, "%.0fpx");

                // Font Weight Control
                ImGui::Text("  Weight:");
                ImGui::SameLine();
                ImGui::SetNextItemWidth(120);
                ImGui::SliderFloat("##NFW", &sec.nav_items[i].font_weight, 100, 1200, "%.0f");
                ImGui::SameLine();
                if (ImGui::Button("L##NL", ImVec2(20, 0))) sec.nav_items[i].font_weight = 300;
                ImGui::SameLine();
                if (ImGui::Button("N##NN", ImVec2(20, 0))) sec.nav_items[i].font_weight = 400;
                ImGui::SameLine();
                if (ImGui::Button("B##NB", ImVec2(20, 0))) sec.nav_items[i].font_weight = 700;
                ImGui::SameLine();
                if (ImGui::Button("U##NU", ImVec2(20, 0))) sec.nav_items[i].font_weight = 1100;

                ImGui::Separator();
                ImGui::PopID();
            }
            if (ImGui::Button("+ Add Menu Item", ImVec2(-1, 24))) {
                sec.nav_items.push_back({"Link", "#", "", "", sec.nav_text_color, sec.nav_font_size, sec.nav_font_weight});
            }
        }

        // Typography
        ImGui::Spacing();
        ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "TYPOGRAPHY");
        ImGui::Separator();

        // Title typography
        ImGui::Text("Title");
        ImGui::ColorEdit4("##TC", (float*)&sec.title_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);

        // Font Size Control
        ImGui::Text("  Font Size:");
        ImGui::SetNextItemWidth(200);
        if (ImGui::SliderFloat("##TFS", &sec.title_font_size, 12, 150, "%.0f px")) {
            // Real-time update - no action needed, already updating sec.title_font_size
        }
        ImGui::SameLine();
        ImGui::SetNextItemWidth(50);
        ImGui::InputFloat("##TFSI", &sec.title_font_size, 0, 0, "%.0f");
        if (sec.title_font_size < 12) sec.title_font_size = 12;
        if (sec.title_font_size > 150) sec.title_font_size = 150;

        // Font Weight Control
        ImGui::Text("  Font Weight:");
        ImGui::SetNextItemWidth(200);
        if (ImGui::SliderFloat("##TFW", &sec.title_font_weight, 100, 1200, "%.0f")) {
            // Real-time update
        }
        ImGui::SameLine();
        ImGui::SetNextItemWidth(50);
        ImGui::InputFloat("##TFWI", &sec.title_font_weight, 0, 0, "%.0f");
        if (sec.title_font_weight < 100) sec.title_font_weight = 100;
        if (sec.title_font_weight > 1200) sec.title_font_weight = 1200;

        // Weight Presets
        ImGui::Text("  Quick:");
        ImGui::SameLine();
        if (ImGui::Button("Light##TL", ImVec2(45, 0))) sec.title_font_weight = 300;
        ImGui::SameLine();
        if (ImGui::Button("Normal##TN", ImVec2(50, 0))) sec.title_font_weight = 400;
        ImGui::SameLine();
        if (ImGui::Button("Bold##TB", ImVec2(40, 0))) sec.title_font_weight = 700;
        ImGui::SameLine();
        if (ImGui::Button("Black##TBL", ImVec2(45, 0))) sec.title_font_weight = 900;
        ImGui::SameLine();
        if (ImGui::Button("Ultra##TU", ImVec2(40, 0))) sec.title_font_weight = 1100;

        // Live Preview
        ImGui::Spacing();
        ImGui::PushStyleColor(ImGuiCol_ChildBg, ImVec4(0.15f, 0.15f, 0.15f, 1.0f));
        ImGui::BeginChild("##TitlePreview", ImVec2(0, 50), true);
        ImGui::PushStyleColor(ImGuiCol_Text, sec.title_color);
        // Scale font for preview (ImGui doesn't support custom font sizes easily, so show as text)
        std::string preview = sec.title.empty() ? "Title Preview" : sec.title;
        ImGui::SetCursorPosY(15);
        ImGui::TextWrapped("%s", preview.c_str());
        char info[64];
        snprintf(info, sizeof(info), "%.0fpx, Weight: %.0f", sec.title_font_size, sec.title_font_weight);
        ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.6f, 0.6f, 0.6f, 1.0f));
        ImGui::TextWrapped("%s", info);
        ImGui::PopStyleColor();
        ImGui::PopStyleColor();
        ImGui::EndChild();
        ImGui::PopStyleColor();
        ImGui::Spacing();

        // Subtitle typography
        ImGui::Text("Subtitle");
        ImGui::ColorEdit4("##SC", (float*)&sec.subtitle_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);

        // Font Size Control
        ImGui::Text("  Font Size:");
        ImGui::SetNextItemWidth(200);
        ImGui::SliderFloat("##SFS", &sec.subtitle_font_size, 10, 100, "%.0f px");
        ImGui::SameLine();
        ImGui::SetNextItemWidth(50);
        ImGui::InputFloat("##SFSI", &sec.subtitle_font_size, 0, 0, "%.0f");
        if (sec.subtitle_font_size < 10) sec.subtitle_font_size = 10;
        if (sec.subtitle_font_size > 100) sec.subtitle_font_size = 100;

        // Font Weight Control
        ImGui::Text("  Font Weight:");
        ImGui::SetNextItemWidth(200);
        ImGui::SliderFloat("##SFW", &sec.subtitle_font_weight, 100, 1200, "%.0f");
        ImGui::SameLine();
        ImGui::SetNextItemWidth(50);
        ImGui::InputFloat("##SFWI", &sec.subtitle_font_weight, 0, 0, "%.0f");
        if (sec.subtitle_font_weight < 100) sec.subtitle_font_weight = 100;
        if (sec.subtitle_font_weight > 1200) sec.subtitle_font_weight = 1200;

        // Weight Presets
        ImGui::Text("  Quick:");
        ImGui::SameLine();
        if (ImGui::Button("Light##SL", ImVec2(45, 0))) sec.subtitle_font_weight = 300;
        ImGui::SameLine();
        if (ImGui::Button("Normal##SN", ImVec2(50, 0))) sec.subtitle_font_weight = 400;
        ImGui::SameLine();
        if (ImGui::Button("Bold##SB", ImVec2(40, 0))) sec.subtitle_font_weight = 700;
        ImGui::SameLine();
        if (ImGui::Button("Black##SBL", ImVec2(45, 0))) sec.subtitle_font_weight = 900;
        ImGui::SameLine();
        if (ImGui::Button("Ultra##SU", ImVec2(40, 0))) sec.subtitle_font_weight = 1100;

        // Live Preview
        ImGui::Spacing();
        ImGui::PushStyleColor(ImGuiCol_ChildBg, ImVec4(0.15f, 0.15f, 0.15f, 1.0f));
        ImGui::BeginChild("##SubtitlePreview", ImVec2(0, 45), true);
        ImGui::PushStyleColor(ImGuiCol_Text, sec.subtitle_color);
        std::string preview_sub = sec.subtitle.empty() ? "Subtitle Preview" : sec.subtitle;
        ImGui::SetCursorPosY(10);
        ImGui::TextWrapped("%s", preview_sub.c_str());
        char info_sub[64];
        snprintf(info_sub, sizeof(info_sub), "%.0fpx, Weight: %.0f", sec.subtitle_font_size, sec.subtitle_font_weight);
        ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(0.6f, 0.6f, 0.6f, 1.0f));
        ImGui::TextWrapped("%s", info_sub);
        ImGui::PopStyleColor();
        ImGui::PopStyleColor();
        ImGui::EndChild();
        ImGui::PopStyleColor();
        ImGui::Spacing();

        // Content typography with enhanced controls
        ImGui::Text("Content");
        ImGui::ColorEdit4("##CC", (float*)&sec.content_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);

        // Font Size Control
        ImGui::Text("  Font Size:");
        ImGui::SetNextItemWidth(200);
        if (ImGui::SliderFloat("##CFS", &sec.content_font_size, 10, 80, "%.0f px")) {
            // Real-time update - no action needed
        }
        ImGui::SameLine();
        ImGui::SetNextItemWidth(50);
        ImGui::InputFloat("##CFSI", &sec.content_font_size, 0, 0, "%.0f");
        if (sec.content_font_size < 10) sec.content_font_size = 10;
        if (sec.content_font_size > 80) sec.content_font_size = 80;

        // Font Weight Control
        ImGui::Text("  Font Weight:");
        ImGui::SetNextItemWidth(200);
        if (ImGui::SliderFloat("##CFW", &sec.content_font_weight, 100, 1200, "%.0f")) {
            // Real-time update
        }
        ImGui::SameLine();
        ImGui::SetNextItemWidth(50);
        ImGui::InputFloat("##CFWI", &sec.content_font_weight, 0, 0, "%.0f");
        if (sec.content_font_weight < 100) sec.content_font_weight = 100;
        if (sec.content_font_weight > 1200) sec.content_font_weight = 1200;

        // Weight Presets
        ImGui::Text("  Presets:");
        ImGui::SameLine();
        if (ImGui::Button("Light##CL", ImVec2(45, 0))) sec.content_font_weight = 300;
        ImGui::SameLine();
        if (ImGui::Button("Normal##CN", ImVec2(50, 0))) sec.content_font_weight = 400;
        ImGui::SameLine();
        if (ImGui::Button("Bold##CB", ImVec2(40, 0))) sec.content_font_weight = 700;
        ImGui::SameLine();
        if (ImGui::Button("Black##CBL", ImVec2(45, 0))) sec.content_font_weight = 900;
        ImGui::SameLine();
        if (ImGui::Button("Ultra##CU", ImVec2(40, 0))) sec.content_font_weight = 1100;

        // Live Preview
        ImGui::PushStyleColor(ImGuiCol_ChildBg, ImVec4(0.15f, 0.15f, 0.15f, 1.0f));
        ImGui::BeginChild("##ContentPreview", ImVec2(0, 50), true);
        ImGui::PushStyleColor(ImGuiCol_Border, ImVec4(0.4f, 0.4f, 0.4f, 1.0f));
        ImGui::PushStyleColor(ImGuiCol_Text, sec.content_color);
        std::string contentPreview = sec.content.empty() ? "Content Preview" : sec.content;
        ImGui::TextWrapped("%s", contentPreview.c_str());
        char contentInfo[64];
        snprintf(contentInfo, sizeof(contentInfo), "%.0fpx, Weight: %.0f", sec.content_font_size, sec.content_font_weight);
        ImGui::TextWrapped("%s", contentInfo);
        ImGui::PopStyleColor();
        ImGui::PopStyleColor();
        ImGui::EndChild();
        ImGui::PopStyleColor();
        ImGui::Spacing();

        // Button typography (for sections with buttons) - enhanced controls
        if (sec.type == SEC_HERO || sec.type == SEC_CTA || sec.type == SEC_CONTACT) {
            ImGui::Text("Button");
            ImGui::ColorEdit4("##BTC", (float*)&sec.button_text_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);

            // Font Size Control
            ImGui::Text("  Font Size:");
            ImGui::SetNextItemWidth(200);
            if (ImGui::SliderFloat("##BFS", &sec.button_font_size, 10, 60, "%.0f px")) {
                // Real-time update - no action needed
            }
            ImGui::SameLine();
            ImGui::SetNextItemWidth(50);
            ImGui::InputFloat("##BFSI", &sec.button_font_size, 0, 0, "%.0f");
            if (sec.button_font_size < 10) sec.button_font_size = 10;
            if (sec.button_font_size > 60) sec.button_font_size = 60;

            // Font Weight Control
            ImGui::Text("  Font Weight:");
            ImGui::SetNextItemWidth(200);
            if (ImGui::SliderFloat("##BFW", &sec.button_font_weight, 100, 1200, "%.0f")) {
                // Real-time update
            }
            ImGui::SameLine();
            ImGui::SetNextItemWidth(50);
            ImGui::InputFloat("##BFWI", &sec.button_font_weight, 0, 0, "%.0f");
            if (sec.button_font_weight < 100) sec.button_font_weight = 100;
            if (sec.button_font_weight > 1200) sec.button_font_weight = 1200;

            // Weight Presets
            ImGui::Text("  Presets:");
            ImGui::SameLine();
            if (ImGui::Button("Light##BL", ImVec2(45, 0))) sec.button_font_weight = 300;
            ImGui::SameLine();
            if (ImGui::Button("Normal##BN", ImVec2(50, 0))) sec.button_font_weight = 400;
            ImGui::SameLine();
            if (ImGui::Button("Bold##BB", ImVec2(40, 0))) sec.button_font_weight = 700;
            ImGui::SameLine();
            if (ImGui::Button("Black##BBL", ImVec2(45, 0))) sec.button_font_weight = 900;
            ImGui::SameLine();
            if (ImGui::Button("Ultra##BU", ImVec2(40, 0))) sec.button_font_weight = 1100;

            // Live Preview
            ImGui::PushStyleColor(ImGuiCol_ChildBg, ImVec4(0.15f, 0.15f, 0.15f, 1.0f));
            ImGui::BeginChild("##ButtonPreview", ImVec2(0, 50), true);
            ImGui::PushStyleColor(ImGuiCol_Border, ImVec4(0.4f, 0.4f, 0.4f, 1.0f));
            ImGui::PushStyleColor(ImGuiCol_Text, sec.button_text_color);
            std::string buttonPreview = sec.button_text.empty() ? "Button Preview" : sec.button_text;
            ImGui::TextWrapped("%s", buttonPreview.c_str());
            char buttonInfo[64];
            snprintf(buttonInfo, sizeof(buttonInfo), "%.0fpx, Weight: %.0f", sec.button_font_size, sec.button_font_weight);
            ImGui::TextWrapped("%s", buttonInfo);
            ImGui::PopStyleColor();
            ImGui::PopStyleColor();
            ImGui::EndChild();
            ImGui::PopStyleColor();
            ImGui::Spacing();
        }

        // Style
        ImGui::Spacing();
        ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "STYLE");
        ImGui::Separator();
        ImGui::Text("Background Color");
        ImGui::ColorEdit4("##BGC", (float*)&sec.bg_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);
        ImGui::Text("Height");
        ImGui::SliderFloat("##H", &sec.height, 80, 800);

        // UNIVERSAL WIDTH & POSITION CONTROLS (for ALL sections)
        ImGui::Spacing();
        ImGui::TextColored(ImVec4(0.3f, 0.8f, 0.3f, 1), "WIDTH & POSITION");
        ImGui::Separator();

        ImGui::Text("Width:");
        ImGui::SetNextItemWidth(200);
        ImGui::SliderFloat("##SecWidth", &sec.section_width_percent, 30.0f, 100.0f, "%.0f%%");
        if (ImGui::IsItemHovered()) {
            ImGui::SetTooltip("30%% = narrow, 50%% = half screen, 100%% = full width");
        }

        ImGui::Text("Horizontal Align:");
        const char* h_align_opts[] = {"Left", "Center", "Right"};
        ImGui::Combo("##SecHAlign", &sec.horizontal_align, h_align_opts, 3);
        if (ImGui::IsItemHovered()) {
            ImGui::SetTooltip("Position: Left side, Center, or Right side of canvas");
        }

        ImGui::Spacing();
        ImGui::Checkbox("Manual Y Position", &sec.use_manual_position);
        if (ImGui::IsItemHovered()) {
            ImGui::SetTooltip("Enable to place this section at a specific Y coordinate\n(allows side-by-side layouts)");
        }

        if (sec.use_manual_position) {
            ImGui::Text("Y Position:");
            ImGui::SetNextItemWidth(200);
            ImGui::DragFloat("##ManualY", &sec.y_position, 1.0f, 0.0f, 5000.0f, "%.0fpx");
            if (ImGui::IsItemHovered()) {
                ImGui::SetTooltip("Vertical position from top of page (0 = top)");
            }
            ImGui::TextColored(ImVec4(0.7f, 0.7f, 0.0f, 1), "Tip: Use same Y position for side-by-side sections!");
        }

        // Cards
        if ((sec.type == SEC_CARDS || sec.type == SEC_SERVICES || sec.type == SEC_FEATURES || sec.type == SEC_PRICING ||
             sec.type == SEC_TEAM || sec.type == SEC_TESTIMONIALS || sec.type == SEC_STATS)) {
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "CARD LAYOUT");
            ImGui::Separator();
            ImGui::Text("Card Size");
            ImGui::SetNextItemWidth(80);
            ImGui::DragFloat("Width##CW", &sec.card_width, 5, 150, 500, "%.0f");
            ImGui::SameLine();
            ImGui::SetNextItemWidth(80);
            ImGui::DragFloat("Height##CH", &sec.card_height, 5, 100, 500, "%.0f");
            ImGui::Text("Cards Per Row");
            ImGui::SetNextItemWidth(80);
            ImGui::DragInt("##CPR", &sec.cards_per_row, 1, 1, 6);

            ImGui::Spacing();
            ImGui::Text("Heading to Cards Spacing");
            ImGui::SetNextItemWidth(150);
            ImGui::SliderFloat("##HCSpacing", &sec.heading_to_cards_spacing, 10.0f, 150.0f, "%.0fpx");
            if (ImGui::IsItemHovered()) {
                ImGui::SetTooltip("Adjust space between section heading and cards\n10px = Very close\n40px = Normal (default)\n100px = Very spacious");
            }

            if (!sec.items.empty()) {
                ImGui::Spacing();
                ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "ITEMS (%d)", (int)sec.items.size());
                ImGui::Separator();
                int deleteIndex = -1;
                for (int i = 0; i < (int)sec.items.size(); i++) {
                    ImGui::PushID(i);
                    auto& it = sec.items[i];
                    char itb[128], idb[256];
                    strncpy(itb, it.title.c_str(), sizeof(itb) - 1);
                    itb[sizeof(itb) - 1] = '\0';
                    strncpy(idb, it.description.c_str(), sizeof(idb) - 1);
                    idb[sizeof(idb) - 1] = '\0';
                    ImGui::Text("Item %d", i + 1);
                    ImGui::SameLine(ImGui::GetContentRegionAvail().x - 25);
                    ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.7f, 0.2f, 0.2f, 1));
                    if (ImGui::Button("X##DEL", ImVec2(22, 18))) deleteIndex = i;
                    ImGui::PopStyleColor();
                    if (ImGui::InputText("##IT", itb, sizeof(itb))) it.title = itb;
                    if (ImGui::InputText("##ID", idb, sizeof(idb))) it.description = idb;
                    if (sec.type == SEC_PRICING) {
                        char pb[64];
                        strncpy(pb, it.price.c_str(), sizeof(pb) - 1);
                        pb[sizeof(pb) - 1] = '\0';
                        if (ImGui::InputText("##IP", pb, sizeof(pb))) it.price = pb;
                    }
                    ImGui::Text("Colors");
                    ImGui::ColorEdit4("BG##IB", (float*)&it.bg_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);
                    ImGui::SameLine();
                    ImGui::ColorEdit4("Title##ITC", (float*)&it.title_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);
                    ImGui::SameLine();
                    ImGui::ColorEdit4("Desc##IDC", (float*)&it.desc_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);

                    // Font controls for Title
                    ImGui::Text("Title Font:");
                    ImGui::SetNextItemWidth(100);
                    ImGui::SliderFloat("Size##TFS", &it.title_font_size, 10, 80, "%.0fpx");
                    ImGui::SameLine();
                    ImGui::SetNextItemWidth(100);
                    ImGui::SliderFloat("Weight##TFW", &it.title_font_weight, 100, 1200, "%.0f");
                    ImGui::SameLine();
                    if (ImGui::Button("L##TL", ImVec2(18, 0))) it.title_font_weight = 300;
                    ImGui::SameLine();
                    if (ImGui::Button("N##TN", ImVec2(18, 0))) it.title_font_weight = 400;
                    ImGui::SameLine();
                    if (ImGui::Button("B##TB", ImVec2(18, 0))) it.title_font_weight = 700;
                    ImGui::SameLine();
                    if (ImGui::Button("U##TU", ImVec2(18, 0))) it.title_font_weight = 1100;

                    // Font controls for Description
                    ImGui::Text("Desc Font:");
                    ImGui::SetNextItemWidth(100);
                    ImGui::SliderFloat("Size##DFS", &it.desc_font_size, 10, 60, "%.0fpx");
                    ImGui::SameLine();
                    ImGui::SetNextItemWidth(100);
                    ImGui::SliderFloat("Weight##DFW", &it.desc_font_weight, 100, 1200, "%.0f");
                    ImGui::SameLine();
                    if (ImGui::Button("L##DL", ImVec2(18, 0))) it.desc_font_weight = 300;
                    ImGui::SameLine();
                    if (ImGui::Button("N##DN", ImVec2(18, 0))) it.desc_font_weight = 400;
                    ImGui::SameLine();
                    if (ImGui::Button("B##DB", ImVec2(18, 0))) it.desc_font_weight = 700;
                    ImGui::SameLine();
                    if (ImGui::Button("U##DU", ImVec2(18, 0))) it.desc_font_weight = 1100;

                    // Glass Effect
                    ImGui::Checkbox("Glass Effect##IGE", &it.glass_effect);
                    if (it.glass_effect) {
                        // Opacity and Tint
                        ImGui::Text("Opacity");
                        ImGui::SameLine();
                        ImGui::SetNextItemWidth(70);
                        ImGui::SliderFloat("##IGO", &it.glass_opacity, 0.1f, 0.8f, "%.2f");
                        ImGui::SameLine();
                        ImGui::ColorEdit4("Tint##IGT", (float*)&it.glass_tint, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);

                        // Border radius and width
                        ImGui::Text("Border");
                        ImGui::SameLine();
                        ImGui::SetNextItemWidth(50);
                        ImGui::DragFloat("R##IGBR", &it.glass_border_radius, 0.5f, 0, 50, "%.0f");
                        if (ImGui::IsItemHovered()) ImGui::SetTooltip("Border Radius");
                        ImGui::SameLine();
                        ImGui::SetNextItemWidth(40);
                        ImGui::DragFloat("W##IGBW", &it.glass_border_width, 0.1f, 0, 5, "%.1f");
                        if (ImGui::IsItemHovered()) ImGui::SetTooltip("Border Width");
                        ImGui::SameLine();
                        ImGui::ColorEdit4("##IGBC", (float*)&it.glass_border_color, ImGuiColorEditFlags_NoInputs);
                        if (ImGui::IsItemHovered()) ImGui::SetTooltip("Border Color");

                        // Highlight/shine effect
                        ImGui::Checkbox("Highlight##IGH", &it.glass_highlight);
                        if (it.glass_highlight) {
                            ImGui::SameLine();
                            ImGui::SetNextItemWidth(60);
                            ImGui::SliderFloat("##IGHO", &it.glass_highlight_opacity, 0.1f, 0.6f, "%.2f");
                        }
                    }

                    // Modern Card Style Controls
                    ImGui::Spacing();
                    ImGui::TextColored(ImVec4(0.3f, 0.6f, 1.0f, 1), "MODERN CARD STYLE");
                    const char* card_styles[] = {"Classic", "Service (Icon + Bullets)", "Portfolio (Thumbnail + Tags)"};
                    ImGui::SetNextItemWidth(200);
                    ImGui::Combo("Style##CS", &it.card_style, card_styles, 3);

                    // Service Card Controls (card_style == 1)
                    if (it.card_style == 1) {
                        ImGui::Text("Icon:");
                        ImGui::SameLine();
                        ImGui::ColorEdit4("Color##IC", (float*)&it.icon_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);
                        ImGui::SameLine();
                        char icon_buf[32];
                        strncpy(icon_buf, it.icon_emoji.c_str(), sizeof(icon_buf) - 1);
                        icon_buf[sizeof(icon_buf) - 1] = '\0';
                        ImGui::SetNextItemWidth(80);
                        if (ImGui::InputText("Emoji##IE", icon_buf, sizeof(icon_buf))) it.icon_emoji = icon_buf;

                        // Quick icon buttons
                        ImGui::Text("Quick:");
                        ImGui::SameLine();
                        if (ImGui::Button("⚡##Q1", ImVec2(30, 0))) it.icon_emoji = "⚡";
                        ImGui::SameLine();
                        if (ImGui::Button("🌐##Q2", ImVec2(30, 0))) it.icon_emoji = "🌐";
                        ImGui::SameLine();
                        if (ImGui::Button("📱##Q3", ImVec2(30, 0))) it.icon_emoji = "📱";
                        ImGui::SameLine();
                        if (ImGui::Button("💼##Q4", ImVec2(30, 0))) it.icon_emoji = "💼";
                        ImGui::SameLine();
                        if (ImGui::Button("🚀##Q5", ImVec2(30, 0))) it.icon_emoji = "🚀";

                        // Bullet points editor
                        ImGui::Text("Bullet Points:");
                        if (it.bullet_points.size() < 3) {
                            it.bullet_points.resize(3, "");
                        }
                        for (int bp = 0; bp < 3; bp++) {
                            char bp_buf[128];
                            strncpy(bp_buf, it.bullet_points[bp].c_str(), sizeof(bp_buf) - 1);
                            bp_buf[sizeof(bp_buf) - 1] = '\0';
                            ImGui::PushID(bp);
                            ImGui::SetNextItemWidth(230);
                            if (ImGui::InputText("##BP", bp_buf, sizeof(bp_buf))) {
                                it.bullet_points[bp] = bp_buf;
                            }
                            ImGui::PopID();
                        }
                    }

                    // Portfolio Card Controls (card_style == 2)
                    if (it.card_style == 2) {
                        ImGui::Text("Category Badge:");
                        char badge_buf[64];
                        strncpy(badge_buf, it.category_badge.c_str(), sizeof(badge_buf) - 1);
                        badge_buf[sizeof(badge_buf) - 1] = '\0';
                        ImGui::SetNextItemWidth(200);
                        if (ImGui::InputText("##CB", badge_buf, sizeof(badge_buf))) {
                            it.category_badge = badge_buf;
                        }

                        // Tech tags editor
                        ImGui::Text("Tech Tags:");
                        if (it.tech_tags.size() < 3) {
                            it.tech_tags.resize(3, "");
                        }
                        for (int tt = 0; tt < 3; tt++) {
                            char tt_buf[64];
                            strncpy(tt_buf, it.tech_tags[tt].c_str(), sizeof(tt_buf) - 1);
                            tt_buf[sizeof(tt_buf) - 1] = '\0';
                            ImGui::PushID(100 + tt);
                            ImGui::SetNextItemWidth(150);
                            if (ImGui::InputText("##TT", tt_buf, sizeof(tt_buf))) {
                                it.tech_tags[tt] = tt_buf;
                            }
                            ImGui::PopID();
                        }
                    }

                    // Animation controls (for all modern cards)
                    if (it.card_style > 0) {
                        ImGui::Text("Animation:");
                        const char* anim_dirs[] = {"None", "Left to Right", "Right to Left"};
                        ImGui::SetNextItemWidth(150);
                        ImGui::Combo("Direction##AD", &it.anim_direction, anim_dirs, 3);
                        ImGui::SameLine();
                        ImGui::SetNextItemWidth(60);
                        ImGui::SliderFloat("Delay##ADL", &it.anim_delay, 0.0f, 1.0f, "%.2fs");

                        // Reset animation button
                        if (ImGui::Button("Reset Animation##RA", ImVec2(120, 0))) {
                            it.anim_progress = 0.0f;
                        }
                    }

                    ImGui::Separator();
                    ImGui::PopID();
                }
                if (deleteIndex >= 0 && sec.items.size() > 1) sec.items.erase(sec.items.begin() + deleteIndex);
            }
            ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.2f, 0.5f, 0.3f, 1));
            if (ImGui::Button("+ Add Card", ImVec2(-1, 26))) {
                sec.items.push_back({"New Card", "Description", "", "", "",
                    ImVec4(1,1,1,1), ImVec4(0.1f,0.1f,0.1f,1), ImVec4(0.4f,0.4f,0.4f,1), 20, 14, 600, 400, 0, 0, 0,
                    false, 0.25f, 10.0f, ImVec4(0.1f,0.15f,0.25f,1),
                    15.0f, 1.5f, ImVec4(1,1,1,0.2f), true, 0.3f});
            }
            ImGui::PopStyleColor();
        }

        // Glass Panels section in right panel
        if (!sec.glass_panels.empty()) {
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "GLASS PANELS (%d)", (int)sec.glass_panels.size());
            ImGui::Separator();

            // Find selected glass panel
            int selectedGlassPanel = -1;
            for (int gpi = 0; gpi < (int)sec.glass_panels.size(); gpi++) {
                if (sec.glass_panels[gpi].selected) {
                    selectedGlassPanel = gpi;
                    break;
                }
            }

            if (selectedGlassPanel >= 0) {
                WebSection::GlassPanel& gp = sec.glass_panels[selectedGlassPanel];
                ImGui::Text("Panel %d Settings", selectedGlassPanel + 1);

                // Text content
                char gpText[256];
                strncpy(gpText, gp.text.c_str(), sizeof(gpText) - 1);
                gpText[sizeof(gpText) - 1] = '\0';
                ImGui::Text("Text");
                if (ImGui::InputTextMultiline("##GPT", gpText, sizeof(gpText), ImVec2(-1, 60))) gp.text = gpText;

                // Position
                ImGui::Text("Position (X, Y)");
                ImGui::SetNextItemWidth(70);
                ImGui::DragFloat("##GPX", &gp.x, 1, 0, 1000, "%.0f");
                ImGui::SameLine();
                ImGui::SetNextItemWidth(70);
                ImGui::DragFloat("##GPY", &gp.y, 1, 0, 1000, "%.0f");

                // Size
                ImGui::Text("Size (W, H)");
                ImGui::SetNextItemWidth(70);
                ImGui::DragFloat("##GPW", &gp.width, 1, 50, 800, "%.0f");
                ImGui::SameLine();
                ImGui::SetNextItemWidth(70);
                ImGui::DragFloat("##GPH", &gp.height, 1, 30, 500, "%.0f");

                // Glass settings
                ImGui::Text("Glass Opacity");
                ImGui::SliderFloat("##GPO", &gp.opacity, 0.1f, 0.8f, "%.2f");

                ImGui::Text("Glass Tint");
                ImGui::ColorEdit4("##GPTint", (float*)&gp.tint, ImGuiColorEditFlags_NoInputs);

                ImGui::Text("Border Radius");
                ImGui::SliderFloat("##GPBR", &gp.border_radius, 0, 32, "%.0fpx");

                // Text settings
                ImGui::Text("Text Size & Color");
                ImGui::SetNextItemWidth(60);
                ImGui::DragFloat("##GPTS", &gp.text_size, 1, 10, 48, "%.0fpx");
                ImGui::SameLine();
                ImGui::ColorEdit4("##GPTC", (float*)&gp.text_color, ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoAlpha);
            } else {
                ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 0.7f), "Select a panel from left");
            }
        }

        // ========================================================================
        // IMAGES SECTION
        // ========================================================================
        ImGui::Spacing();
        ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "IMAGES");
        ImGui::Separator();

        // Background image upload - Available for all sections EXCEPT Hero and CTA
        // (Hero/CTA use animation images instead)
        if (sec.type != SEC_HERO && sec.type != SEC_CTA) {
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "BACKGROUND IMAGE");
            ImGui::Separator();
            if (ImGui::Button("Upload Background Image", ImVec2(-1, 25))) {
                std::string path = OpenFileDialog("Select background image (JPG, PNG, etc.)");
                if (!path.empty()) {
                    sec.background_image = path;
                    ImageTexture bgTex = LoadTexture(path);
                    sec.bg_texture_id = bgTex.id;
                    sec.use_bg_image = true;
                }
            }
            if (sec.use_bg_image && !sec.background_image.empty()) {
                ImGui::TextWrapped("Image: %s", sec.background_image.c_str());
                ImGui::Checkbox("Show Background", &sec.use_bg_image);
                if (sec.use_bg_image) {
                    ImGui::Text("Overlay Opacity:");
                    ImGui::SliderFloat("##BGOverlay", &sec.bg_overlay_opacity, 0.0f, 1.0f, "%.2f");
                    if (ImGui::IsItemHovered()) {
                        ImGui::SetTooltip("Add dark overlay on background (0=transparent, 1=dark)");
                    }
                }
                if (ImGui::Button("Remove Background", ImVec2(-1, 20))) {
                    sec.background_image = "";
                    sec.bg_texture_id = 0;
                    sec.use_bg_image = false;
                }
            }
        }

        // Hero Animation Images (for Hero and CTA sections only)
        if (sec.type == SEC_HERO || sec.type == SEC_CTA) {
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.8f, 0.5f, 1), "HERO ANIMATION (Slideshow)");
            ImGui::Separator();

            ImGui::Checkbox("Enable Hero Animation", &sec.enable_hero_animation);

            if (sec.enable_hero_animation) {
                ImGui::Text("Animation Speed (seconds per image):");
                ImGui::SetNextItemWidth(200);
                ImGui::SliderFloat("##AnimSpeed", &sec.hero_animation_speed, 1.0f, 10.0f, "%.1fs");

                ImGui::Spacing();
                ImGui::Text("Animation Images (%d images)", (int)sec.hero_animation_images.size());

                if (ImGui::Button("Add Images to Animation", ImVec2(-1, 30))) {
                    std::vector<std::string> paths = OpenMultipleFilesDialog();
                    for (const auto& path : paths) {
                        sec.hero_animation_images.push_back(path);
                        ImageTexture tex = LoadTexture(path);
                        sec.hero_animation_texture_ids.push_back(tex.id);
                    }
                    // Reset animation when images are added
                    sec.current_animation_frame = 0;
                    sec.animation_timer = 0.0f;
                }

                if (!sec.hero_animation_images.empty()) {
                    ImGui::Spacing();
                    ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "Manage Animation Images:");

                    for (int i = 0; i < (int)sec.hero_animation_images.size(); i++) {
                        ImGui::PushID(i);
                        ImGui::BulletText("Image %d", i + 1);
                        ImGui::SameLine(ImGui::GetContentRegionAvail().x - 25);
                        ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.8f, 0.3f, 0.3f, 1));
                        if (ImGui::Button("X", ImVec2(22, 18))) {
                            sec.hero_animation_images.erase(sec.hero_animation_images.begin() + i);
                            if (i < (int)sec.hero_animation_texture_ids.size()) {
                                sec.hero_animation_texture_ids.erase(sec.hero_animation_texture_ids.begin() + i);
                            }
                            i--;
                            // Reset animation frame if needed
                            if (sec.current_animation_frame >= (int)sec.hero_animation_images.size()) {
                                sec.current_animation_frame = 0;
                            }
                        }
                        ImGui::PopStyleColor();
                        ImGui::PopID();
                    }

                    ImGui::Spacing();
                    ImGui::TextColored(ImVec4(0.7f, 0.7f, 0.7f, 1), "Tip: You can add 4, 6, 8, or any number of images!");
                }
            }
        }

        // Gallery images upload (for Gallery section)
        if (sec.type == SEC_GALLERY) {
            ImGui::Spacing();
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "GALLERY CONTROLS");
            ImGui::Separator();

            // Image Size Controls (always visible)
            ImGui::Text("Image Box Size");
            ImGui::SliderFloat("Width", &sec.card_width, 200.0f, 1200.0f, "%.0fpx");
            ImGui::SliderFloat("Height", &sec.card_height, 200.0f, 1200.0f, "%.0fpx");
            ImGui::SliderFloat("Spacing", &sec.card_spacing, 10.0f, 80.0f, "%.0fpx");

            ImGui::Spacing();
            ImGui::Text("Gallery Images (%d)", (int)sec.gallery_images.size());
            if (ImGui::Button("Add Images to Gallery", ImVec2(-1, 25))) {
                std::vector<std::string> paths = OpenMultipleFilesDialog();
                for (const auto& path : paths) {
                    sec.gallery_images.push_back(path);
                    ImageTexture tex = LoadTexture(path);
                    sec.gallery_texture_ids.push_back(tex.id);
                }
            }
            if (!sec.gallery_images.empty()) {
                ImGui::Spacing();
                ImGui::Text("Gallery Layout");
                ImGui::SliderInt("Columns", &sec.gallery_columns, 1, 6);
                ImGui::SliderFloat("Gallery Spacing", &sec.gallery_spacing, 5.0f, 50.0f, "%.0fpx");
                ImGui::Checkbox("Lightbox Effect", &sec.gallery_lightbox);

                ImGui::Spacing();
                ImGui::Text("Manage Images:");
                for (int i = 0; i < (int)sec.gallery_images.size(); i++) {
                    ImGui::PushID(i);
                    ImGui::BulletText("Image %d", i + 1);
                    ImGui::SameLine(ImGui::GetContentRegionAvail().x - 25);
                    ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.7f, 0.2f, 0.2f, 1));
                    if (ImGui::Button("X", ImVec2(22, 18))) {
                        sec.gallery_images.erase(sec.gallery_images.begin() + i);
                        if (i < (int)sec.gallery_texture_ids.size()) {
                            sec.gallery_texture_ids.erase(sec.gallery_texture_ids.begin() + i);
                        }
                        i--;
                    }
                    ImGui::PopStyleColor();
                    ImGui::PopID();
                }
            }
        }

        // Section image (for other sections)
        if (sec.type != SEC_HERO && sec.type != SEC_CTA && sec.type != SEC_GALLERY) {
            ImGui::Text("Section Image");
            if (ImGui::Button("Upload Section Image", ImVec2(-1, 25))) {
                std::string path = OpenFileDialog("Select section image");
                if (!path.empty()) {
                    sec.section_image = path;
                    ImageTexture imgTex = LoadTexture(path);
                    sec.img_texture_id = imgTex.id;
                }
            }
            if (!sec.section_image.empty()) {
                ImGui::TextWrapped("Current: %s", sec.section_image.c_str());
                if (ImGui::Button("Remove Image", ImVec2(-1, 20))) {
                    sec.section_image = "";
                    sec.img_texture_id = 0;
                }
            }
        }

        // ========================================================================
        // MOVEABLE IMAGES SECTION - REMOVED PER USER REQUEST
        // ========================================================================
        // (Feature hidden from UI but data structure preserved for backward compatibility)

        // ========================================================================
        // ANIMATION SECTION
        // ========================================================================
        ImGui::Spacing();
        ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "ANIMATION");
        ImGui::Separator();

        ImGui::Text("Animation Type");
        int anim_idx = (int)sec.animation_type;
        if (ImGui::Combo("##AnimType", &anim_idx, g_AnimationNames, IM_ARRAYSIZE(g_AnimationNames))) {
            sec.animation_type = (AnimationType)anim_idx;
        }

        if (sec.animation_type != ANIM_NONE) {
            ImGui::TextColored(ImVec4(0.3f, 0.8f, 0.3f, 1), "✓ Animation Active");
            ImGui::Spacing();

            // Different UI for carousel vs. other animations
            if (sec.animation_type == ANIM_CAROUSEL) {
                ImGui::Text("Scroll Speed");
                ImGui::SliderFloat("##AnimDur", &sec.animation_duration, 1.0f, 20.0f, "%.1fs");
                if (ImGui::IsItemHovered()) {
                    ImGui::SetTooltip("Time for complete scroll cycle\n1s = very fast, 20s = very slow");
                }

                ImGui::Spacing();
                ImGui::TextColored(ImVec4(0.8f, 0.8f, 0.3f, 1), "ℹ Carousel Mode:");
                ImGui::Text("  • All cards scroll together");
                ImGui::Text("  • Right to left continuously");
                ImGui::Text("  • Seamless infinite loop");
                if (sec.items.size() > 0) {
                    ImGui::Text("  • %d cards in carousel", (int)sec.items.size());
                }
            } else {
                ImGui::Text("Card Animation Duration");
                ImGui::SliderFloat("##AnimDur", &sec.animation_duration, 0.1f, 30.0f, "%.1fs");
                if (ImGui::IsItemHovered()) {
                    ImGui::SetTooltip("How long each card takes to animate\n0.1s = very fast, 30s = very slow");
                }

                ImGui::Text("Stagger Delay (between cards)");
                ImGui::SliderFloat("##StaggerDelay", &sec.card_stagger_delay, 0.05f, 3.0f, "%.2fs");
                if (ImGui::IsItemHovered()) {
                    ImGui::SetTooltip("Time delay before next card starts animating\n0.05s = almost together, 3s = slow sequence");
                }

                ImGui::Text("Start Delay (seconds)");
                ImGui::SliderFloat("##AnimDelay", &sec.animation_delay, 0.0f, 10.0f, "%.1fs");
                if (ImGui::IsItemHovered()) {
                    ImGui::SetTooltip("Wait before starting first card animation");
                }

                ImGui::Checkbox("Continuous Loop", &sec.animation_repeat);
                if (ImGui::IsItemHovered()) {
                    ImGui::SetTooltip("Cards will animate continuously in sequence\nNO sudden restart - smooth cycle!");
                }

                // Show animation preview info
                if (sec.items.size() > 0) {
                    ImGui::Spacing();
                    ImGui::TextColored(ImVec4(0.6f, 0.6f, 0.8f, 1), "Card Sequence Info:");
                    float totalTime = sec.animation_duration + (sec.items.size() * sec.card_stagger_delay);
                    ImGui::Text("  • %d cards animate one by one", (int)sec.items.size());
                    ImGui::Text("  • %.2fs delay between each card", sec.card_stagger_delay);
                    ImGui::Text("  • Total cycle: %.1f seconds", totalTime);
                }
            }

            ImGui::Spacing();
            if (ImGui::Button("Reset Animation", ImVec2(-1, 25))) {
                // Reset animation states
                AnimationEngine::ResetAllAnimations();
            }
            if (ImGui::IsItemHovered()) {
                ImGui::SetTooltip("Restart animation from beginning");
            }
        }

        // ========================================================================
        // TEXT EDITOR SECTION
        // ========================================================================
        ImGui::Spacing();
        ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "TEXT EDITOR");
        ImGui::Separator();

        char rich_text[2048];
        strncpy(rich_text, sec.content.c_str(), sizeof(rich_text) - 1);
        rich_text[sizeof(rich_text) - 1] = '\0';
        ImGui::Text("Rich Text Content");
        if (ImGui::InputTextMultiline("##RichText", rich_text, sizeof(rich_text),
                                       ImVec2(-1, 150),
                                       ImGuiInputTextFlags_AllowTabInput)) {
            sec.content = rich_text;
        }

        // Text formatting helpers
        if (ImGui::Button("Bold", ImVec2(60, 20))) {
            std::string wrapped = "<b>" + sec.content + "</b>";
            if (wrapped.length() < sizeof(rich_text)) sec.content = wrapped;
        }
        ImGui::SameLine();
        if (ImGui::Button("Italic", ImVec2(60, 20))) {
            std::string wrapped = "<i>" + sec.content + "</i>";
            if (wrapped.length() < sizeof(rich_text)) sec.content = wrapped;
        }
        ImGui::SameLine();
        if (ImGui::Button("Underline", ImVec2(70, 20))) {
            std::string wrapped = "<u>" + sec.content + "</u>";
            if (wrapped.length() < sizeof(rich_text)) sec.content = wrapped;
        }

        ImGui::Spacing();
        ImGui::Spacing();
        ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.6f, 0.2f, 0.2f, 1));
        if (ImGui::Button("Delete Section", ImVec2(-1, 28))) {
            g_Sections.erase(g_Sections.begin() + g_SelectedSectionIndex);
            g_SelectedSectionIndex = std::min(g_SelectedSectionIndex, (int)g_Sections.size() - 1);
        }
        ImGui::PopStyleColor();
        ImGui::End();
    }
    } // end of else block for non-Figma mode

    // Export success
    if (g_ShowExportSuccess) {
        g_ExportSuccessTimer -= io.DeltaTime;
        if (g_ExportSuccessTimer <= 0) g_ShowExportSuccess = false;
        else {
            ImGui::SetNextWindowPos(ImVec2(io.DisplaySize.x / 2 - 150, io.DisplaySize.y - 80));
            ImGui::SetNextWindowSize(ImVec2(300, 50));
            ImGui::Begin("##Exp", nullptr, ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove);
            ImGui::TextColored(ImVec4(0.2f, 0.8f, 0.3f, 1), "Exported ImGui Website!");
            ImGui::Text("%s", g_ExportPath.c_str());
            ImGui::End();
        }
    }

    // Template Gallery
    static int g_TemplateToDelete = -1;
    static std::string g_TemplateToDeleteName = "";
    static bool g_OpenDeletePopup = false;

    if (g_ShowTemplateGallery) {
        ImGui::SetNextWindowPos(ImVec2(io.DisplaySize.x / 2 - 400, io.DisplaySize.y / 2 - 300), ImGuiCond_FirstUseEver);
        ImGui::SetNextWindowSize(ImVec2(800, 600), ImGuiCond_FirstUseEver);
        ImGui::Begin("Template Gallery", &g_ShowTemplateGallery);

        ImGui::TextColored(ImVec4(0.3f, 0.5f, 0.8f, 1), "Choose a template to start with:");
        ImGui::Separator();
        ImGui::Spacing();

        // Open delete popup if flagged (must be done outside PushID scope)
        if (g_OpenDeletePopup) {
            ImGui::OpenPopup("Confirm Delete Template");
            g_OpenDeletePopup = false;
        }

        // Delete confirmation popup (must be at window level, not inside loop)
        if (ImGui::BeginPopupModal("Confirm Delete Template", NULL, ImGuiWindowFlags_AlwaysAutoResize)) {
            ImGui::Text("Are you sure you want to delete template:");
            ImGui::TextColored(ImVec4(1.0f, 0.5f, 0.5f, 1), "\"%s\"?", g_TemplateToDeleteName.c_str());
            ImGui::Spacing();
            ImGui::Text("This action cannot be undone.");
            ImGui::Spacing();
            ImGui::Separator();
            ImGui::Spacing();

            if (ImGui::Button("Delete", ImVec2(120, 30))) {
                // Delete from database
                if (g_UseDatabase && g_DBConnection && g_TemplateToDelete >= 0 && g_TemplateToDelete < (int)g_AvailableTemplates.size()) {
                    std::string templateName = g_AvailableTemplates[g_TemplateToDelete].name;

                    // Get template ID first
                    std::string query = "SELECT id FROM templates WHERE template_name='" + SQLEscape(templateName) + "'";
                    PGresult* result = PQexec(g_DBConnection, query.c_str());
                    if (PQresultStatus(result) == PGRES_TUPLES_OK && PQntuples(result) > 0) {
                        int templateId = atoi(PQgetvalue(result, 0, 0));
                        PQclear(result);

                        // Delete figma_layers first (foreign key constraint)
                        query = "DELETE FROM figma_layers WHERE template_id=" + std::to_string(templateId);
                        result = PQexec(g_DBConnection, query.c_str());
                        PQclear(result);

                        // Delete sections
                        query = "DELETE FROM sections WHERE template_id=" + std::to_string(templateId);
                        result = PQexec(g_DBConnection, query.c_str());
                        PQclear(result);

                        // Delete template
                        query = "DELETE FROM templates WHERE id=" + std::to_string(templateId);
                        result = PQexec(g_DBConnection, query.c_str());
                        PQclear(result);

                        printf("[Template Gallery] Deleted template: %s (ID: %d)\n", templateName.c_str(), templateId);

                        // Refresh template list
                        LoadAvailableTemplates();
                    } else {
                        PQclear(result);
                    }
                }
                g_TemplateToDelete = -1;
                g_TemplateToDeleteName = "";
                ImGui::CloseCurrentPopup();
            }
            ImGui::SameLine();
            if (ImGui::Button("Cancel", ImVec2(120, 30))) {
                g_TemplateToDelete = -1;
                g_TemplateToDeleteName = "";
                ImGui::CloseCurrentPopup();
            }
            ImGui::EndPopup();
        }

        // Display templates in a grid
        int columns = 3;
        float buttonWidth = (800 - 40) / columns - 10;

        if (g_AvailableTemplates.empty()) {
            ImGui::TextColored(ImVec4(0.7f, 0.7f, 0.7f, 1), "No templates found.");
            ImGui::Text("Create a website and click 'Save Template' to save it.");
        } else {
            for (size_t i = 0; i < g_AvailableTemplates.size(); i++) {
                const auto& tmpl = g_AvailableTemplates[i];

                ImGui::PushID(i);
                ImGui::BeginGroup();

                // Template card/button
                ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.2f, 0.3f, 0.4f, 1));
                ImGui::PushStyleColor(ImGuiCol_ButtonHovered, ImVec4(0.3f, 0.4f, 0.6f, 1));
                if (ImGui::Button(tmpl.name.c_str(), ImVec2(buttonWidth - 25, 80))) {
                    if (LoadTemplate(tmpl.filename)) {
                        g_ShowTemplateGallery = false;
                    }
                }
                ImGui::PopStyleColor(2);

                // Delete button (small X on same line)
                ImGui::SameLine();
                ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.6f, 0.2f, 0.2f, 1));
                ImGui::PushStyleColor(ImGuiCol_ButtonHovered, ImVec4(0.8f, 0.3f, 0.3f, 1));
                if (ImGui::Button("X", ImVec2(20, 80))) {
                    g_TemplateToDelete = i;
                    g_TemplateToDeleteName = tmpl.name;
                    g_OpenDeletePopup = true;  // Flag to open popup on next frame
                }
                ImGui::PopStyleColor(2);

                // Description
                ImGui::PushTextWrapPos(ImGui::GetCursorPos().x + buttonWidth);
                ImGui::TextColored(ImVec4(0.6f, 0.6f, 0.6f, 1), "%s", tmpl.description.c_str());
                ImGui::PopTextWrapPos();

                // Date
                ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "%s", tmpl.created_date.c_str());

                ImGui::EndGroup();
                ImGui::PopID();

                // Layout in columns
                if ((i + 1) % columns != 0 && i < g_AvailableTemplates.size() - 1) {
                    ImGui::SameLine();
                }
            }
        }

        ImGui::Spacing();
        ImGui::Separator();
        if (ImGui::Button("Close", ImVec2(120, 30))) {
            g_ShowTemplateGallery = false;
        }

        ImGui::End();
    }

    // Save Template Dialog
    if (g_ShowSaveTemplate) {
        ImGui::SetNextWindowPos(ImVec2(io.DisplaySize.x / 2 - 250, io.DisplaySize.y / 2 - 150));
        ImGui::SetNextWindowSize(ImVec2(500, 300));
        ImGui::Begin("Save Template", &g_ShowSaveTemplate);

        ImGui::TextColored(ImVec4(0.3f, 0.5f, 0.8f, 1), "Save current design as a template");
        ImGui::Separator();
        ImGui::Spacing();

        ImGui::Text("Template Name:");
        ImGui::SetNextItemWidth(-1);
        ImGui::InputText("##TemplateName", g_TemplateNameBuffer, sizeof(g_TemplateNameBuffer));

        ImGui::Spacing();
        ImGui::Text("Description:");
        ImGui::SetNextItemWidth(-1);
        ImGui::InputTextMultiline("##TemplateDesc", g_TemplateDescBuffer, sizeof(g_TemplateDescBuffer), ImVec2(-1, 100));

        ImGui::Spacing();
        ImGui::Separator();
        ImGui::Spacing();

        bool canSave = strlen(g_TemplateNameBuffer) > 0;

        if (!canSave) {
            ImGui::PushStyleVar(ImGuiStyleVar_Alpha, 0.5f);
        }

        if (ImGui::Button("Save Template", ImVec2(150, 35)) && canSave) {
            if (SaveTemplate(g_TemplateNameBuffer, g_TemplateDescBuffer)) {
                g_ShowSaveTemplate = false;
                // Show success message
                g_ShowExportSuccess = true;
                g_ExportSuccessTimer = 2.0f;
                g_ExportPath = "Template saved: " + std::string(g_TemplateNameBuffer);
            }
        }

        if (!canSave) {
            ImGui::PopStyleVar();
        }

        ImGui::SameLine();
        if (ImGui::Button("Cancel", ImVec2(100, 35))) {
            g_ShowSaveTemplate = false;
        }

        if (!canSave) {
            ImGui::TextColored(ImVec4(0.8f, 0.3f, 0.3f, 1), "Please enter a template name");
        }

        ImGui::End();
    }

    // URL Import Dialog
    if (g_ShowURLImportDialog) {
        ImGui::SetNextWindowPos(ImVec2(io.DisplaySize.x / 2 - 320, io.DisplaySize.y / 2 - 250));
        ImGui::SetNextWindowSize(ImVec2(640, 500));
        ImGui::Begin("Import from URL", &g_ShowURLImportDialog, ImGuiWindowFlags_NoResize);

        ImGui::TextColored(ImVec4(0.9f, 0.5f, 0.2f, 1), "Import website design from URL");
        ImGui::Separator();
        ImGui::Spacing();

        // Import Method Selection (Tabs)
        ImGui::Text("Import Method:");
        ImGui::SameLine();

        // Tab buttons - save state before button clicks to avoid push/pop mismatch
        bool isLiveScrape = (g_ImportMethod == 0);
        bool isLocalDownload = (g_ImportMethod == 1);
        bool isFigmaStyle = (g_ImportMethod == 2);

        if (isLiveScrape) {
            ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.3f, 0.5f, 0.8f, 1.0f));
        }
        if (ImGui::Button("Live Scrape", ImVec2(100, 28))) {
            g_ImportMethod = 0;
        }
        if (isLiveScrape) {
            ImGui::PopStyleColor();
        }

        ImGui::SameLine();

        if (isLocalDownload) {
            ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.3f, 0.7f, 0.4f, 1.0f));
        }
        if (ImGui::Button("Local Download", ImVec2(100, 28))) {
            g_ImportMethod = 1;
        }
        if (isLocalDownload) {
            ImGui::PopStyleColor();
        }

        ImGui::SameLine();

        if (isFigmaStyle) {
            ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.8f, 0.3f, 0.6f, 1.0f));
        }
        if (ImGui::Button("Figma-Style", ImVec2(100, 28))) {
            g_ImportMethod = 2;
        }
        if (isFigmaStyle) {
            ImGui::PopStyleColor();
        }

        ImGui::Spacing();
        ImGui::Separator();
        ImGui::Spacing();

        ImGui::Text("Enter URL:");
        ImGui::SetNextItemWidth(-1);
        ImGui::InputText("##URLInput", g_URLImportBuffer, sizeof(g_URLImportBuffer));

        ImGui::Spacing();

        if (g_ImportMethod == 0) {
            // LIVE SCRAPE OPTIONS
            ImGui::TextColored(ImVec4(0.5f, 0.7f, 1.0f, 1), "Live Scrape Mode");
            ImGui::Indent(10);
            ImGui::TextColored(ImVec4(0.6f, 0.6f, 0.6f, 1), "Scrapes website in real-time using browser automation");
            ImGui::Unindent(10);

            ImGui::Spacing();

            // Timeout control
            ImGui::Text("Scraping Timeout:");
            ImGui::SetNextItemWidth(350);
            ImGui::SliderInt("##TimeoutSlider", &g_URLImportTimeout, 60, 600, "%d seconds");
            ImGui::SameLine();
            ImGui::TextColored(ImVec4(0.6f, 0.6f, 0.6f, 1), "(%d min %d sec)", g_URLImportTimeout / 60, g_URLImportTimeout % 60);

            ImGui::Indent(15);
            ImGui::TextColored(ImVec4(0.5f, 0.5f, 0.5f, 1), "Recommended: 3-5 min for most sites");
            ImGui::Unindent(15);

            ImGui::Spacing();

            // Stealth Browser MCP option
            ImGui::Checkbox("Use Stealth Browser (bypasses anti-bot protection)", &g_URLImportUseStealth);
            ImGui::Indent(15);
            if (g_URLImportUseStealth) {
                ImGui::TextColored(ImVec4(0.4f, 0.8f, 0.4f, 1), "Stealth mode: Bypasses bot detection");
            } else {
                ImGui::TextColored(ImVec4(0.6f, 0.6f, 0.6f, 1), "Standard Playwright browser");
            }
            ImGui::Unindent(15);

        } else if (g_ImportMethod == 1) {
            // LOCAL DOWNLOAD OPTIONS
            ImGui::TextColored(ImVec4(0.4f, 0.9f, 0.5f, 1), "Local Download Mode (More Accurate)");
            ImGui::Indent(10);
            ImGui::TextColored(ImVec4(0.6f, 0.6f, 0.6f, 1), "Downloads entire website locally, then parses HTML/CSS files");
            ImGui::Unindent(10);

            ImGui::Spacing();

            // Benefits
            ImGui::TextColored(ImVec4(0.8f, 0.8f, 0.3f, 1), "Benefits:");
            ImGui::Indent(15);
            ImGui::BulletText("All images downloaded (no lazy loading issues)");
            ImGui::BulletText("Actual CSS files parsed (not computed styles)");
            ImGui::BulletText("No timeout issues");
            ImGui::BulletText("Can analyze complex sites offline");
            ImGui::Unindent(15);

            ImGui::Spacing();

            ImGui::TextColored(ImVec4(0.6f, 0.6f, 0.6f, 1), "Uses wget to mirror the website");
        } else if (g_ImportMethod == 2) {
            // FIGMA-STYLE OPTIONS
            ImGui::TextColored(ImVec4(0.9f, 0.4f, 0.7f, 1), "Figma-Style Mode (Pixel Perfect)");
            ImGui::Indent(10);
            ImGui::TextColored(ImVec4(0.6f, 0.6f, 0.6f, 1), "Extracts every element with exact positions like Figma");
            ImGui::Unindent(10);

            ImGui::Spacing();

            // Benefits
            ImGui::TextColored(ImVec4(0.8f, 0.8f, 0.3f, 1), "Benefits:");
            ImGui::Indent(15);
            ImGui::BulletText("Pixel-perfect layout preservation");
            ImGui::BulletText("Every element as a draggable layer");
            ImGui::BulletText("Screenshot overlay for reference");
            ImGui::BulletText("Edit like Figma/Sketch");
            ImGui::Unindent(15);

            ImGui::Spacing();

            ImGui::TextColored(ImVec4(0.9f, 0.7f, 0.3f, 1), "Note: Opens in Figma-style editor mode");
        }

        ImGui::Spacing();

        if (!g_URLImportStatus.empty() || !g_FigmaImportStatus.empty()) {
            std::string status = (g_ImportMethod == 2) ? g_FigmaImportStatus : g_URLImportStatus;
            ImVec4 color = ImVec4(0.7f, 0.7f, 0.7f, 1);
            if (status.find("Error") != std::string::npos) {
                color = ImVec4(1, 0.3f, 0.3f, 1);
            } else if (status.find("Warning") != std::string::npos) {
                color = ImVec4(1, 0.8f, 0.2f, 1);
            } else if (status.find("Success") != std::string::npos) {
                color = ImVec4(0.3f, 1, 0.3f, 1);
            }

            ImGui::TextColored(color, "%s", status.c_str());

            if (g_URLImportInProgress || g_FigmaImportInProgress) {
                ImGui::ProgressBar(g_URLImportProgress);
            }
        }

        ImGui::Spacing();
        ImGui::Separator();
        ImGui::Spacing();

        bool can_import = strlen(g_URLImportBuffer) > 10 && !g_URLImportInProgress && !g_FigmaImportInProgress;

        if (!can_import) {
            ImGui::PushStyleVar(ImGuiStyleVar_Alpha, 0.5f);
        }

        // Import button text changes based on method
        const char* importBtnText = "Import";
        if (g_ImportMethod == 0) importBtnText = "Import (Live)";
        else if (g_ImportMethod == 1) importBtnText = "Import (Download)";
        else if (g_ImportMethod == 2) importBtnText = "Import (Figma)";

        if (ImGui::Button(importBtnText, ImVec2(150, 35)) && can_import) {
            if (g_ImportMethod == 0) {
                // Live Scrape
                g_URLImportInProgress = true;
                bool success = ImportFromURL(std::string(g_URLImportBuffer), g_URLImportTimeout, g_URLImportUseStealth);
                g_URLImportInProgress = false;
            } else if (g_ImportMethod == 1) {
                // Local Download
                g_URLImportInProgress = true;
                bool success = ImportFromLocalDownload(std::string(g_URLImportBuffer));
                g_URLImportInProgress = false;
            } else if (g_ImportMethod == 2) {
                // Figma-style
                bool success = ImportFigmaLayers(std::string(g_URLImportBuffer));
                if (success) {
                    g_ShowURLImportDialog = false;  // Close dialog on success
                }
            }
        }

        if (!can_import) {
            ImGui::PopStyleVar();
        }

        ImGui::SameLine();
        if (ImGui::Button("Cancel", ImVec2(100, 35))) {
            g_ShowURLImportDialog = false;
        }

        if (!can_import && strlen(g_URLImportBuffer) > 0 && strlen(g_URLImportBuffer) < 10) {
            ImGui::TextColored(ImVec4(1, 0.5f, 0, 1), "Please enter a valid URL (http:// or https://)");
        }

        ImGui::End();
    }
}

// ============================================================================
// MAIN
// ============================================================================
// Modern Service Card (Screenshot 1 style: icon + bullet points)
void DrawModernServiceCard(ImDrawList* dl, float x, float y, float w, float h,
                          const std::string& title, const std::string& subtitle,
                          const std::vector<std::string>& bullets, const std::string& icon_emoji,
                          ImVec4 icon_color, ImVec4 text_color, float anim_progress) {
    // Animation: slide in from right
    float slideOffset = (1.0f - anim_progress) * 150.0f;
    x += slideOffset;
    float alpha = anim_progress;

    // Card shadow (soft, modern)
    dl->AddRectFilled(ImVec2(x + 2, y + 8), ImVec2(x + w + 2, y + h + 8),
                     IM_COL32(0, 0, 0, (int)(15 * alpha)), 16.0f);

    // Card background (white)
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x + w, y + h),
                     IM_COL32(255, 255, 255, (int)(255 * alpha)), 16.0f);

    // Card border (light gray, complete border)
    dl->AddRect(ImVec2(x, y), ImVec2(x + w, y + h),
               IM_COL32(230, 230, 230, (int)(255 * alpha)), 16.0f, 0, 1.0f);

    // Decorative blob and icon box removed

    // Title (bold, dark) - starts from top now
    ImFont* font = ImGui::GetFont();
    float textY = y + 32;
    ImVec2 title_size = font->CalcTextSizeA(22.0f, FLT_MAX, w - 48, title.c_str());
    dl->AddText(font, 22.0f, ImVec2(x + 24, textY),
               IM_COL32(18, 18, 18, (int)(255 * alpha)), title.c_str(), nullptr, w - 48);
    textY += title_size.y + 10;

    // Subtitle (gray)
    ImVec2 sub_size = font->CalcTextSizeA(15.0f, FLT_MAX, w - 48, subtitle.c_str());
    dl->AddText(font, 15.0f, ImVec2(x + 24, textY),
               IM_COL32(115, 115, 128, (int)(255 * alpha)), subtitle.c_str(), nullptr, w - 48);
    textY += sub_size.y + 18;

    // Bullet points with icons
    for (size_t i = 0; i < bullets.size() && i < 3; i++) {
        // Bullet icon (small dark circle)
        dl->AddCircleFilled(ImVec2(x + 30, textY + 7), 3, IM_COL32(60, 60, 67, (int)(255 * alpha)));

        // Bullet text
        dl->AddText(font, 14.0f, ImVec2(x + 42, textY),
                   IM_COL32(60, 60, 67, (int)(255 * alpha)), bullets[i].c_str(), nullptr, w - 66);
        textY += 24;
    }

    // "Learn More" link with arrow at bottom
    textY = y + h - 40;
    dl->AddText(font, 15.0f, ImVec2(x + 24, textY),
               IM_COL32(0, 112, 243, (int)(255 * alpha)), "Learn More →");
}

// Modern Portfolio Card (Screenshot 2 style: thumbnail + tags)
void DrawModernPortfolioCard(ImDrawList* dl, float x, float y, float w, float h,
                             const std::string& title, const std::string& subtitle,
                             const std::vector<std::string>& tech_tags, const std::string& badge_text,
                             GLuint thumbnail_id, ImVec4 text_color, float anim_progress) {
    // Animation: slide in from right
    float slideOffset = (1.0f - anim_progress) * 150.0f;
    x += slideOffset;
    float alpha = anim_progress;

    // Card shadow (soft, modern)
    dl->AddRectFilled(ImVec2(x + 2, y + 8), ImVec2(x + w + 2, y + h + 8),
                     IM_COL32(0, 0, 0, (int)(15 * alpha)), 20.0f);

    // Card background (white)
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x + w, y + h),
                     IM_COL32(255, 255, 255, (int)(255 * alpha)), 16.0f);

    // Thumbnail image at top (rounded corners)
    float thumbnailH = h * 0.5f;  // 50% of card height
    if (thumbnail_id != 0) {
        // Clip to rounded rectangle for image
        dl->PushClipRect(ImVec2(x + 1, y + 1), ImVec2(x + w - 1, y + thumbnailH), true);
        dl->AddImage((ImTextureID)(intptr_t)thumbnail_id,
                    ImVec2(x, y), ImVec2(x + w, y + thumbnailH));
        dl->PopClipRect();
    } else {
        // Placeholder gradient if no image
        dl->AddRectFilledMultiColor(ImVec2(x, y), ImVec2(x + w, y + thumbnailH),
                                    IM_COL32(100, 149, 237, (int)(255 * alpha)),
                                    IM_COL32(135, 206, 250, (int)(255 * alpha)),
                                    IM_COL32(135, 206, 250, (int)(255 * alpha)),
                                    IM_COL32(100, 149, 237, (int)(255 * alpha)));
    }

    // Category badge (overlaying bottom-left of image)
    if (!badge_text.empty()) {
        ImFont* font = ImGui::GetFont();
        ImVec2 badge_size = font->CalcTextSizeA(13.0f, FLT_MAX, 0.0f, badge_text.c_str());
        float badgeW = badge_size.x + 20;
        float badgeH = 26;
        float badgeX = x + 16;
        float badgeY = y + thumbnailH - badgeH - 12;

        // Badge background (blue pill)
        dl->AddRectFilled(ImVec2(badgeX, badgeY), ImVec2(badgeX + badgeW, badgeY + badgeH),
                         IM_COL32(0, 112, 243, (int)(255 * alpha)), badgeH / 2);

        // Badge text (white)
        dl->AddText(font, 13.0f, ImVec2(badgeX + 10, badgeY + 6),
                   IM_COL32(255, 255, 255, (int)(255 * alpha)), badge_text.c_str());
    }

    // Content area (below thumbnail)
    float contentY = y + thumbnailH + 24;
    ImFont* font = ImGui::GetFont();

    // Title (bold, dark)
    ImVec2 title_size = font->CalcTextSizeA(20.0f, FLT_MAX, w - 48, title.c_str());
    dl->AddText(font, 20.0f, ImVec2(x + 24, contentY),
               IM_COL32(18, 18, 18, (int)(255 * alpha)), title.c_str(), nullptr, w - 48);
    contentY += title_size.y + 10;

    // Subtitle (gray)
    ImVec2 sub_size = font->CalcTextSizeA(14.0f, FLT_MAX, w - 48, subtitle.c_str());
    dl->AddText(font, 14.0f, ImVec2(x + 24, contentY),
               IM_COL32(115, 115, 128, (int)(255 * alpha)), subtitle.c_str(), nullptr, w - 48);
    contentY += sub_size.y + 16;

    // Technology tags (blue pills)
    float tagX = x + 24;
    for (size_t i = 0; i < tech_tags.size() && i < 3; i++) {
        ImVec2 tag_size = font->CalcTextSizeA(12.0f, FLT_MAX, 0.0f, tech_tags[i].c_str());
        float tagW = tag_size.x + 16;
        float tagH = 24;

        // Tag background (light blue pill)
        dl->AddRectFilled(ImVec2(tagX, contentY), ImVec2(tagX + tagW, contentY + tagH),
                         IM_COL32(225, 238, 255, (int)(255 * alpha)), tagH / 2);

        // Tag text (blue)
        dl->AddText(font, 12.0f, ImVec2(tagX + 8, contentY + 6),
                   IM_COL32(0, 112, 243, (int)(255 * alpha)), tech_tags[i].c_str());

        tagX += tagW + 8;  // Space between tags
    }

    // "View Project" link with arrow at bottom
    float linkY = y + h - 40;
    dl->AddText(font, 15.0f, ImVec2(x + 24, linkY),
               IM_COL32(0, 112, 243, (int)(255 * alpha)), "View Project →");
}

static void glfw_error_callback(int e, const char* d) { fprintf(stderr, "GLFW Error %d: %s\n", e, d); }

int main(int, char**) {
    glfwSetErrorCallback(glfw_error_callback);
    if (!glfwInit()) return 1;
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 2);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);

    g_Window = glfwCreateWindow(1400, 900, "ImGui Website Designer", nullptr, nullptr);
    if (!g_Window) return 1;
    glfwMakeContextCurrent(g_Window);
    glfwSwapInterval(1);

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO();
    io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;

    // Enable smooth scrolling for Mac trackpad (two-finger scrolling)
    io.MouseWheelH = 0.0f;  // Horizontal scroll support
    io.ConfigMacOSXBehaviors = true;  // Enable Mac-specific behaviors

    io.Fonts->AddFontFromFileTTF("/System/Library/Fonts/SFNS.ttf", 14.0f);
    if (io.Fonts->Fonts.empty()) io.Fonts->AddFontDefault();

    ImGui::StyleColorsDark();
    ImGui_ImplGlfw_InitForOpenGL(g_Window, true);
    ImGui_ImplOpenGL3_Init("#version 150");

    // Initialize PostgreSQL database connection (will fallback to JSON if fails)
    if (!InitDatabase()) {
        printf("PostgreSQL not available, using JSON files for templates\n");
    }

    g_Pages = {"Home"};

    while (!glfwWindowShouldClose(g_Window)) {
        glfwPollEvents();
        ImGui_ImplOpenGL3_NewFrame();
        ImGui_ImplGlfw_NewFrame();
        ImGui::NewFrame();
        RenderUI();
        RenderTemplatePicker();  // Render template picker modal
        ImGui::Render();
        int dw, dh;
        glfwGetFramebufferSize(g_Window, &dw, &dh);
        glViewport(0, 0, dw, dh);
        glClearColor(0.08f, 0.08f, 0.1f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);
        ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
        glfwSwapBuffers(g_Window);
    }

    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplGlfw_Shutdown();
    ImGui::DestroyContext();
    glfwDestroyWindow(g_Window);
    CloseDatabase();  // Close PostgreSQL connection
    glfwTerminate();
    return 0;
}
