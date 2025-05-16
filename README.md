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

```bash
# Raspberry Pi OS — 3-liner, no venv: install Python tooling, cv2, Ultralytics YOLO, Requests, and make ~/.local/bin permanent
sudo apt update && sudo apt install -y python3 python3-pip build-essential libjpeg-dev zlib1g-dev libatlas-base-dev libopenblas-dev
python3 -m pip install --upgrade --user pip && pip install --user opencv-python ultralytics requests        # cv2 & yolo CLI go to ~/.local/bin
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc && exec "$SHELL" -l                                # add to .bashrc and reload shell
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
