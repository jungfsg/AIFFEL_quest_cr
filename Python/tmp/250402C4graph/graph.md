- 베이스라인 지표(VGG16)
![베이스라인 지표](https://github.com/user-attachments/assets/7339aa1d-e5cf-4697-ae24-74ba0feef120)

- 전체 이미지를 흑백처리하고, 증강기법을 다양하게 적용했을 때의 그래프
![스크린샷 2025-04-02 124513](https://github.com/user-attachments/assets/cc665e70-da46-4d63-a83d-5ae9f54af11f)

- 흑백처리만 진행했을 때의 그래프(확률 0.5)
![스크린샷 2025-04-02 142140](https://github.com/user-attachments/assets/e2efe392-23c3-4cf5-afd7-c07c20b2554a)

- 에포크 15, 드롭아웃 0.2
![스크린샷 2025-04-02 151552](https://github.com/user-attachments/assets/4d54d101-9cc3-4b0a-bb7d-8024c1c79a13)
(같은 조건)
![image](https://github.com/user-attachments/assets/5bc9be92-cde5-4834-af95-d0ae46a418be)
- 검증 데이터 개수가 너무 적어서 모니터링이 불안정한 것으로 생각됨


- 데이터셋 변경 이후 베이스라인 그래프(드롭아웃 0.2)
![스크린샷 2025-04-03 141046](https://github.com/user-attachments/assets/ecdf24b3-9787-44fc-a425-41acb538f03e)

- 새로운 데이터셋 가운데 blue_jellyfish의 검증 데이터셋이 비교적 많이 정제되어있다고 판단함
- blue_jellyfish 데이터셋을 제외하고 같은 모델을 다시 학습시킨 결과 아래와 같음(2회 시도함)
![image](https://github.com/user-attachments/assets/66bb5e41-d21a-4ef5-94e1-1e356eec6e61)
