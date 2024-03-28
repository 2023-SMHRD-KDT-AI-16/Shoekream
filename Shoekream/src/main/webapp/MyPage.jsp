<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./MAIN/CSS/MyPage.css">
    <style>
        /* 추가한 스타일 */
        .hidden {
            display: none;
        }
    </style>
</head>

<body>
    <input type="checkbox" id="menuicon">
    <header>
        <div>
            <ul class="navi">
                <!-- 메뉴아이콘 -->
                <label for="menuicon" class="menubtn">
                    <span></span>
                    <span></span>
                    <span></span>
                </label>
                <li class="logo"><a>SHOEKREAM</a> </li>
            </ul>
        </div>
    </header>
    <div class="container">
        <div id="profile_wrap">
            <div class="profile_box1">
                <div class="photo"><img src="/MAIN/img/299400862_433066862176075_265719782033185215_n.jpg" alt="기본프로필">
                </div>
                <div class="right">
                    <h1>profile name<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" style="fill: rgba(0, 0, 0, 1); margin-left: 100px;"><path d="M12 16c2.206 0 4-1.794 4-4s-1.794-4-4-4-4 1.794-4 4 1.794 4 4 4zm0-6c1.084 0 2 .916 2 2s-.916 2-2 2-2-.916-2-2 .916-2 2-2z"></path><path d="m2.845 16.136 1 1.73c.531.917 1.809 1.261 2.73.73l.529-.306A8.1 8.1 0 0 0 9 19.402V20c0 1.103.897 2 2 2h2c1.103 0 2-.897 2-2v-.598a8.132 8.132 0 0 0 1.896-1.111l.529.306c.923.53 2.198.188 2.731-.731l.999-1.729a2.001 2.001 0 0 0-.731-2.732l-.505-.292a7.718 7.718 0 0 0 0-2.224l.505-.292a2.002 2.002 0 0 0 .731-2.732l-.999-1.729c-.531-.92-1.808-1.265-2.731-.732l-.529.306A8.1 8.1 0 0 0 15 4.598V4c0-1.103-.897-2-2-2h-2c-1.103 0-2 .897-2 2v.598a8.132 8.132 0 0 0-1.896 1.111l-.529-.306c-.924-.531-2.2-.187-2.731.732l-.999 1.729a2.001 2.001 0 0 0 .731 2.732l.505.292a7.683 7.683 0 0 0 0 2.223l-.505.292a2.003 2.003 0 0 0-.731 2.733zm3.326-2.758A5.703 5.703 0 0 1 6 12c0-.462.058-.926.17-1.378a.999.999 0 0 0-.47-1.108l-1.123-.65.998-1.729 1.145.662a.997.997 0 0 0 1.188-.142 6.071 6.071 0 0 1 2.384-1.399A1 1 0 0 0 11 5.3V4h2v1.3a1 1 0 0 0 .708.956 6.083 6.083 0 0 1 2.384 1.399.999.999 0 0 0 1.188.142l1.144-.661 1 1.729-1.124.649a1 1 0 0 0-.47 1.108c.112.452.17.916.17 1.378 0 .461-.058.925-.171 1.378a1 1 0 0 0 .471 1.108l1.123.649-.998 1.729-1.145-.661a.996.996 0 0 0-1.188.142 6.071 6.071 0 0 1-2.384 1.399A1 1 0 0 0 13 18.7l.002 1.3H11v-1.3a1 1 0 0 0-.708-.956 6.083 6.083 0 0 1-2.384-1.399.992.992 0 0 0-1.188-.141l-1.144.662-1-1.729 1.124-.651a1 1 0 0 0 .471-1.108z"></path></svg></h1>
                    <!-- 프로필 네임 안에 user_name? user_nickname? -->
                    <ul>
                        <h5><span>게시글 6</span> <span>팔로워 150</span> <span>팔로우 13</span> </h5> 
                    </ul>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="grid-container">
                <!-- 마이페이지 게시물  -->
                <div class="my_post1"><img src="/MAIN/img/KakaoTalk_20240319_123914465.jpg" alt="사진"></div>
                <div class="my_post2"><img src="/MAIN/img/299400862_433066862176075_265719782033185215_n.jpg" alt="사진"></div>
                <div class="my_post3"><img src="" alt="사진"></div>
                <div class="my_post4"><img src="" alt="사진"></div>
                <div class="my_post5"><img src="" alt="사진"></div>
                <div class="my_post6"><img src="" alt="사진"></div>

            </div>
        </div>
        <!-- 여기에 script 사용해서 게시물 여부에 따라 출력할지 지정  -->
    </div>
    <div class="sidebar">
        <span class="area_desc">SIDEBAR영역</span>
        <input type="checkbox" name="accordion" id="answer00">
        <label for="answer00"> <input type="text" placeholder="검색"><em></em></label>
        <input type="checkbox" name="accordion" id="answer01">
        <label for="answer01">홈<em></em></label>
        <div>
            <p>여기에 내용</p>
        </div>
        <input type="checkbox" name="accordion" id="answer02">
        <label for="answer02">게시글작성<em></em></label>
        <div>
            <p>여기에 내용</p>
        </div>
        <input type="checkbox" name="accordion" id="answer03">
        <label for="answer03">채팅<em></em></label>
        <div>
            <p>여기에 내용</p>
        </div>
        <input type="checkbox" name="accordion" id="answer04">
        <label for="answer04">알림<em></em></label>
        <div>
            <p>여기에 내용</p>
        </div>
        <input type="checkbox" name="accordion" id="answer05">
        <label for="answer05">프로필<em></em></label>
        <div>
            <p>여기에 내용</p>
        </div>
    </div>
</body>

</html>