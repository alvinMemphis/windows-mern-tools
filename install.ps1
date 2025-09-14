# ===============================
# Developer Environment Setup (Questionnaire Style)
# ===============================

function Install-App {
    param([string]$id)
    if (-not (winget list --id $id | Out-String -ErrorAction SilentlyContinue | Select-String $id)) {
        Write-Output "Installing $id..."
        winget install --id $id -e --silent
    } else {
        Write-Output "$id already installed."
    }
}

Write-Output "==============================="
Write-Output " Developer Setup Questionnaire"
Write-Output "==============================="

# --- Ask Questions ---
$installEssentials    = Read-Host "Install Essentials (VS Code, Git, Terminal, PowerToys, Chrome, etc.)? (y/n)"
$installRuntimes      = Read-Host "Install Languages & Runtimes (Node, NVM, Python, Java, .NET)? (y/n)"
$installPkgManagers   = Read-Host "Install Package Managers (Yarn, pnpm)? (y/n)"
$installDatabases     = Read-Host "Install Database Tools (Docker, Postman, MySQL WB, MongoDB Compass, pgAdmin, DBeaver)? (y/n)"
$installCollab        = Read-Host "Install Collaboration Tools (Slack, Zoom, Notion, GitHub Desktop)? (y/n)"
$installWSL           = Read-Host "Enable WSL2 with Ubuntu? (y/n)"
$installVSCodeExt     = Read-Host "Install Recommended VS Code Extensions? (y/n)"

Write-Output "`n================================"
Write-Output " Installing selected components..."
Write-Output "================================`n"

# --- Essentials ---
if ($installEssentials -eq "y") {
    Install-App Microsoft.VisualStudioCode
    Install-App Git.Git
    Install-App Microsoft.PowerToys
    Install-App Microsoft.WindowsTerminal
    Install-App Google.Chrome
    Install-App 7zip.7zip
    Install-App GnuWin32.Wget
    Install-App curl
    Install-App stedolan.jq
    Install-App JanDeDobbeleer.OhMyPosh
}

# --- Languages & Runtimes ---
if ($installRuntimes -eq "y") {
    Install-App Nodejs.Nodejs
    Install-App RavenPowers.NodeVersionManager
    Install-App Python.Python.3.12
    Install-App OpenJDK.Temurin.17.JDK
    Install-App Microsoft.DotNet.SDK.8
}

# --- Package Managers ---
if ($installPkgManagers -eq "y") {
    Install-App Yarn.Yarn
    Install-App pnpm.pnpm
}

# --- Databases & Tools ---
if ($installDatabases -eq "y") {
    Install-App Docker.DockerDesktop
    Install-App Postman.Postman
    Install-App NoSQLBooster.NoSQLBooster
    Install-App Oracle.MySQL.Workbench
    Install-App MongoDB.Compass.Full
    Install-App PostgreSQL.pgAdmin
    Install-App dbeaver.dbeaver
}

# --- Collaboration Tools ---
if ($installCollab -eq "y") {
    Install-App SlackTechnologies.Slack
    Install-App Zoom.Zoom
    Install-App Notion.Notion
    Install-App GitHub.GitHubDesktop
}

# --- WSL2 & Linux ---
if ($installWSL -eq "y") {
    Write-Output "Enabling WSL and Virtual Machine Platform..."
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    wsl --set-default-version 2
    Install-App Canonical.Ubuntu
    Write-Output "Ubuntu installed. Launch it once from Start Menu to complete setup."
}

# --- VS Code Extensions ---
if ($installVSCodeExt -eq "y") {
    $extensions = @(
        "ms-vscode.PowerShell",
        "formulahendry.code-runner",
        "dbaeumer.vscode-eslint",
        "esbenp.prettier-vscode",
        "redhat.vscode-yaml",
        "ms-azuretools.vscode-docker",
        "ms-vscode.vscode-node-azure-pack",
        "github.github-vscode-theme",
        "github.copilot",
        "ms-python.python",
        "ms-toolsai.jupyter",
        "ms-vscode.cpptools",
        "ms-vscode.intellicode",
        "humao.rest-client",
        "EditorConfig.EditorConfig",
        "ms-vscode-remote.remote-wsl"
    )
    foreach ($ext in $extensions) {
        code --install-extension $ext
    }
}

# ===============================
# PowerShell Profile Setup
# ===============================
$profilePath = $PROFILE
if (-not (Test-Path -Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force
}

@"
# --- Custom PowerShell Profile ---

# Oh My Posh setup
oh-my-posh init pwsh | Invoke-Expression

# posh-git for Git info in prompt
if (Get-Module -ListAvailable -Name posh-git) {
    Import-Module posh-git
}

# Aliases
Set-Alias gs 'git status'
Set-Alias ga 'git add'
Set-Alias gc 'git commit'
Set-Alias gp 'git push'
Set-Alias gl 'git log --oneline --graph --decorate'

# Auto-switch Node version if .nvmrc exists
function Use-Nvmrc {
    if (Test-Path .nvmrc) {
        $version = Get-Content .nvmrc | Select-Object -First 1
        nvm use $version
    }
}

# WSL helper: update packages quickly
function wsl-update {
    wsl sudo apt update && wsl sudo apt upgrade -y && wsl sudo apt autoremove -y
}
"@ | Out-File -FilePath $profilePath -Encoding utf8 -Append

Write-Output "`n==============================="
Write-Output " Setup complete."
Write-Output " Restart your computer to finish setup."
Write-Output "==============================="
