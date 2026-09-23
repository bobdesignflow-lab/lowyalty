import os
import json

directory = r"c:\My Web Sites\Lowyalty Website"

html_files = []
for root, dirs, files in os.walk(directory):
    for file in files:
        if file.endswith(".html"):
            # skip wp-json folders if any, usually junk
            if "wp-json" in root:
                continue
            rel_path = os.path.relpath(os.path.join(root, file), directory).replace("\\", "/")
            html_files.append(rel_path)

with open(os.path.join(directory, "html_structure.json"), "w", encoding="utf-8") as f:
    json.dump(html_files, f, indent=4)
