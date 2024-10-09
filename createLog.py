import os
import re
from datetime import datetime
from urllib.parse import urljoin

# Safely split file paths by spaces while preserving paths with special characters
markdown_files = os.getenv("NEW_MARKDOWN_FILES", "").strip().split(' ')
print(f"Markdown files to process: {markdown_files}")

if markdown_files == ["none"] or not markdown_files:
    print("No new Markdown files were found in the last week.")
    markdown_files = []

repo_url = "https://github.com/levoxtrip/TKB"
pages_url = "https://levoxtrip.github.io/TKB/"
log_file = "log.md"

with open(log_file, "w", encoding="utf-8") as log:
    log.write(f"# Weekly Log - {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')} UTC\n\n")
    log.write("List of newly created Markdown files in the last week from the docs folder:\n\n")

    for file in markdown_files:
        if file == "none" or file.endswith("index.md"):
            print(f"Skipping file: {file}")
            continue

        if not os.path.exists(file):
            print(f"File not found: {file}")
            continue

        with open(file, "r", encoding="utf-8") as f:
            content = f.read()

            headline_match = re.search(r"^(# .+)", content, re.MULTILINE)
            headline = headline_match.group(1) if headline_match else "No headline found"

            image_match = re.search(r"!\[.*?\]\((.*?)\)", content)
            image_link = image_match.group(1) if image_match else "No image found"

            file_url = urljoin(pages_url, file)

            log.write(f"- **[{file}]({file_url})**\n")
            log.write(f"  - Headline: {headline}\n")
            log.write(f"  - First image: ![]({image_link})\n\n")
