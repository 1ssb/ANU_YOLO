#!/usr/bin/env bash
# install_conda_yolo_env.sh — Unattended Miniforge + Conda “yolo” env installer for Raspberry Pi
# With global auto-sourcing via /etc/profile.d

set -euo pipefail
IFS=$'\n\t'

# 1) Setting Paths
MINIFORGE_DIR="$HOME/miniforge"
ENV_NAME="yolo"
PYTHON_VER="3.10"

echo
# detect Pi arch
ARCH="$(uname -m)"
case "$ARCH" in
  aarch64) PKG="Miniforge3-Linux-aarch64.sh" ;;
  armv7l)  PKG="Miniforge3-Linux-armv7l.sh" ;;
  *)       echo "❌ Unsupported arch: $ARCH" >&2; exit 1 ;;
esac

# 2) Install Miniforge if needed
if [[ -x "$MINIFORGE_DIR/bin/conda" ]]; then
  echo "✅ Miniforge already installed in $MINIFORGE_DIR"
else
  echo "⬇️ Downloading Miniforge ($PKG)…"
  wget -q "https://github.com/conda-forge/miniforge/releases/latest/download/$PKG" -O /tmp/miniforge.sh
  echo "⚙️ Installing to $MINIFORGE_DIR…"
  bash /tmp/miniforge.sh -b -p "$MINIFORGE_DIR"
fi

echo
# 3) Write the profile.d hook with expanded variables
echo "🔧 Creating /etc/profile.d/conda.sh…"
sudo tee /etc/profile.d/conda.sh > /dev/null <<EOF
# >>> conda initialize >>>
__conda_setup="\$("$MINIFORGE_DIR/bin/conda" shell.bash hook 2> /dev/null)"
if [ \$? -eq 0 ]; then
  eval "\$__conda_setup"
else
  if [ -f "$MINIFORGE_DIR/etc/profile.d/conda.sh" ]; then
    . "$MINIFORGE_DIR/etc/profile.d/conda.sh"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<
EOF
sudo chmod +x /etc/profile.d/conda.sh

echo
# 4) Activate conda in this session
echo "🐍 Initializing Conda for current session…"
# this will define `conda` for the remainder of the script
eval "$("$MINIFORGE_DIR/bin/conda" shell.bash hook)"

echo
# 5) Create the 'yolo' environment if it doesn't exist
if conda env list | grep -qE "^\s*$ENV_NAME\s"; then
  echo "✅ Conda env '$ENV_NAME' already exists"
else
  echo "🚀 Creating env '$ENV_NAME' (Python $PYTHON_VER)…"
  conda create -n "$ENV_NAME" python="$PYTHON_VER" -y
  echo "📦 Installing PyTorch (CPU), torchvision & OpenCV…"
  conda activate "$ENV_NAME"
  conda install -c conda-forge pytorch torchvision cpuonly opencv -y
  conda deactivate
fi

echo
echo "🎉 Setup complete! Spawning a fresh login shell with Conda ready…"
exec bash --login
