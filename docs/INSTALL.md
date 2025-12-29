# Battleship — Installation & Build Guide

This guide provides detailed instructions for building, testing, and installing **Battleship**, a modern C++ implementation of the classic Battleship game, using **CMake presets** and GitHub Actions workflows.

> [!NOTE]
> All source and header files follow a modular and maintainable structure, supporting scalability.

---

## Table of Contents

- [Prerequisites](#prerequisites)  
- [Cloning the Repository](#cloning-the-repository)  
- [Building the Project](#building-the-project)  
  - [Development Build](#development-build-with-tests)  
  - [Release Build](#release-build-game-only)  
- [Running the Game](#running-the-game)  
- [Installing System-wide](#installing-system-wide)  
- [Continuous Integration](#continuous-integration)  

---

## Prerequisites

Before building **Battleship**, ensure the following software is installed:

- **Git** — version control system  
- **C++17 compatible compiler** (e.g., G++, Clang, MSVC)  
- **CMake ≥ 3.16** — project configuration and build management  

### Example Installation (Linux)

**Ubuntu/Debian-based systems:**

```bash
sudo apt-get update
sudo apt-get install -y build-essential cmake git
```

**Arch Linux/Manjaro:**

```bash
sudo pacman -Sy --needed base-devel git gcc cmake
```
---

## Cloning the Repository

Clone the repository and navigate into it:

```bash
git clone https://github.com/marseilodev/battleship.git
cd battleship
```
---

## Building the Project

Battleship uses CMake presets [CMakePresets](CMakePresets.json) to standardize build configurations.

> [!TIP]
> CMake presets simplify switching between build types and environments.

> [!IMPORTANT]
> - Development builds include tests and are intended for developers and CI pipelines.
> - Release builds are optimized, exclude tests, and are intended for end users.

### Development Build

This build is intended for developers and CI pipelines:

```bash
# Configure project with dev preset
cmake --preset dev

# Build project
cmake --build --preset dev
```

(Optional) Running Tests:

```bash
ctest --test-dir build --output-on-failure
```

> [!NOTE]
> All tests are implemented with [Catch2](https://catch2-temp.readthedocs.io/en/latest/index.html).

### Release Build

This build is optimized for end users, without tests:

```bash
# Configure project with release preset
cmake --preset release

# Build project
cmake --build --preset release
```

---

## Running the Game

After building, run the executable:

```bash
# Development build
./build/BattNavale

# Release build
./build-release/BattNavale
```

Alternatively, use the CMake custom target:

```bash
cmake --build --target run --preset dev
```

---

## Installing System-wide (Optional)

To install the game executable system-wide (e.g., /usr/local/bin):

```bash
cmake --install build-release
```

Once installed, the game can be run from any terminal

```bash
BattNavale
```

> [!TIP]
> If you want to install the game in a system directory like `/usr/local/bin`, you might need to use `sudo` to obtain the necessary permissions

---

## Continuous Integration

This project includes a [GitHub Actions workflow](.github/workflows/ci.yml) with two jobs:

- Build & Test (dev preset): automatically builds the project and runs tests on push or pull request.
- Release Build (release preset): builds only the executable for release purposes.

> [!TIP]
> The CI workflow ensures code quality and prevents regressions on the main and develop branches.
