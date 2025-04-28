## Main Quest 250428

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

#### 2.1. mean_iou가 현저하게 떨어진 이유에 대한 가설과 각각의 반영 결과
- VGG16 U-net의 학습 그래프
  ![download](https://github.com/user-attachments/assets/cda1f777-7daf-4f1e-9d00-2ababd7eceba)

1. 옵티마이저의 기본 학습률이 너무 높다```(기본: 0.001(1e-3))```
   - ```ie-4```로 조정하고 ```max_epochs = 20```으로 학습 시도
   - 결과: mean_iou: 

2. dice_coeff의 스무딩 값이 너무 낮다```(smooth = 1e-10)```
   - ```smooth = 1e-5```로 조정하고 학습 시도



## 3. 3가지 모델의 loss 그래프, meanIoU 계산, segmentation 결과 시각화
- ed_model ```mean_iou: 0.651900342004704```
  ![download](https://github.com/user-attachments/assets/404dac09-c5c3-4ae3-89d6-4cff91d7693a)
  ![download](https://github.com/user-attachments/assets/2e7fcdb7-0475-4fc0-9832-d0b5ef8190de)

- U-net model ```mean_iou: 0.9394320902071809```
  ![download](https://github.com/user-attachments/assets/c61b4ffa-36ed-43a9-81e9-16d2e1dc1126)
  ![download](https://github.com/user-attachments/assets/8e72734b-280b-40f4-8508-3b2fb22bee18)

- 개선된 U-net 모델(최종) ```mean_iou: ```

## 회고
- 클라우드 환경에서 진행 중 VRAM 부족이 의심되어 로컬 환경에서 진행하였음 ```(ResourceExhaustedError: OOM when allocating tensor)``` 
- 여러 모델구조를 한 코드에서 모두 정의해두고 실행을 반복하니.. 정신줄을 꼭 붙들고 있어야겠다는 생각이 들었음(코드 블럭에 주석 처리를 마치 스위치처럼 껐다 켰다 반복 실행하다가 어디 하나라도 잊고 실행할 것 같은 불안함이 있었다)
- 사전 구성된 U-net 모델의 결과가 좋아서 감탄했고, 이 이상으로 개선을 시도하기가 쉽지 않았지만.. 개선 과정은 흥미로웠
