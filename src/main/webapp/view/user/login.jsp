<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<style>
  .login-container {
    padding: 40px;
    border-radius: 10px;
    width: 300px;
    margin: 0 auto;
    color: #ffffff;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }
  .login-container h2 {
    text-align: center;
    margin-bottom: 5px;
  }

  .login-container form {
    display: flex;
    flex-direction: column;
  }

  .login-container input[type="text"],
  .login-container input[type="password"] {
    padding: 10px;
    margin-bottom: 15px;
    border: none;
    border-radius: 5px;
    background-color: #2c2c2c;
    color: white;
  }

  .login-container input[type="submit"],
  .login-container input[type="button"] {
    padding: 10px;
    margin-bottom: 10px;
    border: none;
    border-radius: 5px;
    background-color: #3a3a3a;
    color: white;
    cursor: pointer;
    transition: background-color 0.2s;
  }

  .login-container input[type="submit"]:hover,
  .login-container input[type="button"]:hover {
    background-color: #555;
  }
</style>
<div>
<h2>LOGIN</h2>
</div>
<div class="login-container">
  
  <form action="loginOK.do">
    <input type="text" name="userId" placeholder="ID">
    <input type="password" name="userPwd" placeholder="PW">
    <input type="button" id = "btnLogin" value="확인">
    <input type="button" value="비번변경" id="findPwBtn">
    <input type="button" value="회원가입" id="joinBtn">
  </form>
</div>

<script type="text/javascript">
	$(function(){
		let limitOK = false;
		$("#joinBtn").click(function(){
			location.href = "joinUser.do";
		});
		$("#findPwBtn").click(function(){
			location.href = "resetPassword.do";
		});
		$("#btnLogin").click(function(){
			if(limitOK == false){
				$("form").submit();
				limitOK == true;
			}
		})
	})
</script>