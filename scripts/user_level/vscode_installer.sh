mkdir -p ~/.local/opt
cd ~/.local/opt

wget -O vscode.tar.gz "https://update.code.visualstudio.com/latest/linux-x64/stable"

tar -xf vscode.tar.gz
mv VSCode-linux-x64 vscode
rm vscode.tar.gz

mkdir -p ~/.local/bin
ln -sf ~/.local/opt/vscode/bin/code ~/.local/bin/code.real

cat > ~/.local/bin/code <<EOF
#!/bin/sh
exec "$HOME/.local/bin/code.real" --no-sandbox "$@"
EOF

chmod +x ~/.local/bin/code

mkdir -p ~/.local/share/applications

cat > ~/.local/share/applications/code.desktop <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Visual Studio Code
GenericName=Text Editor
Comment=Code Editing. Redefined.
Exec=$HOME/.local/bin/code %F
Icon=$HOME/.local/opt/vscode/resources/app/resources/linux/code.png
Terminal=false
StartupNotify=true
StartupWMClass=Code
Categories=TextEditor;Development;IDE;
MimeType=text/plain;
Actions=new-empty-window;

[Desktop Action new-empty-window]
Name=New Empty Window
Exec=$HOME/.local/bin/code --new-window %F
Icon=$HOME/.local/opt/vscode/resources/app/resources/linux/code.png
EOF
