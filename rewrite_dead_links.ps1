$ErrorActionPreference = "Stop"
$Root = "c:\My Web Sites\Lowyalty Website"
$SkipDirs = @("hts-cache", "wp-content", "wp-includes", "wp-json", "wp-admin", "cdn-cgi")

$APPARELS = "/printing-services-category/https-lowyalty-ke-apparels/index.html"
$AWARDS = "/printing-services-category/https-lowyalty-ke-awards-recognition/index.html"
$BOOKS = "/printing-services-category/https-lowyalty-ke-stationery-business-books-publications/index.html"
$STATIONERY = "/printing-services-category/https-lowyalty-ke-stationery-business-office-stationery/index.html"
$PACKAGING = "/printing-services-category/https-lowyalty-ke-packaging/index.html"
$SIGNS = "/printing-services-category/https-lowyalty-ke-signs-boards-branding/index.html"
$VEHICLE = "/printing-services-category/https-lowyalty-ke-motor-vehicle-branding-office-branding/index.html"
$CONTACT = "/contact/index.html"
$CART = "/cart/index.html"
$HomePage = "/index.html"

$Exact = @{
    "print-shop/index.html"                                                                 = $HomePage
    "printing-services/index.html"                                                          = $HomePage
    "printing-services.html"                                                                = $HomePage
    "home.html"                                                                             = $HomePage
    "about/index.html"                                                                      = $CONTACT
    "corporate/index.html"                                                                  = $CONTACT
    "office-stationery/index.html"                                                          = $STATIONERY
    "books-publications/index.html"                                                         = $BOOKS
    "stationery-business/books-publications/index.html"                                     = $BOOKS
    "stationery-business/trading-books/index.html"                                          = $STATIONERY
    "stationery-business/trading-books/business-cards/index.html"                           = $STATIONERY
    "printing-services/business-cards/index.html"                                           = $STATIONERY
    "trading-books/index.html"                                                              = $STATIONERY
    "labels-stickers-2/index.html"                                                          = $PACKAGING
    "labels-stickers/index.html"                                                            = $PACKAGING
    "small-format/personal-event-items/index.html"                                          = $CONTACT
    "small-format/marketing-promotional/index.html"                                         = $HomePage
    "flyers/index.html"                                                                     = $HomePage
    "brochures/index.html"                                                                  = $HomePage
    "mugs/index.html"                                                                       = $HomePage
    "water-bottles/index.html"                                                              = $HomePage
    "apparels/index.html"                                                                   = $APPARELS
    "apparels/lesos/index.html"                                                             = $APPARELS
    "apparels/scarves/index.html"                                                           = $APPARELS
    "apparels/fleece-maasai-blankets/index.html"                                            = $APPARELS
    "printing-services-category/https-lowyalty-ke-banners-displays/index.html"              = $SIGNS
    "printing-services-category/https-lowyalty-ke-vehicle-fleet-branding/index.html"        = $VEHICLE
    "printing-services-category/https-lowyalty-ke-corporate-promotional-items/index.html"   = $HomePage
    "printing-services-category/https-lowyalty-ke-labels-and-stickers/index.html"           = $PACKAGING
    "printing-services-category/https-lowyalty-ke-small-format-marketing-promotional/index.html" = $HomePage
    "printing-services-category/https-lowyalty-ke-small-format-personal-event-items/index.html"  = $CONTACT
    "printing-services-category/https-lowyalty-ke-stationery-business-trading-books/index.html"  = $STATIONERY
}

$PrefixMap = [ordered]@{
    "apparels/" = $APPARELS
    "certificates/" = $AWARDS
    "framed-certificates/" = $AWARDS
    "awards/" = $AWARDS
    "trophies/" = $AWARDS
    "medals/" = $AWARDS
    "plaques/" = $AWARDS
    "teardrop-banners/" = $SIGNS
    "feature-banners/" = $SIGNS
    "telescopic-banners/" = $SIGNS
    "back-drop-banners/" = $SIGNS
    "media-banners/" = $SIGNS
    "lateral-banners/" = $SIGNS
    "drop-down-banners/" = $SIGNS
    "hanging-banners/" = $SIGNS
    "pop-up-banners/" = $SIGNS
    "door-frame-banners/" = $SIGNS
    "x-banners/" = $SIGNS
    "s-banners/" = $SIGNS
    "l-banners/" = $SIGNS
    "customised-flags/" = $SIGNS
    "branded-tents/" = $SIGNS
    "broad-base-stand/" = $SIGNS
    "table-roll-up-banner/" = $SIGNS
    "signages/" = $SIGNS
    "indoor-signage/" = $SIGNS
    "outdoor-signage/" = $SIGNS
    "directional-signs/" = $SIGNS
    "safety-signs/" = $SIGNS
    "3d-signages/" = $SIGNS
    "2d-signages/" = $SIGNS
    "reflective-signages/" = $SIGNS
    "light-box-signages/" = $SIGNS
    "selfie-boards/" = $SIGNS
    "van-branding/" = $VEHICLE
    "car-branding/" = $VEHICLE
    "truck-branding/" = $VEHICLE
    "motorcycle-branding/" = $VEHICLE
    "wall-branding/" = $VEHICLE
    "window-branding/" = $VEHICLE
    "frosted-glass-film/" = $VEHICLE
    "floor-graphics/" = $VEHICLE
    "wall-murals/" = $VEHICLE
    "event-branding/" = $VEHICLE
    "podium-branding/" = $VEHICLE
    "cake-boxes/" = $PACKAGING
    "cake-boards/" = $PACKAGING
    "branded-boxes/" = $PACKAGING
    "customised-boxes/" = $PACKAGING
    "annual-reports/" = $BOOKS
    "text-books/" = $BOOKS
    "exercise-books/" = $BOOKS
    "novels/" = $BOOKS
    "story-books/" = $BOOKS
    "reports/" = $BOOKS
    "magazines/" = $BOOKS
    "company-profiles/" = $BOOKS
    "manuals/" = $BOOKS
    "journals/" = $BOOKS
    "training-booklets/" = $BOOKS
    "graduation-booklets/" = $BOOKS
    "invoice-books/" = $STATIONERY
    "receipt-books/" = $STATIONERY
    "delivery-note-books/" = $STATIONERY
    "local-purchase-order/" = $STATIONERY
    "gate-pass/" = $STATIONERY
    "petty-cash-voucher-books/" = $STATIONERY
    "payment-voucher-books/" = $STATIONERY
    "fuel-coupon-books/" = $STATIONERY
    "good-received-books/" = $STATIONERY
    "store-requisition-books/" = $STATIONERY
    "job-cards-books/" = $STATIONERY
    "button-badges/" = $STATIONERY
    "company-seals/" = $STATIONERY
    "compliment/" = $STATIONERY
    "diaries/" = $STATIONERY
    "dividers/" = $STATIONERY
    "folders/" = $STATIONERY
    "envelopes/" = $STATIONERY
    "letterheads/" = $STATIONERY
    "menu-cards/" = $STATIONERY
    "menu-holders/" = $STATIONERY
    "notepads/" = $STATIONERY
    "registers/" = $STATIONERY
    "self-inking-stamp/" = $STATIONERY
    "staff-id-cards/" = $STATIONERY
    "stock-cards/" = $STATIONERY
    "business-cards/" = $STATIONERY
    "product-labels/" = $PACKAGING
    "asset-tags/" = $PACKAGING
    "seal-stickers/" = $PACKAGING
    "barcode-labels/" = $PACKAGING
    "branded-tapes/" = $PACKAGING
    "clear-labels/" = $PACKAGING
    "labels-stickers/" = $PACKAGING
    "wedding-cards/" = $CONTACT
    "invitations/" = $CONTACT
    "event-programs/" = $CONTACT
    "funeral-programs/" = $CONTACT
    "anniversary-programs/" = $CONTACT
    "tickets/" = $CONTACT
    "vouchers/" = $CONTACT
    "success-cards/" = $CONTACT
    "christmas-cards/" = $CONTACT
    "graduation-cards/" = $CONTACT
    "thanksgiving-cards/" = $CONTACT
    "mugs/" = $HomePage
    "water-bottles/" = $HomePage
    "thermo-flasks/" = $HomePage
    "keyrings/" = $HomePage
    "flash-drives/" = $HomePage
    "umbrellas/" = $HomePage
    "pens/" = $HomePage
    "card-holders/" = $HomePage
    "pen-holders/" = $HomePage
    "gift-hampers/" = $HomePage
    "gift-bags/" = $HomePage
    "power-banks/" = $HomePage
    "bags-back-packs/" = $HomePage
    "calendars/" = $HomePage
    "wall-clocks/" = $HomePage
    "lapel-pins/" = $HomePage
    "wrist-bands/" = $HomePage
    "lanyards/" = $HomePage
    "mouse-pads/" = $HomePage
    "flyers/" = $HomePage
    "brochures/" = $HomePage
    "posters/" = $HomePage
    "inserts/" = $HomePage
    "fact-sheets/" = $HomePage
    "catalogues/" = $HomePage
    "print-shop/" = $HomePage
    "about/" = $CONTACT
    "corporate/" = $CONTACT
    "contact/" = $CONTACT
    "cart/" = $CART
}

function Get-ExistingSet {
    $set = @{}
    Get-ChildItem -Path $Root -Filter "*.html" -Recurse | ForEach-Object {
        $rel = $_.FullName.Substring($Root.Length + 1).Replace("\", "/")
        $top = $rel.Split("/")[0]
        if ($SkipDirs -contains $top) { return }
        $set[$rel] = $true
    }
    $set["index.html"] = $true
    return $set
}

$Existing = Get-ExistingSet

function Test-FileExists([string]$path) {
    $path = ($path -split "\?")[0]
    $path = ($path -split "#")[0]
    $path = $path.TrimStart("/")
    if ($Existing.ContainsKey($path)) { return $true }
    return (Test-Path -LiteralPath (Join-Path $Root ($path.Replace("/", "\"))))
}

function Normalize-FilePath([string]$path) {
    $path = [uri]::UnescapeDataString($path.Replace("\", "/"))
    while ($path.Contains("//")) { $path = $path.Replace("//", "/") }
    $path = $path.TrimStart("/")
    if ([string]::IsNullOrWhiteSpace($path) -or $path -eq ".") { return "index.html" }
    if ($path.EndsWith("/")) { $path = $path + "index.html" }
    elseif (-not [IO.Path]::HasExtension($path)) { $path = $path + "/index.html" }
    return $path
}

function Resolve-Against([string]$fileRel, [string]$hrefPath) {
    $hrefPath = $hrefPath.Replace("\", "/")
    if ($hrefPath.StartsWith("/")) { return (Normalize-FilePath $hrefPath) }
    $baseDir = [IO.Path]::GetDirectoryName($fileRel)
    if ([string]::IsNullOrEmpty($baseDir) -or $baseDir -eq ".") {
        $combined = $hrefPath
    } else {
        $combined = ($baseDir.Replace("\", "/") + "/" + $hrefPath)
    }
    $parts = New-Object System.Collections.Generic.List[string]
    foreach ($part in $combined.Split("/")) {
        if ($part -eq "" -or $part -eq ".") { continue }
        if ($part -eq "..") {
            if ($parts.Count -gt 0) { [void]$parts.RemoveAt($parts.Count - 1) }
            continue
        }
        $parts.Add($part)
    }
    return (Normalize-FilePath ("/" + ($parts -join "/")))
}

function Map-Missing([string]$path) {
    $path = (($path -split "\?")[0] -split "#")[0]
    $path = $path.TrimStart("/")
    if ($Exact.ContainsKey($path)) { return $Exact[$path] }
    foreach ($key in $PrefixMap.Keys) {
        if ($path.StartsWith($key)) { return $PrefixMap[$key] }
    }
    return $HomePage
}

function Test-External([string]$href) {
    $lower = $href.ToLower()
    if ($lower.StartsWith("mailto:") -or $lower.StartsWith("tel:") -or $lower.StartsWith("javascript:") -or $lower.StartsWith("data:") -or $lower.StartsWith("whatsapp:") -or $lower.StartsWith("sms:")) { return $true }
    if ($href.StartsWith("#")) { return $true }
    if ($lower -match "^https?://") {
        if ($lower -notmatch "lowyaltybrandingline\.(com|vercel\.app)") { return $true }
    }
    return $false
}

function Test-Asset([string]$path) {
    $lower = (($path.ToLower() -split "\?")[0]).TrimStart("/")
    if ($lower.StartsWith("wp-content/") -or $lower.StartsWith("wp-includes/") -or $lower.StartsWith("wp-json/") -or $lower.StartsWith("cdn-cgi/") -or $lower.StartsWith("xmlrpc")) { return $true }
    $ext = [IO.Path]::GetExtension($lower)
    return @(".css", ".js", ".png", ".jpg", ".jpeg", ".gif", ".webp", ".svg", ".woff", ".woff2", ".ttf", ".eot", ".ico", ".json", ".xml", ".php", ".pdf", ".mp4", ".webm") -contains $ext
}

function Strip-SitePrefix([string]$href) {
    foreach ($prefix in @(
            "https://lowyaltybrandingline.com/",
            "http://lowyaltybrandingline.com/",
            "https://lowyaltybrandingline.vercel.app/",
            "http://lowyaltybrandingline.vercel.app/"
        )) {
        if ($href.StartsWith($prefix)) { return "/" + $href.Substring($prefix.Length) }
    }
    return $href
}

function Rewrite-Href([string]$raw, [string]$fileRel) {
    if ([string]::IsNullOrWhiteSpace($raw) -or $raw.Trim() -eq "#") { return $raw }
    if (Test-External $raw) { return $raw }
    $href = Strip-SitePrefix $raw
    $fragment = ""
    if ($href.Contains("#")) {
        $idx = $href.IndexOf("#")
        $fragment = $href.Substring($idx)
        $href = $href.Substring(0, $idx)
    }
    if ($href.Contains("?")) { $href = $href.Substring(0, $href.IndexOf("?")) }

    $pathPart = $href
    if (Test-Asset $pathPart) { return $raw }
    if ($pathPart -eq "" -or $pathPart -eq "/") { return ($HomePage + $fragment) }

    $resolved = Resolve-Against $fileRel $pathPart
    $intended = Normalize-FilePath ($pathPart.TrimStart("./"))

    $chosen = $null
    if (Test-FileExists $resolved) { $chosen = $resolved }
    elseif (Test-FileExists $intended) { $chosen = $intended }
    else { $chosen = (Map-Missing $intended).TrimStart("/") }

    if (-not $chosen.StartsWith("/")) { $chosen = "/" + $chosen }
    if (-not (Test-FileExists $chosen)) {
        $chosen = Map-Missing $chosen
    }
    if ($chosen -eq "/" ) { $chosen = $HomePage }
    return ($chosen + $fragment)
}

$hrefRegex = [regex]'(?is)(<a\b[^>]*?\bhref\s*=\s*)(["''])(.*?)\2'
$actionRegex = [regex]'(?is)(<form\b[^>]*?\baction\s*=\s*)(["''])(.*?)\2'

$files = Get-ChildItem -Path $Root -Filter "*.html" -Recurse | Where-Object {
    $rel = $_.FullName.Substring($Root.Length + 1)
    $top = $rel.Split("\")[0]
    $SkipDirs -notcontains $top
}

$totalFiles = 0
$totalHrefs = 0
$samples = @()

foreach ($file in $files) {
    $rel = $file.FullName.Substring($Root.Length + 1).Replace("\", "/")
    $text = [IO.File]::ReadAllText($file.FullName)
    $original = $text
    $count = 0

    $evaluator = {
        param($m)
        $prefix = $m.Groups[1].Value
        $quote = $m.Groups[2].Value
        $href = $m.Groups[3].Value
        $new = Rewrite-Href $href $rel
        if ($new -ne $href) {
            $script:count++
            if ($rel -eq "index.html" -and $script:samples.Count -lt 20) {
                $script:samples += "$href => $new"
            }
        }
        return ($prefix + $quote + $new + $quote)
    }

    $text = $hrefRegex.Replace($text, $evaluator)
    $formEval = {
        param($m)
        $prefix = $m.Groups[1].Value
        $quote = $m.Groups[2].Value
        $href = $m.Groups[3].Value
        $new = Rewrite-Href $href $rel
        if ($href -match "lowyaltybrandingline.com" -or $href -in @("/", "/index.html", "index.html")) {
            $new = $CONTACT
        }
        if ($new -ne $href) { $script:count++ }
        return ($prefix + $quote + $new + $quote)
    }
    $text = $actionRegex.Replace($text, $formEval)

    if ($text -ne $original) {
        $utf8 = New-Object System.Text.UTF8Encoding $false
        [IO.File]::WriteAllText($file.FullName, $text, $utf8)
        $totalFiles++
        $totalHrefs += $count
    }
}

Write-Output "Updated $totalFiles files, $totalHrefs hrefs"
Write-Output "Homepage samples:"
$samples | ForEach-Object { Write-Output $_ }
