$directory = (Get-Location).Path
$htmlFiles = Get-Content "html_list.txt"
$mappings = Get-Content "page_mappings.json" | ConvertFrom-Json

$specialMappings = @{
    "company" = "about/index.html"
    "about us" = "about/index.html"
    "contact us" = "contact/index.html"
    "enquire" = "contact/index.html"
    "books" = "books-publications/index.html"
    "home" = "index.html"
    "lowyalty" = "index.html"
    "shop" = "shop/index.html"
}

$fixedCount = 0
$filesModified = 0

foreach ($file in $htmlFiles) {
    if (-not (Test-Path $file)) { continue }
    
    $content = Get-Content $file -Raw -ErrorAction SilentlyContinue
    if (-not $content) { continue }
    
    $originalContent = $content
    $modified = $false
    
    $matches = [regex]::Matches($content, '(?i)<a\s+[^>]*href=["''](.*?)["''][^>]*>(.*?)</a>')
    
    # Process matches in reverse to replace by index if we need to, but regex replace with exact href is safer if we just match exactly.
    # Actually, replacing all occurrences of that exact href is usually fine, but to be safe, let's just do it.
    
    # Since we want to only modify the matched href, a safe way is to iterate over the matches
    foreach ($m in $matches) {
        $href = $m.Groups[1].Value
        $textRaw = $m.Groups[2].Value
        
        if ($href -match "^http" -or $href -match "^mailto:" -or $href -match "^tel:") {
            continue
        }
        
        $text = $textRaw -replace '<[^>]+>', ''
        $text = $text.Trim()
        
        $target = $null
        
        $cleanText = $text.ToLower() -replace '[^a-z0-9]', '-'
        $cleanText = $cleanText -replace '--+', '-'
        $cleanText = $cleanText.Trim('-')
        
        if ($specialMappings.ContainsKey($cleanText)) {
            $target = $specialMappings[$cleanText]
        } elseif ($mappings.psobject.properties.name -contains $cleanText) {
            $target = $mappings.$cleanText
        } else {
            # Try matching based on href
            $cleanHref = $href -replace '\.html$', ''
            $cleanHref = $cleanHref -replace '^(\.\./)+', ''
            $cleanHref = $cleanHref -replace '/$', ''
            $cleanHref = [System.IO.Path]::GetFileNameWithoutExtension($cleanHref)
            
            if ($cleanHref -and $mappings.psobject.properties.name -contains $cleanHref) {
                $target = $mappings.$cleanHref
            }
        }
        
        if ($target) {
            $targetFullPath = [System.IO.Path]::Combine($directory, $target.Replace("/", "\"))
            $fileUri = [System.Uri]::new($file)
            $targetUri = [System.Uri]::new($targetFullPath)
            
            $relativeUri = $fileUri.MakeRelativeUri($targetUri).ToString()
            $newHref = [uri]::UnescapeDataString($relativeUri)
            
            if ($newHref -eq "") {
                $newHref = [System.IO.Path]::GetFileName($file)
            }
            
            if ($href -ne $newHref) {
                # replace all occurrences of this exact href in this specific a tag?
                # Actually, simply replacing href="old" with href="new" globally in the file is easiest if we restrict to safe ones.
                # BUT replacing `href=""` globally could break things. 
                # Let's replace the EXACT match string of the anchor tag.
                
                $oldA = $m.Value
                $newA = $oldA -replace [regex]::Escape("href=`"$href`""), "href=`"$newHref`""
                $newA = $newA -replace [regex]::Escape("href='$href'"), "href='$newHref'"
                
                if ($oldA -ne $newA) {
                    $content = $content.Replace($oldA, $newA)
                    $fixedCount++
                    $modified = $true
                }
            }
        }
    }
    
    if ($modified) {
        # Fix generic view-all for specific categories based on previous DOM structures 
        # (if any were missed by the loop)
        [IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        $filesModified++
    }
}

Write-Output "Fixed $fixedCount links across $filesModified files."
