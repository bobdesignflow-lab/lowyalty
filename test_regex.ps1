$content = Get-Content -Path 'index.html' -Raw
if ($content -match '(?s)(Apparels.{0,1000}?)View All') {
    Write-Output $matches[0]
}
