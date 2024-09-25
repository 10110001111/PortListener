# Function to start listening on a port
function Start-PortListener {
    param (
        [int]$Port = 8090
    )
    
    $endpoint = New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Any, $Port)
    $listener = New-Object System.Net.Sockets.TcpListener $endpoint
    
    try {
        $listener.Start()
        Write-Host "Listening on port $Port. Press Ctrl+C to stop."
        
        while ($true) {
            if ($listener.Pending()) {
                $client = $listener.AcceptTcpClient()
                $clientEndPoint = $client.Client.RemoteEndPoint
                Write-Host "Connection received from $clientEndPoint"
                $client.Close()
            }
            Start-Sleep -Milliseconds 100
        }
    }
    finally {
        $listener.Stop()
    }
}

# Usage example
Start-PortListener -Port 8090
