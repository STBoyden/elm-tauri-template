#![cfg_attr(
    all(not(debug_assertions), target_os = "windows"),
    windows_subsystem = "windows"
)]

use chrono::Local;

#[tauri::command]
fn info() -> String { format!("{:#?}, Time: {}", std::thread::current(), Local::now()) }

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![info])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
