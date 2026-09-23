$directory = (Get-Location).Path
$htmlFiles = Get-Content "html_list.txt"
$mappings = Get-Content "page_mappings.json" | ConvertFrom-Json

# Hardcode some footer / special link text mappings
$specialMappings = @{
    "company" = "about/index.html"
    "about us" = "about/index.html"
    "contact us" = "contact/index.html"
    "enquire" = "contact/index.html"
    "books" = "books-publications/index.html"
    "home" = "index.html"
    "lowyalty" = "index.html"
}

$results = @()

foreach ($file in $htmlFiles) {
    # read file
    $content = Get-Content $file -Raw -ErrorAction SilentlyContinue
    if (-not $content) { continue }
    
    # regex to find links: <a [^>]*href=["'](.*?)["'][^>]*>(.*?)</a>
    # Note: capturing text might be tricky if there are nested tags, but we can do a simplified regex
    $matches = [regex]::Matches($content, '(?i)<a[^>]+href=["''](.*?)["''][^>]*>(.*?)</a>')
    
    foreach ($m in $matches) {
        $href = $m.Groups[1].Value
        $textRaw = $m.Groups[2].Value
        
        # clean text (remove inner tags, trim)
        $text = $textRaw -replace '<[^>]+>', ''
        $text = $text.Trim()
        
        $status = "LEAVE"
        $newHref = $href
        
        # skip external
        if ($href -match "^http" -or $href -match "^mailto:" -or $href -match "^tel:") {
            $status = "EXTERNAL"
            continue
        }
        
        # Determine intended target based on text or current href
        $target = $null
        
        $cleanText = $text.ToLower() -replace '[^a-z0-9]', '-'
        $cleanText = $cleanText -replace '--+', '-'
        $cleanText = $cleanText.Trim('-')
        
        if ($specialMappings.ContainsKey($cleanText)) {
            $target = $specialMappings[$cleanText]
        } elseif ($mappings.psobject.properties.name -contains $cleanText) {
            $target = $mappings.$cleanText
        } else {
            # Try matching based on href if text is generic like "View All"
            if ($cleanText -eq "view-all" -or $cleanText -eq "") {
                # Could try to infer from href
                $cleanHref = $href -replace '\.html$', ''
                $cleanHref = $cleanHref -replace '^(\.\./)+', ''
                $cleanHref = $cleanHref -replace '/$', ''
                $cleanHref = [System.IO.Path]::GetFileNameWithoutExtension($cleanHref)
                if ($mappings.psobject.properties.name -contains $cleanHref) {
                    $target = $mappings.$cleanHref
                }
            }
        }
        
        # if target found, calculate relative path
        if ($target) {
            # Target is absolute path relative to web root
            $targetFullPath = [System.IO.Path]::Combine($directory, $target.Replace("/", "\"))
            
            # File full path
            $fileFullPath = $file
            
            $fileUri = [System.Uri]::new($fileFullPath)
            $targetUri = [System.Uri]::new($targetFullPath)
            
            $relativeUri = $fileUri.MakeRelativeUri($targetUri).ToString()
            $newHref = [uri]::UnescapeDataString($relativeUri)
            
            if ($newHref -eq "") {
                $newHref = [System.IO.Path]::GetFileName($file)
            }
            
            if ($href -ne $newHref) {
                $status = "FIXED"
            } else {
                $status = "OK"
            }
        } else {
            if ($href -eq "#" -or $href -eq "") {
                $status = "MISSING_NO_TARGET"
            } else {
                $status = "UNKNOWN_TARGET"
            }
        }
        
        if ($status -eq "FIXED" -or $status -eq "MISSING_NO_TARGET") {
            $results += [PSCustomObject]@{
                File = $file.Replace($directory + "\", "")
                Text = $text
                CurrentHref = $href
                NewHref = $newHref
                Status = $status
            }
        }
    }
}

$results | Select-Object -Unique -First 500 | Export-Csv -Path "link_audit.csv" -NoTypeInformation -Encoding utf8
$results.Count | Out-File "link_audit_count.txt"
