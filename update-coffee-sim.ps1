# update-coffee-sim.ps1

param(
    [string]$AgentUrl = "http://localhost:17070",
    [string]$SimulationPath = "Tricentis Demo CoffeeShop.yml",
    [string]$ConnectionName = "Coffee Sim"
)

# URL-encode the path (because of spaces)
$encodedPath = [System.Uri]::EscapeDataString($SimulationPath)

Write-Host "Getting connections for simulation path '$SimulationPath' ..."
$connections = Invoke-RestMethod -Method Get -Uri "$AgentUrl/api/connections?path=$encodedPath"

# Find the Coffee Sim connection
$connection = $connections | Where-Object { $_.name -eq $ConnectionName }

if (-not $connection) {
    throw "Connection '$ConnectionName' not found for path '$SimulationPath'."
}

$connectionId = $connection.id

Write-Host "Found connection '$($connection.name)' with id: $connectionId"
Write-Host "Current forward:" ($connection.forward | ConvertTo-Json -Depth 5)

# --- Update the mode property only ---

$connection.forward.mode = "ForwardFirst"

Write-Host "Updated mode to ForwardFirst."

# Convert back to JSON
$bodyJson = $connection | ConvertTo-Json -Depth 10

Write-Host "Sending update..."
Write-Host $bodyJson

# PUT updated object back to the agent
Invoke-RestMethod `
    -Method Put `
    -Uri "$AgentUrl/api/connections/$connectionId" `
    -Body $bodyJson `
    -ContentType "application/json"

Write-Host "Connection '$($connection.name)' updated successfully."