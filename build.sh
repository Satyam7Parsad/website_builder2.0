#!/bin/bash

echo "Building ImGui Website Designer..."

# Compile ImGui and main app together
clang++ -std=c++17 -O2 \
  imgui_website_designer.cpp \
  imgui/imgui.cpp \
  imgui/imgui_draw.cpp \
  imgui/imgui_tables.cpp \
  imgui/imgui_widgets.cpp \
  imgui/backends/imgui_impl_glfw.cpp \
  imgui/backends/imgui_impl_opengl3.cpp \
  -o imgui_website_designer \
  -I./imgui \
  -I./imgui/backends \
  -I/usr/local/include/postgresql@14 \
  -I/opt/homebrew/include \
  -I/usr/local/include \
  -L/usr/local/Cellar/postgresql@14/14.19/lib/postgresql@14 \
  -L/usr/local/lib \
  -lpq \
  -lglfw \
  -framework OpenGL \
  -framework Cocoa \
  -framework IOKit \
  -framework CoreVideo

if [ $? -eq 0 ]; then
  echo "Build successful! Run with: ./imgui_website_designer"
else
  echo "Build failed!"
  exit 1
fi
