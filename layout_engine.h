// ============================================================================
// Layout Engine - Flexbox & Grid Layout Algorithms
// Website Builder v2.0 - Phase 2
// ============================================================================

#pragma once
#include <vector>
#include <string>
#include <algorithm>
#include <sstream>
#include <cmath>
#include <map>

// Layout calculation result for a single child element
struct LayoutRect {
    float x, y, width, height;

    LayoutRect() : x(0), y(0), width(0), height(0) {}
    LayoutRect(float _x, float _y, float _w, float _h)
        : x(_x), y(_y), width(_w), height(_h) {}
};

// Flexbox layout properties (from WebSection)
struct FlexboxLayout {
    std::string flex_direction;
    std::string justify_content;
    std::string align_items;
    std::string flex_wrap;
    float gap;

    FlexboxLayout() : flex_direction("row"), justify_content("flex-start"),
                      align_items("stretch"), flex_wrap("nowrap"), gap(0) {}
};

// Grid layout properties (from WebSection)
struct GridLayout {
    std::string grid_template_columns;
    std::string grid_template_rows;
    float grid_gap;
    float row_gap;
    float column_gap;
    std::string grid_auto_flow;

    GridLayout() : grid_gap(20), row_gap(20), column_gap(20), grid_auto_flow("row") {}
};

// Child element flex/grid properties
struct ChildLayoutProps {
    float flex_grow;
    float flex_shrink;
    std::string flex_basis;
    std::string align_self;
    int grid_column_start;
    int grid_column_end;
    int grid_row_start;
    int grid_row_end;

    ChildLayoutProps() : flex_grow(0), flex_shrink(1), flex_basis("auto"),
                         align_self("auto"), grid_column_start(0), grid_column_end(0),
                         grid_row_start(0), grid_row_end(0) {}
};

// ============================================================================
// FLEXBOX LAYOUT ENGINE
// ============================================================================

class FlexboxEngine {
public:
    static std::vector<LayoutRect> CalculateLayout(
        float containerX, float containerY,
        float containerWidth, float containerHeight,
        const FlexboxLayout& props,
        const std::vector<float>& childWidths,
        const std::vector<float>& childHeights,
        const std::vector<ChildLayoutProps>& childProps = std::vector<ChildLayoutProps>()
    ) {
        std::vector<LayoutRect> result;
        int numChildren = childWidths.size();

        if (numChildren == 0) return result;

        // Determine direction
        bool isRow = (props.flex_direction == "row" || props.flex_direction == "row-reverse");
        bool isReverse = (props.flex_direction.find("reverse") != std::string::npos);

        // Prepare child props (use defaults if not provided)
        std::vector<ChildLayoutProps> actualChildProps = childProps;
        if (actualChildProps.empty()) {
            actualChildProps.resize(numChildren);
        }

        // Calculate main axis sizes
        std::vector<float> mainSizes = isRow ? childWidths : childHeights;
        std::vector<float> crossSizes = isRow ? childHeights : childWidths;

        // Apply flex-grow/shrink
        float totalMainSize = 0;
        for (float size : mainSizes) totalMainSize += size;
        totalMainSize += props.gap * (numChildren - 1);

        float availableSpace = isRow ? containerWidth : containerHeight;
        float freeSpace = availableSpace - totalMainSize;

        // Distribute free space based on flex-grow
        if (freeSpace > 0) {
            float totalGrow = 0;
            for (const auto& cp : actualChildProps) totalGrow += cp.flex_grow;

            if (totalGrow > 0) {
                for (int i = 0; i < numChildren; i++) {
                    mainSizes[i] += (freeSpace * actualChildProps[i].flex_grow / totalGrow);
                }
            }
        } else if (freeSpace < 0) {
            // Shrink if needed
            float totalShrink = 0;
            for (int i = 0; i < numChildren; i++) {
                totalShrink += actualChildProps[i].flex_shrink * mainSizes[i];
            }

            if (totalShrink > 0) {
                for (int i = 0; i < numChildren; i++) {
                    float shrinkAmount = (-freeSpace * actualChildProps[i].flex_shrink * mainSizes[i]) / totalShrink;
                    mainSizes[i] = std::max(0.0f, mainSizes[i] - shrinkAmount);
                }
            }
        }

        // Calculate positions
        float currentPos = 0;
        float spacing = props.gap;

        // Apply justify-content
        if (props.justify_content == "center") {
            float totalSize = 0;
            for (float size : mainSizes) totalSize += size;
            totalSize += spacing * (numChildren - 1);
            currentPos = (availableSpace - totalSize) / 2;
        } else if (props.justify_content == "flex-end") {
            float totalSize = 0;
            for (float size : mainSizes) totalSize += size;
            totalSize += spacing * (numChildren - 1);
            currentPos = availableSpace - totalSize;
        } else if (props.justify_content == "space-between") {
            if (numChildren > 1) {
                float totalChildSize = 0;
                for (float size : mainSizes) totalChildSize += size;
                spacing = (availableSpace - totalChildSize) / (numChildren - 1);
            }
        } else if (props.justify_content == "space-around") {
            if (numChildren > 0) {
                float totalChildSize = 0;
                for (float size : mainSizes) totalChildSize += size;
                spacing = (availableSpace - totalChildSize) / numChildren;
                currentPos = spacing / 2;
            }
        } else if (props.justify_content == "space-evenly") {
            if (numChildren > 0) {
                float totalChildSize = 0;
                for (float size : mainSizes) totalChildSize += size;
                spacing = (availableSpace - totalChildSize) / (numChildren + 1);
                currentPos = spacing;
            }
        }

        // Create layout rects
        for (int i = 0; i < numChildren; i++) {
            LayoutRect rect;

            if (isRow) {
                rect.x = containerX + currentPos;
                rect.width = mainSizes[i];
                rect.height = crossSizes[i];

                // Apply align-items for cross-axis (vertical)
                std::string alignment = actualChildProps[i].align_self != "auto"
                                      ? actualChildProps[i].align_self
                                      : props.align_items;

                if (alignment == "center") {
                    rect.y = containerY + (containerHeight - rect.height) / 2;
                } else if (alignment == "flex-end") {
                    rect.y = containerY + containerHeight - rect.height;
                } else if (alignment == "stretch") {
                    rect.y = containerY;
                    rect.height = containerHeight;
                } else {  // flex-start
                    rect.y = containerY;
                }

                currentPos += mainSizes[i] + spacing;
            } else {
                // Column direction
                rect.y = containerY + currentPos;
                rect.height = mainSizes[i];
                rect.width = crossSizes[i];

                // Apply align-items for cross-axis (horizontal)
                std::string alignment = actualChildProps[i].align_self != "auto"
                                      ? actualChildProps[i].align_self
                                      : props.align_items;

                if (alignment == "center") {
                    rect.x = containerX + (containerWidth - rect.width) / 2;
                } else if (alignment == "flex-end") {
                    rect.x = containerX + containerWidth - rect.width;
                } else if (alignment == "stretch") {
                    rect.x = containerX;
                    rect.width = containerWidth;
                } else {  // flex-start
                    rect.x = containerX;
                }

                currentPos += mainSizes[i] + spacing;
            }

            result.push_back(rect);
        }

        return result;
    }
};

// ============================================================================
// GRID LAYOUT ENGINE
// ============================================================================

class GridEngine {
public:
    static std::vector<LayoutRect> CalculateLayout(
        float containerX, float containerY,
        float containerWidth, float containerHeight,
        const GridLayout& props,
        int numItems,
        const std::vector<ChildLayoutProps>& childProps = std::vector<ChildLayoutProps>()
    ) {
        std::vector<LayoutRect> result;

        if (numItems == 0) return result;

        // Parse grid template columns
        std::vector<float> columnWidths = ParseGridTemplate(
            props.grid_template_columns,
            containerWidth,
            props.column_gap
        );

        // Parse grid template rows (or auto-generate)
        std::vector<float> rowHeights;
        if (!props.grid_template_rows.empty() && props.grid_template_rows != "auto") {
            rowHeights = ParseGridTemplate(
                props.grid_template_rows,
                containerHeight,
                props.row_gap
            );
        }

        // Auto-generate rows if not specified
        int numCols = columnWidths.size();
        if (numCols == 0) numCols = 3;  // Default to 3 columns

        int numRows = (numItems + numCols - 1) / numCols;
        if (rowHeights.empty()) {
            float rowHeight = (containerHeight - (numRows - 1) * props.row_gap) / numRows;
            rowHeights.resize(numRows, rowHeight);
        }

        // Place items in grid
        for (int i = 0; i < numItems; i++) {
            int col = i % numCols;
            int row = i / numCols;

            if (row >= (int)rowHeights.size()) break;

            // Calculate x position
            float x = containerX;
            for (int c = 0; c < col; c++) {
                x += columnWidths[c] + props.column_gap;
            }

            // Calculate y position
            float y = containerY;
            for (int r = 0; r < row; r++) {
                y += rowHeights[r] + props.row_gap;
            }

            LayoutRect rect;
            rect.x = x;
            rect.y = y;
            rect.width = columnWidths[col];
            rect.height = rowHeights[row];

            result.push_back(rect);
        }

        return result;
    }

private:
    static std::vector<float> ParseGridTemplate(
        const std::string& templateStr,
        float availableSize,
        float gap
    ) {
        std::vector<float> result;

        if (templateStr.empty() || templateStr == "none") {
            return result;
        }

        // Handle "repeat(n, size)" pattern
        if (templateStr.find("repeat") != std::string::npos) {
            // Parse repeat(3, 1fr) or repeat(4, 200px)
            size_t startParen = templateStr.find('(');
            size_t comma = templateStr.find(',', startParen);
            size_t endParen = templateStr.find(')', comma);

            if (startParen != std::string::npos && comma != std::string::npos && endParen != std::string::npos) {
                std::string countStr = templateStr.substr(startParen + 1, comma - startParen - 1);
                std::string sizeStr = templateStr.substr(comma + 1, endParen - comma - 1);

                // Trim whitespace
                countStr.erase(0, countStr.find_first_not_of(" \t"));
                countStr.erase(countStr.find_last_not_of(" \t") + 1);
                sizeStr.erase(0, sizeStr.find_first_not_of(" \t"));
                sizeStr.erase(sizeStr.find_last_not_of(" \t") + 1);

                int count = std::stoi(countStr);

                // Handle fractional units (fr)
                if (sizeStr.find("fr") != std::string::npos) {
                    float totalGap = gap * (count - 1);
                    float colWidth = (availableSize - totalGap) / count;
                    result.resize(count, colWidth);
                } else {
                    // Handle pixel values
                    float size = std::stof(sizeStr);
                    result.resize(count, size);
                }
            }
        }
        // Handle space-separated values like "200px 1fr 2fr"
        else {
            std::istringstream iss(templateStr);
            std::string token;
            std::vector<float> frValues;
            float fixedTotal = 0;
            int frCount = 0;

            while (iss >> token) {
                if (token.find("fr") != std::string::npos) {
                    float frValue = std::stof(token);
                    frValues.push_back(frValue);
                    frCount++;
                } else if (token.find("px") != std::string::npos) {
                    float size = std::stof(token);
                    result.push_back(size);
                    fixedTotal += size;
                } else if (token == "auto") {
                    result.push_back(100);  // Default auto size
                    fixedTotal += 100;
                }
            }

            // Calculate fr units
            if (frCount > 0) {
                float totalGap = gap * (result.size() + frCount - 1);
                float frAvailable = availableSize - fixedTotal - totalGap;
                float totalFr = 0;
                for (float fr : frValues) totalFr += fr;

                for (float fr : frValues) {
                    result.push_back((frAvailable * fr) / totalFr);
                }
            }
        }

        // Default to 3 equal columns if parsing failed
        if (result.empty()) {
            float colWidth = (availableSize - gap * 2) / 3;
            result.resize(3, colWidth);
        }

        return result;
    }
};

// ============================================================================
// ANIMATION ENGINE
// ============================================================================

struct AnimationState {
    float progress;          // 0.0 to 1.0
    float elapsedTime;       // Total elapsed time (seconds)
    bool completed;          // Has animation finished?
    float opacity;           // Current opacity (for fade effects)
    float translateX;        // Current X offset (for slide effects)
    float translateY;        // Current Y offset (for slide effects)
    float scale;             // Current scale (for scale effects)

    AnimationState()
        : progress(0.0f), elapsedTime(0.0f), completed(false),
          opacity(1.0f), translateX(0.0f), translateY(0.0f), scale(1.0f) {}
};

class AnimationEngine {
private:
    static std::map<int, AnimationState> s_AnimationStates;

public:
    /**
     * Update animation for a section
     * @param sectionId - Unique section ID
     * @param animationType - Animation type (0=none, 1=fadeIn, 2=slideLeft, 3=slideRight, 4=slideUp, 5=slideDown, 6=scaleUp)
     * @param duration - Animation duration (seconds)
     * @param delay - Animation delay (seconds)
     * @param repeat - Loop animation?
     * @param deltaTime - Time since last frame
     * @return Current animation state
     */
    static AnimationState& UpdateAnimation(
        int sectionId,
        int animationType,
        float duration,
        float delay,
        bool repeat,
        float deltaTime
    ) {
        // Get or create animation state
        if (s_AnimationStates.find(sectionId) == s_AnimationStates.end()) {
            s_AnimationStates[sectionId] = AnimationState();
        }

        AnimationState& anim = s_AnimationStates[sectionId];

        // Skip if completed and not repeating
        if (anim.completed && !repeat) {
            return anim;
        }

        // Update elapsed time
        anim.elapsedTime += deltaTime;

        // Check if still in delay period
        if (anim.elapsedTime < delay) {
            anim.progress = 0.0f;
            ApplyAnimationType(anim, animationType, 0.0f);
            return anim;
        }

        // Calculate progress (0 to 1)
        float effectiveTime = anim.elapsedTime - delay;
        float rawProgress = (duration > 0) ? (effectiveTime / duration) : 1.0f;
        rawProgress = std::min(rawProgress, 1.0f);

        // Apply easing (ease-out cubic for smooth deceleration)
        anim.progress = EaseOutCubic(rawProgress);

        // Check if animation finished
        if (rawProgress >= 1.0f) {
            if (repeat) {
                // Loop: reset to beginning
                anim.elapsedTime = 0.0f;
                anim.progress = 0.0f;
            } else {
                // Complete: stay at final state
                anim.progress = 1.0f;
                anim.completed = true;
            }
        }

        // Apply animation-specific transforms
        ApplyAnimationType(anim, animationType, anim.progress);

        return anim;
    }

    /**
     * Apply animation transform to layout box
     * @param box - Original layout box
     * @param anim - Animation state
     * @return Modified box with animation applied
     */
    static LayoutRect ApplyAnimationTransform(const LayoutRect& box, const AnimationState& anim) {
        LayoutRect result = box;

        // Apply translation
        result.x += anim.translateX;
        result.y += anim.translateY;

        // Apply scale (scale from center)
        if (anim.scale != 1.0f) {
            float centerX = box.x + box.width / 2.0f;
            float centerY = box.y + box.height / 2.0f;
            float scaledWidth = box.width * anim.scale;
            float scaledHeight = box.height * anim.scale;
            result.x = centerX - scaledWidth / 2.0f;
            result.y = centerY - scaledHeight / 2.0f;
            result.width = scaledWidth;
            result.height = scaledHeight;
        }

        return result;
    }

    /**
     * Get opacity for fade effects
     */
    static float GetOpacity(int sectionId) {
        if (s_AnimationStates.find(sectionId) != s_AnimationStates.end()) {
            return s_AnimationStates[sectionId].opacity;
        }
        return 1.0f;
    }

    /**
     * Reset all animations (useful when loading new template)
     */
    static void ResetAllAnimations() {
        s_AnimationStates.clear();
    }

    /**
     * Reset specific animation
     */
    static void ResetAnimation(int sectionId) {
        s_AnimationStates.erase(sectionId);
    }

private:
    static void ApplyAnimationType(AnimationState& anim, int type, float progress) {
        switch (type) {
            case 1: // ANIM_FADE_IN
                anim.opacity = progress;
                anim.translateX = 0;
                anim.translateY = 0;
                anim.scale = 1.0f;
                break;

            case 2: // ANIM_SLIDE_LEFT
                anim.opacity = 1.0f;
                anim.translateX = -150.0f * (1.0f - progress);  // Slide from left
                anim.translateY = 0;
                anim.scale = 1.0f;
                break;

            case 3: // ANIM_SLIDE_RIGHT
                anim.opacity = 1.0f;
                anim.translateX = 150.0f * (1.0f - progress);   // Slide from right
                anim.translateY = 0;
                anim.scale = 1.0f;
                break;

            case 4: // ANIM_SLIDE_UP
                anim.opacity = 1.0f;
                anim.translateX = 0;
                anim.translateY = -100.0f * (1.0f - progress);  // Slide from top
                anim.scale = 1.0f;
                break;

            case 5: // ANIM_SLIDE_DOWN
                anim.opacity = 1.0f;
                anim.translateX = 0;
                anim.translateY = 100.0f * (1.0f - progress);   // Slide from bottom
                anim.scale = 1.0f;
                break;

            case 6: // ANIM_SCALE_UP
                anim.opacity = progress;
                anim.translateX = 0;
                anim.translateY = 0;
                anim.scale = progress;  // Scale from 0 to 1
                break;

            case 7: // ANIM_ZOOM_OUT
                {
                    anim.opacity = progress;
                    anim.translateX = 0;
                    anim.translateY = 0;
                    anim.scale = 1.5f - (0.5f * progress);  // Scale from 1.5 to 1.0
                }
                break;

            case 8: // ANIM_BOUNCE
                {
                    anim.opacity = progress;
                    anim.translateX = 0;
                    // Bounce effect: overshoot and settle
                    float bounce = std::sin(progress * 3.14159f) * (1.0f - progress) * 50.0f;
                    anim.translateY = -bounce;
                    anim.scale = 1.0f;
                }
                break;

            case 9: // ANIM_ROTATE
                {
                    anim.opacity = progress;
                    anim.translateX = 0;
                    anim.translateY = 0;
                    anim.scale = progress;
                    // Note: rotation would need separate handling in ImGui
                }
                break;

            case 10: // ANIM_CAROUSEL (horizontal scrolling)
                {
                    // For carousel, progress represents the continuous scroll position
                    // This will be handled differently in the main rendering code
                    anim.opacity = 1.0f;
                    anim.translateX = 0;  // Will be calculated per-section, not per-card
                    anim.translateY = 0;
                    anim.scale = 1.0f;
                }
                break;

            default: // ANIM_NONE
                anim.opacity = 1.0f;
                anim.translateX = 0;
                anim.translateY = 0;
                anim.scale = 1.0f;
                break;
        }
    }

    static float EaseOutCubic(float t) {
        float f = t - 1.0f;
        return f * f * f + 1.0f;
    }
};

// Initialize static member
std::map<int, AnimationState> AnimationEngine::s_AnimationStates;

// ============================================================================
// TRANSITION ENGINE (for hover effects)
// ============================================================================

struct TransitionState {
    float hoverProgress;       // 0.0 (not hovered) to 1.0 (fully hovered)
    float scaleMultiplier;     // Current scale (1.0 = normal, 1.05 = hovered)
    float brightness;          // Brightness multiplier (1.0 = normal, 1.1 = brighter)

    TransitionState()
        : hoverProgress(0.0f), scaleMultiplier(1.0f), brightness(1.0f) {}
};

class TransitionEngine {
private:
    static std::map<int, TransitionState> s_TransitionStates;

public:
    /**
     * Update transition (smooth hover effect)
     * @param elementId - Unique element ID
     * @param isHovered - Is element currently hovered?
     * @param deltaTime - Time since last frame
     * @param transitionDuration - Transition duration (default 0.3s)
     * @return Current transition state
     */
    static TransitionState& UpdateTransition(
        int elementId,
        bool isHovered,
        float deltaTime,
        float transitionDuration = 0.3f
    ) {
        // Get or create transition state
        if (s_TransitionStates.find(elementId) == s_TransitionStates.end()) {
            s_TransitionStates[elementId] = TransitionState();
        }

        TransitionState& trans = s_TransitionStates[elementId];

        // Target hover progress
        float target = isHovered ? 1.0f : 0.0f;

        // Smooth interpolation (exponential ease)
        float speed = 1.0f / transitionDuration;
        float delta = (target - trans.hoverProgress) * speed * deltaTime * 10.0f;
        trans.hoverProgress += delta;

        // Clamp to [0, 1]
        trans.hoverProgress = std::max(0.0f, std::min(1.0f, trans.hoverProgress));

        // Calculate derived properties
        trans.scaleMultiplier = 1.0f + (0.05f * trans.hoverProgress);  // Scale 1.0 -> 1.05
        trans.brightness = 1.0f + (0.1f * trans.hoverProgress);        // Brighten by 10%

        return trans;
    }

    /**
     * Apply transition transform to layout box
     */
    static LayoutRect ApplyTransitionTransform(const LayoutRect& box, const TransitionState& trans) {
        LayoutRect result = box;

        // Apply scale from center
        if (trans.scaleMultiplier != 1.0f) {
            float centerX = box.x + box.width / 2.0f;
            float centerY = box.y + box.height / 2.0f;
            float scaledWidth = box.width * trans.scaleMultiplier;
            float scaledHeight = box.height * trans.scaleMultiplier;
            result.x = centerX - scaledWidth / 2.0f;
            result.y = centerY - scaledHeight / 2.0f;
            result.width = scaledWidth;
            result.height = scaledHeight;
        }

        return result;
    }

    /**
     * Apply brightness to color
     */
    static void ApplyBrightness(float& r, float& g, float& b, float brightness) {
        r = std::min(r * brightness, 1.0f);
        g = std::min(g * brightness, 1.0f);
        b = std::min(b * brightness, 1.0f);
    }

    /**
     * Reset all transitions
     */
    static void ResetAllTransitions() {
        s_TransitionStates.clear();
    }
};

// Initialize static member
std::map<int, TransitionState> TransitionEngine::s_TransitionStates;
