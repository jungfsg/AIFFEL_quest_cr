# 유방암 여부 진단
# Label은 True, False임(양성, 음성)

# 필요한 모듈 import
from sklearn.datasets import load_breast_cancer
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn import svm
from sklearn.linear_model import SGDClassifier
from sklearn.linear_model import LogisticRegression

# 불러온 데이터 변수 지정
brCancer = load_breast_cancer()

# 데이터 확인
print(brCancer.keys())
print(brCancer.target)
print(brCancer.data[0])

# feature_name 확인
print(brCancer.feature_names)

# Feature, Label 데이터 지정
brCancerData = brCancer.data
brCancerLabeled = brCancer.target

# target_names, DESCR 출력
print(brCancer.target_names)
print(brCancer.DESCR)

# =========

# train, test 데이터 분리하기
X_train, X_test, y_train, y_test = train_test_split(brCancerData,   
                                                    brCancerLabeled,   
                                                    test_size = 0.2,   
                                                    random_state = 10)


# 분리된 모델의 길이 확인
print('X_train: ', len(X_train),', X_test: ', len(X_test))

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
print('='*15, 'SGD_Classifier_report', '='*15)
print(classification_report(y_test, y_pred))
print('='*53)

# 5. Logistic Regression

# 표본수가 적어 liblinear를 사용하였고 반복 횟수를 증가시켰음 (기본값 = 100)
logistic_model = LogisticRegression(solver='liblinear', max_iter=1000)
logistic_model.fit(X_train, y_train)
y_pred = logistic_model.predict(X_test)

# Logistic Regression 모델 평가
print('='*12, 'Logistic_Regression_report', '='*12)
print(classification_report(y_test, y_pred))
print('='*53)

# =========

# 각 모델에 대해 classification_report를 활용하여 지표를 생성함
# 암과 같은 질병 탐지를 목적으로 할 경우 가장 치명적인 오류는 [질병에 걸렸는데 탐지되지 않은] 경우임
# 질병에 걸렸는데 탐지되지 않은 경우 = False Negative
# False Negative를 줄이는 방법은 recall을 높이는 것임
# recall을 높여 False Positive가 늘어나더라도(정밀성이 떨어지더라도) 생명에 치명적인 것은 아님

# >> Recall이 가장 중요한 지표라고 생각함