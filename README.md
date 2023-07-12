# Auto Setup

This repository contains a shell script designed to automate the process of cloning and setting up development environments for different types of projects from GitHub. This tool is intended to simplify the initial setup process, allowing developers to get started more quickly.

## Features

- Automatically clones a specified GitHub repository.
- Detects the type of project (Python, Rust, Go, Java, Maven, Node.js) based on the presence of specific files.
- Sets up a `tasks.json` file in the .vscode directory of the cloned repository, which can be used by Visual Studio Code to define tasks.

## Prerequisites

Make sure you have installed all of the following prerequisites on your development machine:

- Git
- Visual Studio Code
- The appropriate development tools for your project (Python, Rust, Go, Java, Maven, Node.js)

## Usage

1. Clone this repository to your local machine using `https://github.com/AutoDevSetup/AutoSetup.git`.
2. Navigate to the cloned repository. Example: `cd AutoSetup`.
3. Make the script executable by running `chmod +x as.sh`. Replace `as.sh` with the name of the script file.
4. Run the script with the GitHub repository you want to clone as an argument. Example: `./as.sh <repo>`, where `<repo>` is the repository you want to clone. Replace `as.sh` with the name of the script file. for example: `ac.sh AutoDevSetup/AutoSetup`

The script will create a new directory, clone the GitHub repository into it, detect the project type, and create a `tasks.json` file in the .vscode directory of the cloned repository.

## Contributing

We encourage you to contribute to this project! Please check out the [Contributing to Auto Setup](https://github.com/AutoDevSetup/AutoSetup/blob/master/CONTRIBUTING.md) guide for guidelines about how to proceed.

## License

This project is licensed under the [MIT License](https://github.com/AutoDevSetup/AutoSetup/blob/master/LICENSE).
