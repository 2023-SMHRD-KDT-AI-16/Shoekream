<%@page import="com.smhrd.model.UserDTO"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="kor">
<!-- Head -->
<head>

<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1, shrink-to-fit=no, viewport-fit=cover">
<meta name="color-scheme" content="light dark">

<title>Messenger - 2.2.0</title>

<!-- Favicon -->
<link rel="shortcut icon" href="./assets/img/favicon/favicon.ico"
	type="image/x-icon">

<!-- Font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700"
	rel="stylesheet">

<!-- Template CSS -->
<link class="css-lt" rel="stylesheet"
	href="./assets/css/template.bundle.css"
	media="(prefers-color-scheme: light)">
<link class="css-dk" rel="stylesheet"
	href="./assets/css/template.dark.bundle.css"
	media="(prefers-color-scheme: dark)">

 <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- Theme mode -->
<script>
            if (localStorage.getItem('color-scheme')) {
                let scheme = localStorage.getItem('color-scheme');

                const LTCSS = document.querySelectorAll('link[class=css-lt]');
                const DKCSS = document.querySelectorAll('link[class=css-dk]');

                [...LTCSS].forEach((link) => {
                    link.media = (scheme === 'light') ? 'all' : 'not all';
                });

                [...DKCSS].forEach((link) => {
                    link.media = (scheme === 'dark') ? 'all' : 'not all';
                });
            }
        </script>
  <script type="text/javascript">

  document.addEventListener('DOMContentLoaded', (event) => {
	    // DOM이 완전히 로드되었을 때 실행할 코드
	    connect();
	    loadMessages(); // 페이지 로딩 시 저장된 메시지들을 불러와서 표시하는 함수 호출
	});

	function loadMessages() {
	    const storedMessages = JSON.parse(localStorage.getItem('chatMessages') || '[]'); // 로컬 스토리지에서 메시지 배열을 불러옴
	    storedMessages.forEach(msg => {
	        appendMessage(msg.content, msg.senderId === userId ? 'message-out' : 'message'); // 메시지를 채팅창에 추가
	    });
	}
	 function connect() {
		    var wsUri = "ws://localhost:8081/Shoekream/echo.do";
		    websocket = new WebSocket(wsUri);
		    websocket.onopen = function(evt) { console.log("웹소켓 연결됨"); };
		    websocket.onclose = function(evt) { console.log("웹소켓 연결 끊김"); };
		    websocket.onmessage = function(evt) { onMessage(evt); };
		    websocket.onerror = function(evt) { console.log("웹소켓 에러 발생"); };
		  }
	    
	    function onOpen() {
	        console.log("웹소켓이 열렸습니다~");
	    }
<% UserDTO user_info = (UserDTO) session.getAttribute("user_info"); %>

    var userId = '<%= user_info.getUserId() %>';

    console.log(userId);
    
    let websocket;
    let chat = $('#chat'); // 메시지를 표시할 채팅창 전체 컨테이너
   
    $(document).ready(connect);
   

  //받은 메세지
    function onMessage(event) {
    console.log("메시지 수신됨: ", event.data);
    try {
      let finalData = JSON.parse(event.data);
      // 중복 메시지 표시 방지를 위해 messageId를 체크
      if (!isMessageAlreadyDisplayed(finalData.messageId)) {
        appendMessage(finalData.content, finalData.senderId === userId ? 'message-out' : 'message', finalData.messageId);
        if(finalData.senderId !== userId) {
          saveMessage(finalData); // 상대방으로부터 온 메시지만 저장
        }
      }
    } catch (error) {
      console.error("Received message is not in JSON format:", event.data);
    }
  }

  function isMessageAlreadyDisplayed(messageId) {
    // 화면에 메시지가 이미 표시되었는지 확인하는 로직
    return document.querySelector(`[data-message-id="${messageId}"]`) !== null;
  }
    function saveMessage(data) {
        const storedMessages = JSON.parse(localStorage.getItem('chatMessages') || '[]'); // 기존에 저장된 메시지들을 불러옴
        storedMessages.push(data); // 새 메시지를 배열에 추가
        localStorage.setItem('chatMessages', JSON.stringify(storedMessages)); // 변경된 배열을 다시 로컬 스토리지에 저장
    }
    
    
    // 메시지 전송 함수, 기존의 submitFunction을 이 위치에 통합
    //내가 보내는 메세지
function sendMessage(event) {
    if (event) event.preventDefault();
    if (websocket.readyState !== WebSocket.OPEN) {
        console.error("웹소켓이 연결되지 않았습니다.");
        return;
    }
    const messageContent = $('#chatContent').val();
    if (!messageContent) {
        return;
    }

    const uniqueId = new Date().getTime(); // 메시지 고유 식별자로 타임스탬프 사용
    const data = {
        content: messageContent,
        senderId: userId,
        messageId: uniqueId // 메시지에 고유 식별자 추가
    };

    appendMessage(data.content, 'message-out', data.messageId); // 수정: 고유 식별자도 함께 전달
    saveMessage(data); // 메시지 저장 로직 유지

    let jsonData = JSON.stringify(data);
    websocket.send(jsonData); // 웹소켓을 통해 메시지 전송
    $('#chatContent').val(''); // 입력 필드 초기화
}

    // 메시지를 채팅창에 추가하는 함수
function appendMessage(content, className, messageId) {
    if(isMessageAlreadyDisplayed(messageId)) return; // 이미 표시된 메시지는 무시

    let messageDiv = document.createElement('div');
    messageDiv.setAttribute('data-message-id', messageId); // 메시지에 고유 식
    messageDiv.className = className;
    messageDiv.style.display = 'flex';
    messageDiv.style.marginBottom = '10px'; // 메시지 간 간격 조정

    let messageContentWrapper = document.createElement('div');
    messageContentWrapper.style.display = 'flex';
    messageContentWrapper.style.alignItems = 'center'; // 아바타와 텍스트를 세로 중앙에 정렬

    // 'message-out' 클래스일 때 오른쪽 정렬, 그렇지 않으면 왼쪽 정렬
    if (className === 'message-out') {
        messageDiv.style.justifyContent = 'flex-end';
        messageContentWrapper.style.marginLeft = '10px';
    } else {
        messageContentWrapper.style.marginRight = '10px';
    }

    let avatarDiv = document.createElement('div');
    avatarDiv.className = "avatar avatar-responsive";
    let img = document.createElement('img');
    img.className = 'avatar-img';
    img.src = className === 'message-out' ? "" : "img/<%=request.getParameter("writerProfile") %>";
    avatarDiv.appendChild(img);

    let messageContentDiv = document.createElement('div');
    messageContentDiv.className = 'message-content';

    let messageTextDiv = document.createElement('div');
    messageTextDiv.className = 'message-text';

    let p = document.createElement('p');
    p.textContent = content;

    messageTextDiv.appendChild(p);
    messageContentDiv.appendChild(messageTextDiv);

    // 메시지 내용과 아바타를 wrapper에 추가
    if (className === 'message-out') {
        messageContentWrapper.appendChild(messageContentDiv);
        messageContentWrapper.appendChild(avatarDiv);
    } else {
        messageContentWrapper.appendChild(avatarDiv);
        messageContentWrapper.appendChild(messageContentDiv);
    }

    // 메시지 div에 wrapper 추가
    messageDiv.appendChild(messageContentWrapper);

    // 메시지를 채팅창에 추가
    let chatContainer = document.getElementById('chat');
    chatContainer.appendChild(messageDiv);
    console.log("생성로직 완료!");

    // 채팅창의 스크롤을 최하단으로 이동시킴
    let chatBody = document.querySelector('.chat-body');
    chatBody.scrollTop = chatBody.scrollHeight;
}
</script>
        
</head>

<body>

	<div class="layout overflow-hidden">
		<!-- Navigation -->
		<nav
			class="navigation d-flex flex-column text-center navbar navbar-light hide-scrollbar">
			<!-- Brand -->
			<a href="Mypage.jsp" title="Messenger" class="d-none d-xl-block mb-6">
				<svg version="1.1" width="46px" height="46px" fill="currentColor"
					xmlns="http://www.w3.org/2000/svg"
					xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
					viewBox="0 0 46 46" enable-background="new 0 0 46 46"
					xml:space="preserve">
                        <polygon opacity="0.7"
						points="45,11 36,11 35.5,1 " />
                        <polygon points="35.5,1 25.4,14.1 39,21 " />
                        <polygon opacity="0.4"
						points="17,9.8 39,21 17,26 " />
                        <polygon opacity="0.7"
						points="2,12 17,26 17,9.8 " />
                        <polygon opacity="0.7"
						points="17,26 39,21 28,36 " />
                        <polygon points="28,36 4.5,44 17,26 " />
                        <polygon points="17,26 1,26 10.8,20.1 " />
                    </svg>

			</a>

			<!-- Nav items -->
			<ul
				class="d-flex nav navbar-nav flex-row flex-xl-column flex-grow-1 justify-content-between justify-content-xl-center align-items-center w-100 py-4 py-lg-2 px-lg-3"
				role="tablist">
				<!-- Invisible item to center nav vertically -->
				<li class="nav-item d-none d-xl-block invisible flex-xl-grow-1">
					<a class="nav-link py-0 py-lg-8" href="#" title="">
						<div class="icon icon-xl">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-x">
								<line x1="18" y1="6" x2="6" y2="18"></line>
								<line x1="6" y1="6" x2="18" y2="18"></line></svg>
						</div>
				</a>
				</li>

				<!-- New chat -->
				<li class="nav-item"><a class="nav-link py-0 py-lg-8"
					id="tab-create-chat" href="#tab-content-create-chat"
					title="Create chat" data-bs-toggle="tab" role="tab">
						<div class="icon icon-xl">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-edit-3">
								<path d="M12 20h9"></path>
								<path
									d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
						</div>
				</a></li>

				<!-- Friends -->
				<li class="nav-item"><a class="nav-link py-0 py-lg-8"
					id="tab-friends" href="#tab-content-friends" title="Friends"
					data-bs-toggle="tab" role="tab">
						<div class="icon icon-xl">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-users">
								<path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
								<circle cx="9" cy="7" r="4"></circle>
								<path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
								<path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
						</div>
				</a></li>

				<!-- Chats -->
				<li class="nav-item"><a class="nav-link active py-0 py-lg-8"
					id="tab-chats" href="#tab-content-chats" title="Chats"
					data-bs-toggle="tab" role="tab">
						<div class="icon icon-xl icon-badged">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-message-square">
								<path
									d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path></svg>
							<div class="badge badge-circle bg-primary">
								<span></span>
							</div>
						</div>
				</a></li>

				<!-- Notification -->
				<li class="nav-item"><a class="nav-link py-0 py-lg-8"
					id="tab-notifications" href="#tab-content-notifications"
					title="Notifications" data-bs-toggle="tab" role="tab">
						<div class="icon icon-xl">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-bell">
								<path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
								<path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg>
						</div>
				</a></li>

				<!-- Support -->
				<li class="nav-item d-none d-xl-block flex-xl-grow-1"><a
					class="nav-link py-0 py-lg-8" id="tab-support"
					href="#tab-content-support" title="Support" data-bs-toggle="tab"
					role="tab">
						<div class="icon icon-xl">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-layout">
								<rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
								<line x1="3" y1="9" x2="21" y2="9"></line>
								<line x1="9" y1="21" x2="9" y2="9"></line></svg>
						</div>
				</a></li>

				<!-- Switcher -->
				<li class="nav-item d-none d-xl-block"><a
					class="switcher-btn nav-link py-0 py-lg-8" href="#!" title="Themes">
						<div class="switcher-icon switcher-icon-dark icon icon-xl d-none"
							data-theme-mode="dark">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-moon">
								<path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg>
						</div>
						<div class="switcher-icon switcher-icon-light icon icon-xl d-none"
							data-theme-mode="light">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-sun">
								<circle cx="12" cy="12" r="5"></circle>
								<line x1="12" y1="1" x2="12" y2="3"></line>
								<line x1="12" y1="21" x2="12" y2="23"></line>
								<line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line>
								<line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>
								<line x1="1" y1="12" x2="3" y2="12"></line>
								<line x1="21" y1="12" x2="23" y2="12"></line>
								<line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line>
								<line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg>
						</div>
				</a></li>

				<!-- Settings -->
				<li class="nav-item"><a class="nav-link py-0 py-lg-8"
					id="tab-settings" href="#tab-content-settings" title="Settings"
					data-bs-toggle="tab" role="tab">
						<div class="icon icon-xl">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-settings">
								<circle cx="12" cy="12" r="3"></circle>
								<path
									d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path></svg>
						</div>
				</a></li>

				<!-- Profile -->
				<li class="nav-item d-none d-xl-block"><a href="#"
					class="nav-link p-0 mt-lg-2" data-bs-toggle="modal"
					data-bs-target="#modal-profile">
						<div class="avatar avatar-online mx-auto">
							<img class="avatar-img" src="" alt="">
						</div>
				</a></li>
			</ul>
		</nav>

		<!-- Navigation -->

		

		<!-- Chat -->
		<main class="main is-visible" data-dropzone-area="">
			<div class="container h-100">

				<div class="d-flex flex-column h-100 position-relative">
					<!-- Chat: Header -->
					<div class="chat-header border-bottom py-4 py-lg-7">
						<div class="row align-items-center">

							<!-- Mobile: close -->
							<div class="col-2 d-xl-none">
								<a class="icon icon-lg text-muted" href="#" data-toggle-chat="">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round" class="feather feather-chevron-left">
										<polyline points="15 18 9 12 15 6"></polyline></svg>
								</a>
							</div>
							<!-- Mobile: close -->

							<!-- Content -->
							<div class="col-8 col-xl-12">
								<div class="row align-items-center text-center text-xl-start">
									<!-- Title -->
									<div class="col-12 col-xl-6">
										<div class="row align-items-center gx-5">
											<div class="col-auto">
												<div class="avatar avatar-online d-none d-xl-inline-block">
													<img class="avatar-img" src="img/<%=request.getParameter("writerProfile") %>"
														alt="">
												</div>
											</div>
												
											<div class="col overflow-hidden">
											
												<h5 id="writerNickDisplay" class="text-truncate"><%=request.getParameter("writerNick") %></h5>
												<p class="text-truncate">
													<span class='typing-dots'><span>.</span><span>.</span><span>.</span></span>
												</p>
											</div>
										</div>
									</div>
									<!-- Title -->

									<!-- Toolbar -->
									<div class="col-xl-6 d-none d-xl-block">
										<div class="row align-items-center justify-content-end gx-6">
											<div class="col-auto">
												<a href="#" class="icon icon-lg text-muted"
													data-bs-toggle="offcanvas" data-bs-target="#offcanvas-more"
													aria-controls="offcanvas-more"> <svg
														xmlns="http://www.w3.org/2000/svg" width="24" height="24"
														viewBox="0 0 24 24" fill="none" stroke="currentColor"
														stroke-width="2" stroke-linecap="round"
														stroke-linejoin="round"
														class="feather feather-more-horizontal">
														<circle cx="12" cy="12" r="1"></circle>
														<circle cx="19" cy="12" r="1"></circle>
														<circle cx="5" cy="12" r="1"></circle></svg>
												</a>
											</div>

											<div class="col-auto">
												<div class="avatar-group">
													
													</a>
												</div>
											</div>
										</div>
									</div>
									<!-- Toolbar -->
								</div>
							</div>
							<!-- Content -->

							<!-- Mobile: more -->
							<div class="col-2 d-xl-none text-end">
								<a href="#" class="icon icon-lg text-muted"
									data-bs-toggle="offcanvas" data-bs-target="#offcanvas-more"
									aria-controls="offcanvas-more"> <svg
										xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round" class="feather feather-more-vertical">
										<circle cx="12" cy="12" r="1"></circle>
										<circle cx="12" cy="5" r="1"></circle>
										<circle cx="12" cy="19" r="1"></circle></svg>
								</a>
							</div>
							<!-- Mobile: more -->

						</div>
					</div>
					<!-- Chat: Header -->

					<!-- Chat: Content -->
					<div class="chat-body hide-scrollbar flex-1 h-100">
						<div class="chat-body-inner"  >
							<div class="py-6 py-lg-12" id="chat">

							   <!-- Divider -->
                                    <div class="message-divider">
                                        <small class="text-muted"></small>
                                    </div>

                              
							

							</div>
						</div>
					</div>
					<!-- Chat: Content -->

					<!-- Chat: Footer -->
					<div
						class="chat-footer pb-3 pb-lg-7 position-absolute bottom-0 start-0">
						<!-- Chat: Files -->
						<div class="dz-preview bg-dark" id="dz-preview-row"
							data-horizontal-scroll=""></div>
						<!-- Chat: Files -->

						<!-- Chat: Form -->
						<form class="chat-form rounded-pill bg-dark" data-emoji-form="">
							<div class="row align-items-center gx-0">
								<div class="col-auto">
									<a href="#"	class="btn btn-icon btn-link text-body rounded-circle"
										id="dz-btn"> <svg xmlns="http://www.w3.org/2000/svg"
											width="24" height="24" viewBox="0 0 24 24" fill="none"
											stroke="currentColor" stroke-width="2" stroke-linecap="round"
											stroke-linejoin="round" class="feather feather-paperclip">
											<path
												d="M21.44 11.05l-9.19 9.19a6 6 0 0 1-8.49-8.49l9.19-9.19a4 4 0 0 1 5.66 5.66l-9.2 9.19a2 2 0 0 1-2.83-2.83l8.49-8.48"></path></svg>
									</a>
								</div>

								<div class="col">
									<div class="input-group">
										<textarea class="form-control px-0" id="chatContent"
											placeholder="Type your message..." rows="1"
											data-emoji-input="" data-autosize="true"></textarea>

										<a href="#" class="input-group-text text-body pe-0"
											data-emoji-btn=""> <span class="icon icon-lg"> <svg
													xmlns="http://www.w3.org/2000/svg" width="24" height="24"
													viewBox="0 0 24 24" fill="none" stroke="currentColor"
													stroke-width="2" stroke-linecap="round"
													stroke-linejoin="round" class="feather feather-smile">
													<circle cx="12" cy="12" r="10"></circle>
													<path d="M8 14s1.5 2 4 2 4-2 4-2"></path>
													<line x1="9" y1="9" x2="9.01" y2="9"></line>
													<line x1="15" y1="9" x2="15.01" y2="9"></line></svg>
										</span>
										</a>
									</div>
								</div>

								<div class="col-auto">
									<button class="btn btn-icon btn-primary rounded-circle ms-5"
										onclick="sendMessage(event)">
										<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
											viewBox="0 0 24 24" fill="none" stroke="currentColor"
											stroke-width="2" stroke-linecap="round"
											stroke-linejoin="round" class="feather feather-send">
											<line x1="22" y1="2" x2="11" y2="13"></line>
											<polygon points="22 2 15 22 11 13 2 9 22 2"></polygon></svg>
									</button>
								</div>
							</div>
						</form>
						<!-- Chat: Form -->
					</div>
					<!-- Chat: Footer -->
				</div>

			</div>
		</main>
		<!-- Chat -->

		<!-- Chat: Info -->
		<div class="offcanvas offcanvas-end offcanvas-aside"
			data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1"
			id="offcanvas-more">
			<!-- Offcanvas Header -->
			<div class="offcanvas-header py-4 py-lg-7 border-bottom">
				<a class="icon icon-lg text-muted" href="#"
					data-bs-dismiss="offcanvas"> <svg
						xmlns="http://www.w3.org/2000/svg" width="24" height="24"
						viewBox="0 0 24 24" fill="none" stroke="currentColor"
						stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
						class="feather feather-chevron-left">
						<polyline points="15 18 9 12 15 6"></polyline></svg>
				</a>

				<div class="visibility-xl-invisible overflow-hidden text-center">
					<h5 class="text-truncate">Ollie Chandler</h5>
					<p class="text-truncate">last seen 5 minutes ago</p>
				</div>

				<!-- Dropdown -->
				<div class="dropdown">
					<a class="icon icon-lg text-muted" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> <svg
							xmlns="http://www.w3.org/2000/svg" width="24" height="24"
							viewBox="0 0 24 24" fill="none" stroke="currentColor"
							stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
							class="feather feather-more-vertical">
							<circle cx="12" cy="12" r="1"></circle>
							<circle cx="12" cy="5" r="1"></circle>
							<circle cx="12" cy="19" r="1"></circle></svg>
					</a>

					<ul class="dropdown-menu">
						<li><a href="#"
							class="dropdown-item d-flex align-items-center"> Edit
								<div class="icon ms-auto">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round" class="feather feather-edit-3">
										<path d="M12 20h9"></path>
										<path
											d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
								</div>
						</a></li>
						<li><a href="#"
							class="dropdown-item d-flex align-items-center"> Mute
								<div class="icon ms-auto">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round" class="feather feather-bell">
										<path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
										<path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg>
								</div>
						</a></li>
						<li>
							<hr class="dropdown-divider">
						</li>
						<li><a href="#"
							class="dropdown-item d-flex align-items-center text-danger">
								Leave
								<div class="icon ms-auto">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round" class="feather feather-log-out">
										<path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
										<polyline points="16 17 21 12 16 7"></polyline>
										<line x1="21" y1="12" x2="9" y2="12"></line></svg>
								</div>
						</a></li>
					</ul>
				</div>
			</div>
			<!-- Offcanvas Header -->

			<!-- Offcanvas Body -->
			<div class="offcanvas-body hide-scrollbar">
				<!-- Avatar -->
				<div class="text-center py-10">
					<div class="row gy-6">
						<div class="col-12">
							<div class="avatar avatar-xl mx-auto">
								

								<a href="#"
									class="badge badge-lg badge-circle bg-primary text-white border-outline position-absolute bottom-0 end-0">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round" class="feather feather-plus">
										<line x1="12" y1="5" x2="12" y2="19"></line>
										<line x1="5" y1="12" x2="19" y2="12"></line></svg>
								</a>
							</div>
						</div>

						<div class="col-12">
							<h4>Ollie Chandler</h4>
							<p>
								Bootstrap is an open source <br> toolkit for developing web
								with <br> HTML, CSS, and JS.
							</p>
						</div>
					</div>
				</div>
				<!-- Avatar -->

				<!-- Tabs -->
				<ul class="nav nav-pills nav-justified" role="tablist">
					<li class="nav-item"><a class="nav-link active"
						data-bs-toggle="pill" href="#offcanvas-tab-profile" role="tab"
						aria-controls="offcanvas-tab-profile" aria-selected="true">
							Profile </a></li>

					<li class="nav-item"><a class="nav-link" data-bs-toggle="pill"
						href="#offcanvas-tab-media" role="tab"
						aria-controls="offcanvas-tab-media" aria-selected="true">
							Media </a></li>

					<li class="nav-item"><a class="nav-link" data-bs-toggle="pill"
						href="#offcanvas-tab-files" role="tab"
						aria-controls="offcanvas-tab-files" aria-selected="false">
							Files </a></li>
				</ul>
				<!-- Tabs -->

				<!-- Tabs: Content -->
				<div class="tab-content py-2" role="tablist">
					<!-- Profile -->
					<div class="tab-pane fade show active" id="offcanvas-tab-profile"
						role="tabpanel">
						<ul class="list-group list-group-flush">
							<li class="list-group-item">
								<div class="row align-items-center gx-6">
									<div class="col">
										<h5>Phone</h5>
										<p>1-800-275-2273</p>
									</div>

									<div class="col-auto">
										<div class="btn btn-sm btn-icon btn-dark">
											<svg xmlns="http://www.w3.org/2000/svg" width="24"
												height="24" viewBox="0 0 24 24" fill="none"
												stroke="currentColor" stroke-width="2"
												stroke-linecap="round" stroke-linejoin="round"
												class="feather feather-phone-call">
												<path
													d="M15.05 5A5 5 0 0 1 19 8.95M15.05 1A9 9 0 0 1 23 8.94m-1 7.98v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
										</div>
									</div>
								</div>
							</li>

							<li class="list-group-item">
								<div class="row align-items-center gx-6">
									<div class="col">
										<h5>Location</h5>
										<p>USA, Houston</p>
									</div>

									<div class="col-auto">
										<div class="btn btn-sm btn-icon btn-dark">
											<svg xmlns="http://www.w3.org/2000/svg" width="24"
												height="24" viewBox="0 0 24 24" fill="none"
												stroke="currentColor" stroke-width="2"
												stroke-linecap="round" stroke-linejoin="round"
												class="feather feather-globe">
												<circle cx="12" cy="12" r="10"></circle>
												<line x1="2" y1="12" x2="22" y2="12"></line>
												<path
													d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
										</div>
									</div>
								</div>
							</li>

							<li class="list-group-item">
								<div class="row align-items-center gx-6">
									<div class="col">
										<h5>E-mail</h5>
										<p>chandler@ollie.com</p>
									</div>

									<div class="col-auto">
										<div class="btn btn-sm btn-icon btn-dark">
											<svg xmlns="http://www.w3.org/2000/svg" width="24"
												height="24" viewBox="0 0 24 24" fill="none"
												stroke="currentColor" stroke-width="2"
												stroke-linecap="round" stroke-linejoin="round"
												class="feather feather-mail">
												<path
													d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
												<polyline points="22,6 12,13 2,6"></polyline></svg>
										</div>
									</div>
								</div>
							</li>
						</ul>

						<ul class="list-group list-group-flush border-top mt-8">
							<li class="list-group-item">
								<div class="row align-items-center gx-6">
									<div class="col">
										<h5>Notifications</h5>
										<p>Enable sound notifications</p>
									</div>

									<div class="col-auto">
										<div class="form-check form-switch">
											<input class="form-check-input" type="checkbox"
												id="accordion-security-check-5"> <label
												class="form-check-label" for="accordion-security-check-5"></label>
										</div>
									</div>
								</div>
							</li>
						</ul>

						<ul class="list-group list-group-flush border-top mt-8">
							<li class="list-group-item"><a href="#" class="text-reset">Send
									Message</a></li>

							<li class="list-group-item"><a href="#" class="text-danger">Delete
									Chat</a></li>
						</ul>
					</div>
					<!-- Profile -->

					<!-- Media -->
					<div class="tab-pane fade" id="offcanvas-tab-media" role="tabpanel">
						<div class="row row-cols-3 g-3 py-6">
							<div class="col">
								<a href="#" data-bs-toggle="modal"
									data-bs-target="#modal-media-preview"
									data-theme-img-url="assets/img/chat/media-1.jpg"> <img
									class="img-fluid rounded" src="assets/img/chat/1.jpg" alt="">
								</a>
							</div>

							<div class="col">
								<a href="#" data-bs-toggle="modal"
									data-bs-target="#modal-media-preview"
									data-theme-img-url="assets/img/chat/media-2.jpg"> <img
									class="img-fluid rounded" src="assets/img/chat/2.jpg" alt="">
								</a>
							</div>

							<div class="col">
								<a href="#" data-bs-toggle="modal"
									data-bs-target="#modal-media-preview"
									data-theme-img-url="assets/img/chat/media-3.jpg"> <img
									class="img-fluid rounded" src="assets/img/chat/3.jpg" alt="">
								</a>
							</div>

							<div class="col">
								<a href="#" data-bs-toggle="modal"
									data-bs-target="#modal-media-preview"
									data-theme-img-url="assets/img/chat/media-1.jpg"> <img
									class="img-fluid rounded" src="assets/img/chat/4.jpg" alt="">
								</a>
							</div>

							<div class="col">
								<a href="#" data-bs-toggle="modal"
									data-bs-target="#modal-media-preview"
									data-theme-img-url="assets/img/chat/media-2.jpg"> <img
									class="img-fluid rounded" src="assets/img/chat/5.jpg" alt="">
								</a>
							</div>

							<div class="col">
								<a href="#" data-bs-toggle="modal"
									data-bs-target="#modal-media-preview"
									data-theme-img-url="assets/img/chat/media-3.jpg"> <img
									class="img-fluid rounded" src="assets/img/chat/6.jpg" alt="">
								</a>
							</div>

							<div class="col">
								<a href="#" data-bs-toggle="modal"
									data-bs-target="#modal-media-preview"
									data-theme-img-url="assets/img/chat/media-1.jpg"> <img
									class="img-fluid rounded" src="assets/img/chat/7.jpg" alt="">
								</a>
							</div>

							<div class="col">
								<a href="#" data-bs-toggle="modal"
									data-bs-target="#modal-media-preview"
									data-theme-img-url="assets/img/chat/media-2.jpg"> <img
									class="img-fluid rounded" src="assets/img/chat/8.jpg" alt="">
								</a>
							</div>

							<div class="col">
								<a href="#" data-bs-toggle="modal"
									data-bs-target="#modal-media-preview"
									data-theme-img-url="assets/img/chat/media-3.jpg"> <img
									class="img-fluid rounded" src="assets/img/chat/9.jpg" alt="">
								</a>
							</div>
						</div>
					</div>
					<!-- Media -->

					<!-- Files -->
					<div class="tab-pane fade" id="offcanvas-tab-files" role="tabpanel">
						<ul class="list-group list-group-flush">

							<!-- Item -->
							<li class="list-group-item">
								<div class="row align-items-center gx-5">
									<!-- Icons -->
									<div class="col-auto">
										<div class="avatar-group">
											
											</a> <a href="#" class="avatar avatar-sm"> <span
												class="avatar-text bg-primary"> <svg
														xmlns="http://www.w3.org/2000/svg" width="24" height="24"
														viewBox="0 0 24 24" fill="none" stroke="currentColor"
														stroke-width="2" stroke-linecap="round"
														stroke-linejoin="round" class="feather feather-file-text">
														<path
															d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
														<polyline points="14 2 14 8 20 8"></polyline>
														<line x1="16" y1="13" x2="8" y2="13"></line>
														<line x1="16" y1="17" x2="8" y2="17"></line>
														<polyline points="10 9 9 9 8 9"></polyline></svg>
											</span>
											</a>
										</div>
									</div>
									<!-- Icons -->

									<!-- Text -->
									<div class="col overflow-hidden">
										<h5 class="text-truncate">
											<a href="#">E5419783-047D-4B4C-B30E-F24DD8247731.JPG</a>
										</h5>
										<ul class="list-inline m-0">
											<li class="list-inline-item"><small
												class="text-uppercase text-muted">79.2 KB</small></li>

											<li class="list-inline-item"><small
												class="text-uppercase text-muted">txt</small></li>
										</ul>
									</div>
									<!-- Text -->

									<!-- Dropdown -->
									<div class="col-auto">
										<div class="dropdown">
											<a class="icon text-muted" href="#" role="button"
												data-bs-toggle="dropdown" aria-expanded="false"> <svg
													xmlns="http://www.w3.org/2000/svg" width="24" height="24"
													viewBox="0 0 24 24" fill="none" stroke="currentColor"
													stroke-width="2" stroke-linecap="round"
													stroke-linejoin="round"
													class="feather feather-more-vertical">
													<circle cx="12" cy="12" r="1"></circle>
													<circle cx="12" cy="5" r="1"></circle>
													<circle cx="12" cy="19" r="1"></circle></svg>
											</a>

											<ul class="dropdown-menu">
												<li><a class="dropdown-item d-flex align-items-center"
													href="#"> Download
														<div class="icon ms-auto">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-download">
																<path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
																<polyline points="7 10 12 15 17 10"></polyline>
																<line x1="12" y1="15" x2="12" y2="3"></line></svg>
														</div>
												</a></li>
												<li><a class="dropdown-item d-flex align-items-center"
													href="#"> Share
														<div class="icon ms-auto">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-share-2">
																<circle cx="18" cy="5" r="3"></circle>
																<circle cx="6" cy="12" r="3"></circle>
																<circle cx="18" cy="19" r="3"></circle>
																<line x1="8.59" y1="13.51" x2="15.42" y2="17.49"></line>
																<line x1="15.41" y1="6.51" x2="8.59" y2="10.49"></line></svg>
														</div>
												</a></li>
												<li><hr class="dropdown-divider"></li>
												<li><a
													class="dropdown-item d-flex align-items-center text-danger"
													href="#"> <span class="me-auto">Delete</span>
														<div class="icon">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-trash-2">
																<polyline points="3 6 5 6 21 6"></polyline>
																<path
																	d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
																<line x1="10" y1="11" x2="10" y2="17"></line>
																<line x1="14" y1="11" x2="14" y2="17"></line></svg>
														</div>
												</a></li>
											</ul>
										</div>
									</div>
									<!-- Dropdown -->
								</div>
							</li>

							<!-- Item -->
							<li class="list-group-item">
								<div class="row align-items-center gx-5">

									<!-- Icons-->
									<div class="col-auto">
										<div class="avatar-group">
											
											</a> <a href="#" class="avatar avatar-sm"> <span
												class="avatar-text bg-warning"> <svg
														xmlns="http://www.w3.org/2000/svg" width="24" height="24"
														viewBox="0 0 24 24" fill="none" stroke="currentColor"
														stroke-width="2" stroke-linecap="round"
														stroke-linejoin="round" class="feather feather-film">
														<rect x="2" y="2" width="20" height="20" rx="2.18"
															ry="2.18"></rect>
														<line x1="7" y1="2" x2="7" y2="22"></line>
														<line x1="17" y1="2" x2="17" y2="22"></line>
														<line x1="2" y1="12" x2="22" y2="12"></line>
														<line x1="2" y1="7" x2="7" y2="7"></line>
														<line x1="2" y1="17" x2="7" y2="17"></line>
														<line x1="17" y1="17" x2="22" y2="17"></line>
														<line x1="17" y1="7" x2="22" y2="7"></line></svg>
											</span>
											</a>
										</div>
									</div>
									<!-- Icons -->

									<!-- Text -->
									<div class="col overflow-hidden">
										<h5 class="text-truncate">
											<a href="#">E5419783-047D-4B4C-B30E-F24DD8247731.JPG</a>
										</h5>
										<ul class="list-inline m-0">
											<li class="list-inline-item"><small
												class="text-uppercase text-muted">54.2 KB</small></li>

											<li class="list-inline-item"><small
												class="text-uppercase text-muted">mp4</small></li>
										</ul>
									</div>
									<!-- Text -->

									<!-- Dropdown -->
									<div class="col-auto">
										<div class="dropdown">
											<a class="icon text-muted" href="#" role="button"
												data-bs-toggle="dropdown" aria-expanded="false"> <svg
													xmlns="http://www.w3.org/2000/svg" width="24" height="24"
													viewBox="0 0 24 24" fill="none" stroke="currentColor"
													stroke-width="2" stroke-linecap="round"
													stroke-linejoin="round"
													class="feather feather-more-vertical">
													<circle cx="12" cy="12" r="1"></circle>
													<circle cx="12" cy="5" r="1"></circle>
													<circle cx="12" cy="19" r="1"></circle></svg>
											</a>

											<ul class="dropdown-menu">
												<li><a class="dropdown-item d-flex align-items-center"
													href="#"> Download
														<div class="icon ms-auto">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-download">
																<path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
																<polyline points="7 10 12 15 17 10"></polyline>
																<line x1="12" y1="15" x2="12" y2="3"></line></svg>
														</div>
												</a></li>
												<li><a class="dropdown-item d-flex align-items-center"
													href="#"> Share
														<div class="icon ms-auto">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-share-2">
																<circle cx="18" cy="5" r="3"></circle>
																<circle cx="6" cy="12" r="3"></circle>
																<circle cx="18" cy="19" r="3"></circle>
																<line x1="8.59" y1="13.51" x2="15.42" y2="17.49"></line>
																<line x1="15.41" y1="6.51" x2="8.59" y2="10.49"></line></svg>
														</div>
												</a></li>
												<li><hr class="dropdown-divider"></li>
												<li><a
													class="dropdown-item d-flex align-items-center text-danger"
													href="#"> <span class="me-auto">Delete</span>
														<div class="icon">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-trash-2">
																<polyline points="3 6 5 6 21 6"></polyline>
																<path
																	d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
																<line x1="10" y1="11" x2="10" y2="17"></line>
																<line x1="14" y1="11" x2="14" y2="17"></line></svg>
														</div>
												</a></li>
											</ul>
										</div>
									</div>
									<!-- Dropdown -->
								</div>
							</li>

							<!-- Item -->
							<li class="list-group-item">
								<div class="row align-items-center gx-5">

									<!-- Icons -->
									<div class="col-auto">
										<div class="avatar-group">
										
											</a> <a href="#" class="avatar avatar-sm"> <span
												class="avatar-text bg-primary"> <svg
														xmlns="http://www.w3.org/2000/svg" width="24" height="24"
														viewBox="0 0 24 24" fill="none" stroke="currentColor"
														stroke-width="2" stroke-linecap="round"
														stroke-linejoin="round" class="feather feather-file-text">
														<path
															d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
														<polyline points="14 2 14 8 20 8"></polyline>
														<line x1="16" y1="13" x2="8" y2="13"></line>
														<line x1="16" y1="17" x2="8" y2="17"></line>
														<polyline points="10 9 9 9 8 9"></polyline></svg>
											</span>
											</a>
										</div>
									</div>
									<!-- Icons -->

									<!-- Text -->
									<div class="col overflow-hidden">
										<h5 class="text-truncate">
											<a href="#">E5419783-047D-4B4C-B30E-F24DD8247731.JPG</a>
										</h5>
										<ul class="list-inline m-0">
											<li class="list-inline-item"><small
												class="text-uppercase text-muted">64.8 KB</small></li>

											<li class="list-inline-item"><small
												class="text-uppercase text-muted">jpg</small></li>
										</ul>
									</div>
									<!-- Text -->

									<!-- Dropdown -->
									<div class="col-auto">
										<div class="dropdown">
											<a class="icon text-muted" href="#" role="button"
												data-bs-toggle="dropdown" aria-expanded="false"> <svg
													xmlns="http://www.w3.org/2000/svg" width="24" height="24"
													viewBox="0 0 24 24" fill="none" stroke="currentColor"
													stroke-width="2" stroke-linecap="round"
													stroke-linejoin="round"
													class="feather feather-more-vertical">
													<circle cx="12" cy="12" r="1"></circle>
													<circle cx="12" cy="5" r="1"></circle>
													<circle cx="12" cy="19" r="1"></circle></svg>
											</a>

											<ul class="dropdown-menu">
												<li><a class="dropdown-item d-flex align-items-center"
													href="#"> Download
														<div class="icon ms-auto">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-download">
																<path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
																<polyline points="7 10 12 15 17 10"></polyline>
																<line x1="12" y1="15" x2="12" y2="3"></line></svg>
														</div>
												</a></li>
												<li><a class="dropdown-item d-flex align-items-center"
													href="#"> Share
														<div class="icon ms-auto">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-share-2">
																<circle cx="18" cy="5" r="3"></circle>
																<circle cx="6" cy="12" r="3"></circle>
																<circle cx="18" cy="19" r="3"></circle>
																<line x1="8.59" y1="13.51" x2="15.42" y2="17.49"></line>
																<line x1="15.41" y1="6.51" x2="8.59" y2="10.49"></line></svg>
														</div>
												</a></li>
												<li><hr class="dropdown-divider"></li>
												<li><a
													class="dropdown-item d-flex align-items-center text-danger"
													href="#"> <span class="me-auto">Delete</span>
														<div class="icon">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-trash-2">
																<polyline points="3 6 5 6 21 6"></polyline>
																<path
																	d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
																<line x1="10" y1="11" x2="10" y2="17"></line>
																<line x1="14" y1="11" x2="14" y2="17"></line></svg>
														</div>
												</a></li>
											</ul>
										</div>
									</div>
									<!-- Dropdown -->
								</div>
							</li>

							<!-- Item -->
							<li class="list-group-item">
								<div class="row align-items-center gx-5">

									<!-- Icons-->
									<div class="col-auto">
										<div class="avatar-group">
											
											</a> <a href="#" class="avatar avatar-sm"> <span
												class="avatar-text bg-warning"> <svg
														xmlns="http://www.w3.org/2000/svg" width="24" height="24"
														viewBox="0 0 24 24" fill="none" stroke="currentColor"
														stroke-width="2" stroke-linecap="round"
														stroke-linejoin="round" class="feather feather-film">
														<rect x="2" y="2" width="20" height="20" rx="2.18"
															ry="2.18"></rect>
														<line x1="7" y1="2" x2="7" y2="22"></line>
														<line x1="17" y1="2" x2="17" y2="22"></line>
														<line x1="2" y1="12" x2="22" y2="12"></line>
														<line x1="2" y1="7" x2="7" y2="7"></line>
														<line x1="2" y1="17" x2="7" y2="17"></line>
														<line x1="17" y1="17" x2="22" y2="17"></line>
														<line x1="17" y1="7" x2="22" y2="7"></line></svg>
											</span>
											</a>
										</div>
									</div>
									<!-- Icons-->

									<!-- Text -->
									<div class="col overflow-hidden">
										<h5 class="text-truncate">
											<a href="#">E5419783-047D-4B4C-B30E-F24DD8247731.JPG</a>
										</h5>
										<ul class="list-inline m-0">
											<li class="list-inline-item"><small
												class="text-uppercase text-muted">80.8 KB</small></li>

											<li class="list-inline-item"><small
												class="text-uppercase text-muted">mp4</small></li>
										</ul>
									</div>
									<!-- Text -->

									<!-- Dropdown -->
									<div class="col-auto">
										<div class="dropdown">
											<a class="icon text-muted" href="#" role="button"
												data-bs-toggle="dropdown" aria-expanded="false"> <svg
													xmlns="http://www.w3.org/2000/svg" width="24" height="24"
													viewBox="0 0 24 24" fill="none" stroke="currentColor"
													stroke-width="2" stroke-linecap="round"
													stroke-linejoin="round"
													class="feather feather-more-vertical">
													<circle cx="12" cy="12" r="1"></circle>
													<circle cx="12" cy="5" r="1"></circle>
													<circle cx="12" cy="19" r="1"></circle></svg>
											</a>

											<ul class="dropdown-menu">
												<li><a class="dropdown-item d-flex align-items-center"
													href="#"> Download
														<div class="icon ms-auto">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-download">
																<path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
																<polyline points="7 10 12 15 17 10"></polyline>
																<line x1="12" y1="15" x2="12" y2="3"></line></svg>
														</div>
												</a></li>
												<li><a class="dropdown-item d-flex align-items-center"
													href="#"> Share
														<div class="icon ms-auto">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-share-2">
																<circle cx="18" cy="5" r="3"></circle>
																<circle cx="6" cy="12" r="3"></circle>
																<circle cx="18" cy="19" r="3"></circle>
																<line x1="8.59" y1="13.51" x2="15.42" y2="17.49"></line>
																<line x1="15.41" y1="6.51" x2="8.59" y2="10.49"></line></svg>
														</div>
												</a></li>
												<li><hr class="dropdown-divider"></li>
												<li><a
													class="dropdown-item d-flex align-items-center text-danger"
													href="#"> <span class="me-auto">Delete</span>
														<div class="icon">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-trash-2">
																<polyline points="3 6 5 6 21 6"></polyline>
																<path
																	d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
																<line x1="10" y1="11" x2="10" y2="17"></line>
																<line x1="14" y1="11" x2="14" y2="17"></line></svg>
														</div>
												</a></li>
											</ul>
										</div>
									</div>
									<!-- Dropdown -->
								</div>
							</li>

							<!-- Item -->
							<li class="list-group-item">
								<div class="row align-items-center gx-5">

									<!-- Icons-->
									<div class="col-auto">
										<div class="avatar-group">
										
											</a> <a href="#" class="avatar avatar-sm"> <span
												class="avatar-text bg-success"> <svg
														xmlns="http://www.w3.org/2000/svg" width="24" height="24"
														viewBox="0 0 24 24" fill="none" stroke="currentColor"
														stroke-width="2" stroke-linecap="round"
														stroke-linejoin="round" class="feather feather-image">
														<rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
														<circle cx="8.5" cy="8.5" r="1.5"></circle>
														<polyline points="21 15 16 10 5 21"></polyline></svg>
											</span>
											</a>
										</div>
									</div>
									<!-- Icons-->

									<!-- Text -->
									<div class="col overflow-hidden">
										<h5 class="text-truncate">
											<a href="#">E5419783-047D-4B4C-B30E-F24DD8247731.JPG</a>
										</h5>
										<ul class="list-inline m-0">
											<li class="list-inline-item"><small
												class="text-uppercase text-muted">100 KB</small></li>

											<li class="list-inline-item"><small
												class="text-uppercase text-muted">jpg</small></li>
										</ul>
									</div>
									<!-- Text -->

									<!-- Dropdown -->
									<div class="col-auto">
										<div class="dropdown">
											<a class="icon text-muted" href="#" role="button"
												data-bs-toggle="dropdown" aria-expanded="false"> <svg
													xmlns="http://www.w3.org/2000/svg" width="24" height="24"
													viewBox="0 0 24 24" fill="none" stroke="currentColor"
													stroke-width="2" stroke-linecap="round"
													stroke-linejoin="round"
													class="feather feather-more-vertical">
													<circle cx="12" cy="12" r="1"></circle>
													<circle cx="12" cy="5" r="1"></circle>
													<circle cx="12" cy="19" r="1"></circle></svg>
											</a>

											<ul class="dropdown-menu">
												<li><a class="dropdown-item d-flex align-items-center"
													href="#"> Download
														<div class="icon ms-auto">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-download">
																<path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
																<polyline points="7 10 12 15 17 10"></polyline>
																<line x1="12" y1="15" x2="12" y2="3"></line></svg>
														</div>
												</a></li>
												<li><a class="dropdown-item d-flex align-items-center"
													href="#"> Share
														<div class="icon ms-auto">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-share-2">
																<circle cx="18" cy="5" r="3"></circle>
																<circle cx="6" cy="12" r="3"></circle>
																<circle cx="18" cy="19" r="3"></circle>
																<line x1="8.59" y1="13.51" x2="15.42" y2="17.49"></line>
																<line x1="15.41" y1="6.51" x2="8.59" y2="10.49"></line></svg>
														</div>
												</a></li>
												<li><hr class="dropdown-divider"></li>
												<li><a
													class="dropdown-item d-flex align-items-center text-danger"
													href="#"> <span class="me-auto">Delete</span>
														<div class="icon">
															<svg xmlns="http://www.w3.org/2000/svg" width="24"
																height="24" viewBox="0 0 24 24" fill="none"
																stroke="currentColor" stroke-width="2"
																stroke-linecap="round" stroke-linejoin="round"
																class="feather feather-trash-2">
																<polyline points="3 6 5 6 21 6"></polyline>
																<path
																	d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
																<line x1="10" y1="11" x2="10" y2="17"></line>
																<line x1="14" y1="11" x2="14" y2="17"></line></svg>
														</div>
												</a></li>
											</ul>
										</div>
									</div>
									<!-- Dropdown -->
								</div>
							</li>
						</ul>
					</div>
					<!-- Files -->
				</div>
				<!-- Tabs: Content -->
			</div>
			<!-- Offcanvas Body -->
		</div>
	</div>
	<!-- Layout -->

	<!-- Modal: Invite -->
	<div class="modal fade" id="modal-invite" tabindex="-1"
		aria-labelledby="modal-invite" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-xl-down">
			<div class="modal-content">

				<!-- Modal: Body -->
				<div class="modal-body py-0">
					<!-- Header -->
					<div class="profile modal-gx-n">
						<div class="profile-img text-primary rounded-top-xl">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor"
								viewBox="0 0 400 140.74">
								<defs>
								<style>
.cls-2 {
	fill: #fff;
	opacity: 0.1;
}
</style></defs>
								<g>
								<g>
								<path d="M400,125A1278.49,1278.49,0,0,1,0,125V0H400Z" />
								<path class="cls-2"
									d="M361.13,128c.07.83.15,1.65.27,2.46h0Q380.73,128,400,125V87l-1,0a38,38,0,0,0-38,38c0,.86,0,1.71.09,2.55C361.11,127.72,361.12,127.88,361.13,128Z" />
								<path class="cls-2"
									d="M12.14,119.53c.07.79.15,1.57.26,2.34v0c.13.84.28,1.66.46,2.48l.07.3c.18.8.39,1.59.62,2.37h0q33.09,4.88,66.36,8,.58-1,1.09-2l.09-.18a36.35,36.35,0,0,0,1.81-4.24l.08-.24q.33-.94.6-1.9l.12-.41a36.26,36.26,0,0,0,.91-4.42c0-.19,0-.37.07-.56q.11-.86.18-1.73c0-.21,0-.42,0-.63,0-.75.08-1.51.08-2.28a36.5,36.5,0,0,0-73,0c0,.83,0,1.64.09,2.45C12.1,119.15,12.12,119.34,12.14,119.53Z" />
								<circle class="cls-2" cx="94.5" cy="57.5" r="22.5" />
								<path class="cls-2"
									d="M276,0a43,43,0,0,0,43,43A43,43,0,0,0,362,0Z" /></g></g></svg>

							<div class="position-absolute top-0 start-0 p-5">
								<button type="button"
									class="btn-close btn-close-white btn-close-arrow opacity-100"
									data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
						</div>

						<div class="profile-body">
							<div class="avatar avatar-lg">
								<span class="avatar-text bg-primary"> <svg
										xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round" class="feather feather-user-plus">
										<path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
										<circle cx="8.5" cy="7" r="4"></circle>
										<line x1="20" y1="8" x2="20" y2="14"></line>
										<line x1="23" y1="11" x2="17" y2="11"></line></svg>
								</span>
							</div>

							<h4 class="fw-bold mb-1">Invite your friends</h4>
							<p style="font-size: 16px;">Send invitation links to your
								friends</p>
						</div>
					</div>
					<!-- Header -->

					<hr class="hr-bold modal-gx-n my-0">

					<!-- Form -->
					<div class="modal-py">
						<form class="row gy-6">
							<div class="col-12">
								<label for="invite-email" class="form-label text-muted">E-mail</label>
								<input type="email" class="form-control form-control-lg"
									id="invite-email" placeholder="name@example.com">
							</div>

							<div class="col-12">
								<label for="invite-message" class="form-label text-muted">Message</label>
								<textarea class="form-control form-control-lg"
									id="invite-message" rows="3" placeholder="Custom message"></textarea>
							</div>
						</form>
					</div>
					<!-- Form -->

					<hr class="hr-bold modal-gx-n my-0">

					<!-- Button -->
					<div class="modal-py">
						<a href="#"
							class="btn btn-lg btn-primary w-100 d-flex align-items-center"
							data-bs-toggle="modal" data-bs-target="#invite-modal"> Send <span
							class="icon ms-auto"> <svg
									xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
									class="feather feather-chevron-right">
									<polyline points="9 18 15 12 9 6"></polyline></svg>
						</span>
						</a>
					</div>
					<!-- Button -->
				</div>
				<!-- Modal: Body -->

			</div>
		</div>
	</div>

	<!-- Modal: Profile -->
	<div class="modal fade" id="modal-profile" tabindex="-1"
		aria-labelledby="modal-profile" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-xl-down">
			<div class="modal-content">

				<!-- Modal body -->
				<div class="modal-body py-0">
					<!-- Header -->
					<div class="profile modal-gx-n">
						<div class="profile-img text-primary rounded-top-xl">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor"
								viewBox="0 0 400 140.74">
								<defs>
								<style>
.cls-2 {
	fill: #fff;
	opacity: 0.1;
}
</style></defs>
								<g>
								<g>
								<path d="M400,125A1278.49,1278.49,0,0,1,0,125V0H400Z" />
								<path class="cls-2"
									d="M361.13,128c.07.83.15,1.65.27,2.46h0Q380.73,128,400,125V87l-1,0a38,38,0,0,0-38,38c0,.86,0,1.71.09,2.55C361.11,127.72,361.12,127.88,361.13,128Z" />
								<path class="cls-2"
									d="M12.14,119.53c.07.79.15,1.57.26,2.34v0c.13.84.28,1.66.46,2.48l.07.3c.18.8.39,1.59.62,2.37h0q33.09,4.88,66.36,8,.58-1,1.09-2l.09-.18a36.35,36.35,0,0,0,1.81-4.24l.08-.24q.33-.94.6-1.9l.12-.41a36.26,36.26,0,0,0,.91-4.42c0-.19,0-.37.07-.56q.11-.86.18-1.73c0-.21,0-.42,0-.63,0-.75.08-1.51.08-2.28a36.5,36.5,0,0,0-73,0c0,.83,0,1.64.09,2.45C12.1,119.15,12.12,119.34,12.14,119.53Z" />
								<circle class="cls-2" cx="94.5" cy="57.5" r="22.5" />
								<path class="cls-2"
									d="M276,0a43,43,0,0,0,43,43A43,43,0,0,0,362,0Z" /></g></g></svg>

							<div class="position-absolute top-0 start-0 py-6 px-5">
								<button type="button"
									class="btn-close btn-close-white btn-close-arrow opacity-100"
									data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
						</div>

						<div class="profile-body">
							<div class="avatar avatar-xl">
								
							</div>

							<h4 class="mb-1">William Wright</h4>
							<p>last seen 5 minutes ago</p>
						</div>
					</div>
					<!-- Header -->

					<hr class="hr-bold modal-gx-n my-0">

					<!-- List -->
					<ul class="list-group list-group-flush">
						<li class="list-group-item">
							<div class="row align-items-center gx-6">
								<div class="col">
									<h5>Location</h5>
									<p>USA, Houston</p>
								</div>

								<div class="col-auto">
									<div class="btn btn-sm btn-icon btn-dark">
										<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
											viewBox="0 0 24 24" fill="none" stroke="currentColor"
											stroke-width="2" stroke-linecap="round"
											stroke-linejoin="round" class="feather feather-globe">
											<circle cx="12" cy="12" r="10"></circle>
											<line x1="2" y1="12" x2="22" y2="12"></line>
											<path
												d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
									</div>
								</div>
							</div>
						</li>

						<li class="list-group-item">
							<div class="row align-items-center gx-6">
								<div class="col">
									<h5>E-mail</h5>
									<p>william@studio.com</p>
								</div>

								<div class="col-auto">
									<div class="btn btn-sm btn-icon btn-dark">
										<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
											viewBox="0 0 24 24" fill="none" stroke="currentColor"
											stroke-width="2" stroke-linecap="round"
											stroke-linejoin="round" class="feather feather-mail">
											<path
												d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
											<polyline points="22,6 12,13 2,6"></polyline></svg>
									</div>
								</div>
							</div>
						</li>

						<li class="list-group-item">
							<div class="row align-items-center gx-6">
								<div class="col">
									<h5>Phone</h5>
									<p>1-800-275-2273</p>
								</div>

								<div class="col-auto">
									<div class="btn btn-sm btn-icon btn-dark">
										<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
											viewBox="0 0 24 24" fill="none" stroke="currentColor"
											stroke-width="2" stroke-linecap="round"
											stroke-linejoin="round" class="feather feather-phone-call">
											<path
												d="M15.05 5A5 5 0 0 1 19 8.95M15.05 1A9 9 0 0 1 23 8.94m-1 7.98v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
									</div>
								</div>
							</div>
						</li>
					</ul>
					<!-- List  -->

					<hr class="hr-bold modal-gx-n my-0">

					<!-- List -->
					<ul class="list-group list-group-flush">
						<li class="list-group-item">
							<div class="row align-items-center gx-6">
								<div class="col">
									<h5>Active status</h5>
									<p>Show when you're active.</p>
								</div>

								<div class="col-auto">
									<div class="form-check form-switch">
										<input class="form-check-input" type="checkbox"
											id="profile-status" checked> <label
											class="form-check-label" for="profile-status"></label>
									</div>
								</div>
							</div>
						</li>
					</ul>
					<!-- List -->

					<hr class="hr-bold modal-gx-n my-0">

					<!-- List -->
					<ul class="list-group list-group-flush">
						<li class="list-group-item"><a href="#" class="text-danger">Logout</a>
						</li>
					</ul>
					<!-- List -->
				</div>
				<!-- Modal body -->

			</div>
		</div>
	</div>

	<!-- Modal: User profile -->
	<div class="modal fade" id="modal-user-profile" tabindex="-1"
		aria-labelledby="modal-user-profile" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-fullscreen-xl-down">
			<div class="modal-content">

				<!-- Modal body -->
				<div class="modal-body py-0">
					<!-- Header -->
					<div class="profile modal-gx-n">
						<div class="profile-img text-primary rounded-top-xl">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor"
								viewBox="0 0 400 140.74">
								<defs>
								<style>
.cls-2 {
	fill: #fff;
	opacity: 0.1;
}
</style></defs>
								<g>
								<g>
								<path d="M400,125A1278.49,1278.49,0,0,1,0,125V0H400Z" />
								<path class="cls-2"
									d="M361.13,128c.07.83.15,1.65.27,2.46h0Q380.73,128,400,125V87l-1,0a38,38,0,0,0-38,38c0,.86,0,1.71.09,2.55C361.11,127.72,361.12,127.88,361.13,128Z" />
								<path class="cls-2"
									d="M12.14,119.53c.07.79.15,1.57.26,2.34v0c.13.84.28,1.66.46,2.48l.07.3c.18.8.39,1.59.62,2.37h0q33.09,4.88,66.36,8,.58-1,1.09-2l.09-.18a36.35,36.35,0,0,0,1.81-4.24l.08-.24q.33-.94.6-1.9l.12-.41a36.26,36.26,0,0,0,.91-4.42c0-.19,0-.37.07-.56q.11-.86.18-1.73c0-.21,0-.42,0-.63,0-.75.08-1.51.08-2.28a36.5,36.5,0,0,0-73,0c0,.83,0,1.64.09,2.45C12.1,119.15,12.12,119.34,12.14,119.53Z" />
								<circle class="cls-2" cx="94.5" cy="57.5" r="22.5" />
								<path class="cls-2"
									d="M276,0a43,43,0,0,0,43,43A43,43,0,0,0,362,0Z" /></g></g></svg>

							<div class="position-absolute top-0 start-0 p-5">
								<button type="button"
									class="btn-close btn-close-white btn-close-arrow opacity-100"
									data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
						</div>

						<div class="profile-body">
							<div class="avatar avatar-xl">
								

								<a href="#"
									class="badge badge-lg badge-circle bg-primary text-white border-outline position-absolute bottom-0 end-0">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round" class="feather feather-plus">
										<line x1="12" y1="5" x2="12" y2="19"></line>
										<line x1="5" y1="12" x2="19" y2="12"></line></svg>
								</a>
							</div>

							<h4 class="mb-1">William Wright</h4>
							<p>last seen 5 minutes ago</p>
						</div>
					</div>
					<!-- Header -->

					<hr class="hr-bold modal-gx-n my-0">

					<!-- List -->
					<ul class="list-group list-group-flush">
						<li class="list-group-item">
							<div class="row align-items-center gx-6">
								<div class="col">
									<h5>Location</h5>
									<p>USA, Houston</p>
								</div>

								<div class="col-auto">
									<div class="btn btn-sm btn-icon btn-dark">
										<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
											viewBox="0 0 24 24" fill="none" stroke="currentColor"
											stroke-width="2" stroke-linecap="round"
											stroke-linejoin="round" class="feather feather-globe">
											<circle cx="12" cy="12" r="10"></circle>
											<line x1="2" y1="12" x2="22" y2="12"></line>
											<path
												d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
									</div>
								</div>
							</div>
						</li>

						<li class="list-group-item">
							<div class="row align-items-center gx-6">
								<div class="col">
									<h5>E-mail</h5>
									<p>william@studio.com</p>
								</div>

								<div class="col-auto">
									<div class="btn btn-sm btn-icon btn-dark">
										<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
											viewBox="0 0 24 24" fill="none" stroke="currentColor"
											stroke-width="2" stroke-linecap="round"
											stroke-linejoin="round" class="feather feather-mail">
											<path
												d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
											<polyline points="22,6 12,13 2,6"></polyline></svg>
									</div>
								</div>
							</div>
						</li>

						<li class="list-group-item">
							<div class="row align-items-center gx-6">
								<div class="col">
									<h5>Phone</h5>
									<p>1-800-275-2273</p>
								</div>

								<div class="col-auto">
									<div class="btn btn-sm btn-icon btn-dark">
										<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
											viewBox="0 0 24 24" fill="none" stroke="currentColor"
											stroke-width="2" stroke-linecap="round"
											stroke-linejoin="round" class="feather feather-phone-call">
											<path
												d="M15.05 5A5 5 0 0 1 19 8.95M15.05 1A9 9 0 0 1 23 8.94m-1 7.98v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
									</div>
								</div>
							</div>
						</li>
					</ul>
					<!-- List -->

					<hr class="hr-bold modal-gx-n my-0">

					<!-- List -->
					<ul class="list-group list-group-flush">
						<li class="list-group-item">
							<div class="row align-items-center gx-6">
								<div class="col">
									<h5>Notifications</h5>
									<p>Enable sound notifications</p>
								</div>

								<div class="col-auto">
									<div class="form-check form-switch">
										<input class="form-check-input" type="checkbox"
											id="user-notification-check"> <label
											class="form-check-label" for="user-notification-check"></label>
									</div>
								</div>
							</div>
						</li>
					</ul>
					<!-- List -->

					<hr class="hr-bold modal-gx-n my-0">

					<!-- List -->
					<ul class="list-group list-group-flush">
						<li class="list-group-item"><a href="#" class="text-reset">Send
								Message</a></li>

						<li class="list-group-item"><a href="#" class="text-danger">Block
								User</a></li>
					</ul>
					<!-- List -->
				</div>
				<!-- Modal body -->

			</div>
		</div>
	</div>

	<!-- Modal: Media Preview -->
	<div class="modal fade" id="modal-media-preview" tabindex="-1"
		aria-hidden="true">
		<div
			class="modal-dialog modal-xl modal-dialog-centered modal-fullscreen-xl-down">
			<div class="modal-content">

				<!-- Modal: Header -->
				<div class="modal-header">
					<button type="button" class="btn-close btn-close-arrow"
						data-bs-dismiss="modal" aria-label="Close"></button>

					<div>
						<!-- Dropdown -->
						<div class="dropdown">
							<a class="icon text-muted" href="#" role="button"
								data-bs-toggle="dropdown" aria-expanded="false"> <svg
									xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
									class="feather feather-more-vertical">
									<circle cx="12" cy="12" r="1"></circle>
									<circle cx="12" cy="5" r="1"></circle>
									<circle cx="12" cy="19" r="1"></circle></svg>
							</a>

							<ul class="dropdown-menu">
								<li><a class="dropdown-item d-flex align-items-center"
									href="#"> Download
										<div class="icon ms-auto">
											<svg xmlns="http://www.w3.org/2000/svg" width="24"
												height="24" viewBox="0 0 24 24" fill="none"
												stroke="currentColor" stroke-width="2"
												stroke-linecap="round" stroke-linejoin="round"
												class="feather feather-download-cloud">
												<polyline points="8 17 12 21 16 17"></polyline>
												<line x1="12" y1="12" x2="12" y2="21"></line>
												<path
													d="M20.88 18.09A5 5 0 0 0 18 9h-1.26A8 8 0 1 0 3 16.29"></path></svg>
										</div>
								</a></li>
								<li><a class="dropdown-item d-flex align-items-center"
									href="#"> Share
										<div class="icon ms-auto">
											<svg xmlns="http://www.w3.org/2000/svg" width="24"
												height="24" viewBox="0 0 24 24" fill="none"
												stroke="currentColor" stroke-width="2"
												stroke-linecap="round" stroke-linejoin="round"
												class="feather feather-share-2">
												<circle cx="18" cy="5" r="3"></circle>
												<circle cx="6" cy="12" r="3"></circle>
												<circle cx="18" cy="19" r="3"></circle>
												<line x1="8.59" y1="13.51" x2="15.42" y2="17.49"></line>
												<line x1="15.41" y1="6.51" x2="8.59" y2="10.49"></line></svg>
										</div>
								</a></li>
								<li><hr class="dropdown-divider"></li>
								<li><a
									class="dropdown-item d-flex align-items-center text-danger"
									href="#"> <span class="me-auto">Delete</span>
										<div class="icon">
											<svg xmlns="http://www.w3.org/2000/svg" width="24"
												height="24" viewBox="0 0 24 24" fill="none"
												stroke="currentColor" stroke-width="2"
												stroke-linecap="round" stroke-linejoin="round"
												class="feather feather-trash-2">
												<polyline points="3 6 5 6 21 6"></polyline>
												<path
													d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
												<line x1="10" y1="11" x2="10" y2="17"></line>
												<line x1="14" y1="11" x2="14" y2="17"></line></svg>
										</div>
								</a></li>
							</ul>
						</div>
						<!-- Dropdown -->
					</div>
				</div>
				<!-- Modal: Header -->

				<!-- Modal: Body -->
				<div class="modal-body p-0">
					<div class="d-flex align-items-center justify-content-center h-100">
						<img class="img-fluid modal-preview-url" src="#" alt="#">
					</div>
				</div>
				<!-- Modal: Body -->

				<!-- Modal: Footer -->
				<div class="modal-footer">
					<div class="w-100 text-center">
						<h6>
							<a href="#">Marshall Wallaker</a>
						</h6>
						<p class="small">Today at 14:43</p>
					</div>
				</div>
				<!-- Modal: Footer -->
			</div>
		</div>
	</div>

	<!-- Scripts -->
	<script src="./assets/js/vendor.js"></script>
	<script src="./assets/js/template.js"></script>
</body>
</html>