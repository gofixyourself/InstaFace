#!/bin/bash

echo "Setting up InstaFace environment with SDXL..."

if [ ! -d "ComfyUI" ]; then
    echo "Cloning ComfyUI..."
    git clone https://github.com/comfyanonymous/ComfyUI.git
else
    echo "ComfyUI already exists, skipping cloning..."
fi

if [ ! -f "ComfyUI/models/checkpoints/sdxl_base.safetensors" ]; then
    echo "Downloading SDXL Base model..."
    wget -O ComfyUI/models/checkpoints/sdxl_base.safetensors "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors"
else
    echo "SDXL Base model already exists, skipping download..."
fi

if [ ! -d "ComfyUI/custom_nodes/ComfyUI-Manager" ]; then
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git ComfyUI/custom_nodes/ComfyUI-Manager
fi

if [ ! -d "ComfyUI/custom_nodes/ComfyUI-InstantID-FaceSwap" ]; then
    unzip ComfyUI-InstantID-FaceSwap.zip -d ComfyUI/custom_nodes
fi

mkdir -p ComfyUI/models/insightface/models/antelopev2
if [ ! -f "ComfyUI/models/insightface/models/antelopev2/1k3d68.onnx" ]; then
    echo "Downloading InsightFace model weights..."
    wget -O ComfyUI/models/insightface/models/antelopev2/1k3d68.onnx "https://huggingface.co/DIAMONIK7777/antelopev2/resolve/main/1k3d68.onnx"
    wget -O ComfyUI/models/insightface/models/antelopev2/2d106det.onnx "https://huggingface.co/DIAMONIK7777/antelopev2/resolve/main/2d106det.onnx"
    wget -O ComfyUI/models/insightface/models/antelopev2/genderage.onnx "https://huggingface.co/DIAMONIK7777/antelopev2/resolve/main/genderage.onnx"
    wget -O ComfyUI/models/insightface/models/antelopev2/glintr100.onnx "https://huggingface.co/DIAMONIK7777/antelopev2/resolve/main/glintr100.onnx"
    wget -O ComfyUI/models/insightface/models/antelopev2/scrfd_10g_bnkps.onnx "https://huggingface.co/DIAMONIK7777/antelopev2/resolve/main/scrfd_10g_bnkps.onnx"
fi

mkdir -p ComfyUI/models/ipadapter
if [ ! -f "ComfyUI/models/ipadapter/ip-adapter.bin" ]; then
    echo "Downloading IpAdapter model weights..."
    wget -O ComfyUI/models/ipadapter/ip-adapter.bin "https://huggingface.co/InstantX/InstantID/resolve/main/ip-adapter.bin"
fi

mkdir -p ComfyUI/models/controlnet/insta_controlnet
if [ ! -f "ComfyUI/models/controlnet/insta_controlnet/diffusion_pytorch_model.safetensors" ]; then
    echo "Downloading ControlNet model weights..."
    wget -O ComfyUI/models/controlnet/insta_controlnet/diffusion_pytorch_model.safetensors "https://huggingface.co/InstantX/InstantID/resolve/main/ControlNetModel/diffusion_pytorch_model.safetensors"
    wget -O ComfyUI/models/controlnet/insta_controlnet/config.json "https://huggingface.co/InstantX/InstantID/resolve/main/ControlNetModel/config.json"
fi

echo "Done!"