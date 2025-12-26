cmake_minimum_required(VERSION 3.16)

# ---------------------------
# Project
# ---------------------------
project(Battleship VERSION 1.0 LANGUAGES CXX)

# ---------------------------
# C++ Standard & Compiler Warnings
# ---------------------------
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Compiler warnings
if(MSVC)
	add_compile_options(/W4 /permissive-)
else()
	add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# ---------------------------
# Build type defaults
# ---------------------------
if(NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE Release CACHE STRING
		"Choose the type of build (Debug or Release)" FORCE)
endif()

set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g -O0")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O2")

# ---------------------------
# Source files
# ---------------------------
file(GLOB_RECURSE SRC_FILES
	"${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
)

# ---------------------------
# Executable target
# ---------------------------
add_executable(BattNavale ${SRC_FILES})

# Include directories
target_include_directories(BattNavale
	PRIVATE
		"${CMAKE_CURRENT_SOURCE_DIR}/include"
)

# ---------------------------
# Optional: Run target
# ---------------------------
add_custom_target(run
	COMMAND BattNavale
	DEPENDS BattNavale
	WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
	COMMENT "Running BattNavale..."
)

# ---------------------------
# Optional: Install target
# ---------------------------
install(TARGETS BattNavale
	RUNTIME DESTINATION bin
)

# ---------------------------
# Optional: Enable testing
# ---------------------------
enable_testing()
