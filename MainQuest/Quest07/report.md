# Main Quest 250428

1. tf.data.Dataset에 augmentation 반영하여 진행하기
2. U-net의 개선 모델 meanIoU를 기존 U-net보다 높이기
3. 3가지 모델의 loss 그래프, meanIoU 계산, segmentation 결과 시각화

## 1. tf.data.Dataset에 augmentation 반영

```
augment_params = functools.partial(_augment, 
                                  hue_delta=0.1,      
                                  horizontal_flip=True,
                                  width_shift_range=0.05,
                                  height_shift_range=0.05)

train_dataset = get_baseline_dataset(x_train_filenames,
                                    y_train_filenames,
                                    preproc_fn=augment_params)
train_dataset = train_dataset.repeat()

# 테스트 데이터는 증강 비활성화
test_dataset = get_baseline_dataset(x_test_filenames,
                                   y_test_filenames,
                                   is_train=False)
```
## 2. U-net의 개선 모델 meanIoU를 기존 U-net보다 높이기
- 기존 U-net의 mean_iou: 0.9394320902071809
- VGG16 U-net의 mean_iou: 0.5303546044177141

#### 2.1. mean_iou값 증가를 위한 여러가지 시도
- VGG16 U-net의 학습 그래프
  ![download](https://github.com/user-attachments/assets/cda1f777-7daf-4f1e-9d00-2ababd7eceba)

1. 옵티마이저의 학습률 수정```(기본: 0.001(1e-3))```
   - ```ie-4```로 조정하고 ```max_epochs = 20```으로 학습 시도
   - 결과: mean_iou: 0.6286652732094592
   - 약간의 차이가 있었음

2. dice_coeff의 스무딩 값 수정```(smooth = 1e-10)```
   - ```smooth = 1e-5```로 조정하고 학습 시도
   - 결과: mean_iou: 0.5269317960932139
   - 큰 차이가 나타나지 않음

3. 1의 방법에서 ```learning_rate=1e-4``` ```max_epochs = 30``` 으로 다시 시도
   - 결과: mean_iou: 0.8395255866004301
  ![b68e7d96-a828-48e4-9420-86e8c2b5497c](https://github.com/user-attachments/assets/ff7e498b-2af1-422d-aecf-c2363176b967)

4. 3 방법에 추가로 augment 조정하기
   - 내시경 사진임을 고려했을 때, ```hue_delta``` 적용이 적절하지 않을 수 있음(색상 자체가 진단적 의미가 클 수 있으므로)
   - ```hue_delta 0.1 >> 0.0```
   - ```shift_range 0.05 >> 0.1```
   - mean_iou: 0.8311504766369799
   - 변화가 거의 나타나지 않았음
  
5. 손실 그래프가 오히려 불안정해졌으므로 ```hue_delta``` 값만 0으로 조정
   - mean_iou: 0.8307475580624613
   - 마찬가지로 변화가 거의 나타나지 않음

6. ```batch_size = 16``` 으로 설정
   - mean_iou: 0.8027922119723314

7. 최종 시도
   - ```hue_delta = 0.1```
   - ```shift_range = 0.05```
   - ```batch_size = 8```
   - ```learning_rate=1e-4```
   - ```max_epochs = 30```
   - ```smooth = 1e-10```
   - mean_iou: 0.811481264466321


## 3. 3가지 모델의 loss 그래프, meanIoU 계산, segmentation 결과 시각화
- ed_model ```mean_iou: 0.651900342004704```
  ![download](https://github.com/user-attachments/assets/404dac09-c5c3-4ae3-89d6-4cff91d7693a)
  ![download](https://github.com/user-attachments/assets/2e7fcdb7-0475-4fc0-9832-d0b5ef8190de)

- U-net model ```mean_iou: 0.9394320902071809```
  ![download](https://github.com/user-attachments/assets/c61b4ffa-36ed-43a9-81e9-16d2e1dc1126)
  ![download](https://github.com/user-attachments/assets/8e72734b-280b-40f4-8508-3b2fb22bee18)

- 개선된 U-net 모델(최종 시도) ```mean_iou: 0.811481264466321 ```
![660f5981-beb9-4dc1-b0d2-14da799c4fae](https://github.com/user-attachments/assets/1472d07b-01b7-44ad-881d-e14b0d04e2b8)
![1413bbb1-24a0-4d79-91e6-64e9d92d3c94](https://github.com/user-attachments/assets/730fd8c0-3345-4fa4-8926-08cd3804e76d)

## 회고
- 클라우드 환경에서 진행 중 VRAM 부족이 의심되어 로컬 환경에서 진행하였음 ```(ResourceExhaustedError: OOM when allocating tensor)``` 
- 여러 모델구조를 한 코드에서 모두 정의해두고 실행을 반복하니.. 정신줄을 꼭 붙들고 있어야겠다는 생각이 들었음(코드 블럭에 주석 처리를 마치 스위치처럼 껐다 켰다 반복 실행하다가 어디 하나라도 잊고 실행할 것 같은 불안함이 있었다)
- 사전 구성된 U-net 모델의 결과가 좋아서 감탄했고, 이 이상으로 개선을 시도하기가 쉽지 않았지만.. 개선 과정은 흥미로웠음
