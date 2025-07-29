# run on new shell home
# *リンク先の各ライセンスに注意

cp /etc/pacman.conf /tmp/pacman.conf
sed -i 's|^#\(XferCommand = /usr/bin/curl \)\(.*\)|\1-k \2|' /tmp/pacman.conf
# (注意:-k SSL認証OFF)
pacman-key --init --config /tmp/pacman.conf
pacman-key --populate msys2 --config /tmp/pacman.conf
# pacman -Sy --config /tmp/pacman.conf --noconfirm
pacman -S git --config /tmp/pacman.conf --noconfirm
pacman -S unzip --config /tmp/pacman.conf --noconfirm
pacman -S diffutils --config /tmp/pacman.conf --noconfirm
pacman -S tmux --config /tmp/pacman.conf --noconfirm
pacman -S vim --config /tmp/pacman.conf --noconfirm
pacman -S python --config /tmp/pacman.conf --noconfirm
# https://github.com/tmux/tmux/wiki/Getting-Started
# tmux new
pacman -S tree --config /tmp/pacman.conf --noconfirm

mkdir $OPT/7zip
export PATH=$PATH:$OPT/7zip
curl -k --ssl-no-revoke -L -o $OPT/7zip/7zr.exe https://www.7-zip.org/a/7zr.exe
curl -k --ssl-no-revoke -L -o $OPT/7zip/7z2500-extra.7z https://www.7-zip.org/a/7z2500-extra.7z
$OPT/7zip/7zr.exe x $OPT/7zip/7z2500-extra.7z -o"$OPT/7zip/"

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$HOME/.fzf/install --key-bindings --completion --no-update-rc

dlzip https://go.dev/dl/go1.24.5.windows-amd64.zip $OPT/go
mv $OPT/go/go/* $OPT/go/

dlzip https://www.python.org/ftp/python/3.12.10/python-3.12.10-embed-amd64.zip $OPT/python
sed -i 's/^#import site$/import site/' "$OPT/python/python312._pth"
curl -k --ssl-no-revoke -L -o $OPT/python/get-pip.py https://bootstrap.pypa.io/pip/get-pip.py
$OPT/python/python $OPT/python/get-pip.py
$OPT/python/Scripts/pip install --upgrade setuptools wheel

dlzip https://github.com/gitui-org/gitui/releases/download/v0.27.0/gitui-win.tar.gz $OPT/gitui
$OPT/7zip/7za x $OPT/gitui/gitui-win.tar -o$OPT/gitui
dlzip https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-pc-windows-gnu.zip $OPT/ripgrep
dlzip https://nodejs.org/dist/v22.17.1/node-v22.17.1-win-x64.zip $OPT/node
dlzip https://github.com/LuaLS/lua-language-server/releases/download/3.15.0/lua-language-server-3.15.0-win32-x64.zip $OPT/lualsp
dlzip https://github.com/sharkdp/bat/releases/download/v0.25.0/bat-v0.25.0-x86_64-pc-windows-gnu.zip $OPT/bat
dlzip https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-x86_64-pc-windows-msvc.zip $OPT/delta
dlzip https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-pc-windows-gnu.zip $OPT/fd
dlzip https://github.com/avih/uclip/releases/download/v0.6/uclip.version-0.6.zip $OPT/uclip
dlzip https://github.com/gitui-org/gitui/releases/download/v0.27.0/gitui-win.tar.gz $OPT/gitui
dlzip https://github.com/charmbracelet/glow/releases/download/v2.1.1/glow_2.1.1_Windows_x86_64.zip $OPT/glow

git clone https://github.com/Shougo/dein.vim ~/.cache/dein/repos/github.com/Shougo/dein.vim
mkdir -p ~/.vim/rc
touch ~/.vim/rc/dein.toml ~/.vim/rc/dein_lazy.toml
