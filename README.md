# 인생겜컷 (Life GameCut)

## 프로젝트 개요
**인생겜컷**은 ‘인생네컷’과 ‘게임’을 결합한 이름으로, 짧고 임팩트 있는 게임 명장면(킬캠, 클러치, 재치 있는 장면 등)을 쉽고 빠르게 공유하고, 댓글·커뮤니티로 소통할 수 있는 웹 플랫폼입니다.  
기존 텍스트 중심 커뮤니티의 불편함을 해소하고, 릴스·숏츠처럼 영상 소비가 폭발적으로 증가한 트렌드를 반영해 기획되었습니다. 

## 팀 구성
- **팀명**: 개코
- **팀장 : 조세창: AJAX & Fetch API 비동기 통신 구현  
- **팀원**  
  - 고강찬: FileUtil 클래스 설계 (static)  
  - 공우진, 전희재: 자동 로그아웃, UI/UX  
  - 성준우: 오류 보고·디버깅  
  - 양소영: 테마·설정 관리, 테스트 및 문서화 

## 주요 기능
1. **영상 업로드 & 랜덤 재생**  
2. **댓글 기능** (감상·팁·공감 공유)  
3. **커뮤니티 공간** (게임 토론, 정보 공유, 팔로워 찾기)  
4. **웹 게임 & 랭킹 시스템** (포인트 기반 경쟁)  
5. **쇼핑 기능** (아이템 구매 · 장바구니)  
6. **포인트 및 계급 랭킹 조회**  
7. **설정 관리** (UI 크기 · 폰트 · 테마)  
8. **마이페이지, 받은 쪽지, 팔로우 관리**  
9. **좋아요 · 공유 · 다운로드 · 신고 기능** 

## 기술 스택
- **백엔드**: Java, JSP/Servlet (MVC 패턴), JSTL  
- **프론트엔드**: HTML5, CSS3, JavaScript (AJAX, Fetch API)  
- **DB**: Oracle DB (ERD 설계 및 SQL 명세서 제공)  
- **서버**: Apache Tomcat  
- **협업 도구**: GitHub, PPT, 팀 위키 

## 설치 및 실행
1. 저장소 클론  
   ```bash
   git clone https://github.com/your-org/life-gamecut.git
   cd life-gamecut

2. Java 및 Maven 빌드
mvn clean package

3. Oracle DB 설정
  - /db/schema.sql 파일로 테이블 생성
  - src/main/resources/db.properties에 DB 접속 정보 입력

4. Tomcat에 WAR 배포

##  프로젝트 구조
├─ src/
│  ├─ main/
│  │  ├─ java/com/gamecut/
│  │  │  ├─ controller/
│  │  │  ├─ dao/
│  │  │  └─ vo/
│  │  └─ webapp/
│  │     ├─ WEB-INF/jsp/
│  │     ├─ static/css/
│  │     └─ static/js/
├─ db/
│  ├─ schema.sql
│  └─ data.sql
└─ README.md

## 회고 및 개선점
- 조세창: 비동기 처리 경험, 다음에는 더 완성도 높은 기능 구현
- 고강찬: MVC 패턴 학습, 미구현 기능 보완 목표
- 공우진: 필터·디스패처 이해도 향상
- 전희재: 대규모 프로젝트 협업 경험
- 성준우: JSP 디버깅 역량 강화
- 양소영: 설정관리 및 디버깅 스킬 향상

## 라이선스
- MIT © 개코 팀
