import psutil
import gpustat
import time
import os

# PyTorch mock model import
try:
    import torch
    import torch.nn as nn

    class SimpleAIModel(nn.Module):
        def __init__(self):
            super(SimpleAIModel, self).__init__()
            self.linear = nn.Linear(2, 1)  # Dummy input: [gpu_usage, cpu_usage]

        def forward(self, x):
            return torch.sigmoid(self.linear(x))

    # Initialize dummy model
    ai_model = SimpleAIModel()
    print("[AI] AI model loaded for optimization prediction.")

except Exception as e:
    print(f"[AI] Failed to load AI model: {e}")
    ai_model = None

# Configuration
LOW_PRIORITY_PROCESSES = ["firefox", "chrome", "discord"]
GPU_UTIL_THRESHOLD = 60  # Used only if AI fails

def get_gpu_utilization():
    try:
        stats = gpustat.new_query()
        utilization = stats.gpus[0].utilization
        return utilization
    except Exception as e:
        print(f"[GPU] Error getting GPU stats: {e}")
        return 0

def get_cpu_utilization():
    return psutil.cpu_percent(interval=1)

def adjust_priority(proc_name, nice_value=10):
    for proc in psutil.process_iter(['pid', 'name']):
        if proc.info['name'] and proc_name.lower() in proc.info['name'].lower():
            try:
                p = psutil.Process(proc.info['pid'])
                p.nice(nice_value)
                print(f"[Optimizer] Adjusted priority of {proc.info['name']} (PID {proc.info['pid']}) to {nice_value}")
            except Exception as e:
                print(f"[Error] Failed to adjust priority: {e}")

def ai_predict_optimize(gpu_util, cpu_util):
    if not ai_model:
        return gpu_util >= GPU_UTIL_THRESHOLD  # fallback rule

    try:
        input_tensor = torch.tensor([[gpu_util / 100, cpu_util / 100]], dtype=torch.float32)
        output = ai_model(input_tensor)
        prediction = int(output.item() > 0.5)
        print(f"[AI] Prediction score: {output.item():.4f} → {'Optimize' if prediction else 'No action'}")
        return prediction
    except Exception as e:
        print(f"[AI] Prediction failed: {e}")
        return gpu_util >= GPU_UTIL_THRESHOLD  # fallback rule

def main():
    while True:
        gpu_util = get_gpu_utilization()
        cpu_util = get_cpu_utilization()
        print(f"[Monitor] GPU: {gpu_util}%, CPU: {cpu_util}%")

        if ai_predict_optimize(gpu_util, cpu_util):
            print("[AI Decision] High resource usage detected. Optimizing system...")
            for app in LOW_PRIORITY_PROCESSES:
                adjust_priority(app, nice_value=10)

        time.sleep(10)

if __name__ == "__main__":
    main()

