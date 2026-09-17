$content = Get-Content -Path 'index.html' -Raw
$content = $content -replace '(?is)(<h4[^>]*>Apparels</h4>.*?href=)"#("[^>]*>.*?View All)', '${1}"/printing-services-category/https-lowyalty-ke-apparels/index.html$2'
if ($content -match 'href="/printing-services-category/https-lowyalty-ke-apparels/index.html"[^>]*>.*?View All') {
    Write-Output "Matched replacement!"
} else {
    Write-Output "Replacement failed."
}
