cp /etc/pacman.conf /tmp/pacman.conf
echo 'XferCommand = /usr/bin/curl -k -L -C - -f -o %o %u' >> /tmp/pacman.conf 
# (注意:-k SSL認証OFF)
pacman-key --init --config /tmp/pacman.conf
pacman-key --populate msys2 --config /tmp/pacman.conf
pacman -Sy --config /tmp/pacman.conf
pacman -S git --config /tmp/pacman.conf
pacman -S tmux --config /tmp/pacman.conf
# https://github.com/tmux/tmux/wiki/Getting-Started
# tmux new
pacman -S tree --config /tmp/pacman.conf
