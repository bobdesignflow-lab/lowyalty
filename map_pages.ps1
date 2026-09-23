$htmlFiles = Get-ChildItem -Recurse -Filter *.html | Where-Object { $_.FullName -notmatch "wp-json" -and $_.FullName -notmatch "wp-admin" -and $_.FullName -notmatch "wp-content" }

$allPages = @{}
foreach ($file in $htmlFiles) {
    # e.g. "business-cards" -> "printing-services\business-cards\index.html" (or whatever the path is)
    $relPath = $file.FullName.Replace((Get-Location).Path + "\", "").Replace("\", "/")
    
    # create some keys to look up by
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($file.FullName)
    $dirName = [System.IO.Path]::GetFileName([System.IO.Path]::GetDirectoryName($file.FullName))
    
    if ($fileName -eq "index" -and $dirName -ne "") {
        $allPages[$dirName.ToLower()] = $relPath
    } else {
        $allPages[$fileName.ToLower()] = $relPath
    }
}

# Add some specific mappings
$allPages["home"] = "index.html"
$allPages["lowyalty"] = "index.html"
$allPages["books"] = "books-publications/index.html"

# Output mapping to JSON
$allPages | ConvertTo-Json -Depth 3 | Out-File "page_mappings.json" -Encoding utf8
