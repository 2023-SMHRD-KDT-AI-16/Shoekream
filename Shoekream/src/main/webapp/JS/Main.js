function togglefollowN(index) {
    var followButton = document.getElementById('follow_' + index);
    followButton.classList.toggle('active');
    var post_userid = document.querySelector('input[name="post_userid"]').value;
    
    if (followButton.classList.contains('active')) {
        followButton.textContent = '팔로잉';
        
        $.ajax({
            url: "FollowService",
            data: { "post_userid": post_userid, "follow": "y" },
            type: 'get',
            success: function (result) {
                console.log("팔로우 DB저장완료");
            },
            error: function () {
                console.log("통신 실패");
            }
        });
        
    } else {
        followButton.textContent = '팔로우';
        $.ajax({
            url: "FollowService",
            data: { "post_userid": post_userid, "follow": "n" },
            type: 'get',
            success: function (result) {
                console.log("팔로우 DB삭제완료");
            },
            error: function () {
                console.log("통신 실패");
            }
        });
    }
}

function togglefollowY(index) {
	
    var followButton = document.getElementById('follow_' + index);
    followButton.classList.toggle('active');
    var post_userid = document.querySelector('input[name="post_userid"]').value;
    
    if (followButton.classList.contains('active')) {
		followButton.textContent = '팔로우';
        $.ajax({
            url: "FollowService",
            data: { "post_userid": post_userid, "follow": "n" },
            type: 'get',
            success: function (result) {
                console.log("팔로우 DB삭제완료");
            },
            error: function () {
                console.log("통신 실패");
            }
        });
    } else {
        
        followButton.textContent = '팔로잉';
        
        $.ajax({
            url: "FollowService",
            data: { "post_userid": post_userid, "follow": "y" },
            type: 'get',
            success: function (result) {
                console.log("팔로우 DB저장완료");
            },
            error: function () {
                console.log("통신 실패");
            }
        });
        
    }
}

//------------------------------------------------------------
//좋아요 누른 게시글일때
function toggleLikeN(index) {
    var likeButton = document.getElementById('like_' + index);
    likeButton.classList.toggle('active');
    
    var likeCountElement = likeButton.parentElement.nextElementSibling;
    var likeCount = parseInt(likeCountElement.textContent);
    var post_idx = $('[name="postIdx"]').eq(index).val();
    
    if (likeButton.classList.contains('active')) {
        // 좋아요를 눌렀을 때
        likeCount += 1;
        likeButton.textContent='❤️';
        $.ajax({
            url: "LIkeService",
            data: { "post_idx": post_idx, "like": "y" },
            type: 'get',
            success: function (result) {
                console.log("좋아요 DB저장완료")
            },
            error: function () {
                console.log("통신 실패")
            }
        });
    } else {
        // 좋아요 취소 했을 때
        likeCount -= 1;
        likeButton.textContent='🤍';
        $.ajax({
            url: "LIkeService",
            data: { "post_idx": post_idx, "like": "n" },
            type: 'get',
            success: function (result) {
                console.log("좋아요 삭제 완료")
            },
            error: function () {
                console.log("통신 실패")
            }
        });
    }

    likeCountElement.textContent = likeCount;
}
//좋아요 안누른 게시글 일때
function toggleLikeY(index) {
    var likeButton = document.getElementById('like_' + index);
    likeButton.classList.toggle('active');
    
    var likeCountElement = likeButton.parentElement.nextElementSibling;
    var likeCount = parseInt(likeCountElement.textContent);
    var post_idx = $('[name="postIdx"]').eq(index).val();
    
    if (likeButton.classList.contains('active')) {
         // 좋아요 취소 했을 때
        likeCount -= 1;
        likeButton.textContent='🤍';
        $.ajax({
            url: "LIkeService",
            data: { "post_idx": post_idx, "like": "n" },
            type: 'get',
            success: function (result) {
                console.log("좋아요 삭제 완료")
            },
            error: function () {
                console.log("통신 실패")
            }
        });
    } else {
    	 // 좋아요를 눌렀을 때
        likeCount += 1;
        likeButton.textContent='❤️';
        $.ajax({
            url: "LIkeService",
            data: { "post_idx": post_idx, "like": "y" },
            type: 'get',
            success: function (result) {
                console.log("좋아요 DB저장완료")
            },
            error: function () {
                console.log("통신 실패")
            }
        });
    }

    likeCountElement.textContent = likeCount;
}

//----------------------------------------------------------------
//댓글 달기

function writeComment(i){
	var inputComment = $('[name="comment"]').eq(i).val();
	var postIdx = $('[name="postIdx"]').eq(i).val();
	
	$.ajax({
		//1.어디로 요청할 것인지
		url:'WriteCommentService',
		//2.요청할 데이터 {key:value} --> request객체에 담김
		data:{"postIdx": postIdx, "inputComment": inputComment},
		//3.요청방식
		type:'get',
		//요청에 성공했을때 무엇을 할 것인지
		success: function(result){
			console.log("통신 성공")
			$('[name="comment"]').eq(i).val('')
			
		},
		//요청에 실패했을때
		error:function(){
		console.log("통신 실패")
		}
		
		
	});
	
}


//-----------------------------------------------------------------------------
//게시글 작성 모달창, 게시글 출력
	const modalOpenButton = document.getElementById('modalOpenButton');
	const modalCloseButton = document.getElementById('modalCloseButton');
	const modal = document.getElementById('modalContainer');
	const fileInput = document.getElementById('fileInput');
	const nextButton = document.getElementById('nextButton');
	const prevButton = document.getElementById('prevButton');
	const preview = document.getElementById('preview');
	const fileSelectionScreen = document.getElementById('fileSelectionScreen');
	const photoPreviewScreen = document.getElementById('photoPreviewScreen');

	modalOpenButton.addEventListener('click', () => {
	  modal.classList.remove('hidden');
	  fileSelectionScreen.style.display = 'block'; // Show file selection screen
	  photoPreviewScreen.style.display = 'none'; // Hide photo preview screen
	});

	modalCloseButton.addEventListener('click', () => {
	  modal.classList.add('hidden');
	});

	nextButton.addEventListener('click', () => {
	  // Check if a file is selected
	  if (fileInput.files.length > 0) {
	    // Display the selected image
	    const file = fileInput.files[0];
	    const reader = new FileReader();
	    reader.onload = function(event) {
	      const img = document.createElement('img');
	      img.src = event.target.result;
	      img.style.maxWidth = '100%'; // Adjust as needed
	      preview.innerHTML = ''; // Clear previous preview
	      preview.appendChild(img);
	    };
	    reader.readAsDataURL(file);
	    fileSelectionScreen.style.display = 'none'; // Hide file selection screen
	    photoPreviewScreen.style.display = 'block'; // Show photo preview screen
	  } else {
	    alert('파일을 선택하세요.');
	  }
	});
	
	prevButton.addEventListener('click', () => {
	  // Show file selection screen and hide photo preview screen
	  fileSelectionScreen.style.display = 'block';
	  photoPreviewScreen.style.display = 'none';
	});
	
