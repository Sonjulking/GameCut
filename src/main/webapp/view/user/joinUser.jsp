<%@ page
        language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"
%>


<div class="joinUserWrapper">
    <form action="joinUserOK.do" method="post">

        <div class="input-row">
            <h2 class="joinUserTitle">회원가입</h2>
        </div>
        <div class="input-row">
            <label for="userId">아이디</label>
            <input type="text" name="userId" id="userId"/>
            <button type="button" id="checkID">중복확인</button>
        </div>
        <div class="input-row">
            <label for="userPwd">비밀번호</label>
            <input type="password" name="userPwd" id="userPwd"/>
        </div>
        <div class="input-row">
            <label for="userPwd2">비밀번호 확인</label>
            <input type="password" name="userPwd2" id="userPwd2"/>
        </div>
        <div class="input-row">
            <label for="userName">사용자 이름</label>
            <input type="text" name="userName" id="userName"/>
        </div>
        <div class="input-row">
            <label for="userNickname">사용자 닉네임</label>
            <input type="text" name="userNickname" id="userNickname"/>
            <button type="button" id="checkNickname">중복확인</button>
        </div>

        <div class="input-row">
            <label for="phone">핸드폰 번호</label>
            <input type="text" name="phone" id="phone"/>
        </div>
        <div class="input-row">
            <label for="email">이메일</label>
            <input type="text" name="email" id="email"/>
        </div>
        <div class="btn-group">
            <input type="Button" value="가입하기" id="btnOK"/>
        </div>
    </form>
</div>

<style>
    html,
    body {
        margin: 0;
        padding: 0;
        height: 100%;
        background-color: #121212;
        font-family: 'Noto Sans KR', sans-serif;
        color: white;
        overflow-y: auto;
        font-size: 16px;
    }

    .joinUserTitle {
        font-size: 1.5rem;
        color: #f0f0f0;
    }

    .joinUserWrapper {
        padding-bottom: 2.5rem;
    }

    form {
        flex-direction: column;
        /* gap: 0.375rem; */
        font-size: 0.875rem;
        box-sizing: content-box;
        /* padding: 0 1rem; */
    }

    .input-row {
        display: flex;
        flex-direction: row;
        justify-content: flex-start;
        align-items: center;
        gap: 0.25rem;
    }
    .input-row label {
        width:9rem;
        font-weight: 500;
    }
    .input-row input[type='password'],
    .input-row input[type='text'] {
        flex: 1;
    }



    input[type='text'],
    input[type='password'] {
        padding: 0.75rem;
        border: none;
        border-radius: 0.375rem;
        background-color: #2c2c2c;
        color: white;
        font-size: 0.875rem;
        width: 100%;
    }



    button,
    input[type='button'] {
        padding: 0.75rem;
        height: 2.375rem;
        border: none;
        border-radius: 0.375rem;
        background-color: #3a3a3a;
        color: white;
        cursor: pointer;
        font-weight: bold;
        font-size: 0.8125rem;
        line-height: 1;
        min-width: 5rem;
        white-space: nowrap;
        transition: background-color 0.2s ease;
    }

    button:hover,
    input[type='button']:hover
    {
        background-color: #555;
    }


</style>


<script>
    $(function () {

        let checkIdOK = false;
        let checkNickname = false;
        let limitOK = false;

        $("#checkID").click(function () {
            let id = $("#userId").val().trim();
            if (id === "") {
                alert("아이디를 입력해주세요.");
                return;
            }

            $.get("idCheck.do?id=" + id, (data) => {
                if (data.result == 1) {
                    alert("이미 사용 중인 아이디 입니다.");

                } else {
                    alert("사용 가능한 아이디 입니다.");
                    checkIdOK = true;
                }
            });
        });


        $("#checkNickname").click(function () {
            let userNickname = $("#userNickname").val().trim();
            if (userNickname === "") {
                alert("닉네임를 입력해주세요.");
                return
            }

            $.get("nicknameCheck.do?userNickname=" + userNickname, (data) => {
                console.log(userNickname);
                if (data.result == 1) {
                    alert("이미 사용 중인 닉네임 입니다.");
                    return;

                } else {
                    alert("사용 가능한 닉네임 입니다.");
                    checkNickname = true;
                    
                }
            });

        });


        $("#btnOK").click(function () {
        	let userId = $("#userID").val();
            let pw1 = $("#userPwd").val();
            let pw2 = $("#userPwd2").val();
            let userName = $("#userName").val();
            let userNickname = $("#userNickname").val();
            let userPhone = $("#phone").val();
            let userEmail = $("#email").val();
			
            
            
            
            
            if (checkIdOK == true && checkNickname == true) {
            	if(userId === "" || userName === "" || userNickname === "" || userPhone === "" || userEmail === ""){
            		alert("모든 정보를 입력해주세요.");
                    return;
            	}
                if (!(pw1 === pw2) || pw1 === "") {
                    //비밀번호가 다름
                    alert("비밀번호를 다시 확인해주세요.");
                    return;
                } else {
                	if(limitOK == false){
                		//회원가입성공
                		limitOK == true;
                        $("form").submit();
                	}
                }
            } else {
                //아이디 중복을 확인해주세요.
                alert("아이디와 닉네임 중복 확인해주세요.");
                return;
            }
        });
    });

</script>