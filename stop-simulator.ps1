# stop-simulator.ps1

param(
    [string]$AgentUrl = "http://localhost:17070"
)

Write-Host "Stopping Simulator Agent via API..."
Invoke-RestMethod -Method Post -Uri "$AgentUrl/api/agent/close"