# run on new shell home
# *リンク先の各ライセンスに注意

export PATH="$PATH:$OPT"
export PATH="$PATH:$OPT/7zip"
export PATH="$PATH:$OPT/7zip/arm64"
export PATH="$PATH:$OPT/7zip/x64"
export PATH="$PATH:$OPT/bat/bat-v0.25.0-x86_64-pc-windows-gnu"
export PATH="$PATH:$OPT/delta/delta-0.18.2-x86_64-pc-windows-msvc"
export PATH="$PATH:$OPT/dlzip"
export PATH="$PATH:$OPT/fd/fd-v10.2.0-x86_64-pc-windows-gnu"
export PATH="$PATH:$OPT/glow/glow_2.1.1_Windows_x86_64"
export PATH="$PATH:$OPT/go/go/bin"
export PATH="$PATH:$OPT/go/go/pkg/tool/windows_amd64"
export PATH="$PATH:$OPT/go/go/src"
export PATH="$PATH:$OPT/insert"
export PATH="$PATH:$OPT/lazygit"
export PATH="$PATH:$OPT/lualsp/bin"
export PATH="$PATH:$OPT/node/node-v22.17.1-win-x64"
export PATH="$PATH:$OPT/node/node-v22.17.1-win-x64/node_modules/corepack/shims"
export PATH="$PATH:$OPT/node/node-v22.17.1-win-x64/node_modules/corepack/shims/nodewin"
export PATH="$PATH:$OPT/node/node-v22.17.1-win-x64/node_modules/npm/bin"
export PATH="$PATH:$OPT/node/node-v22.17.1-win-x64/node_modules/npm/bin/node-gyp-bin"
export PATH="$PATH:$OPT/node/node-v22.17.1-win-x64/node_modules/npm/node_modules/@npmcli/run-script/lib/node-gyp-bin"
export PATH="$PATH:$OPT/node/node-v22.17.1-win-x64/node_modules/npm/node_modules/node-gyp/gyp"
export PATH="$PATH:$OPT/nvim/nvim-win64/bin"
export PATH="$PATH:$OPT/nvim/nvim-win64/share/nvim/runtime/scripts"
export PATH="$PATH:$OPT/python"
export PATH="$PATH:$OPT/python/Scripts"
export PATH="$PATH:$OPT/rgd"
export PATH="$PATH:$OPT/ripgrep/ripgrep-14.1.1-x86_64-pc-windows-gnu"
export PATH="$PATH:$OPT/uclip"

cp /etc/pacman.conf /tmp/pacman.conf
sed -i 's|^#\(XferCommand = /usr/bin/curl \)\(.*\)|\1-k \2|' /tmp/pacman.conf
# (注意:-k SSL認証OFF)
pacman-key --init --config /tmp/pacman.conf
pacman-key --populate msys2 --config /tmp/pacman.conf
pacman -Sy --config /tmp/pacman.conf --noconfirm
pacman -S git --config /tmp/pacman.conf --noconfirm
pacman -S unzip --config /tmp/pacman.conf --noconfirm
pacman -S diffutils --config /tmp/pacman.conf --noconfirm
pacman -S tmux --config /tmp/pacman.conf --noconfirm
# https://github.com/tmux/tmux/wiki/Getting-Started
# tmux new
pacman -S tree --config /tmp/pacman.conf --noconfirm

mkdir $OPT/7zip
wget -O $OPT/7zip/7zr.exe https://www.7-zip.org/a/7zr.exe
wget -O $OPT/7zip/7z2500-extra.7z https://www.7-zip.org/a/7z2500-extra.7z
$OPT/7zip/7zr.exe x $OPT/7zip/7z2500-extra.7z -o"$OPT/7zip/"

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$HOME/.fzf/install --key-bindings --completion --no-update-rc

dlzip https://go.dev/dl/go1.24.5.windows-amd64.zip $OPT/go

dlzip https://www.python.org/ftp/python/3.12.10/python-3.12.10-embed-amd64.zip $OPT/python
sed -i 's/^#import site$/import site/' "$OPT/python/python312._pth"
wget -O $OPT/python/get-pip.py https://bootstrap.pypa.io/pip/get-pip.py
python $OPT/python/get-pip.py
pip install --upgrade setuptools wheel

dlzip https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-pc-windows-gnu.zip $OPT/ripgrep
dlzip https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-win64.zip $OPT/nvim
dlzip https://nodejs.org/dist/v22.17.1/node-v22.17.1-win-x64.zip $OPT/node
dlzip https://github.com/LuaLS/lua-language-server/releases/download/3.15.0/lua-language-server-3.15.0-win32-x64.zip $OPT/lualsp
dlzip https://github.com/sharkdp/bat/releases/download/v0.25.0/bat-v0.25.0-x86_64-pc-windows-gnu.zip $OPT/bat
dlzip https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-x86_64-pc-windows-msvc.zip $OPT/delta
dlzip https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-pc-windows-gnu.zip $OPT/fd
dlzip https://github.com/avih/uclip/releases/download/v0.6/uclip.version-0.6.zip $OPT/uclip
dlzip https://github.com/jesseduffield/lazygit/releases/download/v0.53.0/lazygit_0.53.0_Windows_x86_64.zip $OPT/lazygit
dlzip https://github.com/charmbracelet/glow/releases/download/v2.1.1/glow_2.1.1_Windows_x86_64.zip $OPT/glow
