# app.py
from flask import Flask, render_template, request, jsonify
from transformers import AutoTokenizer, AutoModelForCausalLM
import torch

app = Flask(__name__)

# 使用 Hugging Face 的镜像站点
mirror_url = "https://hf-mirror.com"
model_name = "google/gemma-2b"  # 或者 "google/gemma-7b"

# 加载 Gemma 2 模型和分词器
tokenizer = AutoTokenizer.from_pretrained(model_name, mirror=mirror_url)
model = AutoModelForCausalLM.from_pretrained(model_name, mirror=mirror_url)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/generate', methods=['POST'])
def generate():
    input_text = request.json['input_text']
    
    # 对输入进行编码
    inputs = tokenizer(input_text, return_tensors="pt")
    
    # 生成输出
    with torch.no_grad():
        outputs = model.generate(**inputs, max_length=100)
    
    # 解码输出
    generated_text = tokenizer.decode(outputs[0], skip_special_tokens=True)
    
    return jsonify({'generated_text': generated_text})

if __name__ == '__main__':
    app.run(debug=True)