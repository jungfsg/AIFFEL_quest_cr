# 손글씨 분류하기

# 필요한 모듈 import
import sklearn
from sklearn.datasets import load_digits
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn import svm
from sklearn.linear_model import SGDClassifier
from sklearn.linear_model import LogisticRegression


# 불러온 데이터 변수 지정
digits = load_digits()

# 데이터 확인
print('keys', digits.keys())
print('data', digits.data)
# print(digitsData[0])
print('target', digits.target)

# data는 8*8 크기(64개)로 나뉘어진 이미지 정보
print(len(digits.data[0]))

# feature_name 확인
print('feature_names', digits.feature_names)
print('images', digits.images)

# =========

# Feature 데이터 지정, Label 데이터 지정
digitsData = digits.data
digitsLabeled = digits.target

# Target Names 출력하기, 데이터 Describe 하기
print('target_names', digits.target_names)
print('describe', digits.DESCR)

# =========

# train, test 데이터 분리하기
# x는 데이터, y는 target임
X_train, X_test, y_train, y_test = train_test_split(digitsData,   
                                                    digitsLabeled,   
                                                    test_size = 0.2,   
                                                    random_state = 10)
# 분리된 모델의 길이 확인
print('X_train: ', len(X_train),', X_test: ', len(X_test))

# =========

# 1. Decision Tree

decision_tree = DecisionTreeClassifier(random_state = 32)
print(decision_tree._estimator_type)
# 결정나무 학습구조 업데이트
decision_tree.fit(X_train, y_train)
# X_test로 예측하기, label(y_test)과 비교하기
y_pred = decision_tree.predict(X_test)
# print(y_pred)
# print(y_test)

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
print('='*15, 'SGD_Classifier_report', '='*15)
print(classification_report(y_test, y_pred))
print('='*53)

# 5. Logistic Regression
# STOP: TOTAL NO. OF ITERATIONS REACHED LIMIT 경고가 출력되었음
# 주어진 반복 횟수 내에서 모델이 최적화되거나 수렴되지 못하는 경우 발생함
# >> 기본값 100인 반복횟수를 500으로 증가시킴
logistic_model = LogisticRegression(max_iter=500)
logistic_model.fit(X_train, y_train)
y_pred = logistic_model.predict(X_test)

# Logistic Regression 모델 평가
print('='*12, 'Logistic_Regression_report', '='*12)
print(classification_report(y_test, y_pred))
print('='*53)

# =========

# 각 모델에 대해 sklearn.metrics에서 제공하는 classification_report를 활용하여 지표를 생성했다.
# 손글씨로 작성된 숫자를 분류하는 작업에는 정밀도, 재현율, F1 점수 가운데 재현율이 가장 중요하다고 생각한다.
# 숫자를 분류하는 작업에서 재현율이란, 실제 숫자 가운데 모델이 예측에 성공한 숫자의 비율을 뜻함
# 어떤 숫자에 대해서 얼마나 정밀하게 맞췄는지보다는 숫자를 얼마나 많이 맞추는 데 성공하는지가 중요하다고 생각했음.
# (classification_report 상 재현율(Recall)이 가장 높게 도출된 모델은 SVM 모델이었음)

# >> Recall이 가장 중요한 지표라고 생각함