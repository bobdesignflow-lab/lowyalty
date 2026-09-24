$ErrorActionPreference = "Continue"

$responsiveCSS = @"

        /* ==========================================================================
           COMPREHENSIVE MOBILE RESPONSIVE FIXES
           Header, Footer, Apparels & All Navigation Links
           ========================================================================== */

        /* ========================================
           1. HEADER: Mobile & Tablet Responsive Fixes
           ======================================== */

        @media screen and (max-width: 1024px) {
            .l-subheader.at_top {
                padding: 8px 10px !important;
                height: auto !important;
                min-height: auto !important;
                line-height: normal !important;
                overflow: visible !important;
                white-space: normal !important;
                display: block !important;
            }
            .l-subheader.at_top .l-subheader-h {
                height: auto !important;
                min-height: auto !important;
                line-height: normal !important;
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
                gap: 4px !important;
                width: 100% !important;
                text-align: center !important;
            }
            .l-subheader.at_top .w-text {
                white-space: normal !important;
                font-size: 11px !important;
                line-height: 1.35 !important;
                text-align: center !important;
                display: flex !important;
                justify-content: center !important;
                height: auto !important;
            }
            .l-subheader.at_top .w-text-h {
                white-space: normal !important;
                text-align: center !important;
                justify-content: center !important;
                height: auto !important;
                line-height: 1.35 !important;
            }
            .l-subheader.at_top .w-text-value {
                white-space: normal !important;
                overflow: visible !important;
                text-overflow: unset !important;
                word-break: break-word !important;
                text-align: center !important;
            }
            .l-header .w-nav-list.level_2 {
                width: 240px !important;
                max-height: 70vh !important;
                overflow-y: auto !important;
                -webkit-overflow-scrolling: touch !important;
            }
        }

        @media screen and (max-width: 900px) {
            .l-subheader.at_middle .w-image.ush_image_1 img {
                max-width: 80px !important;
                max-height: 80px !important;
                width: 80px !important;
                height: 80px !important;
            }
        }

        @media screen and (max-width: 600px) {
            .l-subheader.at_top {
                padding: 8px 10px !important;
                height: auto !important;
                min-height: auto !important;
                line-height: normal !important;
            }
            .l-subheader.at_top .l-subheader-h {
                gap: 8px !important;
                height: auto !important;
                flex-direction: column !important;
                align-items: center !important;
            }
            .l-subheader.at_top .l-subheader-cell.at_left,
            .l-subheader.at_top .l-subheader-cell.at_right {
                display: flex !important;
                flex-direction: column !important;
                align-items: center !important;
                gap: 4px !important;
                width: 100% !important;
            }
            .l-subheader.at_top .w-text {
                font-size: 10.5px !important;
                line-height: 1.35 !important;
                white-space: normal !important;
                display: flex !important;
            }
            .l-subheader.at_top .w-text-value {
                white-space: normal !important;
            }
            .l-subheader.at_middle {
                min-height: auto !important;
                padding: 10px 0 !important;
            }
            .l-subheader.at_middle .l-subheader-h {
                padding-left: 12px !important;
                padding-right: 12px !important;
            }
            .w-hwrapper {
                --hwrapper-gap: 0.8rem !important;
            }
            .w-hwrapper .w-image img {
                max-width: 60px !important;
                max-height: 60px !important;
                width: 60px !important;
                height: 60px !important;
            }
            .l-subheader.at_bottom {
                min-height: auto !important;
                padding-top: 6px !important;
                padding-bottom: 6px !important;
            }
            .w-nav-control {
                display: inline-flex !important;
            }
            .l-header .w-nav-list.level_2 {
                width: 100% !important;
                max-width: 100% !important;
                padding: 8px !important;
            }
            .l-header .w-nav-item.level_2 {
                flex: 1 1 50% !important;
            }
            .l-header .w-nav-item.level_2 > a {
                font-size: 10.5px !important;
                padding: 5px 6px !important;
                white-space: normal !important;
                line-height: 1.3 !important;
            }
        }

        /* ========================================
           2. FOOTER: Mobile & Tablet Responsive Fixes
           ======================================== */

        @media screen and (max-width: 1024px) {
            .color_footer-bottom .g-cols.wpb_row.cols_5 {
                display: grid !important;
                grid-template-columns: repeat(2, minmax(0, 1fr)) !important;
                gap: 24px 20px !important;
                --columns-gap: 0 !important;
                width: 100% !important;
                padding-left: 16px !important;
                padding-right: 16px !important;
                box-sizing: border-box !important;
            }
            .color_footer-bottom .g-cols.wpb_row.cols_5 > .wpb_column {
                width: 100% !important;
                display: block !important;
            }
            .color_footer-bottom .g-cols.wpb_row.cols_5 > .wpb_column > .vc_column-inner {
                padding: 0 !important;
            }
            .color_footer-bottom .l-section-h {
                padding-left: 0 !important;
                padding-right: 0 !important;
            }
            .color_footer-bottom div[style*="display:flex"][style*="justify-content:center"][style*="gap:2.5rem"] {
                flex-wrap: wrap !important;
                gap: 12px !important;
                padding: 14px 16px !important;
                width: 100% !important;
                box-sizing: border-box !important;
            }
            .color_footer-bottom div[style*="display:flex"][style*="justify-content:center"][style*="gap:2.5rem"] > span[style*="opacity"] {
                display: none !important;
            }
            .us_custom_821ea863 .l-section-h {
                padding-left: 0 !important;
                padding-right: 0 !important;
            }
        }

        @media screen and (max-width: 600px) {
            .color_footer-bottom .g-cols.wpb_row.cols_5 {
                grid-template-columns: 1fr !important;
                gap: 20px !important;
                padding-left: 16px !important;
                padding-right: 16px !important;
            }
            .color_footer-bottom h5.vc_custom_heading {
                font-size: 1rem !important;
            }
            .color_footer-bottom div[style*="display:flex"][style*="justify-content:center"][style*="gap:2.5rem"] {
                flex-direction: column !important;
                align-items: flex-start !important;
                gap: 10px !important;
                padding: 16px !important;
            }
            .color_footer-bottom div[style*="display:flex"][style*="justify-content:center"][style*="gap:2.5rem"] > div {
                width: 100% !important;
                white-space: normal !important;
            }
            .color_footer-bottom div[style*="display:flex"][style*="justify-content:center"][style*="gap:2.5rem"] a {
                font-size: 0.85rem !important;
                word-break: break-word !important;
                white-space: normal !important;
            }
            .color_footer-bottom div[style*="display:flex"][style*="gap:0.9rem"] {
                justify-content: flex-start !important;
                width: 100% !important;
                margin-top: 6px !important;
            }
            .us_custom_821ea863 .g-cols.wpb_row.cols_2-1 {
                display: flex !important;
                flex-direction: column !important;
                gap: 10px !important;
                padding-left: 16px !important;
                padding-right: 16px !important;
                --columns-gap: 0 !important;
            }
            .us_custom_821ea863 .g-cols.wpb_row.cols_2-1 > .wpb_column {
                width: 100% !important;
            }
            .us_custom_821ea863 .w-text {
                text-align: left !important;
            }
            .us_custom_821ea863 .wpb_text_column p {
                text-align: left !important;
                font-size: 0.8rem !important;
            }
            .color_footer-bottom .w-separator.size_medium {
                display: none !important;
            }
        }

        /* ========================================
           3. APPARELS BANNERS & OTHER LINKS
           ======================================== */

        @media screen and (max-width: 1024px) {
            .l-main, #page-content, section.l-section {
                overflow-x: hidden !important;
            }
            .w-ibanner .w-ibanner-title {
                font-size: 14px !important;
                line-height: 1.3 !important;
                padding: 8px 10px !important;
            }
            .g-cols.wpb_row.via_grid.cols_5:has(.w-ibanner) {
                display: grid !important;
                grid-template-columns: repeat(2, minmax(0, 1fr)) !important;
                gap: 12px !important;
                width: 100% !important;
            }
            .g-cols.wpb_row.via_grid.cols_5:has(.w-ibanner) > .wpb_column {
                width: 100% !important;
                display: block !important;
            }
        }

        @media screen and (max-width: 600px) {
            .g-cols.wpb_row.via_grid.cols_5:has(.w-ibanner) {
                grid-template-columns: repeat(2, minmax(0, 1fr)) !important;
                gap: 10px !important;
                padding-left: 12px !important;
                padding-right: 12px !important;
            }
            .w-ibanner .w-ibanner-title {
                font-size: 12px !important;
                padding: 6px 8px !important;
            }
            .g-cols.wpb_row.cols_4:has(.w-btn) h4,
            .g-cols.wpb_row.cols_4:has(.w-btn) .vc_custom_heading {
                font-size: 1rem !important;
            }
        }

        /* ========================================
           4. GENERAL: Prevent horizontal overflow
           ======================================== */
        html, body {
            overflow-x: hidden !important;
            max-width: 100% !important;
            width: 100% !important;
        }
        .l-canvas {
            overflow-x: hidden !important;
            max-width: 100% !important;
        }
"@

$rootDir = "c:\My Web Sites\Lowyalty\Lowyalty Website"
$countFixed = 0
$countSkipped = 0
$countFailed = 0
$fixedFiles = @()
$failedFiles = @()

$tPattern = '"tablets"\s*:\s*\{("options"\s*:\s*\{.*?\})\s*,\s*"layout"\s*:\s*\{.*?\}\}'
$mPattern = '"mobiles"\s*:\s*\{("options"\s*:\s*\{.*?\})\s*,\s*"layout"\s*:\s*\{.*?\}\}'
$layoutFixed = '{"top_left":["text:7","text:5","text:6"],"top_center":[],"top_right":["text:3","text:8","text:2"],"middle_left":[],"middle_center":["hwrapper:1"],"middle_right":[],"bottom_left":["menu:1"],"bottom_center":[],"bottom_right":[],"hidden":[],"hwrapper:1":["image:1","search:1","cart:1"]}'
$pattern = '(?s)(\.custom-logo-carousel\s+img\s*\{[^}]*margin:\s*0\s*auto\s*!important\s*;[^}]*\})(\s*)(</style>)'

Get-ChildItem -Path $rootDir -Filter "*.html" -Recurse -File | ForEach-Object {
    $file = $_.FullName

    if ($file -match '\\(wp-includes|wp-admin|wp-content|cdn-cgi|hts-cache)\\') {
        $script:countSkipped++
        return
    }

    try {
        $content = [System.IO.File]::ReadAllText($file)
        $modified = $false

        # Update tablets & mobiles layout in $us.headerSettings
        if ([regex]::IsMatch($content, $tPattern)) {
            $newContent = [regex]::Replace($content, $tPattern, { param($m) return '"tablets":{' + $m.Groups[1].Value + ',"layout":' + $layoutFixed + '}' })
            if ($newContent -ne $content) { $content = $newContent; $modified = $true }
        }
        if ([regex]::IsMatch($content, $mPattern)) {
            $newContent = [regex]::Replace($content, $mPattern, { param($m) return '"mobiles":{' + $m.Groups[1].Value + ',"layout":' + $layoutFixed + '}' })
            if ($newContent -ne $content) { $content = $newContent; $modified = $true }
        }

        # Update responsive CSS block
        if ($content -match '(?s)/\* ==========================================================================\s*COMPREHENSIVE MOBILE RESPONSIVE FIXES.*?(</style>)') {
            $content = [regex]::Replace($content, '(?s)/\* ==========================================================================\s*COMPREHENSIVE MOBILE RESPONSIVE FIXES.*?(</style>)', "`$1")
        }

        if ($content -match $pattern) {
            $newContent = [regex]::Replace($content, $pattern, {
                param($m)
                $m.Groups[1].Value + "`r`n" + $responsiveCSS + "`r`n" + $m.Groups[2].Value + $m.Groups[3].Value
            })
            if ($newContent -ne $content) { $content = $newContent; $modified = $true }
        }

        if ($modified) {
            [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
            $script:countFixed++
            $script:fixedFiles += $file
            Write-Host "FIXED: $file" -ForegroundColor Green
        } else {
            $script:countSkipped++
        }
    } catch {
        $script:countFailed++
        $script:failedFiles += "$file : $_"
        Write-Host "ERROR: $file - $_" -ForegroundColor Red
    }
}

Write-Host "Done! Fixed: $countFixed, Skipped: $countSkipped, Failed: $countFailed"
