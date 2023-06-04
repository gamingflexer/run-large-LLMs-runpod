# run-large-LLMs-runpod

Run an open source LLM on a cloud GPU & hook it up to a chat interface

### Models Supported

- guanaco-65B 4 bit
- Wizardlm 30b unfiltered
- vicuna unfiltered
- samantha 33b
- GPT4 Alpaca LoRA Merge


## Get started

Make a runpod instance with the following config 

- 1X NVIDIA L40
- 48 GB VRAM
- 250 GB RAM 32 VCPU

### Manual installation using Conda

Recommended if you have some experience with the command line.

#### 0. Install Conda

On Linux or WSL, it can be automatically installed with these two commands:

```
curl -sL "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" > "Miniconda3.sh"
bash Miniconda3.sh
```
Source: https://educe-ubc.github.io/conda.html

#### 1. Create a new conda environment

```
conda create -n textgen python=3.10.9
conda activate textgen
```

#### 2. Install Pytorch

| System | GPU | Command |
|--------|---------|---------|
| Linux/WSL | NVIDIA | `pip3 install torch torchvision torchaudio` |



#### 3. Install the web UI

```
git clone https://github.com/gamingflexer/text-generation-webui.git
cd text-generation-webui
pip install -r requirements.txt
```

#### 4. Install the other requirements for this model

```
mkdir repositories
cd repositories
git clone https://github.com/oobabooga/GPTQ-for-LLaMa.git -b cuda

pip install https://github.com/jllllll/GPTQ-for-LLaMa-Wheels/raw/Linux-x64/quant_cuda-0.0.0-cp310-cp310-linux_x86_64.whl

```

```
conda activate textgen
conda install -c conda-forge cudatoolkit-dev

cd repositories/GPTQ-for-LLaMa
python setup_cuda.py install
```

#### 5. Start the app
 
```
conda activate textgen
cd text-generation-webui
python server.py --gradio-auth Username:Password	

```

Tip : If you want to close the terminal and run the models

```
tmux a # this command will take you to a new terminal
conda activate textgen
cd text-generation-webui
python server.py --gradio-auth Username:Password	
```

After this press `Ctr + B` then press `D`. It will make it running in the background

#### Extras

If the models are deleted or not accessible by the gradio be UI.

Follow this steps. 

1. Download the models

Models List

```
TheBloke/gpt4-alpaca-lora-30B-GPTQ-4bit-128g
TheBloke/guanaco-65B-GPTQ
TheBloke/samantha-33B-GPTQ
TheBloke/Wizard-Vicuna-30B-Uncensored-GPTQ
TheBloke/WizardLM-30B-Uncensored-GGML
```

Open the text-generation-webui UI as normal. Follow this step for each model at a time.

- Click the Model tab.
- Under Download custom model or LoRA, enter `model names from the list`. 
- Click Download.
- Wait until it says it's finished downloading.
- Click the Refresh icon next to Model in the top left. You should see the models.
- After downloading the models first stop the server & then restart the UI with this commands in the `text-generation-webui` folder

```
conda activate textgen
python server.py --gradio-auth Username:Password	
```

2. I have added here `config-user.yaml` paste (replace content) it in the the text-generation-webui/models/config-user.yaml.

#### Start Up script

The commands above require interaction so make sure to not only run the script. To execute the script, open a terminal, navigate to the directory where the script is saved, and run the following command:

`bash install_llm.sh`