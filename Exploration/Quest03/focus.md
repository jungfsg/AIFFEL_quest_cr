## 250414 Portrait 모드


### 1. Portrait 모드 사진 제작

- 아웃포커싱이 적용된 인물 사진  
  ![image](https://github.com/user-attachments/assets/79fd1a5f-0968-4371-88e0-1a97bf0ed8f2)
- 아웃포커싱이 적용된 동물 사진  
  ![image](https://github.com/user-attachments/assets/4525e731-58f1-4951-963b-537544836846)
- 고양이를 블러 처리하고 배경을 원본으로 남긴 사진  
  ![image](https://github.com/user-attachments/assets/047a4b88-e43d-4137-aa85-caf1e61eb6d6)
- 배경전환 크로마키 사진  
  ![cat_windows_composite](https://github.com/user-attachments/assets/55b9e3d7-f596-47bb-bb20-519548d1cd66)

### 2. 제작한 사진에서 발견한 문제점

![final_cat_windows_composite](https://github.com/user-attachments/assets/c2159285-c343-4f4e-9d60-afd77eef79e2)
- 경계면의 엘리어싱 현상이 심함
- ![image](https://github.com/user-attachments/assets/0b2df480-3b6b-4e6a-8cca-e6ca1f450bcb) ![image](https://github.com/user-attachments/assets/1d891090-5d60-4a8a-931f-829cf15884f2)
  
- 뒤에 서있는 인물의 일부가 인식되지 않음
  ![image](https://github.com/user-attachments/assets/672f2a63-0dbd-4e40-9da6-1f7e891947a1)
  ![image](https://github.com/user-attachments/assets/d8ea9602-20d4-4ceb-8527-680ef682352d)
- 배경 합성으로 다시 확인해보니..
  ![hellosakura](https://github.com/user-attachments/assets/9140cbd8-2470-4717-b600-10bcb2452864)

- 전반적으로 이미지의 경계면을 정확하게 분리하지 않고 물체보다 두껍게 탐지해냄(정밀하지 않음)


### 3. Portrait 모드 사진의 문제점을 개선할 수 있는 솔루션
- CRF(Conditional Random Field) 사용해보기: 세그멘테이션 마스크 전체의 경계선을 개선함(비슷한 색상과 텍스처를 가진 인접 픽셀이 동일한 클래스 소속일 가능성이 높고, 색상차가 큰 곳은 실제 경계일 가능성이 높다는 원리로 작동함) -> 잘못 분류된 고립 픽셀들을 제거할 수 있고, 경계선의 앨리어싱 현상을 완화함
- 모델이 학습한 특정한 해상도 범위가 있다면 그에 맞게 입력 이미지 해상도를 전처리하는 방법이 있을 것 같음

  
### 4. 회고
- 컬러맵을 출력시키는 부분의 코드가 이해하기 어려웠음
- 결과물 개선방안이 쉽게 떠오르지 않았음
- 모델의 정확한 작동 원리가 어려웠음
- 저해상도이거나 경계면이 애매한 이미지에 대해서 어떻게 처리해야 할지 고민이 더 필요할 것 같음
- 촬영 당시 아웃포커싱되어있는 이미지에 대한 경계선 처리가 불분명해보이는데, 이와 같이 문제점을 명확하게 설정하고 해결방법을 찾는 과정이 필요할 것 같음
