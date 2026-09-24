$ErrorActionPreference = "Continue"

$newTopbarCSS = @"
<style id="topbar-center-override">
/* Desktop Top Bar: Centered single line */
@media (min-width: 1025px) {
    .l-subheader.at_top {
        overflow: hidden !important;
        white-space: nowrap !important;
        background: #231f20 !important;
        color: #ffffff !important;
    }
    .l-subheader.at_top .l-subheader-h {
        display: flex !important;
        flex-wrap: nowrap !important;
        justify-content: center !important;
        align-items: center !important;
        gap: 0 18px !important;
        width: 100% !important;
    }
    .l-subheader.at_top .l-subheader-cell.at_left,
    .l-subheader.at_top .l-subheader-cell.at_right {
        display: inline-flex !important;
        flex-wrap: nowrap !important;
        align-items: center !important;
        justify-content: center !important;
        flex-grow: 0 !important;
        flex-shrink: 1 !important;
        gap: 0 18px !important;
    }
    .l-subheader.at_top .l-subheader-cell.at_center {
        display: none !important;
    }
    .l-subheader.at_top .w-text {
        white-space: nowrap !important;
        font-size: 13.5px !important;
        flex-shrink: 0 !important;
        color: #ffffff !important;
    }
    .l-subheader.at_top .w-text-value {
        white-space: nowrap !important;
        font-size: 13.5px !important;
        color: #ffffff !important;
    }
    .l-subheader.at_top a {
        color: #ffffff !important;
    }
    .l-subheader.at_top i.fas,
    .l-subheader.at_top .w-text i {
        font-size: 13px !important;
        color: #ed2127 !important;
    }
}

/* Mobile & Tablet Top Bar: Stacked responsive layout displaying 2 locations, email, and phone numbers in crisp white text */
@media (max-width: 1024px) {
    .l-subheader.at_top {
        padding: 8px 10px !important;
        height: auto !important;
        min-height: auto !important;
        line-height: normal !important;
        overflow: visible !important;
        white-space: normal !important;
        display: block !important;
        background: #231f20 !important;
        color: #ffffff !important;
    }
    .l-subheader.at_top .l-subheader-h {
        height: auto !important;
        min-height: auto !important;
        line-height: normal !important;
        display: flex !important;
        flex-direction: column !important;
        flex-wrap: wrap !important;
        align-items: center !important;
        justify-content: center !important;
        gap: 6px !important;
        width: 100% !important;
    }
    .l-subheader.at_top .l-subheader-cell.at_left,
    .l-subheader.at_top .l-subheader-cell.at_right {
        display: flex !important;
        flex-direction: column !important;
        flex-wrap: wrap !important;
        align-items: center !important;
        justify-content: center !important;
        gap: 5px !important;
        width: 100% !important;
        text-align: center !important;
    }
    .l-subheader.at_top .l-subheader-cell.at_center {
        display: none !important;
    }
    .l-subheader.at_top .w-text {
        white-space: normal !important;
        font-size: 11.5px !important;
        line-height: 1.35 !important;
        text-align: center !important;
        display: flex !important;
        justify-content: center !important;
        height: auto !important;
        flex-shrink: 0 !important;
        color: #ffffff !important;
        opacity: 1 !important;
        visibility: visible !important;
    }
    .l-subheader.at_top .w-text-h {
        white-space: normal !important;
        text-align: center !important;
        justify-content: center !important;
        height: auto !important;
        line-height: 1.35 !important;
        display: inline-flex !important;
        flex-wrap: wrap !important;
        align-items: center !important;
        gap: 4px !important;
        color: #ffffff !important;
    }
    .l-subheader.at_top .w-text-value {
        white-space: normal !important;
        overflow: visible !important;
        text-overflow: unset !important;
        word-break: break-word !important;
        text-align: center !important;
        font-size: 11.5px !important;
        color: #ffffff !important;
    }
    .l-subheader.at_top a {
        color: #ffffff !important;
        text-decoration: none !important;
    }
    .l-subheader.at_top a:hover {
        color: #ed2127 !important;
    }
    .l-subheader.at_top i.fas,
    .l-subheader.at_top .w-text i {
        font-size: 12px !important;
        color: #ed2127 !important;
    }
}
</style>
"@

$rootDir = "c:\My Web Sites\Lowyalty\Lowyalty Website"
$updatedCount = 0
$skippedCount = 0
$errorCount = 0

$tPattern = '"tablets"\s*:\s*\{("options"\s*:\s*\{.*?\})\s*,\s*"layout"\s*:\s*\{.*?\}\}'
$mPattern = '"mobiles"\s*:\s*\{("options"\s*:\s*\{.*?\})\s*,\s*"layout"\s*:\s*\{.*?\}\}'
$layoutFixed = '{"top_left":["text:7","text:5","text:6"],"top_center":[],"top_right":["text:3","text:8","text:2"],"middle_left":[],"middle_center":["hwrapper:1"],"middle_right":[],"bottom_left":["menu:1"],"bottom_center":[],"bottom_right":[],"hidden":[],"hwrapper:1":["image:1","search:1","cart:1"]}'
$topbarPattern = '(?s)<style id="topbar-center-override">.*?</style>'

Get-ChildItem -Path $rootDir -Filter "*.html" -Recurse -File | ForEach-Object {
    $file = $_.FullName

    if ($file -match '\\(wp-includes|wp-admin|wp-content|cdn-cgi|hts-cache)\\') {
        return
    }

    try {
        $content = [System.IO.File]::ReadAllText($file)
        $modified = $false

        # 1. Update tablets layout in $us.headerSettings
        if ([regex]::IsMatch($content, $tPattern)) {
            $newContent = [regex]::Replace($content, $tPattern, {
                param($m)
                return '"tablets":{' + $m.Groups[1].Value + ',"layout":' + $layoutFixed + '}'
            })
            if ($newContent -ne $content) {
                $content = $newContent
                $modified = $true
            }
        }

        # 2. Update mobiles layout in $us.headerSettings
        if ([regex]::IsMatch($content, $mPattern)) {
            $newContent = [regex]::Replace($content, $mPattern, {
                param($m)
                return '"mobiles":{' + $m.Groups[1].Value + ',"layout":' + $layoutFixed + '}'
            })
            if ($newContent -ne $content) {
                $content = $newContent
                $modified = $true
            }
        }

        # 3. Update topbar-center-override style block
        if ([regex]::IsMatch($content, $topbarPattern)) {
            $newContent = [regex]::Replace($content, $topbarPattern, { param($m) return $newTopbarCSS })
            if ($newContent -ne $content) {
                $content = $newContent
                $modified = $true
            }
        }

        if ($modified) {
            [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
            $script:updatedCount++
            Write-Host "UPDATED: $file" -ForegroundColor Green
        } else {
            $script:skippedCount++
        }
    } catch {
        $script:errorCount++
        Write-Host "ERROR: $file - $_" -ForegroundColor Red
    }
}

Write-Host "Done! Updated: $updatedCount, Skipped: $skippedCount, Errors: $errorCount"
