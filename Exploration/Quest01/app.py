from flask import Flask, request, jsonify
# from flask_cors import CORS
from flask import Response
import requests
import tensorflow as tf
import numpy as np
import io
from PIL import Image
import base64
import os

print(os.getcwd())
# 모델 파일이 위치해야 할 디렉토리 확인

app = Flask(__name__)

# CORS(app)

@app.after_request
def add_cors_headers(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
    response.headers.add('Access-Control-Allow-Methods', 'GET,POST,OPTIONS')
    return response

# 모델 로드
model = tf.keras.models.load_model('plant1Q.h5')
print("모델이 로드되었습니다.")

class_names = [
    'Apple___Apple_scab',
    'Apple___Black_rot',
    'Apple___Cedar_apple_rust',
    'Apple___healthy',
    'Background_without_leaves',
    'Blueberry___healthy',
    'Cherry___healthy',
    'Cherry___Powdery_mildew',
    'Corn___Cercospora_leaf_spot Gray_leaf_spot',
    'Corn___Common_rust',
    'Corn___healthy',
    'Corn___Northern_Leaf_Blight',
    'Grape___Black_rot',
    'Grape___Esca_(Black_Measles)',
    'Grape___healthy',
    'Grape___Leaf_blight_(Isariopsis_Leaf_Spot)',
    'Orange___Haunglongbing_(Citrus_greening)',
    'Peach___Bacterial_spot',
    'Peach___healthy',
    'Pepper,_bell___Bacterial_spot',
    'Pepper,_bell___healthy',
    'Potato___Early_blight',
    'Potato___healthy',
    'Potato___Late_blight',
    'Raspberry___healthy',
    'Soybean___healthy',
    'Squash___Powdery_mildew',
    'Strawberry___healthy',
    'Strawberry___Leaf_scorch',
    'Tomato___Bacterial_spot',
    'Tomato___Early_blight',
    'Tomato___healthy',
    'Tomato___Late_blight',
    'Tomato___Leaf_Mold',
    'Tomato___Septoria_leaf_spot',
    'Tomato___Spider_mites Two-spotted_spider_mite',
    'Tomato___Target_Spot',
    'Tomato___Tomato_mosaic_virus',
    'Tomato___Tomato_Yellow_Leaf_Curl_Virus'
    ]

# 모델 훈련은 클라우드에서 하고 앱과 서버 코드는 로컬로 하다보니 클래스명을 자동 생성하기 어려웠음

@app.route('/')
def home():
    return """
    <h1>H5 모델 API 서버</h1>
    <p>POST 요청을 /predict 엔드포인트로 전송.</p>
    <form action="/predict" method="post" enctype="multipart/form-data">
        <input type="file" name="image">
        <input type="submit" value="예측하기">
    </form>
    """

@app.route('/predict', methods=['POST'])
def predict():
    # 이미지 파일 받기
    if 'image' not in request.files:
        return jsonify({'error': '이미지 파일이 없습니다'}), 400
    
    file = request.files['image']
    if file.filename == '':
        return jsonify({'error': '선택된 파일이 없습니다'}), 400
    
    # 이미지 전처리
#     IMG_SIZE = 160

# def format_example(image, label):
#     image = tf.cast(image, tf.float32)
#     image = (image/127.5) - 1
#     image = tf.image.resize(image, (IMG_SIZE, IMG_SIZE))
#     return image, label
    try:
        img = Image.open(io.BytesIO(file.read()))
        img = tf.cast(img, tf.float32)
        img = img.resize((160, 160))
        img_array = tf.keras.preprocessing.image.img_to_array(img)
        img_array = np.expand_dims(img_array, axis=0)
        img_array = (img_array/127.5) - 1  # 정규화
        
        # 예측 수행
        predictions = model.predict(img_array)
        predicted_class_index = np.argmax(predictions[0])
        predicted_class = class_names[predicted_class_index]
        confidence = float(predictions[0][predicted_class_index])
        
        # base64로 이미지 인코딩 (응답에 이미지 포함)
        buffered = io.BytesIO()
        img.save(buffered, format="JPEG")
        img_str = base64.b64encode(buffered.getvalue()).decode()
        
        return jsonify({
            'predicted_class': predicted_class,
            'confidence': confidence,
            'image': img_str
        })
    
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    

@app.route('/proxy_image')
def proxy_image():
    url = request.args.get('url')
    if not url:
        return "URL이 제공되지 않았습니다", 400
    
    try:
        response = requests.get(url)
        return Response(
            response.content, 
            content_type=response.headers['Content-Type']
        )
    except Exception as e:
        return str(e), 500

@app.route('/predict_url', methods=['POST'])
def predict_url():
    data = request.json
    if not data or 'url' not in data:
        return jsonify({'error': 'URL이 제공되지 않았습니다'}), 400
    
    image_url = data['url']
    
    try:
        # URL에서 이미지 다운로드
        response = requests.get(image_url)
        img = Image.open(io.BytesIO(response.content))
        
        # 이미지 전처리
        img = img.resize((160, 160))
        img_array = tf.keras.preprocessing.image.img_to_array(img)
        img_array = np.expand_dims(img_array, axis=0)
        img_array = (img_array/127.5) - 1  # 정규화
    
        
        # 예측 수행
        predictions = model.predict(img_array)
        predicted_class_index = np.argmax(predictions[0])
        predicted_class = class_names[predicted_class_index]
        confidence = float(predictions[0][predicted_class_index])
        
        return jsonify({
            'predicted_class': predicted_class,
            'confidence': confidence
        })
    
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
    # 로컬 호스트 127.0.0.1