#!/usr/bin/env python3
import requests
import os
import subprocess

REPO_OWNER = "ryanoasis"
REPO_NAME = "nerd-fonts"
FONT_NAME = "Iosevka.zip"

def get_latest_release():
    api_url = f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/releases/latest"
    response = requests.get(api_url)
    
    if response.status_code == 200:
        release_data = response.json()
        return release_data["tag_name"]
    else:
        raise Exception(f"Failed to fetch release data: {response.status_code} - {response.text}")

def download_font(version):
    download_url = f"https://github.com/{REPO_OWNER}/{REPO_NAME}/releases/download/{version}/{FONT_NAME}"
    response = requests.get(download_url, stream=True)
    
    if response.status_code == 200:
        file_path = os.path.join(os.getcwd(), FONT_NAME)
        with open(file_path, "wb") as file:
            for chunk in response.iter_content(chunk_size=8192):
                file.write(chunk)
        print(f"Downloaded {FONT_NAME} to {file_path}")
        return file_path
    else:
        raise Exception(f"Failed to download font: {response.status_code} - {response.text}")

def install_font(zip_file_path):
    fonts_dir = os.path.expanduser("~/.fonts")
    os.makedirs(fonts_dir, exist_ok=True)
    unzip_command = f"unzip {zip_file_path} -d {fonts_dir}"
    print(f"Running command: {unzip_command}")
    subprocess.run(unzip_command, shell=True, check=True)
    
    refresh_command = "fc-cache -fv"
    print(f"Running command: {refresh_command}")
    subprocess.run(refresh_command, shell=True, check=True)
    print("Font installation completed successfully.")


if __name__ == "__main__":
    try:
        print("Fetching the latest release version...")
        latest_version = get_latest_release()
        print(f"Latest version: {latest_version}")
        
        print(f"Downloading {FONT_NAME}...")
        zip_file = download_font(latest_version)

        print("Installing the font...")
        install_font(zip_file)
    except Exception as e:
        print(f"Error: {e}")
