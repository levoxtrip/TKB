import os
import re
from datetime import datetime
from urllib.parse import urljoin

# Get the list of newly created Markdown files from the environment variable
markdown_files = os.getenv("NEW_MARKDOWN_FILES", "").strip().split()
print(f"Markdown files to process: {markdown_files}")

# Check if no new files were found
if markdown_files == ["none"] or not markdown_files:
    print("No new Markdown files were found in the last week.")
    markdown_files = []

# Base URL of your GitHub repository (replace with your actual username and repo)
repo_url = "https://github.com/levoxtrip/TKB"

# Create or overwrite the log file
log_file = "log.md"
with open(log_file, "w", encoding="utf-8") as log:
    log.write(f"# Weekly Log - {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')} UTC\n\n")
    log.write("List of newly created Markdown files in the last week from the docs folder:\n\n")

    # Extract and log information from each file
    for file in markdown_files:
        if not os.path.exists(file):
            print(f"File not found: {file}")
            continue

        with open(file, "r", encoding="utf-8") as f:
            content = f.read()

            # Extract the first headline (first line starting with #)
            headline_match = re.search(r"^(# .+)", content, re.MULTILINE)
            headline = headline_match.group(1) if headline_match else "No headline found"

            # Extract the first image link (Markdown image syntax ![alt](link))
            image_match = re.search(r"!\[.*?\]\((.*?)\)", content)
            image_link = image_match.group(1) if image_match else "No image found"

            # Create a link to the file in the GitHub repo
            file_url = urljoin(repo_url, file)

            # Write extracted information to the log
            log.write(f"- **[{file}]({file_url})**\n")
            log.write(f"  - Headline: {headline}\n")
            log.write(f"  - First image: ![]({image_link})\n\n")
