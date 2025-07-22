# Ensure the script is run as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ This script must be run as Administrator!" -ForegroundColor Red
    exit
}

# 1. Change computer name to "client"
Rename-Computer -NewName "client" -Force

# 2. Get the active network adapter (you can customize the alias if needed)
$adapter = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | Select-Object -First 1

# 3. Remove existing IP addresses (IPv4 only)
Get-NetIPAddress -InterfaceAlias $adapter.Name -AddressFamily IPv4 | Remove-NetIPAddress -Confirm:$false

# 4. Set new static IP address and subnet mask (PrefixLength 24 = 255.255.255.0)
New-NetIPAddress -InterfaceAlias $adapter.Name `
                 -IPAddress "192.168.10.11" `
                 -PrefixLength 24 `
                 -DefaultGateway "192.168.10.10"

# 5. Set primary DNS server
Set-DnsClientServerAddress -InterfaceAlias $adapter.Name `
                           -ServerAddresses "192.168.10.10"

# 6. Turn off all firewalls
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# 7. Reboot the system to apply all changes
Restart-Computer -Force
