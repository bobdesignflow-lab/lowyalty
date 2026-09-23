# -*- coding: utf-8 -*-
"""Rewrite internal page links so they always hit an existing HTML file."""
from __future__ import annotations

import json
import os
import re
from pathlib import Path
from urllib.parse import urlparse, unquote

ROOT = Path(r"c:\My Web Sites\Lowyalty Website")
SKIP_DIRS = {"hts-cache", "wp-content", "wp-includes", "wp-json", "wp-admin", "cdn-cgi"}

APPARELS = "/printing-services-category/https-lowyalty-ke-apparels/index.html"
AWARDS = "/printing-services-category/https-lowyalty-ke-awards-recognition/index.html"
BOOKS = "/printing-services-category/https-lowyalty-ke-stationery-business-books-publications/index.html"
STATIONERY = "/printing-services-category/https-lowyalty-ke-stationery-business-office-stationery/index.html"
PACKAGING = "/printing-services-category/https-lowyalty-ke-packaging/index.html"
SIGNS = "/printing-services-category/https-lowyalty-ke-signs-boards-branding/index.html"
VEHICLE = "/printing-services-category/https-lowyalty-ke-motor-vehicle-branding-office-branding/index.html"
CONTACT = "/contact/index.html"
CART = "/cart/index.html"
HOME = "/index.html"

# Exact path aliases (no leading slash, posix, no query/hash)
EXACT = {
    "print-shop/index.html": HOME,
    "printing-services/index.html": HOME,
    "printing-services.html": HOME,
    "home.html": HOME,
    "about/index.html": CONTACT,
    "corporate/index.html": CONTACT,
    "office-stationery/index.html": STATIONERY,
    "books-publications/index.html": BOOKS,
    "stationery-business/books-publications/index.html": BOOKS,
    "stationery-business/trading-books/index.html": STATIONERY,
    "stationery-business/trading-books/business-cards/index.html": STATIONERY,
    "printing-services/business-cards/index.html": STATIONERY,
    "trading-books/index.html": STATIONERY,
    "labels-stickers-2/index.html": PACKAGING,
    "labels-stickers/index.html": PACKAGING,
    "small-format/personal-event-items/index.html": CONTACT,
    "small-format/marketing-promotional/index.html": HOME,
    "flyers/index.html": HOME,
    "brochures/index.html": HOME,
    "mugs/index.html": HOME,
    "water-bottles/index.html": HOME,
    "apparels/index.html": APPARELS,
    "apparels/lesos/index.html": APPARELS,
    "apparels/scarves/index.html": APPARELS,
    "apparels/fleece-maasai-blankets/index.html": APPARELS,
    "printing-services-category/https-lowyalty-ke-banners-displays/index.html": SIGNS,
    "printing-services-category/https-lowyalty-ke-vehicle-fleet-branding/index.html": VEHICLE,
    "printing-services-category/https-lowyalty-ke-corporate-promotional-items/index.html": HOME,
    "printing-services-category/https-lowyalty-ke-labels-and-stickers/index.html": PACKAGING,
    "printing-services-category/https-lowyalty-ke-small-format-marketing-promotional/index.html": HOME,
    "printing-services-category/https-lowyalty-ke-small-format-personal-event-items/index.html": CONTACT,
    "printing-services-category/https-lowyalty-ke-stationery-business-trading-books/index.html": STATIONERY,
}

PREFIX_MAP = [
    ("apparels/", APPARELS),
    ("certificates/", AWARDS),
    ("framed-certificates/", AWARDS),
    ("awards/", AWARDS),
    ("trophies/", AWARDS),
    ("medals/", AWARDS),
    ("plaques/", AWARDS),
    ("banners", SIGNS),
    ("flags/", SIGNS),
    ("branded-tents/", SIGNS),
    ("broad-base-stand/", SIGNS),
    ("table-roll-up-banner/", SIGNS),
    ("customised-flags/", SIGNS),
    ("signages/", SIGNS),
    ("indoor-signage/", SIGNS),
    ("outdoor-signage/", SIGNS),
    ("directional-signs/", SIGNS),
    ("safety-signs/", SIGNS),
    ("3d-signages/", SIGNS),
    ("2d-signages/", SIGNS),
    ("reflective-signages/", SIGNS),
    ("light-box-signages/", SIGNS),
    ("selfie-boards/", SIGNS),
    ("van-branding/", VEHICLE),
    ("car-branding/", VEHICLE),
    ("truck-branding/", VEHICLE),
    ("motorcycle-branding/", VEHICLE),
    ("wall-branding/", VEHICLE),
    ("window-branding/", VEHICLE),
    ("frosted-glass-film/", VEHICLE),
    ("floor-graphics/", VEHICLE),
    ("wall-murals/", VEHICLE),
    ("event-branding/", VEHICLE),
    ("podium-branding/", VEHICLE),
    ("cake-", PACKAGING),
    ("branded-boxes/", PACKAGING),
    ("customised-boxes/", PACKAGING),
    ("annual-reports/", BOOKS),
    ("text-books/", BOOKS),
    ("exercise-books/", BOOKS),
    ("novels/", BOOKS),
    ("story-books/", BOOKS),
    ("reports/", BOOKS),
    ("magazines/", BOOKS),
    ("company-profiles/", BOOKS),
    ("manuals/", BOOKS),
    ("journals/", BOOKS),
    ("training-booklets/", BOOKS),
    ("graduation-booklets/", BOOKS),
    ("invoice-books/", STATIONERY),
    ("receipt-books/", STATIONERY),
    ("delivery-note-books/", STATIONERY),
    ("local-purchase-order/", STATIONERY),
    ("gate-pass/", STATIONERY),
    ("petty-cash-voucher-books/", STATIONERY),
    ("payment-voucher-books/", STATIONERY),
    ("fuel-coupon-books/", STATIONERY),
    ("good-received-books/", STATIONERY),
    ("store-requisition-books/", STATIONERY),
    ("job-cards-books/", STATIONERY),
    ("button-badges/", STATIONERY),
    ("company-seals/", STATIONERY),
    ("compliment/", STATIONERY),
    ("diaries/", STATIONERY),
    ("dividers/", STATIONERY),
    ("folders/", STATIONERY),
    ("envelopes/", STATIONERY),
    ("letterheads/", STATIONERY),
    ("menu-cards/", STATIONERY),
    ("menu-holders/", STATIONERY),
    ("notepads/", STATIONERY),
    ("registers/", STATIONERY),
    ("self-inking-stamp/", STATIONERY),
    ("staff-id-cards/", STATIONERY),
    ("stock-cards/", STATIONERY),
    ("business-cards/", STATIONERY),
    ("labels", PACKAGING),
    ("stickers", PACKAGING),
    ("asset-tags/", PACKAGING),
    ("seal-stickers/", PACKAGING),
    ("barcode-labels/", PACKAGING),
    ("branded-tapes/", PACKAGING),
    ("clear-labels/", PACKAGING),
    ("product-labels/", PACKAGING),
    ("wedding-cards/", CONTACT),
    ("invitations/", CONTACT),
    ("event-programs/", CONTACT),
    ("funeral-programs/", CONTACT),
    ("anniversary-programs/", CONTACT),
    ("tickets/", CONTACT),
    ("vouchers/", CONTACT),
    ("success-cards/", CONTACT),
    ("christmas-cards/", CONTACT),
    ("graduation-cards/", CONTACT),
    ("thanksgiving-cards/", CONTACT),
    ("mugs/", HOME),
    ("water-bottles/", HOME),
    ("thermo-flasks/", HOME),
    ("keyrings/", HOME),
    ("flash-drives/", HOME),
    ("umbrellas/", HOME),
    ("pens/", HOME),
    ("card-holders/", HOME),
    ("pen-holders/", HOME),
    ("gift-hampers/", HOME),
    ("gift-bags/", HOME),
    ("power-banks/", HOME),
    ("bags-back-packs/", HOME),
    ("calendars/", HOME),
    ("wall-clocks/", HOME),
    ("lapel-pins/", HOME),
    ("wrist-bands/", HOME),
    ("lanyards/", HOME),
    ("mouse-pads/", HOME),
    ("flyers/", HOME),
    ("brochures/", HOME),
    ("posters/", HOME),
    ("inserts/", HOME),
    ("fact-sheets/", HOME),
    ("catalogues/", HOME),
    ("print-shop/", HOME),
    ("about/", CONTACT),
    ("corporate/", CONTACT),
    ("contact/", CONTACT),
    ("cart/", CART),
]


def collect_existing() -> set[str]:
    existing: set[str] = set()
    for path in ROOT.rglob("*.html"):
        rel = path.relative_to(ROOT).as_posix()
        if any(part in SKIP_DIRS for part in path.relative_to(ROOT).parts[:1]):
            continue
        existing.add(rel)
        if rel.endswith("/index.html"):
            existing.add(rel[:-11])  # folder path
            existing.add(rel[:-10])  # trailing slash folder
    existing.add("index.html")
    return existing


EXISTING = collect_existing()


def strip_site_prefix(href: str) -> str:
    href = href.strip()
    for prefix in (
        "https://lowyaltybrandingline.com/",
        "http://lowyaltybrandingline.com/",
        "https://lowyaltybrandingline.vercel.app/",
        "http://lowyaltybrandingline.vercel.app/",
        "//lowyaltybrandingline.com/",
    ):
        if href.startswith(prefix):
            return "/" + href[len(prefix) :]
    return href


def is_external(href: str) -> bool:
    lower = href.lower()
    if lower.startswith(
        ("mailto:", "tel:", "javascript:", "data:", "whatsapp:", "sms:")
    ):
        return True
    if href.startswith("#"):
        return True
    parsed = urlparse(href)
    if parsed.scheme in {"http", "https"}:
        host = (parsed.netloc or "").lower()
        if host and host not in {
            "lowyaltybrandingline.com",
            "www.lowyaltybrandingline.com",
            "lowyaltybrandingline.vercel.app",
        }:
            return True
    return False


def looks_like_asset(path: str) -> bool:
    lower = path.lower().split("?")[0]
    if lower.startswith(("wp-content/", "wp-includes/", "wp-json/", "cdn-cgi/", "xmlrpc")):
        return True
    ext = Path(lower).suffix
    return ext in {
        ".css",
        ".js",
        ".png",
        ".jpg",
        ".jpeg",
        ".gif",
        ".webp",
        ".svg",
        ".woff",
        ".woff2",
        ".ttf",
        ".eot",
        ".ico",
        ".json",
        ".xml",
        ".php",
        ".pdf",
        ".mp4",
        ".webm",
    }


def normalize_file_path(path: str) -> str:
    path = unquote(path).replace("\\", "/")
    while "//" in path:
        path = path.replace("//", "/")
    path = path.lstrip("/")
    if path in {"", "."}:
        return "index.html"
    if path.endswith("/"):
        path = path + "index.html"
    elif not Path(path).suffix:
        path = path + "/index.html"
    # collapse .. later via resolve_against
    return path


def resolve_against(file_rel: str, href_path: str) -> str:
    """Resolve a possibly relative href against the HTML file location."""
    href_path = href_path.replace("\\", "/")
    if href_path.startswith("/"):
        return normalize_file_path(href_path)
    base_dir = str(Path(file_rel).parent.as_posix())
    if base_dir == ".":
        combined = href_path
    else:
        combined = f"{base_dir}/{href_path}"
    parts: list[str] = []
    for part in combined.split("/"):
        if part in ("", "."):
            continue
        if part == "..":
            if parts:
                parts.pop()
            continue
        parts.append(part)
    resolved = "/".join(parts)
    return normalize_file_path("/" + resolved)


def intended_root_path(href_path: str) -> str:
    """If HTTrack left a site-root-style relative path, use it as intended destination."""
    clean = href_path.lstrip("./")
    return normalize_file_path(clean)


def map_missing(path: str) -> str:
    path = path.split("?")[0].split("#")[0]
    if path in EXACT:
        return EXACT[path]
    # try without leading
    for key, dest in EXACT.items():
        if path == key or path.endswith("/" + key):
            return dest
    slug = path
    for prefix, dest in PREFIX_MAP:
        if slug.startswith(prefix) or f"/{prefix}" in f"/{slug}":
            return dest
        # also match folder name anywhere as first segment
    first = slug.split("/")[0] + "/"
    for prefix, dest in PREFIX_MAP:
        if first == prefix or slug.startswith(prefix):
            return dest
    return HOME


def file_exists(path: str) -> bool:
    path = path.split("?")[0].split("#")[0]
    if path in EXISTING:
        return True
    # apparels/t-shirts/index.html style
    candidate = ROOT / path
    return candidate.is_file()


def rewrite_href(raw: str, file_rel: str) -> str:
    original = raw
    if not raw or raw.strip() in {"#"}:
        return original
    if is_external(raw):
        return original

    href = strip_site_prefix(raw)
    parsed = urlparse(href)
    fragment = f"#{parsed.fragment}" if parsed.fragment else ""
    # ignore query for static files
    path_part = parsed.path or href.split("#")[0].split("?")[0]

    if looks_like_asset(path_part.lstrip("/")):
        return original

    if path_part in {"", "/"}:
        return HOME + fragment

    # Resolve as if relative to current file
    resolved = resolve_against(file_rel, path_part)
    # Also consider intended site-root relative (common on homepage)
    intended = intended_root_path(path_part)

    chosen = None
    if file_exists(resolved):
        chosen = resolved
    elif file_exists(intended):
        chosen = intended
    else:
        # Prefer mapping the intended root slug (nav items like certificates/index.html)
        chosen_path = map_missing(intended)
        chosen = chosen_path.lstrip("/")

    if not chosen.endswith(".html") and not chosen.startswith("/"):
        chosen = chosen.rstrip("/") + "/index.html"

    if not chosen.startswith("/"):
        chosen = "/" + chosen
    # drop duplicate index for home
    if chosen in {"/index.html", "/"}:
        chosen = HOME

    # If we mapped to a real existing file via map_missing it already has leading /
    if chosen.startswith("/") and file_exists(chosen.lstrip("/")):
        return chosen + fragment
    if file_exists(chosen.lstrip("/")):
        return "/" + chosen.lstrip("/") + fragment
    mapped = map_missing(chosen.lstrip("/"))
    return mapped + fragment


HREF_RE = re.compile(r'(<a\b[^>]*?\bhref\s*=\s*)(["\'])(.*?)\2', re.IGNORECASE | re.DOTALL)
ACTION_RE = re.compile(r'(<form\b[^>]*?\baction\s*=\s*)(["\'])(.*?)\2', re.IGNORECASE | re.DOTALL)


def process_file(path: Path) -> dict:
    rel = path.relative_to(ROOT).as_posix()
    text = path.read_text(encoding="utf-8", errors="ignore")
    original = text
    changes = []

    def replacer(match: re.Match, kind: str) -> str:
        prefix, quote, href = match.group(1), match.group(2), match.group(3)
        new = rewrite_href(href, rel)
        if kind == "form" and (
            "lowyaltybrandingline.com" in href
            or href in {"/", "/index.html", "index.html", "https://lowyaltybrandingline.com/"}
        ):
            new = CONTACT
        if new != href:
            changes.append({"from": href, "to": new})
        return f"{prefix}{quote}{new}{quote}"

    text = HREF_RE.sub(lambda m: replacer(m, "a"), text)
    text = ACTION_RE.sub(lambda m: replacer(m, "form"), text)

    if text != original:
        path.write_text(text, encoding="utf-8", newline="\n")
    return {"file": rel, "changes": len(changes), "samples": changes[:12]}


def main() -> None:
    reports = []
    html_files = []
    for path in ROOT.rglob("*.html"):
        parts = path.relative_to(ROOT).parts
        if parts and parts[0] in SKIP_DIRS:
            continue
        html_files.append(path)

    for path in html_files:
        reports.append(process_file(path))

    out = ROOT / "link_rewrite_report.json"
    out.write_text(json.dumps(reports, indent=2), encoding="utf-8")
    total = sum(r["changes"] for r in reports)
    print(f"Updated {sum(1 for r in reports if r['changes'])} files, {total} hrefs")
    # show a few samples from homepage
    for r in reports:
        if r["file"] == "index.html":
            print("index.html samples:")
            for s in r["samples"]:
                print(" ", s)


if __name__ == "__main__":
    main()
