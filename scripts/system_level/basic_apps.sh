#!/bin/bash

# Ensure the script is run with root privileges for potential package checking/installation
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with root privileges (sudo)!"
  exit 1
fi

echo "=================================================="
echo "          Application Installer Setup             "
echo "=================================================="

# --------------------------------------------------
# STEP 1: Gather User Preferences
# --------------------------------------------------

# Function to prompt user with a default 'Yes' choice
prompt_install() {
    local app_name=$1
    read -p "Do you want to install $app_name? [Y/n]: " choice
    choice=${choice:-"y"} # Default to 'y' if user just hits Enter

    if [[ "$choice" =~ ^[Yy]$ ]]; then
        return 0 # True / Yes
    else
        return 1 # False / No
    fi
}

# Ask for each application
prompt_install "Google Chrome" && install_chrome=true || install_chrome=false
prompt_install "Sublime Text" && install_sublime=true || install_sublime=false
prompt_install "Sublime Merge" && install_merge=true || install_merge=false
prompt_install "IBus" && install_ibus=true || install_ibus=false
prompt_install "OneDrive (openSUSE Repo)" && install_onedrive=true || install_onedrive=false

echo -e "\n=================================================="
echo "          Executing Installation Steps            "
echo "=================================================="

# --------------------------------------------------
# STEP 2: Dedicated Installation Processes
# --------------------------------------------------

# --- 1. GOOGLE CHROME ---
if [ "$install_chrome" = true ]; then
    echo "Processing Google Chrome..."
    if command -v google-chrome-stable &> /dev/null; then
        echo "[Already Installed] Google Chrome is already on this system."
    else
        echo "Installing Google Chrome..."
        wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        apt install -y ./google-chrome-stable_current_amd64.deb
        rm ./google-chrome-stable_current_amd64.deb
        echo "[Success] Google Chrome installed."
    fi
else
    echo "Google Chrome... [Skipped]"
fi

echo "--------------------------------------------------"

# --- 2. SUBLIME TEXT ---
if [ "$install_sublime" = true ]; then
    echo "Processing Sublime Text..."
    if command -v subl &> /dev/null; then
        echo "[Already Installed] Sublime Text is already on this system."
    else
        echo "Installing Sublime Text..."
        mkdir -p /etc/apt/keyrings
        wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
        echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | tee /etc/apt/sources.list.d/sublime-text.sources > /dev/null
        apt update &> /dev/null
        apt-get install -y sublime-text
        echo "[Success] Sublime Text installed."
    fi
else
    echo "Sublime Text... [Skipped]"
fi

echo "--------------------------------------------------"

# --- 3. SUBLIME MERGE ---
if [ "$install_merge" = true ]; then
    echo "Processing Sublime Merge..."
    if command -v smerge &> /dev/null; then
        echo "[Already Installed] Sublime Merge is already on this system."
    else
        echo "Installing Sublime Merge..."
        # Ensure Sublime GPG key and repo exist (in case user skipped Sublime Text but wants Merge)
        if [ ! -f "/etc/apt/sources.list.d/sublime-text.sources" ]; then
            mkdir -p /etc/apt/keyrings
            wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
            echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | tee /etc/apt/sources.list.d/sublime-text.sources > /dev/null
            apt update &> /dev/null
        fi
        apt-get install -y apt-transport-https
        apt-get install -y sublime-merge
        echo "[Success] Sublime Merge installed."
    fi
else
    echo "Sublime Merge... [Skipped]"
fi

echo "--------------------------------------------------"

# --- 4. IBUS BAMBOO ---
if [ "$install_ibus" = true ]; then
    echo "Processing IBus Bamboo..."
    # Check if the bamboo engine is registered inside ibus component list
    if dpkg -l | grep -q ibus-bamboo ; then
        echo "[Already Installed] IBus Bamboo is already on this system."
    else
        echo "Installing IBus Bamboo..."
        add-apt-repository -y ppa:bamboo-engine/ibus-bamboo
        apt update &> /dev/null
        apt install -y ibus-bamboo
        ibus restart
        echo "[Success] IBus Bamboo installed."
    fi
else
    echo "IBus Bamboo... [Skipped]"
fi

echo "--------------------------------------------------"

# --- 5. ONEDRIVE -----
if [ "$install_onedrive" = true ]; then
    echo "Processing OneDrive..."

    # Safe Verification & Clean Up
    if dpkg -l | grep -q "^ii  onedrive " 2>/dev/null; then
        if apt-cache policy onedrive | grep -q "opensuse.org"; then
            echo "[Verified] Official openSUSE repository version is already active."
            SHOULD_INSTALL_ONEDRIVE=false
        else
            echo "[Warning] A non-openSUSE version of OneDrive was detected. Purging..."
            apt-get purge -y onedrive &> /dev/null
            sudo apt-get autoremove -y &> /dev/null
            sudo apt-get clean &> /dev/null
            SHOULD_INSTALL_ONEDRIVE=true
        fi
    else
        echo "[Not Found] Initializing clean OneDrive installation."
        SHOULD_INSTALL_ONEDRIVE=true
    fi

    # Dedicated Repository & Installation
    if [ "$SHOULD_INSTALL_ONEDRIVE" = true ]; then
        echo "Adding openSUSE OBS repository keys..."
        wget -qO - https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_26.04/Release.key | gpg --dearmor | tee /usr/share/keyrings/obs-onedrive.gpg > /dev/null

        echo "Configuring APT sources definition..."
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/obs-onedrive.gpg] https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_26.04/ ./" | tee /etc/apt/sources.list.d/onedrive.list > /dev/null

        apt-get update &> /dev/null
        apt-get install -y --no-install-recommends --no-install-suggests onedrive &> /dev/null
        echo "[Success] OneDrive package installed."
    fi
else
    echo "OneDrive... [Skipped]"
fi

echo "=================================================="
echo "Execution completed successfully."