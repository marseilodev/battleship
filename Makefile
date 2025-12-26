# ---------------------------
# Project configuration
# ---------------------------
TARGET_NAME := BattNavale

CXX := g++
CXXFLAGS := -Wall -Wextra -Wpedantic -std=c++17 -Iinclude -MMD -MP

SRC_DIR   := src
BUILD_DIR := build
OBJ_DIR   := $(BUILD_DIR)/obj
BIN_DIR   := $(BUILD_DIR)/bin

TARGET := $(BIN_DIR)/$(TARGET_NAME)

# ---------------------------
# Source files (automatic discovery)
# ---------------------------
SRCS := $(shell find $(SRC_DIR) -name '*.cpp')
OBJS := $(SRCS:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

# ---------------------------
# Build type (release/debug)
# ---------------------------
BUILD ?= release
ifeq ($(BUILD),debug)
	CXXFLAGS += -g -O0
else
	CXXFLAGS += -O2
endif

# Treat warnings as errors (optional, recommended for CI)
# CXXFLAGS += -Werror

# ---------------------------
# Default targets
# ---------------------------
.PHONY: all clean run install

all: $(TARGET)

# ---------------------------
# Build executable
# ---------------------------
$(TARGET): $(OBJS)
	@mkdir -p $(BIN_DIR)
	@$(CXX) $(CXXFLAGS) $^ -o $@

# ---------------------------
# Build object files
# ---------------------------
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	@$(CXX) $(CXXFLAGS) -c $< -o $@

# ---------------------------
# Run the program
# ---------------------------
run: all
	@echo "Starting Battleship..."
	@$(TARGET)

# ---------------------------
# Install target
# ---------------------------
PREFIX ?= /usr/local
install: $(TARGET)
	@echo "Installing $(TARGET) to $(PREFIX)/bin..."
	install -Dm755 $(TARGET) $(PREFIX)/bin/$(TARGET_NAME)

# ---------------------------
# Clean build artifacts
# ---------------------------
clean:
	rm -rf $(BUILD_DIR)

# ---------------------------
# Include dependency files
# ---------------------------
-include $(OBJS:.o=.d)
