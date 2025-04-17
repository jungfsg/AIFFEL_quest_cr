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
- 진행중
