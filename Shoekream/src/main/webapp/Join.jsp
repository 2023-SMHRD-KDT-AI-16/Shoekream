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

<style>
    #checkbutton {
        background-color: transparent; /* 배경을 투명하게 설정 */
        cursor: pointer; /* 호버 시 포인터 변경 */
        border-color : white;
        color : white;
		border-radius: 5px;
		   transition: all 0.3s ease;
    }

    #checkbutton:hover {
       margin: 2px;
       background-color: green;
    }
</style>
                    <div class="inputbox"  >  
                        <input type="text"  name="user_id" id="user_id" placeholder="영어,숫자 조합으로 6~12자" required>
                        <button type="button" id="checkbutton" onclick="CheckID()">아이디 중복확인</button>
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
                    	<style>
                    	#join {
	width: 100%;
	height: 40px;
	border-radius: 20px;
	font-size: 1em;
	font-weight: 600;
	background-color: #ffffff;
	/* 기본 배경색 */
	/* 테두리 스타일 */
	padding: 10px 20px;
	/* 안쪽 여백 */
	transition: background-color 0.5 ease;
	/* 배경색 변화를 부드럽게 만듦 */
}

#join:hover {
	background-color: #0000001a;
	margin : 2px;
	/* 호버 시 배경색 변경 */
}
                    	</style>
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