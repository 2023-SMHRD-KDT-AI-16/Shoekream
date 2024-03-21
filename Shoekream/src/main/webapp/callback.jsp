<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>네이버로그인</title>
  </head>
  <body>
  <%
    String clientId = "FAb4bunxl3DNMBTgbAkh";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "yTxKC3XSAN";//애플리케이션 클라이언트 시크릿값";
    String code = request.getParameter("code");
    String state = request.getParameter("state");
    String redirectURI = URLEncoder.encode("http://localhost:8081/Shoekream/callback.jsp", "UTF-8");
    String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
        + "&client_id=" + clientId
        + "&client_secret=" + clientSecret
        + "&redirect_uri=" + redirectURI
        + "&code=" + code
        + "&state=" + state;
    String accessToken = "";
    String refresh_token = "";
    try {
      URL url = new URL(apiURL);
      HttpURLConnection con = (HttpURLConnection)url.openConnection();
      con.setRequestMethod("GET");
      int responseCode = con.getResponseCode();
      BufferedReader br;
      
      if (responseCode == 200) { // 정상 호출
        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuilder res = new StringBuilder();
        while ((inputLine = br.readLine()) != null) {
          res.append(inputLine);
        }
        br.close();
        // 응답 데이터에서 토큰 값 추출
        String resStr = res.toString();
        int startIndex = resStr.indexOf("access_token\":\"") + "access_token\":\"".length();
        int endIndex = resStr.indexOf("\"", startIndex);
        accessToken = resStr.substring(startIndex, endIndex);
        out.println("액세스 토큰: " + accessToken);
      } else {  // 에러 발생
        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        String inputLine;
        StringBuilder errorRes = new StringBuilder();
        while ((inputLine = br.readLine()) != null) {
          errorRes.append(inputLine);
        }
        br.close();
        out.println("에러 발생: " + errorRes.toString());
      }
    } catch (Exception e) {
      // Exception 처리
      out.println("오류가 발생했습니다: " + e.getMessage());
      e.printStackTrace();
    }
    
    
    
 String profileURL = "https://openapi.naver.com/v1/nid/me";
    
    try {
      // URL 객체 생성
      URL url = new URL(profileURL);
      
      // HttpURLConnection 객체 생성
      HttpURLConnection con = (HttpURLConnection) url.openConnection();
      
      // 요청 메서드 설정
      con.setRequestMethod("GET");
      
      // 헤더 설정
      con.setRequestProperty("User-Agent", "curl/7.12.1 (i686-redhat-linux-gnu) libcurl/7.12.1 OpenSSL/0.9.7a zlib/1.2.1.2 libidn/0.5.6");
      con.setRequestProperty("Host", "openapi.naver.com");
      con.setRequestProperty("Pragma", "no-cache");
      con.setRequestProperty("Accept", "*/*");
      con.setRequestProperty("Authorization", "Bearer " + accessToken);
      
      // 응답 코드 확인
      int responseCode = con.getResponseCode();
      
      // 정상 응답인 경우
      if (responseCode == 200) {
        // BufferedReader를 사용하여 응답 내용 읽기
        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuilder response2 = new StringBuilder();
        
        // 응답 내용을 문자열로 읽기
        while ((inputLine = in.readLine()) != null) {
          response2.append(inputLine);
        }
        in.close();
        
        // Gson 객체 생성
        Gson gson = new Gson();
        
        // Json 문자열을 JsonObject로 변환
        JsonObject jsonObject = gson.fromJson(response2.toString(), JsonObject.class);
        
        // JsonObject에서 프로필 정보를 가져오기
        String id = jsonObject.getAsJsonObject("response").get("id").getAsString();
        String nickname = jsonObject.getAsJsonObject("response").get("nickname").getAsString();
        String name = jsonObject.getAsJsonObject("response").get("name").getAsString();
        String email=jsonObject.getAsJsonObject("response").get("email").getAsString();
        String profile_image=jsonObject.getAsJsonObject("response").get("profile_image").getAsString();
        
        // 이하 원하는 모든 필드를 가져와서 변수에 저장
        
        // 가져온 정보를 화면에 출력
        out.println("아이디: " + id);
        out.println("닉네임: " + nickname);
        out.println("이름: " + name);
       out.println("이메일: " + email);
       out.println("프로필 이미지"+profile_image);
      } else {
        // 에러 응답인 경우
        out.println("에러 응답 코드: " + responseCode);
      }
    } catch (Exception e) {
      // 예외 처리
      out.println("오류가 발생했습니다: " + e.getMessage());
      e.printStackTrace();
    }
   
  %>
  </body>
</html>