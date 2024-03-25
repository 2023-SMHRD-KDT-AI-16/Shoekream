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
	<form action="JoinService">
	
	
	<input type="text" name="user_id" placeholder="아이디를 입력하세요">
	<input type="password" name="user_pw" placeholder="비밀번호를 입력하세요">
	<input type="text" name="user_email" placeholder="이메일을 입력하세요">
	<input type="text" name="user_name" placeholder="이름을 입력하세요">
	<input type="text" name="user_nick" placeholder="닉네임을 입력하세요">
	<input type="text" name="user_phone" placeholder="전화번호를 입력하세요">
	<input type="submit" value="JoinUs" class="button fit">
</form>

    <section>
   
        <div class="form-box">
            <div class="form-value">
              
                <form action="JoinService">
                  
                    <h2>SHOEKREAM</h2>
                    <br>
                    <h3>회원가입</h3>


                    <div class="inputbox"  >
                        <input type="id"  name="user_id"  placeholder="영어,숫자 조합으로 6~12자">
                        <label for="" >아이디* </label>    
                        
                    </div>
                    <div class="inputbox">
                        
                        <input type="password" name="user_pw" placeholder="영어,숫자 조합으로 8~16자" >
                        <label for="" >비밀번호*</label>
                    </div>
                    <div class="inputbox">
                        
                        <input type="password"  placeholder="동일하게 입력해주세요">
                        <label for="">비밀번호 재확인*</label>
                    </div>
                    <div class="inputbox">
                        
                        <input type="email"  name="user_email" placeholder="예) shoekream12@naver.com">
                        <label for="">이메일*</label>
                    </div>
                    <div class="inputbox">
                        
                        <input type="user_name" name="user_nick" placeholder="예) 슈크림빵">
                        <label for="">닉네임*</label>
                    </div>
                    <div class="inputbox">
                        
                        <input type="phone"  placeholder="예) 010-1234-1234">
                        <label for="">휴대폰번호*</label>
                    </div>
                    <div class="inputbox">
                        
                        <input type="" name="user_name" placeholder="예) 홍길동">
                        <label for="">이름*</label>
                    </div>
                    <div class="forget">
                        <label for="">아이디가 있으신가요? <a href="Login.jsp">로그인 하기</a></label>
                    </div>
                    <div > 
                        <button>회원가입요청</button>
                    </div>
                </form>
            </div>
        </div>
     </section>

</body>
</html>