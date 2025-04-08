# AI-Optimized OS

Problem Statement:
AI-Optimized OS
    • Base: Pop!_OS
    • Source Code: Pop!_OS GitHub
    • Documentation: Pop!_OS Documentation
    • Modification Goals:
        ◦ Pre-install TensorFlow and PyTorch for AI research.
        ◦ Integrate GPU performance monitoring tools.
        ◦ Add smart resource allocation using basic machine learning.


### Part 1:
- Installation of Tensorflow and PyTorch
Step 1: Run install-scripts/install.sh.
Step 2: If it executes successfully, reboot.
Step 3: Run install-scripts/post-install.sh to continue tensorflow installation using tensorman.

### Part 2:
- Installation of GPU Monitoring Tools.
Step 1: Run install-scripts/gpu_utils_installer.sh.

Note: This installs nvtop, nvidia-smi and missioncenter.
Missioncenter is a GUI tool for monitoring resource usage by GPUs.

### Part 3:
- AI based smart allocation of resources for processes.
Step 1:Modify ./smart_allocator/ai_integration.py and add your application name in LOW_PRIORITY_PROCESSES list in the file.
Step 2: Run sudo python3 ./smart_allocator/ai_integration.py


Done 🙂
