import subprocess

def get_bios_mac_ps():
    """Run PowerShell to get the BIOS-aligned MAC and return only the first one."""
    cmd = """
    Get-NetAdapter -Physical | 
    Where-Object { $_.Virtual -eq $false } | 
    Select-Object -ExpandProperty "MacAddress"
    """
    result = subprocess.run(["powershell", "-Command", cmd], capture_output=True, text=True)
    if result.returncode == 0:
        mac_addresses = result.stdout.strip().split("\n")
        return mac_addresses[0].replace("-", ":") if mac_addresses else None
    return None

ps_mac = get_bios_mac_ps()

