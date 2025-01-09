# ABD File Browser

ABD File Browser is a simple and lightweight terminal-based file manager written in Bash. It provides various file management functionalities directly from the terminal, such as navigating directories, copying, pasting, renaming, deleting files and directories, searching, and more. 

## Features

- **File Navigation**: Move between directories and navigate files using arrow keys.
- **Show Hidden Files**: Toggle visibility of hidden files and directories.
- **File Operations**:
  - Copy, Paste, Rename, and Delete files and directories.
  - Perform bulk operations on selected files.
- **Search Functionality**: Search for files and directories by name.
- **Create Folders**: Create new directories directly from the interface.
- **File Preview**: Open files using the default system application.
- **Pagination Support**: Handles large directories with pagination based on terminal height.
- **Keyboard Shortcuts**: Intuitive keybindings for efficient file management.

## Requirements

- Linux-based operating system with a terminal.
- `bash` shell.
- `ls` command with `--group-directories-first` support.
- `xdg-open` for opening files (optional).

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/bharani2624/FileManager
   cd FileManager
   ```

2. Make the script executable:
   ```bash
   chmod +x FileManager.sh
   ```

3. (Optional) Compile the script using `shc`:
   ```bash
   pkg install shc # For Termux or Debian-based systems
   shc -f FileManager.sh
   chmod +x FileManager.sh.x
   ```

4. Run the script:
   ```bash
   ./FileManager.sh
   ```

## Keybindings

| Key              | Action                                |
|------------------|---------------------------------------|
| **Up Arrow**     | Move cursor up.                      |
| **Down Arrow**   | Move cursor down.                    |
| **Left Arrow**   | Move to the parent directory.        |
| **Right Arrow**  | Navigate into the selected directory.|
| `Q/q`            | Quit the file browser.               |
| `S/s`            | Select the current file or directory.|
| `A/a`            | Toggle show hidden files.            |
| `T/t`            | Toggle additional options.           |
| `C/c`            | Copy the selected file/directory.    |
| `P/p`            | Paste the copied file/directory.     |
| `R/r`            | Rename the selected file/directory.  |
| `D/d`            | Delete the selected file/directory.  |
| `?`              | Search for files/directories.        |
| `N/n`            | Create a new folder.                 |
| Enter (empty)    | Open file or navigate into directory.|

## How to Use

1. Run the script using `./FileManager.sh`.
2. Use the arrow keys to navigate files and directories.
3. Perform actions using the keyboard shortcuts listed above.
4. Press `Q/q` to quit the file browser.

## Limitations

- The file manager is designed for terminal use and does not have a GUI.
- Bulk operations are limited to selected files and directories.
- Customization of keybindings and appearance requires editing the script.

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests to improve this project.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

---

Enjoy using the ABD File Browser for efficient file management in your terminal!
