$root = "c:\My Web Sites\Lowyalty Website"
$files = Get-ChildItem -Path $root -Filter "*.html" -Recurse | Where-Object {
    $_.FullName -notmatch '\\hts-cache\\'
}

$utf8NoBom = New-Object System.Text.UTF8Encoding($False)
$summary = New-Object System.Collections.Generic.List[string]

function Count-Matches([string]$text, [string]$pattern) {
    return ([regex]::Matches($text, $pattern)).Count
}

foreach ($file in $files) {
    $content = [IO.File]::ReadAllText($file.FullName)
    $original = $content

    # Duplicate homepage links
    $content = [regex]::Replace($content, 'href="(?:\.\./)*home\.html"', {
        param($m)
        $prefix = $m.Value.Substring(0, $m.Value.Length - 'home.html'.Length)
        return $prefix + 'index.html"'
    })

    # Header utility: Fast Shipping / Order Status (whitespace-tolerant)
    $content = [regex]::Replace(
        $content,
        'href="#"(\s+class="w-text-h">\s*<i class="fas fa-ship"></i>)',
        'href="/contact/index.html"$1'
    )
    $content = [regex]::Replace(
        $content,
        'href="#"(\s+class="w-text-h">\s*<i class="fas fa-truck"></i>)',
        'href="/contact/index.html"$1'
    )

    # Cart icon placeholders
    $content = [regex]::Replace(
        $content,
        '(<a class="w-cart-link"\s+href=)"#"',
        '$1"/cart/index.html"'
    )

    # Search / hamburger: keep href="#" but stop page jumps
    $content = [regex]::Replace(
        $content,
        '(<a class="w-search-open"[^>]*?href="#")(?![^>]*onclick)',
        '$1 onclick="event.preventDefault()"'
    )
    $content = [regex]::Replace(
        $content,
        '(<a class="w-nav-control"[^>]*?href="#")(?![^>]*onclick)',
        '$1 onclick="event.preventDefault()"'
    )

    # Footer label links (span may wrap across newlines)
    $replacements = @{
        'Accolades' = '/about/index.html'
        'Careers' = '/contact/index.html'
        'Payment\s+Details' = '/contact/index.html'
        'Design\s+Services' = '/printing-services/index.html'
        'Samples' = '/contact/index.html'
        'Videos' = '/about/index.html'
    }
    foreach ($label in $replacements.Keys) {
        $url = $replacements[$label]
        $pattern = 'href="[^"]*index\.html"(\s*>\s*<span[^>]*>\s*' + $label + ')'
        $content = [regex]::Replace($content, $pattern, ('href="' + $url + '"$1'))
    }

    $content = [regex]::Replace($content, 'href="#"(>\s*Terms of use)', 'href="/about/index.html"$1')
    $content = [regex]::Replace($content, 'href="#"(>\s*Privacy Policy)', 'href="/about/index.html"$1')

    # View All buttons following a category heading
    $categories = [ordered]@{
        'Apparels' = '/printing-services-category/https-lowyalty-ke-apparels/index.html'
        'Banners\s*&amp;\s*Flags' = '/printing-services-category/https-lowyalty-ke-banners-displays/index.html'
        'Packaging' = '/printing-services-category/https-lowyalty-ke-packaging/index.html'
        'Signages' = '/printing-services-category/https-lowyalty-ke-signs-boards-branding/index.html'
        'Office\s+Branding' = '/printing-services-category/https-lowyalty-ke-motor-vehicle-branding-office-branding/index.html'
        'Motor\s+Vehicle\s+Branding' = '/printing-services-category/https-lowyalty-ke-vehicle-fleet-branding/index.html'
    }
    foreach ($cat in $categories.Keys) {
        $url = $categories[$cat]
        $pattern = '(?s)(<h4[^>]*>\s*' + $cat + '\s*</h4>.*?class="w-btn us-btn-style_9 icon_atright"\s+href=")#'
        $content = [regex]::Replace($content, $pattern, ('${1}' + $url), 1)
    }

    # Contact page Get Quote placeholder
    $content = [regex]::Replace(
        $content,
        '(<a class="w-btn us-btn-style_1" href=")#"(\s*>\s*<span class="w-btn-label">Get Quote)',
        '$1/contact/index.html$2'
    )

    if ($content -ne $original) {
        [IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        $summary.Add($file.FullName.Substring($root.Length + 1))
    }
}

Write-Output ("Updated files: " + $summary.Count)
$summary | ForEach-Object { Write-Output $_ }
