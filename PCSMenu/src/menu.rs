use crate::utils;
use std::fs;
use std::io;
use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::Command;
use termcolor::{Color, ColorChoice, ColorSpec, StandardStream, WriteColor};

static BASE_DIR: &str = "/opt/Wolflith/PCSMenu/src/Functions";

/// Main function to display the menu and handle navigation.
pub fn main() {
    let mut current_dir = PathBuf::from(BASE_DIR);
    loop {
        utils::default_menu_screen();
        match check_and_run_single_script(&current_dir) {
            Ok(Some(script_path)) => {
                run_script(&script_path, &mut current_dir);
            }
            Ok(None) => {}
            Err(e) => eprintln!("Error checking for single script: {}", e),
        }
        let entry_count = match display_menu(&current_dir) {
            Ok(count) => count,
            Err(e) => {
                eprintln!("Error displaying menu: {}", e);
                break;
            }
        };
        print!(
            "\nEnter 1-{}, B for going back up a level or X for Exit: ",
            entry_count
        );
        io::stdout().flush().unwrap();

        let mut selection = String::new();
        if io::stdin().read_line(&mut selection).is_err() {
            eprintln!("Error reading input.");
            continue;
        }
        if !navigate(&mut current_dir, selection.trim(), entry_count) {
            break;
        }
    }
}

/// Displays the menu based on the contents of the current directory.
///
/// Returns the number of entries in the menu.
fn display_menu(current_dir: &Path) -> io::Result<usize> {
    let mut entries = fs::read_dir(current_dir)?
        .filter_map(|e| e.ok())
        .filter(|e| {
            (e.path().is_dir() && e.file_name().to_string_lossy() != "Scripts")
                || (e.path().is_file() && e.path().extension().map_or(false, |ext| ext == "sh"))
        })
        .collect::<Vec<_>>();

    entries.sort_by(|a, b| {
        a.file_name()
            .to_string_lossy()
            .to_lowercase()
            .cmp(&b.file_name().to_string_lossy().to_lowercase())
    });

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
    println!();

    Ok(entries.len())
}

/// Navigates through the directory structure or executes a script based on the user's selection.
///
/// Returns false if the user chooses to exit the application.
/// Returns true in all other cases to keep the application running.
fn navigate(current_dir: &mut PathBuf, selection: &str, entry_count: usize) -> bool {
    match selection.to_uppercase().as_str() {
        "B" => {
            navigate_back(current_dir);
            true
        }
        "X" => {
            utils::clear_screen();
            false
        }
        selection => match selection.parse::<usize>() {
            Ok(num) if num >= 1 && num <= entry_count => select_entry(current_dir, selection),
            _ => {
                println!("Invalid selection. Please try again.");
                true
            }
        },
    }
}

/// Checks the current directory for a single script and runs it if found.
///
/// Returns a path to the script if one is found and run successfully, or None otherwise.
fn check_and_run_single_script(current_dir: &Path) -> io::Result<Option<PathBuf>> {
    let entries = fs::read_dir(current_dir)?
        .filter_map(Result::ok)
        .filter(|e| e.path().is_file() && e.path().extension().map_or(false, |ext| ext == "sh"))
        .collect::<Vec<_>>();

    if entries.len() == 1 {
        Ok(Some(entries[0].path()))
    } else {
        Ok(None)
    }
}

/// Executes the script at the specified path.
///
/// Logs the outcome of the script execution.
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

/// Helper function to navigate back to the parent directory.
///
/// Adjusts `current_dir` if not already at the base directory.
fn navigate_back(current_dir: &mut PathBuf) {
    if current_dir.as_path() != Path::new(BASE_DIR) {
        if let Some(parent) = current_dir.parent() {
            *current_dir = parent.to_path_buf();
        }
    }
}

/// Helper function to handle menu selection.
///
/// Returns false if an invalid selection is made, true otherwise.
fn select_entry(current_dir: &mut PathBuf, selection: &str) -> bool {
    if let Ok(index) = selection.parse::<usize>() {
        let current_dir_clone = current_dir.clone();
        let mut entries = fs::read_dir(&current_dir_clone)
            .unwrap()
            .filter_map(Result::ok)
            .filter(|e| {
                (e.path().is_dir() && e.file_name().to_string_lossy() != "Scripts")
                    || (e.path().is_file() && e.path().extension().map_or(false, |ext| ext == "sh"))
            })
            .collect::<Vec<_>>();

        entries.sort_by(|a, b| {
            a.file_name()
                .to_string_lossy()
                .to_lowercase()
                .cmp(&b.file_name().to_string_lossy().to_lowercase())
        });

        if index > 0 && index <= entries.len() {
            let selected_entry = &entries[index - 1];
            let selected_path = selected_entry.path();

            let action = if selected_path.is_dir() {
                Some(Action::Navigate(selected_path.clone()))
            } else if selected_path.is_file() {
                Some(Action::RunScript(selected_path.clone()))
            } else {
                None
            };

            if let Some(action) = action {
                match action {
                    Action::Navigate(path) => *current_dir = path,
                    Action::RunScript(path) => {
                        let mut current_dir_clone = current_dir.clone();
                        run_script(&path, &mut current_dir_clone)
                    }
                }
            }
            true
        } else {
            false
        }
    } else {
        false
    }
}

enum Action {
    Navigate(PathBuf),
    RunScript(PathBuf),
}
