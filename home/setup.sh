# run on new shell home
# *リンク先の各ライセンスに注意
cp /etc/pacman.conf /tmp/pacman.conf
sed -i 's|^#\(XferCommand = /usr/bin/curl \)\(.*\)|\1-k \2|' /tmp/pacman.conf
# (注意:-k SSL認証OFF)
pacman-key --init --config /tmp/pacman.conf
pacman-key --populate msys2 --config /tmp/pacman.conf
pacman -Sy --config /tmp/pacman.conf
pacman -S git --config /tmp/pacman.conf -y
pacman -S unzip --config /tmp/pacman.conf -y
pacman -S diffutils --config /tmp/pacman.conf -y
pacman -S tmux --config /tmp/pacman.conf -y
# https://github.com/tmux/tmux/wiki/Getting-Started
# tmux new
pacman -S tree --config /tmp/pacman.conf -y

source .bashrc

mkdir $OPT/7zip
wget -O $OPT/7zip/7zr.exe https://www.7-zip.org/a/7zr.exe
source .bashrc
dlzip https://www.7-zip.org/a/7z2500-extra.7z $OPT/7zip
source .bashrc

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

dlzip https://go.dev/dl/go1.24.5.windows-amd64.zip $OPT/go

dlzip https://www.python.org/ftp/python/3.12.10/python-3.12.10-embed-amd64.zip $OPT/python
sed -i 's/^#import site$/import site/' "$OPT/python/python312._pth"
wget -O $OPT/python/get-pip.py https://bootstrap.pypa.io/pip/get-pip.py
source .bashrc
python $OPT/python/get-pip.py
source .bashrc
python -m pip install --upgrade pip setuptools wheel

dlzip https://github.com/PintaProject/Pinta/releases/download/3.0.2/pinta-3.0.2.zip $OPT/pinta
