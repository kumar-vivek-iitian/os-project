echo "Installing nvtop, nvidia-smi and missioncenter"
apt install nvtop nvidia-utils-550 flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo "Enter Y when prompted to continue installation of MissionCenter:"
flatpak install flathub io.missioncenter.MissionCenter
echo "To run missioncenter, run flatpak run io.missioncenter.MissionCenter"
