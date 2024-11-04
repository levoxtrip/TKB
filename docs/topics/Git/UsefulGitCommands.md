---
comments: true
tags:
    - Git
    - Terminal
---
# Useful Commands

Find the file that got edited the longest time ago
```
git ls-files *.md | ForEach-Object {
    $file = $_
    $timestamp = git log -1 --format="%at" -- "$file"
    [PSCustomObject]@{ Timestamp = $timestamp; File = $file }
} | Sort-Object Timestamp | Select-Object -First 1
```