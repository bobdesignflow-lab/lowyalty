import os
from bs4 import BeautifulSoup
import json
import re

directory = r"c:\My Web Sites\Lowyalty Website"

problem_links = []
home_links = []
index_links = []

for root, dirs, files in os.walk(directory):
    for file in files:
        if file.endswith(".html"):
            filepath = os.path.join(root, file)
            try:
                with open(filepath, "r", encoding="utf-8") as f:
                    soup = BeautifulSoup(f, "html.parser")
                    
                    for a in soup.find_all("a", href=True):
                        href = a["href"]
                        text = a.get_text(strip=True)
                        parent_classes = a.parent.get("class", []) if a.parent else []
                        
                        # Find all # or empty links
                        if href == "#" or href == "":
                            problem_links.append({
                                "file": os.path.relpath(filepath, directory),
                                "href": href,
                                "text": text,
                                "parent_classes": parent_classes
                            })
                            
                        # Find all home.html links
                        elif "home.html" in href:
                            home_links.append({
                                "file": os.path.relpath(filepath, directory),
                                "href": href,
                                "text": text
                            })
                            
                        # Find index.html links that might be wrong (e.g., in footer or nav)
                        # We want to identify if the text implies a different destination
                        elif "index.html" in href:
                            if text.lower() not in ["home", "lowyalty", "", "logo"]:
                                index_links.append({
                                    "file": os.path.relpath(filepath, directory),
                                    "href": href,
                                    "text": text
                                })
            except Exception as e:
                print(f"Error parsing {filepath}: {e}")

output = {
    "problem_links_count": len(problem_links),
    "unique_problem_texts": list(set([l["text"] for l in problem_links])),
    "home_links_count": len(home_links),
    "unique_home_links_texts": list(set([l["text"] for l in home_links])),
    "index_links_count": len(index_links),
    "unique_index_links_texts": list(set([l["text"] for l in index_links])),
}

with open(os.path.join(directory, "link_analysis.json"), "w", encoding="utf-8") as f:
    json.dump(output, f, indent=4)
    
print("Analysis complete.")
