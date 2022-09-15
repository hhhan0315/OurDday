# 우리디데이
- 커플 기념일 앱
- 기능
  - 사진 등록
  - 디데이 확인
  - 기념일 확인
  - 홈 화면 위젯 지원
  - 다크모드 지원
- 라이브러리
  - [ToCropViewController](https://github.com/TimOliver/TOCropViewController)
  - [Tabman](https://github.com/uias/Tabman)
- 앱 스토어
  - https://apps.apple.com/kr/app/우리디데이-커플-기념일/id1616155192

# 미리보기
<img src="https://github.com/hhhan0315/OurDday/blob/main/스크린샷/미리보기.png">

# 기능
|첫 실행 확인|홈 화면 및 기념일 화면|배경 사진 등록|
|--|--|--|
|<img src="https://github.com/hhhan0315/OurDday/blob/main/스크린샷/기능1.gif" width="220">|<img src="https://github.com/hhhan0315/OurDday/blob/main/스크린샷/기능2.gif" width="220">|<img src="https://github.com/hhhan0315/OurDday/blob/main/스크린샷/기능3.gif" width="220">|

|프로필 사진 등록|위젯 등록|위젯 동기화|
|--|--|--|
|<img src="https://github.com/hhhan0315/OurDday/blob/main/스크린샷/기능4.gif" width="220">|<img src="https://github.com/hhhan0315/OurDday/blob/main/스크린샷/기능5.gif" width="220">|<img src="https://github.com/hhhan0315/OurDday/blob/main/스크린샷/기능6.gif" width="220">|

# 회고
## 디자인을 바꾼 이유
- 앱 스토어에 첫 배포한 시기가 22년 4월 말쯤에 시작했으며 사용하다보니까 일정 관리 부분의 사용은 줄고 디자인 부분이 미흡하다고 생각했다.
- 하지만 그래도 2000건 이상 노출되고 100건 이상 다운로드 받았으며 이후에 디자인이 좋아진다면 변화가 궁금했다.

## 라이브러리 사용
- 라이브러리를 사용하지 않고 UIScrollView와 UIPageViewController를 통해서 View pager를 구현했지만 사진을 자르는 ToCropviewController 라이브러리를 사용하면서 올바르게 동작하지 않는 오류 발생
- Tabman 라이브러리를 사용함으로써 해결
- Swift Package Manager를 사용해보니까 Cocoapod보다 훨씬 편리했고 내가 사용한 라이브러리는 모두 SPM을 지원해줬기 때문에 불편함은 없었다.

## iOS 14.0
- PHPicker 사용해서 사진 선택
  - UIImagePickerController에서 새롭게 대체
  - 권한 요청 팝업이 나타나지 않음
- WidgetKit
  - SwiftUI로만 작성 가능
  
## 이미지 저장
- UserDefaults를 활용해 날짜, 이미지 주소, 새로 접근했는 지 여부 등을 저장
- Widget에서도 이미지를 불러오기 위해서는 App Group을 사용
- FileManager.default.containerURL(forSecurityAppicationGroupIdentifier:) 활용
- 주소 자체는 UserDefaults, 이미지 자체는 FileManager 저장으로 구현

## 날짜 업데이트
- 다음날일 경우 다시 실행하지 않아도 앱, 위젯 날짜 업데이트 필요
- Notification.Name.NSCalendarDayChanged 활용
- Widget은 TimelineReloadPolicy 활용

## 코드로 UI 구현
- 코드로 구현함으로써 dataSource 등 놓치는 부분이 발생하지 않아서 좋았다.
- 만약 디자이너분과 협업을 한다면 코드로만 구현하는 것은 단점이 될 수 있다고 생각한다.

## MVVM 패턴
- MVVM 패턴을 활용하고 Data Binding은 Combine을 활용했다.
- 아직까지는 이해가 더 필요한 부분이라고 생각한다.

## Custom Font 적용
- 기본 시스템 폰트를 디자인적으로 개선해보기 위해 선택
- https://zeddios.tistory.com/199

# 이전 버전
## 1.0
|![1](https://github.com/hhhan0315/OurDday/blob/main/스크린샷/ios-6.5-inch-1.jpg)|![2](https://github.com/hhhan0315/OurDday/blob/main/스크린샷/ios-6.5-inch-2.jpg)|![3](https://github.com/hhhan0315/OurDday/blob/main/스크린샷/ios-6.5-inch-3.jpg)|![4](https://github.com/hhhan0315/OurDday/blob/main/스크린샷/ios-6.5-inch-4.jpg)|![5](https://github.com/hhhan0315/OurDday/blob/main/스크린샷/ios-6.5-inch-5.jpg)|
|--|--|--|--|--|

## 1.1
|![1.1-1](https://github.com/hhhan0315/OurDday/blob/main/스크린샷/ios-6.5-inch-1-1.1.jpg)|![1.1-2](https://github.com/hhhan0315/OurDday/blob/main/스크린샷/ios-6.5-inch-2-1.1.jpg)|![1.1-3](https://github.com/hhhan0315/OurDday/blob/main/스크린샷/ios-6.5-inch-3-1.1.jpg)|![1.1-4](https://github.com/hhhan0315/OurDday/blob/main/스크린샷/ios-6.5-inch-4-1.1.jpg)|![1.1-5](https://github.com/hhhan0315/OurDday/blob/main/스크린샷/ios-6.5-inch-5-1.1.jpg)|
|--|--|--|--|--|

## 진행상황
https://velog.io/@hhhan0315/iOS-앱-우리만의-디데이
