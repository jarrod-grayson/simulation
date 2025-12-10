# start-simulator.ps1

param(
    # Update this to the actual path of your Simulator Agent EXE
    [string]$AgentExePath = "C:\Users\jargr\AppData\Local\TRICENTIS\Simulation\Tricentis.Simulator.Agent.exe"
)

Write-Host "Starting Simulator Agent: $AgentExePath"
Start-Process -FilePath $AgentExePath