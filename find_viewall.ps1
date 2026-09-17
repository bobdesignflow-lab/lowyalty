# Find all lines in index.html containing href="#" and check if "View All" appears within the next 5 lines
$lines = Get-Content -Path 'index.html'
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match 'href="#"') {
        $found = $false
        $endIdx = [Math]::Min($i + 6, $lines.Count - 1)
        for ($j = $i; $j -le $endIdx; $j++) {
            if ($lines[$j] -match 'View All') {
                $found = $true
                break
            }
        }
        if ($found) {
            Write-Output ("Line " + ($i + 1) + ": " + $lines[$i].Trim())
        }
    }
}
