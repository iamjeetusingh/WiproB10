# on server
# Ensure the script is run as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "You must run this script as an Administrator!"
    exit
}

# Change computer name to 'dc'
Rename-Computer -NewName "dc" -Force

# Get the name of the active network adapter
$adapter = Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1

# Set IP address, subnet mask and default gateway
New-NetIPAddress -InterfaceAlias $adapter.Name `
                 -IPAddress "192.168.10.10" `
                 -PrefixLength 24 `
                 -DefaultGateway "192.168.10.10"

# Set primary DNS server
Set-DnsClientServerAddress -InterfaceAlias $adapter.Name `
                           -ServerAddresses "192.168.10.10"

# Turn off all firewalls
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Reboot the system
Restart-Computer -Force
