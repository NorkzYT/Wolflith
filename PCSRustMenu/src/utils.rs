use serde_json::Value;
use std::sync::Mutex;
use lazy_static::lazy_static; 
use chrono::{DateTime, Utc, Duration};
use std::io::Write;
use sysinfo::System;
use termcolor::{Color, ColorChoice, ColorSpec, StandardStream, WriteColor};
use get_if_addrs::{get_if_addrs, IfAddr};

pub fn clear_screen() {
    print!("\x1B[2J\x1B[1;1H");
}

pub fn default_menu_screen() {
    clear_screen();
    main_cover(); 
    menu_bar();
}

pub fn main_cover() {
    let latest_version = fetch_latest_version();
    let menu_cover = format!(
        " 
  _____   _____  _____  _____ ____  _____  _____  ™
 |  __ \\ / ____|/ ____|/ ____/ __ \\|  __ \\|  __ \\ 
 | |__) | |    | (___ | |   | |  | | |__) | |__) |
 |  ___/| |     \\___ \\| |   | |  | |  _  /|  ___/ 
 | |    | |____ ____) | |___| |__| | | \\ \\| |     
 |_|     \\_____|_____/ \\_____\\____/|_|  \\_\\_|      Version: {}\n",
        latest_version
    );

    print_color_bold(&menu_cover, Color::Cyan, true);
}

fn fetch_latest_version() -> String {
    let url = "https://api.github.com/repos/NorkzYT/Wolflith/releases/latest";
    let client = reqwest::blocking::Client::new();
    let request = client.get(url).header("User-Agent", "request");

    match request.send() {
        Ok(response) => {
            if response.status().is_success() {
                match response.text() {
                    Ok(text) => match serde_json::from_str::<Value>(&text) {
                        Ok(json) => json["tag_name"].as_str().unwrap_or("unknown").to_string(),
                        Err(_) => "Error parsing JSON".to_string(),
                    },
                    Err(_) => "Error getting response text".to_string(),
                }
            } else {
                "API request failed".to_string()
            }
        }
        Err(_) => "Network request failed".to_string(),
    }
}

// New functions for the menu_bar equivalent in Rust
fn get_ipv4() -> String {
    if let Ok(addrs) = get_if_addrs() {
        for addr in addrs {
            match addr.addr {
                IfAddr::V4(v4_addr) => {
                    if !v4_addr.is_loopback() {
                        return v4_addr.ip.to_string();
                    }
                },
                _ => continue,
            }
        }
    }
    "Error fetching IP".to_string()
}

fn get_tailscale_ip() -> Option<String> {
    // Similar approach as get_ipv4 but specifically for the Tailscale IP range
    if let Ok(addrs) = get_if_addrs::get_if_addrs() {
        addrs
            .into_iter()
            .find(|iface| iface.ip().to_string().starts_with("100."))
            .map(|iface| iface.ip().to_string())
    } else {
        None
    }
}

// Struct to hold the cached IP and the last update time
struct CachedIP {
    ip: String,
    last_update: DateTime<Utc>,
}

// Using lazy_static to safely create a static mutable variable
lazy_static! {
    static ref IP_CACHE: Mutex<Option<CachedIP>> = Mutex::new(None);
} 

// Function to get the public IP, updating it every 3 hours if needed
fn get_public_ip() -> String {
    let mut ip_cache = IP_CACHE.lock().unwrap();
    let now = Utc::now();
    
    match &*ip_cache {
        Some(cached_ip) if now - cached_ip.last_update < Duration::try_hours(3).unwrap() => {
            // Cached IP is still fresh
            cached_ip.ip.clone()
        },
        _ => {
            // Cache is empty or IP is old, fetch new IP and update cache
            match reqwest::blocking::get("https://api.ipify.org") {
                Ok(response) => {
                    if response.status().is_success() {
                        match response.text() {
                            Ok(ip) => {
                                *ip_cache = Some(CachedIP {
                                    ip: ip.clone(),
                                    last_update: now,
                                });
                                ip
                            },
                            Err(_) => "Error fetching IP".to_string(),
                        }
                    } else {
                        "API request failed".to_string()
                    }
                },
                Err(_) => "Network request failed".to_string(),
            }
        },
    }
}

fn get_cpu_info() -> usize {
    let mut system = System::new_all();
    system.refresh_all();
    system.cpus().len()  // This retrieves the number of logical CPUs.
}

fn get_ram_info() -> String {
    let mut system = System::new_all();
    system.refresh_memory();
    // sysinfo reports memory in KiB, so convert total and used memory from KiB to GiB for display
    let total_memory_gb = system.total_memory() as f64 / 1024.0 / 1024.0;
    let used_memory_gb = system.used_memory() as f64 / 1024.0 / 1024.0;
    let free_memory_gb = total_memory_gb - used_memory_gb; // Calculate free memory in GiB
    format!("{:.4} GB", free_memory_gb) // Format the output to 4 decimal places
}


pub fn os_release() -> String {
    // Example implementation using sysinfo crate
    let mut system = System::new_all();
    system.refresh_all();
    format!("{} {}", sysinfo::System::name().unwrap_or_default(), sysinfo::System::os_version().unwrap_or_default())
}


pub fn menu_bar() {
    let ipv4 = get_ipv4();
    let tailscale_ip = get_tailscale_ip();
    let public_ip = get_public_ip();
    let cpu_s = get_cpu_info();
    let ram_free = get_ram_info();
    let cpu_threads = cpu_s * 2; // Assuming 2 threads per core as a simplification

    let os_release = os_release(); // Implement os_release based on your needs

    print_color_bold(&format!("OS: {} | CPU(s): {} | CPU Threads: {} | IPv4: {} | Public IP: {} | {} | RAM free: {}\n", 
        os_release, cpu_s, cpu_threads, ipv4, public_ip, 
        tailscale_ip.map_or_else(|| "".to_string(), |ip| format!("Tailscale IP: {}", ip)), 
        ram_free), Color::Cyan, true);
}

// pub fn print_color(text: &str, color: Color) {
//     let mut stdout = StandardStream::stdout(ColorChoice::Always);
//     stdout
//         .set_color(ColorSpec::new().set_fg(Some(color)))
//         .unwrap();
//     writeln!(&mut stdout, "{}", text).unwrap();
//     stdout.reset().unwrap();
// }

pub fn print_color_bold(text: &str, color: Color, bold: bool) {
    let mut stdout = StandardStream::stdout(ColorChoice::Always);
    // First, create a mutable ColorSpec instance
    let mut color_spec = ColorSpec::new();
    // Then, apply the settings separately
    color_spec.set_fg(Some(color)).set_bold(bold);
    stdout.set_color(&color_spec).unwrap();
    writeln!(&mut stdout, "{}", text).unwrap();
    stdout.reset().unwrap();
}
