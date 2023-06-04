#!/bin/bash

# Step 0: Install Conda
echo "Step 0: Installing Conda..."
curl -sL "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" > "Miniconda3.sh"
bash Miniconda3.sh

# Step 1: Create a new conda environment
echo "Step 1: Creating a new conda environment..."
conda create -n textgen python=3.10.9
conda activate textgen

# Step 2: Install PyTorch
echo "Step 2: Installing PyTorch..."
pip3 install torch torchvision torchaudio

# Step 3: Install the web UI
echo "Step 3: Installing the web UI..."
git clone https://github.com/gamingflexer/text-generation-webui.git
cd text-generation-webui
pip install -r requirements.txt

# Step 4: Install the other requirements for this model
echo "Step 4: Installing other requirements..."
mkdir repositories
cd repositories
git clone https://github.com/oobabooga/GPTQ-for-LLaMa.git -b cuda

pip install https://github.com/jllllll/GPTQ-for-LLaMa-Wheels/raw/Linux-x64/quant_cuda-0.0.0-cp310-cp310-linux_x86_64.whl

conda activate textgen
conda install -c conda-forge cudatoolkit-dev

cd GPTQ-for-LLaMa
python setup_cuda.py install

# Step 5: Start the app
echo "Step 5: Starting the app..."
conda activate textgen
cd ../text-generation-webui
python server.py --gradio-auth Username:Password

echo "Installation completed successfully!"
