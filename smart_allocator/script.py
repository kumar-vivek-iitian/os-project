import psutil
import gpustat
import time
import os

# Configuration
GPU_UTIL_THRESHOLD = 60  # % GPU usage to trigger optimization
LOW_PRIORITY_PROCESSES = ["firefox", "chrome", "discord"]

def get_gpu_utilization():
    try:
        stats = gpustat.new_query()
        utilization = stats.gpus[0].utilization
        return utilization
    except Exception as e:
        print(f"GPU stat error: {e}")
        return 0

def adjust_priority(proc_name, nice_value=10):
    for proc in psutil.process_iter(['pid', 'name']):
        if proc.info['name'] and proc_name.lower() in proc.info['name'].lower():
            try:
                p = psutil.Process(proc.info['pid'])
                p.nice(nice_value)
                print(f"Adjusted priority of {proc.info['name']} (PID {proc.info['pid']}) to {nice_value}")
            except Exception as e:
                print(f"Failed to renice {proc.info['name']}: {e}")

def main():
    while True:
        gpu_util = get_gpu_utilization()
        print(f"[Monitor] GPU Utilization: {gpu_util}%")

        if gpu_util >= GPU_UTIL_THRESHOLD:
            print("[Optimizer] High GPU usage detected. Adjusting background tasks...")
            for app in LOW_PRIORITY_PROCESSES:
                adjust_priority(app, nice_value=10)

        time.sleep(10)  # Check every 10 seconds

if __name__ == "__main__":
    main()

