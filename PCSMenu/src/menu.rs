use crate::utils;
use std::fs;
use std::io;
use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::Command;
use termcolor::{Color, ColorChoice, ColorSpec, StandardStream, WriteColor};

static BASE_DIR: &str = "/opt/Wolflith/PCSMenu/src/Functions";

pub fn main() {
    let mut current_dir = PathBuf::from(BASE_DIR);
    loop {
        utils::default_menu_screen();
        match check_and_run_single_script(&current_dir) {
            Ok(Some(script_path)) => {
                // Now that we have a script path, call run_script with current_dir mutable reference
                run_script(&script_path, &mut current_dir);
            }
            Ok(None) => {} // No single script to run, proceed as normal
            Err(e) => eprintln!("Error checking for single script: {}", e),
        }
        let entry_count = match display_menu(&current_dir) {
            Ok(count) => count,
            Err(e) => {
                eprintln!("Error displaying menu: {}", e);
                break;
            }
        };
        // Use `print!` instead of `println!` and add two spaces for the prompt
        print!(
            "\nEnter 1-{}, B for going back up a level or X for Exit: ",
            entry_count
        );
        // Flush stdout to ensure the prompt is displayed before reading input
        io::stdout().flush().unwrap();

        let mut selection = String::new();
        if io::stdin().read_line(&mut selection).is_err() {
            eprintln!("Error reading input.");
            continue;
        }
        if !navigate(&mut current_dir, selection.trim()) {
            break; // Exit loop if navigate returns false
        }
    }
}

fn display_menu(current_dir: &Path) -> io::Result<usize> {
    let mut entries = fs::read_dir(current_dir)?
        .filter_map(|e| e.ok())
        .filter(|e| {
            e.path().is_dir() && e.file_name().to_string_lossy() != "Scripts"
                || e.path().is_file() && e.path().extension().map_or(false, |ext| ext == "sh")
        })
        .collect::<Vec<_>>();

    // Sort entries alphabetically by file name
    entries.sort_by_key(|entry| entry.file_name());

    let mut stdout = StandardStream::stdout(ColorChoice::Always);

    for (i, entry) in entries.iter().enumerate() {
        stdout
            .set_color(ColorSpec::new().set_fg(Some(Color::Green)))
            .unwrap();
        write!(
            stdout,
            "{}) {} ",
            i + 1,
            entry.file_name().to_string_lossy()
        )
        .unwrap();
    }

    stdout
        .set_color(ColorSpec::new().set_fg(Some(Color::Yellow)))
        .unwrap();
    write!(stdout, "  B) Back ").unwrap();

    stdout
        .set_color(ColorSpec::new().set_fg(Some(Color::Red)))
        .unwrap();
    write!(stdout, " X) Exit").unwrap();

    stdout.reset().unwrap();
    println!(); // Move to the next line after the menu options

    Ok(entries.len()) // Return the count of entries
}

fn navigate(current_dir: &mut PathBuf, selection: &str) -> bool {
    match selection.to_uppercase().as_str() {
        "B" => {
            if current_dir.as_path() != Path::new(BASE_DIR) {
                if let Some(parent) = current_dir.parent() {
                    *current_dir = parent.to_path_buf();
                }
            }
        }
        "X" => {
            utils::clear_screen(); // Clear the screen when exiting
            return false;
        }
        _ => {
            if let Ok(index) = selection.parse::<usize>() {
                let entries_result = fs::read_dir(&*current_dir); // Use &* to borrow current_dir
                if let Ok(entries) = entries_result {
                    let mut entries_vec = entries
                        .filter_map(Result::ok)
                        .filter(|e| {
                            e.path().is_dir() && e.file_name().to_string_lossy() != "Scripts"
                                || e.path().is_file()
                                    && e.path().extension().map_or(false, |ext| ext == "sh")
                        })
                        .collect::<Vec<_>>();

                    // Sort entries alphabetically by file name
                    entries_vec.sort_by_key(|entry| entry.file_name());

                    if index <= entries_vec.len() {
                        let new_path = entries_vec[index - 1].path();
                        if new_path.is_dir() {
                            *current_dir = new_path;
                        } else {
                            // Temporarily clone current_dir to avoid move
                            let _current_dir_clone = current_dir.clone();
                            // Execute the script directly if it is a file
                            run_script(&new_path, current_dir);
                        }
                    }
                }
            }
        }
    }
    true
}

fn check_and_run_single_script(current_dir: &Path) -> io::Result<Option<PathBuf>> {
    let entries = fs::read_dir(current_dir)?
        .filter_map(Result::ok)
        .filter(|e| e.path().is_file() && e.path().extension().map_or(false, |ext| ext == "sh"))
        .collect::<Vec<_>>();

    // If there's exactly one script, return its path
    if entries.len() == 1 {
        Ok(Some(entries[0].path()))
    } else {
        Ok(None)
    }
}

fn run_script(script_path: &Path, current_dir: &mut PathBuf) {
    let status = Command::new("bash").arg(script_path).status();
    match status {
        Ok(status) if status.success() => println!("Script executed successfully."),
        Ok(status) if status.code() == Some(2) => {
            utils::default_menu_screen();
            *current_dir = PathBuf::from(BASE_DIR);
        }
        Ok(status) => eprintln!("Script exited with status: {}", status),
        Err(e) => eprintln!("Failed to execute script: {}", e),
    }
}
