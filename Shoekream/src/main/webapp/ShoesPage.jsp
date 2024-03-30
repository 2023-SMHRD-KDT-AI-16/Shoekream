<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="CSS/ShoesPage.css">
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
                <div class="photo"><img src="" alt="신발사진" style="width: 640px;">
                </div>
                <div class="right">
                    <h1>shoesname</h1>
                    <br>

                    <!-- 프로필 네임 안에 user_name? user_nickname? -->
                    <ul>
                        <h5><span>brand</span><br> <span>price</span><br> </h5> 
                    </ul>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="grid-container">
                <!-- 신발 상세페이지 게시물  -->
                <div class="my_post1"><img src="/MAIN/img/KakaoTalk_20240319_123914465.jpg" alt="사진" 
                ></div>
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