```sh
sudo snap remove --purge firefox
sudo snap remove --purge thunderbird

sudo snap remove --purge snapd-desktop-integration
sudo snap remove --purge gtk-common-themes
sudo snap remove --purge gnome-42-2204
sudo snap remove --purge bare
sudo snap remove --purge core22

sudo snap remove --purge prompting-client desktop-security-center firmware-updater
sudo snap remove --purge mesa-2404 gnome-46-2404
sudo snap remove --purge core24

sudo apt-get purge -y snapd
sudo apt-get autoremove -y

sudo rm -rf /var/cache/snapd/
sudo rm -rf /var/snap/
sudo rm -rf /var/lib/snapd/

# no sudo
rm -rf ~/snap




```