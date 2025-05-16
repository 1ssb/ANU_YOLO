# ANU_YOLO

A collection of YOLO-based scripts and environment setups for face and object detection, designed for use on Raspberry Pi OS and other Linux systems.

---

## Table of Contents
- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Model Weights](#model-weights)
- [Usage](#usage)
- [Group Task](#group-task)
- [Credits](#credits)

---

## Project Overview
This repository provides scripts for running YOLOv8-based face and object detection on images and videos. The main scripts, `object.py` and `yolo_face.py`, detects objects and faces using a YOLOv8n model and its retrained model and outputs annotated images or videos with bounding boxes and confidence scores, respectively. This introduces the newcomer to various ML concepts.

### Preparation

Simply copy and paste this onto the terminal and run it. If everything runs correctly the system will auto-reboot and you can reopen the terminal and everything should work including pip directly as well as python. This preperation is immaterial of whether you have cloned, forked etc.

```bash
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# 1) System update & upgrade
echo "1) Updating system…"
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# 2) Repair any broken packages
echo "2) Repairing broken packages…"
sudo apt-get install -f -y
sudo dpkg --configure -a

# 3) Install prerequisites
echo "3) Installing prerequisites…"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl wget unzip bzip2 build-essential cmake \
    libjpeg-dev libpng-dev libtiff-dev \
    libavcodec-dev libavformat-dev libswscale-dev ffmpeg \
    git ca-certificates

# 4) Clean up
echo "4) Cleaning up…"
sudo apt-get autoremove -y
sudo apt-get autoclean -y

# 5) Keyboard layout → US
echo "5) Setting keyboard layout to US…"
sudo sed -i 's/^XKBLAYOUT=.*/XKBLAYOUT="us"/' /etc/default/keyboard
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure -fnoninteractive keyboard-configuration
sudo udevadm trigger --subsystem-match=input --action=change

# 6) Python tooling & Ultralytics YOLO (no venv)
echo "6) Installing Python tooling & YOLO…"
sudo apt-get install -y python3 python3-pip libatlas-base-dev libopenblas-dev
python3 -m pip install --upgrade --user pip >/dev/null
pip install --user numpy ultralytics requests >/dev/null

# 7) Ensure ~/.local/bin is on PATH
PROFILE="$HOME/.bashrc"
LINE='export PATH="$HOME/.local/bin:$PATH"'
if ! grep -Fxq "$LINE" "$PROFILE"; then
  echo "$LINE" >> "$PROFILE"
fi

# 8) Verify pip functionality by installing and importing numpy
echo "8) Verifying pip can install & import numpy…"
if python3 -c "import numpy" &> /dev/null; then
  echo "pip check passed: rebooting now…"
  sudo reboot
else
  echo "numpy not found, attempting install…" >&2
  if pip install --user opencv-python >/dev/null && python3 -c "import opencv-python" &> /dev/null; then
    echo "pip check passed after install: rebooting now…"
    sudo reboot
  else
    echo "ERROR: pip failed to install or import numpy." >&2
    exit 1
  fi
fi

```

###### Error that I made was upgrading your systems but most of you did not complete properly, so it might have broken things. You should not need conda or any other packages/containers after simply installing and changing paths.

##### For those who have not cloned or forked, fork this repo and then run:

```bash
git clone https://github.com/<your_username>/ANU_YOLO.git
cd ANU_YOLO
```
##### For those who have already forked the repo and need to update it to the current state of this repo:

```bash
# 1. Change directory to your local repository
cd ANU_YOLO

# 2. Add the original repository as an upstream remote (do this only once)
git remote add upstream https://github.com/1ssb/ANU_YOLO.git

# 3. Fetch changes from the upstream repo
git fetch upstream

# 4. Checkout your main branch (replace 'main' with your branch name if different)
git checkout main

# 5. Merge changes from upstream/main into your local main branch
git merge upstream/main

# 6. Push the updated main branch to your fork on GitHub
git push origin main
```
---

## Model Weights

Download the YOLOv8 face detector weights from the official repository:
- [lindevs/yolov8-face](https://github.com/lindevs/yolov8-face)

Place the downloaded weights file (e.g., `yolov8n-face-lindevs.pt`) in the project root directory.

---

## Usage

### Object Detection

```bash
python object.py --source bus.jpg --output bus_objects.jpg
```

### Face Detection on Images

```bash
python yolo_face.py --source bus.jpg --output bus_face.jpg
```
- Input: `bus.jpg` (or any image file)
- Output: `bus_face.jpg` (annotated image with bounding boxes and confidence values)

### Face Detection on Videos

```bash
python yolo_face.py --source path/to/video.mp4 --output path/to/output.mp4
```
- Input: Any video file
- Output: Annotated video with detected faces

### Streamer

```bash
python stream.py
```

This should open the webcam interface if you attach one for livestreaming the detection.

---

## Group Task

Count the number of apples in the video: `apples.mp4`. Submit your script as `apples.py` (one per team). Please list your team name and members here:

...

Credits for video: https://www.istockphoto.com/video/gala-apple-falling-gm472985251-20196243?utm_source=pixabay&utm_medium=affiliate&utm_campaign=sponsored_video&utm_content=srp_topbanner_media&utm_term=apple+fall

---

## Credits

- YOLOv8 by Ultralytics: https://docs.ultralytics.com/models/yolov8/
- Face model weights: https://github.com/lindevs/yolov8-face
- [Josh Starmer: Videos](https://www.youtube.com/channel/UCtYLUTtgS3k1Fg4y5tAhLbw) --> I went to LSE to study Machine Learning in 2019 only to end up watching his videos for the exams.
- ChatGPT for a faux annotated image used in the presentation.
