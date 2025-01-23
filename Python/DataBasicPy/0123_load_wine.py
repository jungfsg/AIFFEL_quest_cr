# 와인 분류하기

import sklearn
from sklearn.datasets import load_wine
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn import svm
from sklearn.linear_model import SGDClassifier
from sklearn.linear_model import LogisticRegression

# 불러온 데이터 변수 지정
wines = load_wine()

# 데이터 확인
print(wines.keys())
print(wines.target)     # 0, 1, 2 총 3개 클래스로 이루어짐
print(wines.data[0])

# feature_name 확인
print(wines.feature_names)

# Feature, Label 데이터 지정
winesData = wines.data
winesLabeled = wines.target

# target_names, DESCR 출력
print(wines.target_names)
print(wines.DESCR)

# =========

# train, test 데이터 분리하기
X_train, X_test, y_train, y_test = train_test_split(winesData,   
                                                    winesLabeled,   
                                                    test_size = 0.2,   
                                                    random_state = 10)


# 분리된 모델의 길이 확인
print('X_train: ', len(X_train),', X_test: ', len(X_test))

# =========

# 1. Decision Tree

decision_tree = DecisionTreeClassifier(random_state = 32)
decision_tree.fit(X_train, y_train)
y_pred = decision_tree.predict(X_test)

# Decision Tree 모델 평가
print('='*15, 'Decision_Tree_report', '='*16)
print(classification_report(y_test, y_pred))
print('='*53)

# 2. Random Forest

random_forest = RandomForestClassifier(random_state = 32)
random_forest.fit(X_train, y_train)
y_pred = random_forest.predict(X_test)

# Random Forest 모델 평가
print('='*15, 'Random_Forest_report', '='*16)
print(classification_report(y_test, y_pred))
print('='*53)

# 3. Support Vector Machine (SVM)

svm_model = svm.SVC()
svm_model.fit(X_train, y_train)
y_pred = svm_model.predict(X_test)

# SVM 모델 평가
print('='*20, 'SVM_report', '='*21)
print(classification_report(y_test, y_pred))
print('='*53)

# 4. SGD Classifier

sgd_model = SGDClassifier()
sgd_model.fit(X_train, y_train)
y_pred = sgd_model.predict(X_test)

# SGD Classifier 모델 평가
# SGD_Classifier_report에서 UndefinedMetricWarning: 경고 메시지가 출력되었음
# 특정 클래스가 테스트 사이즈에 희박하게 할당되어 발생한 것으로 판단하였음
# wines의 표본 갯수가 많지 않음
# zero_division을 0으로 설정하여 분모가 0인 경우 해당 정밀도 또는 재현율 값을 0으로 설정함
# SGD Classifier 모델 자체가 대용량의 데이터에 적합하다는 것을 알 수 있었음
print('='*15, 'SGD_Classifier_report', '='*15)
print(classification_report(y_test, y_pred, zero_division = 0))
print('='*53)

# 5. Logistic Regression
# 소규모 데이터셋에 적합한 liblinear를 사용하였음
# 좌표축 하강법 알고리즘을 이용하는 방법임
# 각 변수에 대해 하나씩 최적화를 반복수행함
# 데이터셋이 커질 경우 다른 solver를 사용하는 것이 권장됨
logistic_model = LogisticRegression(solver='liblinear', max_iter=1000)
logistic_model.fit(X_train, y_train)
y_pred = logistic_model.predict(X_test)

# Logistic Regression 모델 평가
print('='*12, 'Logistic_Regression_report', '='*12)
print(classification_report(y_test, y_pred))
print('='*53)

# =========

# 각 모델에 대해 classification_report를 활용하여 지표를 생성함
# SGD_Classifier의 경우 모든 지표에서 현저히 낮은 지표를 나타냄
# 와인의 화학적 특성을 토대로 와인을 3가지로 구분한 것이므로 와인의 품종 자체를 탐지하는 것이 목적이라고 생각하였음
# 품종을 엄밀하게 구분하는 것이 중요함
# 정밀도를 중요한 지표로 판단하는 것이 오탐지를 줄이는 가장 적절한 방법이라고 생각하였음

# >> Precision이 가장 중요한 지표라고 생각함