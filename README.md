## 🌞 프로젝트 기획 이유

flutter를 더 잘 활용하기 위해, 생각하다가 todo앱을 설계하게 되었다. 

## 🤩 프로젝트 개발 목표

- ***일정등록***
    - FloatingActionButton을 클릭시 일정이 등록되어, 이 일정이 캘린더에 보이게 설정하였다.
- ***일정보기***
    - 해당 날짜 클릭시 일정을 볼 수 있게 설정하였다.
- ***일정완료와 삭제***
    - 일정을 완료했으면 완료표시를, 필요없으면 삭제가 가능하게 해놓았다.
- ***일정전체보기***
    - 일정을 완료했으면 완료표시를, 필요없으면 삭제가 가능하게 해놓았다.

## **1. 사용 기술**

- **언어** : Flutter, Dart
- **IDEs** : androidStudio
- **Package**: GetX(상태관리), TableCalendar(캘린더), intl(숫자형식), sliding_up_panel(패널관리)
- **IDEs** : Vscode

## ❤️‍🔥 프로젝트 내용 설명

## 1) 일정 등록하기
<img width="504" alt="image" src="https://user-images.githubusercontent.com/90121929/230699401-a7fc9cb8-289c-4891-b5b2-9bce0f8c485a.png">
- ***왼쪽 사진(메인화면)*** : 이 화면에서 floatingactionbutton을 누르면 오른쪽 화면으로 가게 설정하였다.

- ***오른쪽 사진(일정등록)*** : 할일과 설명을 적게 설정하였다. 이는 **자동으로 validation을 하게 설정**하였다. 그래서 할일과 설명란에 글을 쓰지 않으면 다음 화면으로 넘어갈 수 없게 하였다.
    - ***날짜*** : 내가 누른 날짜와 다른 날짜에 할일을 등록하고 싶을 경우에 대비하여 날짜버튼을 눌렀을 때 변경되도록 설정하였다.
    - <img width="280" alt="image" src="https://user-images.githubusercontent.com/90121929/230699519-71cfbf21-4bc3-4347-93d4-80153f9466f1.png">
    
## 2) 일정보기
<img width="509" alt="image" src="https://user-images.githubusercontent.com/90121929/230699442-15dd4cc6-7a1e-4e1d-aede-9b21428289c1.png">
- ***캘린더탭*** : BottomNavigationBar를 구현하여 캘린더에서 바로 등록한 일정은 캘린더에 **sliding_up_panel로 보이게** 하였다.
- ***일정모음탭*** : 일정모음탭은 캘린더에서 등록한 일정 모두를 **한눈에 보이게 설정**하였다.

## 3) 일정완료와 삭제
<img width="519" alt="image" src="https://user-images.githubusercontent.com/90121929/230699461-cb68f206-ebde-4a37-ba43-d2d3f6e9e66e.png">
- ***일정 등록*** : 위에서 본 것처럼 일정을 등록하면 일정완료와 삭제를 할 수 있다.
<img width="504" alt="image" src="https://user-images.githubusercontent.com/90121929/230699469-6836328c-b197-4df3-8f8f-8a7a85631a79.png">
- ***일정 체크*** : 내가 해당되는 일정을 완료했다면 일정완료를 누를 수 있다. ***캘린더앱이나 일정모음 둘 중에 하나만 일정완료를 눌러도 두개가 연결되어 둘다 일정완료로 표시***된다.
<img width="508" alt="image" src="https://user-images.githubusercontent.com/90121929/230699477-97f13e5d-f8ec-444b-878f-60b6d57549f8.png">
- ***일정 삭제*** : ***alert창***을 띄워 실수로 삭제하는 것을 막고자 하였다. 그래서 ok버튼을 눌렀을 경우 삭제되도록 하였다. 이도 일정완료와 마찬가지로 ***캘린더탭과 일정모음 둘 중에 하나만 삭제해도 두 곳에 있던 일정이 모두 삭제***된다.
- ***일정확인*** : 일정에 대한 설명을 보고 싶을 때 일정을 클릭하면 **할일과 설명에 대한 설명이 자세히 보인다.**
