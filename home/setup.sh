# run on new shell home
cp /etc/pacman.conf /tmp/pacman.conf
sed -i 's|^#\(XferCommand = /usr/bin/curl \)\(.*\)|\1-k \2|' /tmp/pacman.conf
# (注意:-k SSL認証OFF)
pacman-key --init --config /tmp/pacman.conf
pacman-key --populate msys2 --config /tmp/pacman.conf
pacman -Sy --config /tmp/pacman.conf
pacman -S git --config /tmp/pacman.conf -y
pacman -S unzip --config /tmp/pacman.conf -y
pacman -S p7zip --config /tmp/pacman.conf -y
pacman -S diffutils --config /tmp/pacman.conf -y
pacman -S tmux --config /tmp/pacman.conf -y
# https://github.com/tmux/tmux/wiki/Getting-Started
# tmux new
pacman -S tree --config /tmp/pacman.conf -y

source .bashrc

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc
