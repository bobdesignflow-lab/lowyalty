$ErrorActionPreference = "Continue"

$rootDir = "c:\My Web Sites\Lowyalty\Lowyalty Website"
$countFixed = 0
$countSkipped = 0
$countFailed = 0

# Regex to match the WhatsApp Channel link and the following <br /> tag
$pattern = '(?i)<a[^>]*href=["'']https://wa\.link/2vmyd5["''][^>]*>\s*<span[^>]*>\s*WhatsApp Channel\s*</span>\s*</a>\s*<br\s*/?>'

Get-ChildItem -Path $rootDir -Filter "*.html" -Recurse -File | ForEach-Object {
    $file = $_.FullName

    if ($file -match '\\(wp-includes|wp-admin|wp-content|cdn-cgi|hts-cache)\\') {
        $script:countSkipped++
        return
    }

    try {
        $content = [System.IO.File]::ReadAllText($file)
        
        if ($content -match $pattern) {
            $newContent = [regex]::Replace($content, $pattern, '')
            [System.IO.File]::WriteAllText($file, $newContent, [System.Text.Encoding]::UTF8)
            $script:countFixed++
        } else {
            $script:countSkipped++
        }
    } catch {
        $script:countFailed++
        Write-Host "ERROR on file $file - $_" -ForegroundColor Red
    }
}

Write-Host "Batch update complete! Removed WhatsApp Channel from $countFixed files, Skipped: $countSkipped, Failed: $countFailed"
