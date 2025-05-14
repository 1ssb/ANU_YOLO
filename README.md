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

---

## Prerequisites
- Raspberry Pi OS or any modern Linux distribution
- Python 3.10 or higher (recommended: use Micromamba/Miniconda)
- Git

---

## Installation

### 0. Setup the Pi and hook it up to the monitors and make sure the display is working.

# Disclaimer: IF YOU HAVE ALREADY FORKED it click on Update branch in your sync functionality of the git and in terminal go to the folder that you cloned into and run the command: `git pull`

### 1. System Preparation
Open a terminal and execute the following commands in order:

```bash
echo "1) Update & upgrade system…"
sudo apt-get update -qq
sudo apt-get upgrade -y -qq

echo "2) Repair broken packages (if any)…"
sudo apt-get install -f -y -qq
sudo dpkg --configure -a

echo "3) Install core prerequisites: curl, unzip, compilers, media libs…"
sudo apt-get install -y -qq \
    curl unzip wget bzip2 build-essential cmake \
    libjpeg-dev libpng-dev libtiff-dev \
    libavcodec-dev libavformat-dev libswscale-dev ffmpeg \
    git ca-certificates

echo "4) Clean up unused packages & caches…"
sudo apt-get autoremove -y -qq
sudo apt-get autoclean -y -qq

echo "5) Ensure no broken dpkg state remains…"
sudo dpkg --configure -a
sudo apt-get install -f -y -qq

echo "6) Switch keyboard layout to US…"
sudo sed -i 's/^XKBLAYOUT=.*/XKBLAYOUT="us"/' /etc/default/keyboard
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration
sudo udevadm trigger --subsystem-match=input --action=change
sudo reboot
```

After rebooting, continue with the steps below.

### 2. Clone the Repository and Set Up the Environment

```bash
git clone https://www.github.com/<your_username>/ANU_YOLO
cd ANU_YOLO
chmod +x install_env.sh
./install_env.sh # Installs Miniconda and everything that you do not need to worry about
```

This script will install most required dependencies automatically.

### 3. (Optional) Create a Conda Environment

```bash
conda create -n yolo python=3.10
conda activate yolo
pip install opencv-python ultralytics face-recognition
```

---

## Model Weights

Download the YOLOv8 face detector weights from the official repository:
- [lindevs/yolov8-face](https://github.com/lindevs/yolov8-face)

Place the downloaded weights file (e.g., `yolov8n-face-lindevs.pt`) in the project root directory.

---

## Usage

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
