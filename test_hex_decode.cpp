#include <iostream>
#include <vector>
#include <cstdio>
#include <cstring>

// Same decoding function from the main app
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

int main() {
    // Test with PNG header (89 50 4E 47 = PNG magic bytes)
    const char* test_hex = "\\x89504e47";

    printf("Testing PostgreSQL hex BYTEA decoding\n");
    printf("Input: %s\n", test_hex);
    printf("Expected: 0x89 0x50 0x4E 0x47 (PNG header)\n");

    std::vector<unsigned char> binary = DecodePostgresHexBytea(test_hex, strlen(test_hex));

    printf("Decoded %zu bytes: ", binary.size());
    for (size_t i = 0; i < binary.size(); i++) {
        printf("0x%02X ", binary[i]);
    }
    printf("\n");

    // Verify
    if (binary.size() == 4 &&
        binary[0] == 0x89 &&
        binary[1] == 0x50 &&
        binary[2] == 0x4E &&
        binary[3] == 0x47) {
        printf("✅ SUCCESS! Hex decoding works correctly!\n");
        return 0;
    } else {
        printf("❌ FAILED! Decoding incorrect\n");
        return 1;
    }
}
