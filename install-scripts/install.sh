#!/bin/sh
VIOLET="\033[35m"
INDIGO="\033[34m"
BLUE="\033[34m"
GREEN="\033[32m"
YELLOW="\033[33m"
ORANGE="\033[38;5;214m" 
RED="\033[31m"
RESET="\033[0m"

echo -e "${GREEN}Install Script for TensorFlow and PyTorch...${RESET}"
if [ $(id -u) -ne 0 ]; then
    echo -e "${RED}Root Privileges are needed for installation of TensorFlow and PyTorch. Please run as root.${RESET}"
    exit 1
fi

echo -e "${YELLOW}Step: 1${RESET}"
echo -e "Updating the system..."
apt update && apt -y full-upgrade

return_code=$?
if [ $return_code -ne 0 ]; then
    echo "Previous command failed. Exiting.."
    exit 1
fi

echo -e "${YELLOW}Step:2${RESET}"
echo -e "Installing tensorman (utility for installing tensorflow).."
apt install tensorman

return_code=$?
if [ $return_code -ne 0 ]; then
    echo "Previous command failed. Exiting.."
    exit 1
fi

echo -e "${YELLOW}Step:3${RESET}"
echo -e "Installing nvidia-docker2 for CUDA support"

apt install nvidia-docker2

return_code=$?
if [ $return_code -ne 0 ]; then
    echo "Previous command failed. Exiting.."
    exit 1
fi

echo -e "${ORANGE}Recommended: Add your user to docker group${RESET}"

if [ -ne "/usr/bin/kernelstub" ]; then 
    echo "${BLUE}kernelstub is not installed, assuming bootloader is grub, installing kernelstub..${RESET}"
    apt-get install kernelstub
fi

return_code=$?
if [ $return_code -ne 0 ]; then
    echo "Previous command failed. Exiting.."
    exit 1
fi

echo -e "${GREEN}SUCESS: Please run post-install.sh to complete TensorFlow and PyTorch Installation.${RESET}"
