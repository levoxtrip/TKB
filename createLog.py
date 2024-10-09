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

# Create a log file and write the initial log message
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

        # Read the contents of the markdown file
        with open(file, "r", encoding="utf-8") as f:
            content = f.read()

            # Get the first headline
            headline_match = re.search(r"^(# .+)", content, re.MULTILINE)
            headline = headline_match.group(1) if headline_match else "No headline found"

            # Get the first image link from the markdown content
            image_match = re.search(r"!\[.*?\]\((.*?)\)", content)
            image_link = image_match.group(1) if image_match else ""

            # Determine the relative path and construct the file URL
            relative_path = file.replace("docs/", "").replace(".md", "/")
            file_url = urljoin(pages_url, relative_path)

            # Construct the correct image URL based on the 'img/' folder structure
            if image_link:
                # Replace './img/' with the correct relative path to the image folder
                image_url = urljoin(pages_url, os.path.join("topics", os.path.dirname(relative_path), "img", os.path.basename(image_link)).replace("\\", "/"))
            else:
                image_url = "No image found"

            # Write details to log
            log.write(f"## {headline}\n")
            log.write(f"  - First image: ![]({image_url})\n\n")
            log.write(f"**[{relative_path}]({file_url})**\n\n")

        print(f"Processed: {file}")
