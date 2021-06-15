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
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>	<!-- 다음 주소 api -->
	 <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>	<!-- 네이버로그인 api -->
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
                    <h1 class="page-header">회원가입</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-body">
					<!-- 회원가입 정보 -->
					<form class="form-horizontal" name="frm" id="frm" action="/user/create" method="post">
					     <div class="form-group">
					       <label for="userId" class="col-sm-3 control-label">
					       	아이디</label><strong id="idAjaxCheck" style="color:red"></strong>
					       <div class="col-sm-7">
					         <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디를 입력하세요" maxlength="12">
					       </div>
					     </div>


					     <div class="form-group">
					       <label for="userPw" class="col-sm-3 control-label">
					     	   패스워드</label>
					       <div class="col-sm-7">
					         <input type="password" class="form-control" id="userPw" name="userPw" placeholder="Password(숫자+영문자+특수문자포함)" maxlength="15"><br>
					         <input type="password" class="form-control" id="userPwCheck" placeholder="Password 확인" maxlength="15">
					       </div>
					     </div>

					     <div class="form-group">
					       <label for="userNm" class="col-sm-3 control-label">
					   		     이름</label>
					       <div class="col-sm-7">
					         <input type="text" class="form-control" id="userNm" name="userNm" placeholder="이름을 입력하세요" maxlength="20">
					       </div>
					     </div>

					     <div class="form-group">
					       <label for="userEmail" class="col-sm-3 control-label">
					     		이메일</label><strong id="emailAjaxCheck" style="color:red"></strong>
					       <div class="col-sm-7">
					         <input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="Example@Naver.com">
					       </div>
					     </div>

					     <div class="form-group">
					       <label for="userPhone" class="col-sm-3 control-label">연락처</label>
					       <div class="col-sm-7">
					         <input type="text" class="read form-control" id="userPhone" name="userPhone" placeholder="연락처(클릭해주세요!)"  style="background: white">
					       </div>
					     </div>
					   <!-- id,name공백 -->
					     <div class="form-group">
					       <label for="" class="col-sm-3 control-label">주소</label>
					       <div class="col-sm-7">
					         <input type="text" class="form-control" id="addressZipCode" name="addressZipCode" placeholder="우편 번호" readonly style="width:30%; display:inline; background: white">
					         <button type="button" id="addressFind">우편번호 찾기</button>
      					     <input type="text" class="form-control" id="addressRoadName" name="addressRoadName" placeholder="기본주소" readonly style="background: white">
					      	 <input type="text" class="form-control" placeholder="동" id="addressSimple" readonly style="width:30%; display:inline; background: white" >
    					     <input type="text" class="form-control" id="addressDetailed" name="addressDetailed" placeholder="상세주소" style="width:65%; display:inline">
					       </div>
					     </div>
							
														
					     <div class="form-group">
					       <div class="col-sm-offset-2 col-sm-10">
					         <button type="button" class="btn btn-primary" id="createUser">회원가입</button>
					         <button type="button" class="btn btn-default">취소</button>
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
var regExpId= /^[A-za-z0-9]{4,12}$/; //id 형식 체크 정규식 대,소문자,숫자 12자리미만
var regExpEm = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; //이메일주소 형식 체크 정규식
var regExpPw = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; // 특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내의 암호 정규식
var certification = true; //연락처 인증을위한 변수
var idChk = false; 		//아이디 중복여부 체크를 위한변수
var emailChk = false; 	//이메일 중복여부 체크를 위한 변수

//id 정규식검증
$("#userId").change(function() {
	console.log("id 변경사항있음.");
	if(!regExpId.test($("#userId").val())){
		$("#userId").focus();
		alert("아이디를 확인해주세요")
		$("#idAjaxCheck").empty();
		idChk = false;
		return false;
	}
	
    $.ajax({
        url: "/user/createIdAndEmailCheck",
        type: "post",
        data: {
           "userId": $("#userId").val()
        },
        success: function(data) {
			console.log(data);
			console.log(typeof data);
			if(data === 0){
				$("#idAjaxCheck").html("사용가능한 아이디입니다");
				idChk = true;
			}else{
				$("#idAjaxCheck").html("중복된 아이디입니다.");
				$("#idAjaxCheck").focus();
				idChk = false;
			}
			
        },
        error: function(error) {
         console.log("실패");
        }
   });
});

//pw 정규식검증
$("#userPw").change(function() {
	console.log("pw 변경사항있음.");
	if(!regExpPw.test($("#userPw").val())){
		$("#userPw").focus();
		alert("비밀번호를 확인해주세요")
	}
});

//pwcheck 확인
$("#userPwCheck").change(function() {
	console.log("pw체크 변경사항있음.");
	if($("#userPw").val() !== $("#userPwCheck").val()){
		$("#userPwCheck").focus();
		alert("입력한 패스워드가 다릅니다. 확인해주세요")
	}
});
//email 정규식 검증
$("#userEmail").change(function() {
	console.log("email체크 변경사항있음.");
	if(!regExpEm.test($("#userEmail").val())){
		$("#userEmail").focus();
		alert("이메일을 확인해주세요")
		$("#emailAjaxCheck").empty();
		emailChk = false;
		return false;
	}
	
    $.ajax({
        url: "/user/createIdAndEmailCheck",
        type: "post",
        data: {
           "userEmail": $("#userEmail").val()
        },
        success: function(data) {
        	console.log("이메일 성공");
			console.log(typeof data);
			if(data === 0){
				$("#emailAjaxCheck").html("사용가능한 이메일입니다");
				emailChk = true;
			}else{
				$("#emailAjaxCheck").html("중복된 이메일입니다.");
				$("#emailAjaxCheck").focus();
				emailChk = false;
			}
			
        },
        error: function(error) {
         console.log("실패");
        }
   });
	
});

//회원가입 전송 
$("#createUser").click(function(){
	
	if(confirm("회원가입을 하시겠습니까?") === true){
	
		if(idChk === true && emailChk === true && certification === true){
			$("#frm").submit();
		}else{
			alert("가입 정보를 다시 확인해주세요.");
		}
		
	}
	
});

// 연락처 팝업창 생성 
// $("#userPhone").click(function(){
	
//  		var popWidth = 450, popHeight = 280;				// 팝업 창 사이즈
// 		var mtWidth = document.body.clientWidth; 			// 현재 브라우저가 있는 모니터의 화면 폭 사이즈
// 		var mtHeight = document.body.clientHeight;			// 현재 브라우저가 있는 모니터의 화면 높이 사이즈
// 		var scX = window.screenLeft;						// 현재 브라우저의 x 좌표(모니터 두 대를 합한 총 위치 기준)
// 		var scY = window.screenTop;							// 현재 브라우저의 y 좌표(모니터 두 대를 합한 총 위치 기준)

// 		var popX = scX + (mtWidth - popWidth) / 2 - 50;		// 팝업 창을 띄울 x 위치 지정(모니터 두 대를 합한 총 위치 기준)
// 		var popY = scY + (mtHeight - popHeight) / 2 - 50;	// 팝업 창을 띄울 y 위치 지정(모니터 두 대를 합한 총 위치 기준)
// 		var url = "<c:url value='/st/send/phoneSendPop.do' />";
// 		var option = "width=" + popWidth + ", height=" + popHeight + ", left=" + popX + ", top=" + popY + ",scrollbars=yes, resizeable=no, menubar=no, status=no, toolbar=no";
// 		var win = window.open(url, "windowPop", option);
// 		win.focus();

// });

// 자식창에서 부모 스크립트 호출> 데이터삽입
// function setParentInput(childParam){
	
// 	$("#userPhone").val(childParam);
// 	certification = true;
	
// }

//주소 api 호출
$("#addressFind").click(function() {
	console.log("주소api클릭");

    new daum.Postcode({
        oncomplete: function(data) {
        	   // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("addressSimple").value = extraAddr;

            } else {
                document.getElementById("addressSimple").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('addressZipCode').value = data.zonecode;
            document.getElementById("addressRoadName").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("addressDetailed").focus();

        }
    }).open();
});





</script>

</body>

</html>
