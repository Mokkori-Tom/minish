cp /etc/pacman.conf /tmp/pacman.conf
echo 'XferCommand = /usr/bin/curl -k -L -C - -f -o %o %u' >> /tmp/pacman.conf 
# (注意:-k SSL認証OFF)
pacman-key --init --/tmp/pacman.conf
pacman-key --populate msys2 --/tmp/pacman.conf
pacman -Sy --/tmp/pacman.conf
pacman -S git --/tmp/pacman.conf
pacman -S tmux --/tmp/pacman.conf
# https://github.com/tmux/tmux/wiki/Getting-Started
# tmux new
pacman -S tree --/tmp/pacman.conf
