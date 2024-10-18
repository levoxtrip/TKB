import os
import re
from datetime import datetime, timezone
from urllib.parse import urljoin

now_utc = datetime.now(timezone.utc)

# Retrieve the new markdown files to be processed
markdown_files = os.getenv("NEW_MARKDOWN_FILES", "").strip().split(' ')
print(f"Markdown files to process: {markdown_files}")

# Check if there are any new files to process
if markdown_files == ["none"] or not markdown_files:
    print("No new Markdown files were found in the last week.")
    markdown_files = []

# Define the base URLs for the repository and GitHub Pages
pages_url = "https://levoxtrip.github.io/TKB/"
current_date = datetime.now(timezone.utc).strftime('%Y-%m-%d')
log_filename = f"weekly-log-{current_date}.md"

blogposts_folder = os.path.join(os.getcwd(), "docs/topics/blog/posts")

os.makedirs(blogposts_folder, exist_ok=True)

# Full path to save the new log file
log_file_path = os.path.join(blogposts_folder, log_filename)

# Create and open the log file for writing
with open(log_file_path, "w", encoding="utf-8") as log:
    log.write(f"# Weekly Log - {now_utc.strftime('%Y-%m-%d')}\n\n")

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
            # headline_match = re.search(r"^(# .+)", content, re.MULTILINE)
            headline_match = re.search(r"^(#{1,6} .+)", content, re.MULTILINE)
            headline = headline_match.group(1) if headline_match else "No headline found"

            # Get the first image link from the markdown content
            image_match = re.search(r"!\[.*?\]\((.*?)\)", content)
            image_link = image_match.group(1) if image_match else ""

            # Determine the relative path of the file and construct the file URL
            relative_path = file.replace("docs/", "").replace(".md", "/")
            file_url = urljoin(pages_url, relative_path)

            # Construct the correct image URL based on the folder structure
            if image_link:
                # Extract the image filename from the markdown reference
                image_filename = os.path.basename(image_link)
                
                # The `parent_dir` should be the grandparent directory, removing the file-specific folder
                parent_dir = os.path.dirname(os.path.dirname(relative_path))  # Go up two levels
                
                # Construct the image URL relative to the `img` directory
                image_url = urljoin(pages_url, f"{parent_dir}/img/{image_filename}")
            else:
                image_url = ""

            # Write details to log with the correct image URL
            log.write(f"## {headline}\n")
            log.write(f"![]({image_url})\n\n")
            log.write(f"\n\n")
            log.write(f"**[{relative_path}]({file_url})**\n\n")

        print(f"Processed: {file}")
