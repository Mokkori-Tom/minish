echo 'XferCommand = /usr/bin/curl -k -L -C - -f -o %o %u' >> /tmp/pacman.conf 
# (注意:-k SSL認証OFF)
pacman-key --init
pacman-key --populate msys2
pacman -Sy
pacman -S git
pacman -S tmux
