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
                  
                    <h2> <img src="./img/슈크림.jpg" alt="SHOEKREAM 로고" style="width: 200px; height: 100px;"></h2>
                    <h3>회원가입</h3>

<style>

    #checkbutton {
        background-color: transparent; /* 배경을 투명하게 설정 */
        cursor: pointer; /* 호버 시 포인터 변경 */
        border-color : white;
		border-radius: 5px;
		   transition: all 0.3s ease;
    }

    #checkbutton:hover {
       margin: 2px;
       background-color: #ebf1f7; 
    }
    @charset "UTF-8";
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap');

/* 미디어 쿼리가 정의되지 않은 CSS 부분 */
*{
    margin: 0;
    padding: 0;
    font-family: 'poppins',sans-serif;
}

section {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    width: 100%;
    background: url('./goodwpss.jpg') no-repeat;
    background-position: center;
    background-size: cover;
    background: #ebf1f7;
}

.form-box{
    position: relative;
    width: 600px;
    height: 900px;
    background: #fff;
    border: 2px solid black;
    border-radius: 20px;
    backdrop-filter: blur(15px);
    display: flex;
    justify-content: center;
    align-items: center;

}
h2{
    font-size: 2em;
    color: black;
    text-align: center;
}
.inputbox{
    position: relative;
    margin: 30px 0;
    width: 310px;
    border-bottom: 2px solid black;
}
.inputbox label{
    position: absolute;
    top: 0px;
    left: 5px;
    transform: translateY(-50%);
    color: rgb(0, 0, 0);
    font-size: 1em;
    pointer-events: none;
    transition: .5s;
}
input:focus ~ label,
input:valid ~ label{
top: -5px;
}
.inputbox input {
    width: 100%;
    height: 50px;
    background: transparent;
    border: none;
    outline: none;
    font-size: 1em;
    padding:0 35px 0 5px;
    color: rgb(0, 0, 0);
}
.inputbox ion-icon{
    position: absolute;
    right: 8px;
    color: rgb(0, 0, 0);
    font-size: 1.2em;
    top: 20px;
}
.forget{
    margin: -15px 0 15px ;
    font-size: .9em;
    color: rgb(0, 0, 0);
    display: flex;
    justify-content: space-between;  
}

.forget label input{
    margin-right: 5px;
    
    
}
.forget label a{
    color: #ff007f;
    text-decoration: none;
}
.forget label a:hover{
    text-decoration: underline;
}


.register{
    font-size: .9em;
    color: rgb(0, 0, 0);
    text-align: center;
    margin: 25px 0 10px;
}
.register p a{
    text-decoration: none;
    color: rgb(0, 0, 0);
    font-weight: 600;
}
.register p a:hover{
    text-decoration: underline;
}

.form-box{
    color: rgb(0, 0, 0);
    text-align: center;
     
}
   #checkbutton {
        background-color: #2787f5;  /* 배경을 투명하게 설정 */
        border: none; /* 테두리 제거 */
    }

    #checkbutton:hover {
            color: green;
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

	/* 기본 배경색 */
	/* 테두리 스타일 */
	padding: 10px 20px;
	/* 안쪽 여백 */
	transition: background-color 0.5 ease;
	/* 배경색 변화를 부드럽게 만듦 */
    background: #2787f5;
}

#join:hover {
	background-color:#ebf1f7; 
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