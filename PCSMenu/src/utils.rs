use chrono::{DateTime, Duration, Utc};
use get_if_addrs::{get_if_addrs, IfAddr};
use lazy_static::lazy_static;
use std::collections::HashMap;
use std::fs;
use std::fs::File;
use std::io::Write;
use std::io::{self, BufRead};
use std::path::Path;
use std::process::{exit, Command};
use std::sync::Mutex;
use sysinfo::System;
use termcolor::{Color, ColorChoice, ColorSpec, StandardStream, WriteColor};

/// Clears the terminal screen.
pub fn clear_screen() {
    print!("\x1B[2J\x1B[1;1H");
}

/// Displays the default menu screen by clearing the screen and showing the main cover and menu bar.
pub fn default_menu_screen() {
    clear_screen();
    main_cover();
    menu_bar();
}

lazy_static! {
    static ref LATEST_VERSION: Mutex<Option<String>> = Mutex::new(None);
}

/// Displays the main cover, including the application name and version.
///
/// The version is fetched dynamically from a GitHub repository's latest release.
pub fn main_cover() {
    let mut version = LATEST_VERSION.lock().unwrap();
    if version.is_none() {
        *version = Some(
            fs::read_to_string("/opt/Wolflith/PCSMenu/version")
                .unwrap_or_else(|_| "unknown".to_string()),
        );
    }
    let menu_cover = format!(
        " 
  _____   _____  _____  _____ ____  _____  _____  ™
 |  __ \\ / ____|/ ____|/ ____/ __ \\|  __ \\|  __ \\ 
 | |__) | |    | (___ | |   | |  | | |__) | |__) |
 |  ___/| |     \\___ \\| |   | |  | |  _  /|  ___/ 
 | |    | |____ ____) | |___| |__| | | \\ \\| |     
 |_|     \\_____|_____/ \\_____\\____/|_|  \\_\\_|      Version: {}\n",
        version.as_ref().unwrap()
    );

    print_color_bold(&menu_cover, Color::Cyan, true);
}

/// Ensures the version file exists and is populated with the latest version.
/// If the file doesn't exist, it creates it and populates it with the latest version from GitHub.
/// If the file exists, it checks the version and notifies the user if an update is available.
pub fn check_update() {
    let version_path = "/opt/Wolflith/PCSMenu/version";
    let latest_version_url = "https://api.github.com/repos/NorkzYT/Wolflith/releases/latest";

    if !Path::new(version_path).exists() {
        match fetch_version_from_github_releases(latest_version_url) {
            Ok(latest_version) => {
                if let Err(e) = fs::write(version_path, &latest_version) {
                    eprintln!("Failed to create version file: {}", e);
                    return;
                }
            }
            Err(e) => {
                eprintln!("Failed to fetch latest version: {}", e);
                return;
            }
        }
    }

    let local_version = match read_first_line(version_path) {
        Ok(version) => version,
        Err(e) => {
            eprintln!("Error reading local version: {}", e);
            return;
        }
    };

    let current_version = match fetch_version_from_github_releases(latest_version_url) {
        Ok(version) => version,
        Err(e) => {
            eprintln!("Error fetching current version: {}", e);
            return;
        }
    };

    if local_version != current_version {
        loop {
            clear_screen();
            main_cover();
            println!("Your PCSMenu is not up-to-date.");
            println!("Enter 'c' to continue to update or any other key to cancel...");

            let mut input = String::new();
            match io::stdin().read_line(&mut input) {
                Ok(_) => {
                    if input.trim().eq_ignore_ascii_case("c") {
                        println!("Continuing to update...");

                        match Command::new("/opt/Wolflith/PCSMenu/PCSUpdate.sh").status() {
                            Ok(status) if status.success() => {
                                println!("Update completed successfully. Please re-open the Menu.");
                                exit(0);
                            }
                            Ok(status) => {
                                println!("Update script exited with: {}", status);
                                break;
                            }
                            Err(e) => {
                                println!("Failed to execute update script: {}", e);
                                break;
                            }
                        }
                    } else {
                        println!("Invalid input. Please enter 'c' to continue with the update.");
                    }
                }
                Err(error) => {
                    println!("Error reading input: {}", error);
                    break;
                }
            }
        }
    }
}

/// Reads the first line from a file.
fn read_first_line<P: AsRef<Path>>(path: P) -> io::Result<String> {
    let file = File::open(path)?;
    let mut buf_reader = io::BufReader::new(file);
    let mut line = String::new();
    buf_reader.read_line(&mut line)?;
    Ok(line.trim().to_string())
}

/// Fetches the latest version tag directly from GitHub releases.
fn fetch_version_from_github_releases(url: &str) -> Result<String, Box<dyn std::error::Error>> {
    let client = reqwest::blocking::Client::new();
    let response = client.get(url).header("User-Agent", "request").send()?;
    if response.status().is_success() {
        let text = response.text()?;
        let json = serde_json::from_str::<serde_json::Value>(&text)?;
        if let Some(tag_name) = json["tag_name"].as_str() {
            return Ok(tag_name.to_string());
        }
    }
    Err("Failed to fetch or parse version".into())
}

/// Retrieves the primary IPv4 address of the machine.
///
/// Returns a string representation of the IPv4 address.
fn get_ipv4() -> String {
    if let Ok(addrs) = get_if_addrs() {
        for addr in addrs {
            match addr.addr {
                IfAddr::V4(v4_addr) => {
                    if !v4_addr.is_loopback() {
                        return v4_addr.ip.to_string();
                    }
                }
                _ => continue,
            }
        }
    }
    "Error fetching IP".to_string()
}

/// Attempts to retrieve the Tailscale IP address of the machine, if available.
///
/// Returns an `Option<String>` containing the Tailscale IP address or `None` if not found.
fn get_tailscale_ip() -> Option<String> {
    if let Ok(addrs) = get_if_addrs::get_if_addrs() {
        addrs
            .into_iter()
            .find(|iface| iface.ip().to_string().starts_with("100."))
            .map(|iface| iface.ip().to_string())
    } else {
        None
    }
}

/// Struct representing a cached IP address and the last time it was updated.
struct CachedIP {
    ip: String,
    last_update: DateTime<Utc>,
}

lazy_static! {
    static ref IP_CACHE: Mutex<Option<CachedIP>> = Mutex::new(None);
}

/// Retrieves the public IP address, updating it every 3 hours if necessary.
///
/// Returns a string representation of the public IP address.
fn get_public_ip() -> String {
    let mut ip_cache = IP_CACHE.lock().unwrap();
    let now = Utc::now();

    match &*ip_cache {
        Some(cached_ip) if now - cached_ip.last_update < Duration::try_hours(3).unwrap() => {
            cached_ip.ip.clone()
        }
        _ => match reqwest::blocking::get("https://api.ipify.org") {
            Ok(response) => {
                if response.status().is_success() {
                    match response.text() {
                        Ok(ip) => {
                            *ip_cache = Some(CachedIP {
                                ip: ip.clone(),
                                last_update: now,
                            });
                            ip
                        }
                        Err(_) => "Error fetching IP".to_string(),
                    }
                } else {
                    "API request failed".to_string()
                }
            }
            Err(_) => "Network request failed".to_string(),
        },
    }
}

/// Retrieves information about the CPU, such as the number of logical cores.
///
/// Returns the number of logical CPU cores as a usize.
fn get_cpu_info() -> usize {
    let mut system = System::new_all();
    system.refresh_all();
    system.cpus().len()
}

/// Retrieves the current free memory of the system.
///
/// Returns a string representing the amount of free RAM in GB.
fn get_ram_info() -> String {
    let mut system = System::new_all();
    system.refresh_memory();
    let total_memory_gb = system.total_memory() as f64 / 1024.0 / 1024.0;
    let used_memory_gb = system.used_memory() as f64 / 1024.0 / 1024.0;
    let free_memory_gb = total_memory_gb - used_memory_gb;
    format!("{:.4} GB", free_memory_gb)
}

/// Fetches the operating system's release information.
///
/// Returns a string containing the pretty name of the OS.
pub fn os_release() -> String {
    let path = "/etc/os-release";
    let content = fs::read_to_string(path);

    match content {
        Ok(content) => {
            let entries = content
                .lines()
                .filter_map(|line| {
                    let mut parts = line.splitn(2, '=');
                    match (parts.next(), parts.next()) {
                        (Some(key), Some(value)) => Some((key.trim(), value.trim_matches('"'))),
                        _ => None,
                    }
                })
                .collect::<HashMap<_, _>>();

            entries
                .get("PRETTY_NAME")
                .map(|s| s.to_string())
                .unwrap_or_else(|| "Unknown OS".to_string())
        }
        Err(_) => "Error reading /etc/os-release".to_string(),
    }
}

/// Displays the menu bar with system information.
pub fn menu_bar() {
    let ipv4 = get_ipv4();
    let tailscale_ip = get_tailscale_ip();
    let public_ip = get_public_ip();
    let cpu_s = get_cpu_info();
    let ram_free = get_ram_info();
    let cpu_threads = cpu_s * 2;
    let os_release = os_release();
    let tailscale_ip_info =
        tailscale_ip.map_or_else(|| "".to_string(), |ip| format!(" | Tailscale IP: {}", ip));

    print_color_bold(
        &format!(
            "OS: {} | CPU(s): {} | CPU Threads: {} | IPv4: {} | Public IP: {}{} | RAM free: {}\n",
            os_release, cpu_s, cpu_threads, ipv4, public_ip, tailscale_ip_info, ram_free
        ),
        Color::Cyan,
        true,
    );
}

/// Prints the specified text in the given color to the terminal.
///
/// Parameters:
/// - `text`: The text to be printed.
/// - `color`: The `Color` in which the text should be printed.
pub fn print_color(text: &str, color: Color) {
    let mut stdout = StandardStream::stdout(ColorChoice::Always);
    stdout
        .set_color(ColorSpec::new().set_fg(Some(color)))
        .unwrap();
    writeln!(&mut stdout, "{}", text).unwrap();
    stdout.reset().unwrap();
}

/// Prints text in bold with the specified color to the terminal.
///
/// Parameters:
/// - `text`: The text to print.
/// - `color`: The color to use for the text.
/// - `bold`: Whether the text should be bold.
pub fn print_color_bold(text: &str, color: Color, bold: bool) {
    let mut stdout = StandardStream::stdout(ColorChoice::Always);
    let mut color_spec = ColorSpec::new();
    color_spec.set_fg(Some(color)).set_bold(bold);
    stdout.set_color(&color_spec).unwrap();
    writeln!(&mut stdout, "{}", text).unwrap();
    stdout.reset().unwrap();
}
