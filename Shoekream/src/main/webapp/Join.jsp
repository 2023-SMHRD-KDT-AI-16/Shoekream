<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./CSS/Join.css">
    <title>SHOEKREAM</title>
</head>
<body>

    <section>
   
        <div class="form-box">
            <div class="form-value">
              
                <form action="JoinService" id = "JoinForm">
                  
                    <h2>SHOEKREAM</h2>
                    <br>
                    <h3>회원가입</h3>


                    <div class="inputbox"  >  
                        <input type="text"  name="user_id" id="user_id" placeholder="영어,숫자 조합으로 6~12자" required>
                        <button type="button" onclick="CheckID()">아이디 중복확인</button>
                        <span id="idConfirm"></span>
                        <label for="" >아이디* </label>    
                      
                    </div>
                    <div class="inputbox">
                        
                        <input type="password" name="user_pw" id="user_pw" oninput="pwCheck()" placeholder="영어,숫자 조합으로 8~16자" required>
                        <label for="" >비밀번호*</label>
                    </div>
                    <div class="inputbox">
                    
                        
                        <input type="password"  name="user_pw_check" id="user_pw_check"  oninput="pwCheck()" 
                        placeholder="동일하게 입력해주세요" required>
                        <label for="">비밀번호 재확인*</label>
                        <span id="pwConfirm"></span>
                        
                    </div>
                    <div class="inputbox">
                        
                        <input type=""  name="user_email" placeholder="예) shoekream12@naver.com" required>
                        <label for="">이메일*</label>
                    </div>
                    <div class="inputbox">
                        
                        <input type="text" name="user_nick" placeholder="예) 슈크림빵" required>
                        <label for="">닉네임*</label>
                    </div>
                    <div class="inputbox">
                        
                        <input type="text" name="user_phone" placeholder="예) 010-1234-1234" required>
                        <label for="">휴대폰번호*</label>
                    </div>
                    <div class="inputbox">
                        
                        <input type="text" name="user_name" placeholder="예) 홍길동" required>
                        <label for="">이름*</label>
                    </div>
                    <div class="forget">
                        <label for="">아이디가 있으신가요? <a href="Login.jsp">로그인 하기</a></label>
                    </div>
                    <div > 
                        <button type="submit" id="join">회원가입요청</button>
                    </div>
                </form>
            </div>
        </div>
     </section>
     
     <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
     <script src="./JS/Join.js"></script>
     

</body>
</html>