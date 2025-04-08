# AI-Optimized OS

## 🧠 Problem Statement

**AI-Optimized OS** is a modified version of Pop!_OS tailored for AI development and system resource efficiency.

- **Base**: Pop!_OS
- **Modification Goals**:
  - Pre-install **TensorFlow** and **PyTorch** for AI research.
  - Integrate **GPU performance monitoring tools**.
  - Add **smart resource allocation** using basic machine learning.

---

## 🚀 Part 1: Installation of TensorFlow and PyTorch

1. Run the installer:

   ```bash
   sudo bash install-scripts/install.sh
   ```

2. If the script executes successfully, reboot the system.

3. After reboot, run the post-install script:
   ```bash 
   sudo bash install-scripts/post-install.sh
   ```


## 📊 Part 2: Installation of GPU Monitoring Tools
1. Run:
```bash 
sudo bash install-scripts/gpu_utils_installer.sh
```
2. This installs:
    -    nvtop

    -   nvidia-utils-550

    -    nvidia-smi

    -   MissionCenter (via Flatpak)


## 🤖 Part 3: AI-Based Smart Allocation of Resources

    Edit the following file:

```bash
./smart_allocator/ai_integration.py
```

Add your application names to the `LOW_PRIORITY_PROCESSES` list in the code.

    Run the AI integration script with elevated permissions:

```bash
sudo python3 ./smart_allocator/ai_integration.py
```

This script monitors system usage and adjusts process priorities dynamically using a simple PyTorch model trained on CPU/GPU load patterns.

TEAM DETAILS:

1. Vasa Neharika 23JE1069
2. Vedaansh (Leader) 23JE1072
3. Vivek Kumar 23JE1090
4. Vivek Kumar 23JE1091
5. Wali Mohmmad 23JE1096
6. Yadlapalli Shalini 23JE1099
7. Mani Sainath Reddy 23JE1102
8. Yuvraj Singh 23JE1119

PROJECT STATUS: Completed (Prototype stage, testing is pending).


CONTRIBUTION:

Vivek Kumar (23JE1090), Wali worked on Part 1, installation of tensorflow and pytorch. The install script is [here](./install-scripts/).

Vivek Kumar (23JE1091), Mani Sainath Reddy and Yuvraj Singh worked on the Part 2, installation of gpu monitoring tools. The install script is [here](./install-scripts/).

Vedaansh, Neharika and Shalini worked on Part 3, add smart resource allocation using basic machine learning. The smart allocator python program is [here](./smart_allocator/).

However, discussion and implementation of each points was discussed by entire team as a whole.



