echo "Installing nvtop, nvidia-smi and missioncenter"
apt install nvtop nvidia-utils-550 flatpak
flatpak install flathub io.missioncenter.MissionCenter
echo "To run missioncenter, run flatpak run io.missioncenter.MissionCenter"
