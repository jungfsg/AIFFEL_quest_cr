## 실험 기록

### 1. Adam(1e-4), epoch 50

![train_history_0003](https://github.com/user-attachments/assets/b654ff0f-00f0-4dcf-9e38-be701ab3f7af)
![cifar](https://github.com/user-attachments/assets/730821e1-5fde-4c09-9658-62ed679befa9)
![download](https://github.com/user-attachments/assets/7324e08e-49c2-4e4b-9f27-6d0776a922e8)
- 학습이 거의 이루어지지 않음

### 2. Adam(1e-3), epoch 100
- 학습률과 에포크를 모두 증가시키고 재시도
- 유의미하지 않았음
![download](https://github.com/user-attachments/assets/b75264c3-f368-4182-b948-75ebd7890cc7)
![cifar](https://github.com/user-attachments/assets/77a5a8a4-d30a-4d16-a3d6-62512aa0824b)
![download](https://github.com/user-attachments/assets/2dff07f3-8600-4b3a-b764-b2fd35e9ed17)

### 3. Adam(1e-4), epoch 50, discriminator 출력함수 Sigmoid 추가
- 학습률과 에포크를 복구하고, 출력층에 출력 함수를 추가하여 재시도
- 판별자 모델이 비교적 강력하여 가짜 이미지와 실제 이미지 모두를 90%에 가까운 정확도로 구분하고 있음
- 생성자 모델 손실값이 높은 상태가 유지되어 개선되지 못하고 있음
- 판별자의 학습률을 낮추거나 드롭아웃을 증가하는 방향으로 판별자를 너프해야 할 것으로 생각되었음
![download](https://github.com/user-attachments/assets/cd627143-e066-4e93-88a9-07e0c0fe12bb)
![cifar](https://github.com/user-attachments/assets/2403f090-09b8-4701-91dc-f20a79f13886)
![download](https://github.com/user-attachments/assets/8d8a5ba2-8288-408d-a6f6-77b976493dcf)

### 4. Adam(1e-4), epoch 50, discriminator에서 activation = Sigmoid, dropout = 0.5
- 3번 결과를 바탕으로 재구성하여 시도함
![download](https://github.com/user-attachments/assets/25611374-3fd7-42bd-93fd-6f41769de291)
![cifar](https://github.com/user-attachments/assets/90274cbf-5c62-4a20-9e9d-f85a3551d6d2)
![download](https://github.com/user-attachments/assets/3ce31601-0e56-4156-924d-e958cf7a8f50)

### 5. 생성자 층 구조 변경
- 4번 구성에 더해 생성자 모델 층 구조를 깊게 하여 밸런스를 조절해보았음
- 큰 차이는 나타나지 않았음
![download](https://github.com/user-attachments/assets/c34f8a55-24f6-4d5f-834e-e6cf9b96cb9f)
![cifar](https://github.com/user-attachments/assets/4a75abde-9b85-4622-94a6-190ec0c52dff)
![download](https://github.com/user-attachments/assets/54311870-295c-4333-b341-245afde1e6d2)

### 6. 생성자 층 심화
- 생성자 층 구조를 더 깊게 작성하여 학습 진행
![download](https://github.com/user-attachments/assets/5a5d0808-ef57-4325-a2c7-49a2c78224a4)
![cifar](https://github.com/user-attachments/assets/4b7cc0ab-b029-45a7-8d1a-581c186a01b9)
![download](https://github.com/user-attachments/assets/2d2b0cd1-601f-49ce-94a8-2c3dda5ed591)

### 7. 판별자 손실함수에 레이블 스무딩(Label Smoothing) 적용
- 실제 값에 대해 1.0만큼 확신 >> 0.8만큼 확신하도록 조정
- 판별자 모델의 과도한 자신감을 낮추고 생성자 모델에게 숨 쉴 틈을 제공
- 33 epochs에서 중단함
- fake_acc 값이 1에 수렴하는 추세가 완화되지 않았음
![train_history_0034](https://github.com/user-attachments/assets/23111bd2-2855-4e93-8627-8ed41c3c0fc3)
![cifar](https://github.com/user-attachments/assets/1b272346-95a4-4fcf-a365-caaa5841a178)
![download](https://github.com/user-attachments/assets/054baa30-56fd-486f-bb7a-df1001c86f59)



### 회고
- 모델 구조나 하이퍼 파라미터를 조정해봐도 변수에 대한 피드백이 잘 나타나지 않아서 방향성을 잡기 어려웠음
- 그래프가 원하는 방향으로 수렴하지 않고 끝나서 아쉬움
- 학습에 시간이 오래 걸려서 다양한 시도를 해보기 어려웠음
- 종합적으로 개선을 어디서부터 해보는게 좋을지 학습을 이리저리 반복해봐도 결과를 통해 힌트를 구하지 못해 답답..했음
- 생성자와 판별자의 밸런스?를 개념적으로 좀 더 이해하는 것이 필요하다고 생각함
