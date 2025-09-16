# 🖥 Windows MERN Tools

A PowerShell script to automate the installation of **essential developer tools and utilities** on Windows using the `winget` package manager.  
This script simplifies the setup process by asking you a few **interactive questions** (like `create-next-app`), then installs a curated collection of tools commonly used for software development, web development, database management, DevOps, and collaboration.

---

## ✨ Features

- Interactive **questionnaire**: choose which categories of tools to install.  
- 🖥 **Essentials**: VS Code, Git, Windows Terminal, PowerToys, Chrome, 7zip, curl, jq, Oh My Posh.  
- ⚙ **Runtimes**: Node.js (with NVM), Python, Java (JDK), .NET SDK.  
- 📦 **Package Managers**: Yarn, pnpm.  
- 🗄 **Databases & Tools**: Docker Desktop, Postman, MySQL Workbench, NoSQLBooster, MongoDB Compass, pgAdmin, DBeaver.  
- 🤝 **Collaboration Tools**: Slack, Zoom, Notion, GitHub Desktop.  
- 🐧 **Linux on Windows**: WSL2 with Ubuntu.  
- 🧩 **VS Code Extensions**: Installs a curated list for PowerShell, Node.js, linting/formatting, Docker, Python, REST APIs, WSL, GitHub Copilot, and more.  
- 🎨 **PowerShell Profile Setup**:  
  - Oh My Posh theme  
  - Git prompt info (posh-git)  
  - Handy Git aliases (`gs`, `ga`, `gc`, `gp`, `gl`)  
  - Auto Node version switching with `.nvmrc`  
  - `wsl-update` helper  

---

## 📋 Tools Installed

The script installs (depending on your selections):

- **Visual Studio Code** (with extensions)  
- **Git**  
- **Node.js & NVM**  
- **Python**  
- **Java (Temurin JDK 17)**  
- **.NET SDK 8**  
- **PowerToys**  
- **Windows Terminal**  
- **Postman**  
- **Docker Desktop**  
- **Google Chrome**  
- **NoSQL Booster**  
- **MySQL Workbench**  
- **MongoDB Compass**  
- **pgAdmin**  
- **DBeaver**  
- **Yarn & pnpm**  
- **Slack, Zoom, Notion, GitHub Desktop**  
- **WSL2 + Ubuntu**  

And more — all configurable during the setup questionnaire.

---

## 📦 Prerequisites

- Windows 10 or 11  
- `winget` package manager installed ([instructions](https://learn.microsoft.com/en-us/windows/package-manager/winget/))  
- PowerShell with **administrator privileges**  

Check that winget is available:
```powershell
winget --version
