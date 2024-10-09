import os
import re
from datetime import datetime
from urllib.parse import urljoin

# Retrieve the new markdown files to be processed
markdown_files = os.getenv("NEW_MARKDOWN_FILES", "").strip().split(' ')
print(f"Markdown files to process: {markdown_files}")

# Check if there are any new files to process
if markdown_files == ["none"] or not markdown_files:
    print("No new Markdown files were found in the last week.")
    markdown_files = []

# Define the base URLs for the repository and GitHub Pages
repo_url = "https://github.com/levoxtrip/TKB"
pages_url = "https://levoxtrip.github.io/TKB/"
log_file = "log.md"

# Create and open the log file for writing
with open(log_file, "w", encoding="utf-8") as log:
    log.write(f"# Weekly Log - {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')} UTC\n\n")
    log.write("List of newly created Markdown files in the last week from the docs folder:\n\n")

    # Loop through each markdown file to process
    for file in markdown_files:
        # Skip if no new files or if the file is an index.md
        if file == "none" or file.endswith("index.md"):
            print(f"Skipping file: {file}")
            continue

        # Skip if the file does not exist in the filesystem
        if not os.path.exists(file):
            print(f"File not found: {file}")
            continue

        # Read the contents of the markdown file
        with open(file, "r", encoding="utf-8") as f:
            content = f.read()

            # Get the first headline (e.g., # Hold last changed value)
            headline_match = re.search(r"^(# .+)", content, re.MULTILINE)
            headline = headline_match.group(1) if headline_match else "No headline found"

            # Get the first image link from the markdown content
            image_match = re.search(r"!\[.*?\]\((.*?)\)", content)
            image_link = image_match.group(1) if image_match else ""

            # Construct the correct file URL
            relative_path = file.replace("docs/", "").replace(".md", "/")
            file_url = urljoin(pages_url, relative_path)

            # Construct the correct image URL based on the fixed folder structure
            if image_link:
                # The image link should reference the `img/` directory only, without subfolders like `AnimateThroughDataPoints`
                image_filename = os.path.basename(image_link)  # Extract just the image filename
                image_url = urljoin(pages_url, f"topics/TouchDesigner/CHOPS/img/{image_filename}")
            else:
                image_url = "No image found"

            # Write details to log with corrected image URL
            log.write(f"## {headline}\n")
            log.write(f"  - First image
