
# 🖥 Windows MERN Tools

A PowerShell script to automate the installation of **essential developer tools and utilities** on Windows using the `winget` package manager.
This script simplifies the setup process by asking you a few **interactive questions** (like `create-next-app`), then installs a curated collection of tools commonly used for software development, web development, database management, DevOps, and collaboration.

---

## ✨ Features

* Interactive **questionnaire**: choose which categories of tools to install.
* 🖥 **Essentials**: VS Code, Git, Windows Terminal, PowerToys, Chrome, 7zip, curl, jq, Oh My Posh.
* ⚙ **Runtimes**: Node.js (with NVM), Python, Java (JDK), .NET SDK.
* 📦 **Package Managers**: Yarn, pnpm.
* 🗄 **Databases & Tools**: Docker Desktop, Postman, MySQL Workbench, NoSQLBooster, MongoDB Compass, pgAdmin, DBeaver.
* 🤝 **Collaboration Tools**: Slack, Zoom, Notion, GitHub Desktop.
* 🐧 **Linux on Windows**: WSL2 with Ubuntu.
* 🧩 **VS Code Extensions**: Installs a curated list for PowerShell, Node.js, linting/formatting, Docker, Python, REST APIs, WSL, GitHub Copilot, and more.
* 🎨 **PowerShell Profile Setup**:

  * Oh My Posh theme
  * Git prompt info (posh-git)
  * Handy Git aliases (`gs`, `ga`, `gc`, `gp`, `gl`)
  * Auto Node version switching with `.nvmrc`
  * `wsl-update` helper

---

## 📋 Tools Installed

The script installs (depending on your selections):
The script installs (depending on your selections):

* **Visual Studio Code** (with extensions)
* **Git**
* **Node.js & NVM**
* **Python**
* **Java (Temurin JDK 17)**
* **.NET SDK 8**
* **PowerToys**
* **Windows Terminal**
* **Postman**
* **Docker Desktop**
* **Google Chrome**
* **NoSQL Booster**
* **MySQL Workbench**
* **MongoDB Compass**
* **pgAdmin**
* **DBeaver**
* **Yarn & pnpm**
* **Slack, Zoom, Notion, GitHub Desktop**
* **WSL2 + Ubuntu**

And more — all configurable during the setup questionnaire.

---

## 📦 Prerequisites

* Windows 10 or 11
* `winget` package manager installed ([instructions](https://learn.microsoft.com/en-us/windows/package-manager/winget/))
* PowerShell with **administrator privileges**

Check that winget is available:

```powershell
winget --version
```

---

## ⚡ Usage

1. **Clone or download this repository**:

   ```powershell
   git clone https://github.com/<your-username>/windows-mern-tools.git
   cd windows-mern-tools
   ```

2. **Open PowerShell as Administrator**

   * Right-click Start Menu → **Windows Terminal (Admin)** or **PowerShell (Admin)**.

3. **Run the script**:

   ```powershell
   .\install.ps1
   ```

4. **Answer the prompts** (y/n for each category):

   ```
   Install Essentials (VS Code, Git, Terminal, PowerToys, Chrome, etc.)? (y/n): y
   Install Languages & Runtimes (Node, NVM, Python, Java, .NET)? (y/n): y
   Install Database Tools (Docker, MySQL Workbench, MongoDB Compass, etc.)? (y/n): n
   Install Collaboration Tools (Slack, Zoom, Notion, GitHub Desktop)? (y/n): y
   Install WSL2 with Ubuntu? (y/n): n
   Install Recommended VS Code Extensions? (y/n): y
   ```

5. Wait for installations to finish. ☕

---

## 🛠 Troubleshooting

* **`code` command not recognized**:
  The script uses VS Code’s `bin\code.cmd`. If extensions still don’t install, restart your terminal or log out/in.

* **Install failures**:

  * Ensure you have internet access.
  * Update your winget sources:

    ```powershell
    winget source update
    ```
  * Re-run the script with admin rights.

* **Extensions not installing**:
  Close VS Code before running the script.

* **WSL2 not working**:
  Run `wsl --status`. You may need to restart your computer after enabling WSL.

---

## 🧑‍💻 Customization

* To add or remove tools, edit the **`Install-App`** calls in `install.ps1`.
* To change the VS Code extension set, edit the `$extensions` array.
* To tweak PowerShell aliases and theme, edit your PowerShell profile:

  ```powershell
  notepad $PROFILE
  ```

---

## 🤝 Contributing

Contributions are welcome! 🎉

* Add new tools
* Improve error handling
* Suggest better defaults

Open a PR or issue on GitHub.

---

## 📄 License

MIT License © 2025 \[Windows MERN]

---


