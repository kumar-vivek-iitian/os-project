#!/bin/sh
VIOLET="\033[35m"
INDIGO="\033[34m"
BLUE="\033[34m"
GREEN="\033[32m"
YELLOW="\033[33m"
ORANGE="\033[38;5;214m"
RED="\033[31m"
RESET="\033[0m"

echo -e "${GREEN}Post-Install Script for TensorFlow and PyTorch...${RESET}"

if ! command -v docker >/dev/null 2>&1; then
    echo -e "${RED}Docker is not installed. Please install Docker before proceeding.${RESET}"
    exit 1
fi

echo -e "${YELLOW}Step 1:${RESET} Starting Docker service..."
systemctl start docker || service docker start

echo -e "${YELLOW}Step 2:${RESET} Pulling TensorFlow Docker image..."
docker pull tensorflow/tensorflow:latest-gpu

if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to pull TensorFlow image.${RESET}"
    exit 1
fi

echo -e "${YELLOW}Step 3:${RESET} Pulling PyTorch Docker image..."
docker pull pytorch/pytorch:latest

if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to pull PyTorch image.${RESET}"
    exit 1
fi

echo -e "${YELLOW}Step 4:${RESET} Testing TensorFlow in container..."
docker run --rm --gpus all tensorflow/tensorflow:latest-gpu python3 -c "import tensorflow as tf; print(tf.__version__)"

echo -e "${YELLOW}Step 5:${RESET} Testing PyTorch in container..."
docker run --rm --gpus all pytorch/pytorch:latest python3 -c "import torch; print(torch.__version__)"

echo -e "${GREEN}SUCCESS:${RESET} TensorFlow and PyTorch Docker containers tested successfully!"

echo -e "${ORANGE}Optional: Add your user to the docker group to avoid using 'sudo'. Run:${RESET}"
echo -e "${BLUE}sudo usermod -aG docker \$USER && newgrp docker${RESET}"

