$files = Get-ChildItem -Path "c:\My Web Sites\Lowyalty Website" -Filter "*.html" -Recurse

$utf8NoBom = New-Object System.Text.UTF8Encoding($False)

foreach ($file in $files) {
    $content = [IO.File]::ReadAllText($file.FullName)

    # 1. Update duplicate home.html links to index.html
    $content = $content -replace 'href="home\.html"', 'href="index.html"'
    $content = $content -replace 'href="\.\./home\.html"', 'href="../index.html"'
    $content = $content -replace 'href="\.\./\.\./home\.html"', 'href="../../index.html"'

    # 2. Top utility bar
    $content = $content -replace 'href="#"([^>]*?>\s*<i class="fas fa-ship"></i>\s*<span class="w-text-value">Fast Shipping)', 'href="/contact/index.html"$1'
    $content = $content -replace 'href="#"([^>]*?>\s*<i class="fas fa-truck"></i>\s*<span class="w-text-value">Order Status)', 'href="/contact/index.html"$1'
    
    # Header Cart
    $content = $content -replace 'href="#"([^>]*?>\s*<span class="w-cart-icon">\s*<i class="fas fa-shopping-basket">)', 'href="/cart/index.html"$1'

    # Footer Links
    $content = $content -replace 'href="[^"]*?index\.html"([^>]*?>\s*<span[^>]*?>Accolades)', 'href="/about/index.html"$1'
    $content = $content -replace 'href="[^"]*?index\.html"([^>]*?>\s*<span[^>]*?>Careers)', 'href="/contact/index.html"$1'
    $content = $content -replace 'href="[^"]*?index\.html"([^>]*?>\s*<span[^>]*?>Payment Details)', 'href="/contact/index.html"$1'
    $content = $content -replace 'href="[^"]*?index\.html"([^>]*?>\s*<span[^>]*?>Design Services)', 'href="/printing-services/index.html"$1'
    $content = $content -replace 'href="[^"]*?index\.html"([^>]*?>\s*<span[^>]*?>Samples)', 'href="/contact/index.html"$1'
    $content = $content -replace 'href="[^"]*?index\.html"([^>]*?>\s*<span[^>]*?>Videos)', 'href="/about/index.html"$1'

    # Terms of use & Privacy Policy
    $content = $content -replace 'href="#"([^>]*?>Terms of use)', 'href="/about/index.html"$1'
    $content = $content -replace 'href="#"([^>]*?>Privacy Policy)', 'href="/about/index.html"$1'

    # 3. View All Category Buttons
    $categories = @{
        "Apparels" = "/printing-services-category/https-lowyalty-ke-apparels/index.html"
        "Banners &amp; Flags" = "/printing-services-category/https-lowyalty-ke-banners-displays/index.html"
        "Packaging" = "/printing-services-category/https-lowyalty-ke-packaging/index.html"
        "Signages" = "/printing-services-category/https-lowyalty-ke-signs-boards-branding/index.html"
        "Office Branding" = "/printing-services-category/https-lowyalty-ke-motor-vehicle-branding-office-branding/index.html"
        "Motor Vehicle Branding" = "/printing-services-category/https-lowyalty-ke-vehicle-fleet-branding/index.html"
    }

    foreach ($cat in $categories.Keys) {
        $url = $categories[$cat]
        $pattern = "(?s)(<h4[^>]*>$cat</h4>.*?<a\s+class=`"w-btn us-btn-style_9 icon_atright`"\s+href=`")#(`">\s*<span\s+class=`"w-btn-label`">View All)"
        $content = $content -replace $pattern, "`${1}$url`$2"
    }

    [IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
}
Write-Output "Done replacing links in HTML files."
