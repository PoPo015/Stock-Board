<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>

<%@include file="../common/common.jsp" %>

<!DOCTYPE html>
<html lang="en">

<head>
	
	<script src="https://apis.google.com/js/platform.js" async defer></script> <!-- 구글 api -->
	<meta name="google-signin-client_id" content="821344491779-sgqahrsao6njue7ahrhl4b4daauraeor.apps.googleusercontent.com"> <!-- 구글 api -->
	 <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>	<!-- 네이버로그인 api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- 다음주소api -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>SB Admin 2 - Bootstrap Admin Theme</title>

</head>

<body>
    <div id="wrapper">

	<!-- 네비게이션바 -->
	<%@include file="../common/navbar.jsp" %>
    
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">로그인</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-body">
					<!-- 회원가입 정보 -->
					<form class="form-horizontal" name="frm" id="frm" action="/user/login" method="post">
					     <div class="form-group">
					       <label for="userId" class="col-sm-3 control-label">
					       	 아이디</label>
					       <div class="col-sm-4">
					         <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디를 입력하세요" maxlength="12" required value="${Id}">
					       </div>
					     </div>

					     <div class="form-group">
					       <label for="userPw" class="col-sm-3 control-label">
					       	 패스워드</label>
					       <div class="col-sm-4">
					         <input type="password" class="form-control" id="userPw" name="userPw" placeholder="Password" maxlength="15" required value="${Pw}">
					       </div>
					     </div>

					     <div class="form-group">
					       <div class="col-md-6 col-md-offset-3">
					       <label for="rememberMe">
							 <input type="checkbox" id="rememberMe" name="rememberMe" value="true">로그인유지
						   </label>
							 <br>
					         <button type="submit" class="btn btn-primary" id="loginClick"style='padding: 6px 95px'>로그인</button>
						<div>
					       <a href="#">계정찾기</a>
					       <span>/</span>
					       <a href="/user/create">회원가입</a>
						</div>
					         
					       </div>
					     </div>
					   </form>
                        </div>
                    </div>
                    
                </div>
               <div class="col-lg-5">
                    <div class="panel panel-default">
                        <div class="panel-body">
						<!-- 카카오로그인 -->
						<div>
							<a id="custom-login-btn" href="javascript:loginWithKakao()">
								<img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="222" />
							</a>
						</div>
						<!-- 카카오로그인  -->
							
						<!-- 네이버 로그인 -->
						  <%
						    String clientId = "WDXIVy7CxYf0BQJY6pfh";//애플리케이션 클라이언트 아이디값";
						    String redirectURI = URLEncoder.encode("http://124.59.10.246:5109/user/naverLogin", "UTF-8");	//여기있는 url 컨트롤러로 보내고, controller에서 매핑받아 callback.jsp로 보내서 검증하는것, url이 중요함
						    SecureRandom random = new SecureRandom();
						    String state = new BigInteger(130, random).toString();
						    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
						    apiURL += "&client_id=" + clientId;
						    apiURL += "&redirect_uri=" + redirectURI;
						    apiURL += "&state=" + state;
						    session.setAttribute("state", state);
 						%>
 						<div>
						  <a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
						</div>
						<!--  네이버 로그인 -->
						
						<!-- 구글 로그인(히든값은 구글은 로그인되있으면 자동로그인되서 체크를 위해 히든값추가) -->
                        <div>
                        	<input type="hidden" id="googleToken" value="">
                        	<input type="hidden" id="googlebtn" value="">                        
							<div class="g-signin2" data-onsuccess="onSignIn" id="googleLogin"></div>
                        </div>
                        <!--  구글로그인 -->
                        </div>
                    </div>
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->

        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

<!-- sns로그인 api -->
<script src="/resources/js/snsLogin.js"></script>

<script>
$(function(){
    var responseMessage = "<c:out value="${err}" />";
    
    if(responseMessage !== ""){
        alert("${err}");
    }
}) 


</script>

</body>

</html>
