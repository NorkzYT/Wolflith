// First run `sudo apt install pkg-config`
// sudo apt-get update
// sudo apt-get install libssl-dev
// sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
// cd PCSRustMenu
// cargo build --release
// sudo /opt/Wolflith/PCSRustMenu/target/release/pcsmenu

mod menu;
mod utils;

fn main() {
    menu::main();
}
