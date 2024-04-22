# windows-mern-tools
A PowerShell script to automate the installation of essential developer tools and utilities on Windows using the winget package manager. This script simplifies the setup process for developers by installing a curated collection of tools and applications commonly used for software development, web development, database management, DevOps, and more.

## Description

This repository contains a PowerShell script that leverages the `winget` package manager to install a curated collection of developer tools and utilities. The script aims to streamline the setup process for developers by automating the installation of popular applications used for software development, web development, database management, DevOps, and more.

## Tools Installed

The script installs the following tools and applications:

- **Visual Studio Code**: A popular code editor
- **Git**: Distributed version control system
- **Node.js and Node Version Manager (nvm)**: JavaScript runtime and version manager
- **PowerToys**: Utilities for power users
- **Windows Terminal**: Modern terminal application
- **Postman**: Collaboration platform for API development
- **Docker Desktop**: Tool for building and running containerized applications
- **Google Chrome**: Web browser
- **NoSQL Booster**: GUI tool for NoSQL databases
- **MySQL Workbench**: Visual database design and administration tool for MySQL
- **Various Visual Studio Code extensions**: Extensions for PowerShell, code running, linting, formatting, YAML, Docker, Node.js, Azure, GitHub security, and EditorConfig

## Usage

1. Clone the repository or download the `install.ps1` script.
2. Open PowerShell with administrative privileges.
3. Navigate to the directory containing the `install.ps1` script.
4. Run the script: `.\install.ps1`

The script will start installing the specified tools and applications using `winget`. Please note that some packages may require additional prompts or actions during the installation process.

## Prerequisites

- Windows 10 or later
- `winget` package manager installed ([instructions](https://learn.microsoft.com/en-us/windows/package-manager/winget/))

## Customization

The `install.ps1` script can be easily modified to add or remove tools based on your specific requirements. Simply edit the script and add or remove the corresponding `winget install` commands.

## Contributing

Contributions to this project are welcome. If you have any suggestions, improvements, or additional tools to include, please submit a pull request or open an issue.

## License

This project is licensed under the [MIT License](LICENSE).
