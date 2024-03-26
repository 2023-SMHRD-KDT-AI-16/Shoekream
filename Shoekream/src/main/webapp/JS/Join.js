   //비밀번호 재확인
     function pwCheck(){
         if($('#user_pw').val()==$('#user_pw_check').val()){
            $('#pwConfirm').text("비밀번호가 일치합니다").css('color','green')
         }else{
            $('#pwConfirm').text('비밀번호가 일치하지 않습니다.').css('color','red')         
         }
      }
     
     
     document.getElementById("join").addEventListener("click", function(event) {
    	    // CheckID() 함수가 실행되었는지 여부 확인
    	    if(!isIdChecked()) {
    	        // CheckID() 함수가 실행되지 않은 경우
    	        alert("아이디를 확인해주세요");
    	        event.preventDefault(); // 폼 제출 방지
    	    }
    	});

    	function isIdChecked() {
    	    // 아이디 중복 검사가 완료되었는지 확인
    	    let idConfirm = document.getElementById("idConfirm").textContent;
    	    return (idConfirm === '사용할 수 있는 아이디');
    	}
    	
     
     //아이디 중복체크
     function CheckID(){
    	 let id = document.getElementById("user_id").value
				
				$.ajax({
					//1.어디로 요청할 것인지
					url:"IdCheckService",
					//2.요청할 데이터 {key:value} --> request객체에 담김
					data:{"user_id": id},
					//3.요청방식 
					type:'get',
					//요청에 성공했을때 무엇을 할 것인지
					success: function(result){
						if(result=='true'){
							$('#idConfirm').text('중복된 아이디')
							document.getElementById("JoinForm").onsubmit = function() {
			                    return false;
			                };
							
						}else if(result=='false'){
							$('#idConfirm').text('사용할 수 있는 아이디')	
							document.getElementById("JoinForm").onsubmit = function() {
			                    return true;
			                };
						}
					},
					//요청에 실패했을때
					error:function(){
						alert("통신 실패");
					}

				});
			}
     