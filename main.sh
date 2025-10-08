#!/bin/bash

# Warna biar keren dikit
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RESET='\033[0m'
BOLD='\033[1m'

clear
echo -e "${BOLD}${CYAN}╔══════════════════════════════════════════════════╗"
echo -e "║      Chrome Remote Desktop (CRD) Installer       ║"
echo -e "╚══════════════════════════════════════════════════╝${RESET}\n"

# Pilih desktop environment
echo -e "${YELLOW}Pilih Desktop Environment:${RESET}"
echo "1) KDE Plasma"
echo "2) XFCE"
echo "3) UKUI"
read -t 15 -p "Masukkan pilihan (1/2/3) [default=2]: " choice

if [ -z "$choice" ]; then
  choice=2
fi

echo -e "\n${GREEN}==> Update system...${RESET}"
sudo apt update && sudo apt upgrade -y

echo -e "\n${GREEN}==> Install dependensi umum...${RESET}"
sudo apt install -y wget curl unzip nano

echo -e "\n${GREEN}==> Install Chrome Remote Desktop...${RESET}"
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo apt install -y ./chrome-remote-desktop_current_amd64.deb
rm -f chrome-remote-desktop_current_amd64.deb

echo -e "\n${GREEN}==> Install Desktop Environment pilihanmu...${RESET}"
if [ "$choice" = "1" ]; then
    echo -e "${YELLOW}Menginstall KDE Plasma...${RESET}"
    sudo apt install -y kde-plasma-desktop
    echo "startplasma-x11" > ~/.chrome-remote-desktop-session
elif [ "$choice" = "2" ]; then
    echo -e "${YELLOW}Menginstall XFCE4...${RESET}"
    sudo apt install -y xfce4 xfce4-goodies
    echo "exec /usr/bin/xfce4-session" > ~/.chrome-remote-desktop-session
elif [ "$choice" = "3" ]; then
    echo -e "${YELLOW}Menginstall UKUI...${RESET}"
    sudo apt install -y ukui-desktop-environment
    echo "exec /usr/bin/ukui-session" > ~/.chrome-remote-desktop-session
else
    echo -e "${YELLOW}Pilihan salah, default ke XFCE.${RESET}"
    sudo apt install -y xfce4 xfce4-goodies
    echo "exec /usr/bin/xfce4-session" > ~/.chrome-remote-desktop-session
fi

chmod +x ~/.chrome-remote-desktop-session

echo -e "\n${GREEN}==> Konfigurasi selesai!${RESET}"
echo -e "${CYAN}Sekarang buka link berikut di browser kamu:${RESET}"
echo -e "${YELLOW}https://remotedesktop.google.com/headless${RESET}"
echo -e "1. Login dengan akun Google."
echo -e "2. Pilih 'Set up another computer' → pilih Linux."
echo -e "3. Copy command yang diberikan Google."
echo -e "4. Paste di terminal ini untuk link server ke akunmu.\n"

echo -e "${GREEN}=== Installer selesai! ===${RESET}"
