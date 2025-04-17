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
- 진행중
