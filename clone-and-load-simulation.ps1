# clone-and-load-simulation.ps1
# Very simple: clone a GitHub repo and copy a YAML simulation file into the local Simulator workspace.

param(
    # HTTPS Git repo URL
    [string]$RepoUrl = "https://github.com/jarrod-grayson/simulation.git",

    # Path inside the repo to the YAML file you want to load
    [string]$SimFilePathInRepo = "Tricentis Demo CoffeeShop.yml",

    # Folder to clone into (temporary working directory)
    [string]$ClonePath = "C:\temp\sim-repo"
)

# --- 1. Clone the repo ---
Write-Host "Cloning repo: $RepoUrl ..."
if (Test-Path $ClonePath) {
    Remove-Item -Path $ClonePath -Recurse -Force
}
git clone $RepoUrl $ClonePath

# --- 2. Locate the simulation file in the repo ---
$sourceFile = Join-Path $ClonePath $SimFilePathInRepo
Write-Host "Source simulation file: $sourceFile"

# --- 3. Simulator workspace path ---
$workspace = "C:\Users\jargr\AppData\Local\TRICENTIS\Simulation\Workspace"
Write-Host "Simulator workspace: $workspace"

# Ensure workspace exists
New-Item -ItemType Directory -Path $workspace -Force | Out-Null

# --- 4. Copy YAML into Simulator workspace ---
$targetFile = Join-Path $workspace (Split-Path $sourceFile -Leaf)
Write-Host "Copying simulation file to: $targetFile"

Copy-Item -Path $sourceFile -Destination $targetFile -Force

Write-Host "DONE. Simulation file successfully loaded into the Simulator workspace."