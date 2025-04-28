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
- 
