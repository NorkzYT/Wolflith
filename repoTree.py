import os
import re


def natural_sort_key(s):
    """
    Generate a natural sort key for strings containing numbers.
    Splits the string into a list where numeric parts are converted to integers,
    ensuring that, for example, "page_2" comes before "page_10".
    """
    return [
        int(text) if text.isdigit() else text.lower() for text in re.split("(\d+)", s)
    ]


def list_files(start_path):
    """
    Generate a tree-like structure of files and directories starting from start_path.
    Writes the resulting tree to "repoTree.md".
    """
    # List of folder names to ignore
    ignore_list = [
        "node_modules",
        ".git",
        "objects",
        ".env",
        ".ruff_cache",
    ]

    try:
        with open("repoTree.md", "w", encoding="utf-8") as f:
            f.write("./\n")  # Write the root entry
            print_tree(start_path, "", f, ignore_list)
    except IOError as e:
        print(f"Error writing to repoTree.md: {e}")


def print_tree(path, prefix, file, ignore_list):
    """
    Recursively prints the directory tree structure to the given file.

    Parameters:
        path (str): Current directory path.
        prefix (str): String prefix for the current tree level.
        file (file object): File to which the tree output is written.
        ignore_list (list): List of folder names to ignore.
    """
    try:
        items = os.listdir(path)
    except OSError as e:
        print(f"Error reading directory {path}: {e}")
        return

    # Remove ignored items and __pycache__ directories/files
    items = [
        item
        for item in items
        if item not in ignore_list and not item.endswith("__pycache__")
    ]

    # Sort items: Directories first, then files, using natural sort for both groups
    items.sort(
        key=lambda item: (
            0 if os.path.isdir(os.path.join(path, item)) else 1,
            natural_sort_key(item),
        )
    )

    # Iterate over sorted items
    for index, item in enumerate(items):
        is_last = index == len(items) - 1  # Determine if this is the last item
        connector = "└── " if is_last else "├── "
        file.write(prefix + connector + item + "\n")

        # If the item is a directory, recursively print its contents
        item_path = os.path.join(path, item)
        if os.path.isdir(item_path):
            extension = "    " if is_last else "│   "
            print_tree(item_path, prefix + extension, file, ignore_list)


if __name__ == "__main__":
    list_files(".")
