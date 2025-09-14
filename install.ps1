# ===============================
# Developer Environment Setup (Questionnaire + Failure Handling)
# ===============================

$failedInstalls = @() # track failed apps

function Install-App {
    param([string]$id, [string]$name)

    try {
        if (-not (winget list --id $id | Out-String -ErrorAction SilentlyContinue | Select-String $id)) {
            Write-Host "Installing $name..." -ForegroundColor Cyan
            winget install --id $id -e --silent --accept-package-agreements --accept-source-agreements
            if ($LASTEXITCODE -eq 0) {
                Write-Host "$name installed successfully." -ForegroundColor Green
            } else {
                throw "Installation returned error code $LASTEXITCODE"
            }
        } else {
            Write-Host "$name already installed." -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "❌ Failed to install $name ($_)" -ForegroundColor Red
        $global:failedInstalls += $name
    }
}

Write-Host "===============================" -ForegroundColor Magenta
Write-Host " Developer Setup Questionnaire" -ForegroundColor Magenta
Write-Host "===============================" -ForegroundColor Magenta

# --- Ask Questions ---
$installEssentials    = Read-Host "Install Essentials (VS Code, Git, Terminal, PowerToys, Chrome, etc.)? (y/n)"
$installRuntimes      = Read-Host "Install Languages & Runtimes (Node, NVM, Python, Java, .NET)? (y/n)"
$installPkgManagers   = Read-Host "Install Package Managers (Yarn, pnpm)? (y/n)"
$installDatabases     = Read-Host "Install Database Tools (Docker, Postman, MySQL WB, MongoDB Compass, pgAdmin, DBeaver)? (y/n)"
$installCollab        = Read-Host "Install Collaboration Tools (Slack, Zoom, Notion, GitHub Desktop)? (y/n)"
$installWSL           = Read-Host "Enable WSL2 with Ubuntu? (y/n)"
$installVSCodeExt     = Read-Host "Install Recommended VS Code Extensions? (y/n)"

Write-Host "`n================================" -ForegroundColor Cyan
Write-Host " Installing selected components..." -ForegroundColor Cyan
Write-Host "================================`n" -ForegroundColor Cyan

# --- Essentials ---
if ($installEssentials -eq "y") {
    Install-App Microsoft.VisualStudioCode "Visual Studio Code"
    Install-App Git.Git "Git"
    Install-App Microsoft.PowerToys "PowerToys"
    Install-App Microsoft.WindowsTerminal "Windows Terminal"
    Install-App Google.Chrome "Google Chrome"
    Install-App 7zip.7zip "7-Zip"
    Install-App GnuWin32.Wget "wget"
    Install-App curl "curl"
    Install-App stedolan.jq "jq"
    Install-App JanDeDobbeleer.OhMyPosh "Oh My Posh"
}

# --- Languages & Runtimes ---
if ($installRuntimes -eq "y") {
    Install-App Nodejs.Nodejs "Node.js"
    Install-App RavenPowers.NodeVersionManager "NVM for Windows"
    Install-App Python.Python.3.12 "Python 3.12"
    Install-App OpenJDK.Temurin.17.JDK "Java 17 (Temurin)"
    Install-App Microsoft.DotNet.SDK.8 ".NET SDK 8"
}

# --- Package Managers ---
if ($installPkgManagers -eq "y") {
    Install-App Yarn.Yarn "Yarn"
    Install-App pnpm.pnpm "pnpm"
}

# --- Databases & Tools ---
if ($installDatabases -eq "y") {
    Install-App Docker.DockerDesktop "Docker Desktop"
    Install-App Postman.Postman "Postman"
    Install-App NoSQLBooster.NoSQLBooster "NoSQLBooster"
    Install-App Oracle.MySQL.Workbench "MySQL Workbench"
    Install-App MongoDB.Compass.Full "MongoDB Compass"
    Install-App PostgreSQL.pgAdmin "pgAdmin"
    Install-App dbeaver.dbeaver "DBeaver"
}

# --- Collaboration Tools ---
if ($installCollab -eq "y") {
    Install-App SlackTechnologies.Slack "Slack"
    Install-App Zoom.Zoom "Zoom"
    Install-App Notion.Notion "Notion"
    Install-App GitHub.GitHubDesktop "GitHub Desktop"
}

# --- WSL2 & Linux ---
if ($installWSL -eq "y") {
    try {
        Write-Host "Enabling WSL and Virtual Machine Platform..." -ForegroundColor Cyan
        dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
        dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
        wsl --set-default-version 2
        Install-App Canonical.Ubuntu "Ubuntu (WSL2)"
        Write-Host "Ubuntu installed. Launch it once from Start Menu to complete setup." -ForegroundColor Yellow
    }
    catch {
        Write-Host "❌ Failed to setup WSL2 ($_)" -ForegroundColor Red
        $global:failedInstalls += "WSL2/Ubuntu"
    }
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
        try {
            code --install-extension $ext
            if ($LASTEXITCODE -eq 0) {
                Write-Host "VS Code extension $ext installed." -ForegroundColor Green
            } else {
                throw "Error code $LASTEXITCODE"
            }
        }
        catch {
            Write-Host "❌ Failed to install VS Code extension $ext ($_)" -ForegroundColor Red
            $global:failedInstalls += "VS Code Extension: $ext"
        }
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

# ===============================
# Final Report
# ===============================
Write-Host "`n===============================" -ForegroundColor Magenta
Write-Host " Setup complete." -ForegroundColor Green
if ($failedInstalls.Count -gt 0) {
    Write-Host "The following installs failed:" -ForegroundColor Red
    $failedInstalls | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
} else {
    Write-Host "All installs succeeded 🎉" -ForegroundColor Green
}
Write-Host " Restart your computer to finish setup." -ForegroundColor Yellow
Write-Host "===============================" -ForegroundColor Magenta
