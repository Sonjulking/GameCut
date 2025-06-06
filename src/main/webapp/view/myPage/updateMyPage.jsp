<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<div class="main_container">
    <div class="main_content">
        <h2 class="joinUserTitle">내 정보 수정</h2>
        <hr>
        <form action="updateMyPageOK.do" method="post" enctype="multipart/form-data">
            <div class="form-container">
                <div class="left-column">
                    <div class="profile-image-container">
                        <c:if test="${empty file.originalFileName}">
                            <img class="oldFile" id="previewImage" src="img/main/icons/profile_icon.png" width="200"
                                height="200" style="border-radius: 100%;">
                        </c:if>
                        <c:if test="${!empty file.originalFileName}">
                            <img class="oldFile" id="previewImage" src="${file.fileUrl}" width="200"
                                height="200" style="border-radius: 100%;">
                        </c:if>
                    </div>
                    
                    <div class="form-group file-group">
                        <label for="originalFileName">프로필 이미지:</label>
                        <div class="file-controls">
                            <input type="file" name="originalFileName" id="originalFileName">
                            <input type="button" id="deleteFile" value="사진 삭제">
                        </div>
                    </div>
                </div>
                
                <div class="right-column">
                    <div class="form-group">
                        <label for="userName">이름:</label>
                        <input type="text" name="userName" id="userName" value="${user.userName}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="userId">아이디:</label>
                        <input type="text" name="userId" id="userId" value="${user.userId}" disabled>
                    </div>
                    
                    <div class="form-group">
                        <label for="userNickname">닉네임:</label>
                        <div class="input-with-button">
                            <input type="text" name="userNickname" id="userNickname" value="${user.userNickname}" required>
                            <button type="button" id="checkNickname">중복확인</button>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">연락처:</label>
                        <input type="text" name="phone" id="phone" value="${user.phone}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">이메일:</label>
                        <input type="text" name="email" id="email" value="${user.email}" required>
                    </div>
                </div>
            </div>
            
            <input type="hidden" name="oldFileName" value="${file.originalFileName}">
            <input type="hidden" name="isProfileDeleted" id="isProfileDeleted" value="false">
            <input type="hidden" name="userNo" id="userNo" value="${user.userNo}">
            <input type="hidden" name="oldfileUrl" value="${file.fileUrl}">
            <input type="hidden" name="oldPhotoNo" value="${user.photoNo}">
            
            <div class="button-group">
                <input type="submit" value="수정 완료" id="btnOK">
                <input type="reset" value="원래대로" id="btnReset">
            </div>
        </form>
    </div>
</div>

<style>
    .main_container {
        width: 100%;
        padding: 1rem;
    }
    
    .main_content {
        width: 100%;
        padding: 2rem;
        background-color: #1a1a1a;
        border-radius: 0.75rem;
        color: #f0f0f0;
        max-height: 85vh; /* 뷰포트 높이의 85%로 제한 */
        overflow-y: auto; /* 내용이 넘칠 경우 자연스럽게 스크롤바 표시 */
    }
    
    /* 스크롤바 스타일링 */
    .main_content::-webkit-scrollbar {
        width: 0.5rem;
    }
    
    .main_content::-webkit-scrollbar-track {
        background: #1a1a1a;
    }
    
    .main_content::-webkit-scrollbar-thumb {
        background: #3a3a3a;
        border-radius: 0.25rem;
    }
    
    .main_content::-webkit-scrollbar-thumb:hover {
        background: #555;
    }
    
    .joinUserTitle {
        font-size: 1.5rem;
        color: #f0f0f0;
        margin-bottom: 1rem;
        text-align: center;
    }
    
    hr {
        border: none;
        border-top: 0.0625rem solid #3a3a3a;
        margin: 1.5rem 0;
    }
    
    form {
        max-width: 900px;
        margin: 0 auto;
    }
    
    .form-container {
        display: flex;
        flex-direction: row;
        gap: 2rem;
        margin-bottom: 2rem;
    }
    
    .left-column {
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    
    .right-column {
        flex: 2;
    }
    
    .profile-image-container {
        margin-bottom: 1.5rem;
        width: 200px;
        height: 200px;
        overflow: hidden;
        border-radius: 50%;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }
    
    .form-group {
        margin-bottom: 1.5rem;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 500;
        color: #ccc;
    }
    
    .form-group input[type="text"],
    .form-group input[type="file"] {
        width: 100%;
        padding: 0.75rem;
        border: none;
        border-radius: 0.375rem;
        background-color: #2c2c2c;
        color: white;
    }
    
    .form-group input[type="file"] {
        padding: 0.5rem;
        background-color: transparent;
    }
    
    .input-with-button {
        display: flex;
        gap: 0.5rem;
    }
    
    .input-with-button input {
        flex: 1;
    }
    
    .file-group {
        width: 100%;
    }
    
    .file-controls {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }
    
    button,
    input[type="button"],
    input[type="submit"],
    input[type="reset"] {
        padding: 0.75rem 1rem;
        border: none;
        border-radius: 0.375rem;
        background-color: #3a3a3a;
        color: white;
        cursor: pointer;
        font-weight: 500;
        transition: background-color 0.2s ease;
    }
    
    button:hover,
    input[type="button"]:hover,
    input[type="submit"]:hover,
    input[type="reset"]:hover {
        background-color: #555;
    }
    
    #deleteFile {
        background-color: #c62828;
        margin-top: 0.5rem;
    }
    
    #deleteFile:hover {
        background-color: #ef5350;
    }
    
    #checkNickname {
        background-color: #4CAF50;
        white-space: nowrap;
    }
    
    #checkNickname:hover {
        background-color: #66BB6A;
    }
    
    .button-group {
        display: flex;
        justify-content: center;
        gap: 1rem;
        margin-top: 2rem;
        padding-bottom: 1rem;
    }
    
    .button-group input {
        min-width: 8rem;
    }
    
    #btnOK {
        background-color: #4CAF50;
    }
    
    #btnOK:hover {
        background-color: #66BB6A;
    }
    
    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .form-container {
            flex-direction: column;
        }
        
        .left-column, .right-column {
            width: 100%;
        }
        
        .profile-image-container {
            margin: 0 auto 1.5rem;
        }
    }
</style>

<script type="text/javascript">
$(function() {
    // 변수 선언 (let으로 변경하여 값 변경 가능하게 함)
    let isProfileDeleted = false;
    
    // 원래 이미지 URL 저장
    const originalImageUrl = "${file.fileUrl}";
    const emptyImageUrl = "img/common/empty.png";
    
    // 프로필사진 삭제 이벤트
    $("#deleteFile").click(function() {
        // 빈 이미지로 교체
        $("#previewImage").attr("src", emptyImageUrl);
        // 숨겨진 입력 필드 값 설정
        $("#isProfileDeleted").val("true");
        // 파일 입력 필드 초기화
        $("#originalFileName").val("");
        // 변수 업데이트
        isProfileDeleted = true;
        console.log("프로필 삭제 상태: " + isProfileDeleted);
    });
    
    // 리셋 버튼 이벤트
    $("#btnReset").click(function() {
        if (originalImageUrl) {
            $("#previewImage").attr("src", originalImageUrl);
        } else {
            $("#previewImage").attr("src", emptyImageUrl);
        }
        $("#isProfileDeleted").val("false");
        isProfileDeleted = false;
        $("#originalFileName").val("");
    });
    
    // 파일 선택 시 이미지 미리보기
    $("#originalFileName").change(function() {
        if (this.files && this.files[0]) {
            const reader = new FileReader();
            
            reader.onload = function(e) {
                $("#previewImage").attr("src", e.target.result);
                // 파일을 선택했으므로 삭제 상태 해제
                $("#isProfileDeleted").val("false");
                isProfileDeleted = false;
                console.log("이미지 미리보기 로드됨");
            }
            
            reader.readAsDataURL(this.files[0]);
        }
    });
    
    // 닉네임 중복 확인
    let checkNickname = false;
    const originalNickname = "${user.userNickname}";
    
    $("#checkNickname").click(function() {
        let userNickname = $("#userNickname").val().trim();
        let userNo = $("#userNo").val().trim();
        
        if (userNickname === "") {
            alert("닉네임을 입력해주세요.");
            return;
        }
        
        // 원래 닉네임과 같다면 중복 확인 없이 통과
        if (userNickname === originalNickname) {
            alert("사용 가능한 닉네임입니다.");
            checkNickname = true;
            return;
        }
        
        $.get("nicknameCheck.do?userNickname=" + userNickname + "&userNo=" + userNo, (data) => {
            if (data.result == 1) {
                alert("이미 사용 중인 닉네임입니다.");
                checkNickname = false;
            } else {
                alert("사용 가능한 닉네임입니다.");
                checkNickname = true;
            }
        });
    });
    
    // 폼 제출 전 유효성 검사
    $("#btnOK").click(function(e) {
        // 닉네임이 변경되었고 중복 확인을 하지 않았다면
        if ($("#userNickname").val() !== originalNickname && !checkNickname) {
            alert("닉네임 중복 확인을 해주세요.");
            e.preventDefault();
            return false;
        }
    });
});
</script>