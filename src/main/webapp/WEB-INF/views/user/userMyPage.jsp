 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/common.jsp" %>

<!DOCTYPE html>
<html lang="en">

<head>

	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>SB Admin 2 - Bootstrap Admin Theme</title>

<style>
	.btn-block{
	display:block; 
	width:100%;
	}

</style>

</head>

<body>
    <div id="wrapper">

	<!-- 네비게이션바 -->
	<%@include file="../common/navbar.jsp" %>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">마이페이지</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-body">
					<!-- 회원가입 정보 -->
					<form class="form-horizontal" name="frm" id="frm" action="/user/myPage" method="post">
					     <div class="form-group">
					       <label for="userId" class="col-sm-3 control-label">
					       	아이디</label><strong id="idAjaxCheck" style="color:red"></strong>
					       <div class="col-sm-7">
					         <input type="text" class="form-control" id="userId" name="userId" maxlength="12" value="${userId}" readonly>
					       </div>
					     </div>

					     <div class="form-group">
					       <label for="userNm" class="col-sm-3 control-label">
					   		     이름</label>
					       <div class="col-sm-7">
					         <input type="text" class="form-control" id="userNm" name="userNm" maxlength="20" value="${userNm}">
					       </div>
					     </div>

					     <div class="form-group">
					       <label for="userEmail" class="col-sm-3 control-label">
					     		이메일</label><strong id="emailAjaxCheck" style="color:red"></strong>
					       <div class="col-sm-7">
					         <input type="email" class="form-control" id="userEmail" name="userEmail" value="${userEmail}">
					       </div>
					     </div>

					     <div class="form-group">
					       <label for="userPhone" class="col-sm-3 control-label">연락처</label>
					       <div class="col-sm-7">
					         <input type="text" class="read form-control" id="userPhone" name="userPhone" style="background: white" value="${userPhone}">
					       </div>
					     </div>
					   <!-- id,name공백 -->
					     <div class="form-group">
					       <label for="" class="col-sm-3 control-label">주소</label>
					       <div class="col-sm-7">
					         <input type="text" class="form-control" id="addressZipCode" name="addressZipCode" placeholder="우편 번호" readonly style="width:30%; display:inline; background: white" value="${addressZipCode}">
					         <button type="button" id="addressFind">우편번호 찾기</button>
      					     <input type="text" class="form-control" id="addressRoadName" name="addressRoadName" placeholder="기본주소" readonly style="background: white" value="${addressRoadName}">
					      	 <input type="text" class="form-control" placeholder="동" id="addressSimple" readonly style="width:30%; display:inline; background: white" >
    					     <input type="text" class="form-control" id="addressDetailed" name="addressDetailed" placeholder="상세주소" style="width:65%; display:inline" value="${addressDetailed}">
					       </div>
					     </div>
							
														
					     <div class="form-group">
					       <div class="col-sm-offset-2 col-sm-10">
					         <button type="button" class="btn btn-primary" id="createUser">정보 수정</button>
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
						<button class="btn btn-info btn-block" onclick="location.href='/user/pwChange'">비밀번호 변경</button>
						<button class="btn btn-default btn-block" onclick="location.href='/user/withdrawal'">회원 탈퇴</button>

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


<script>
</script>


<script>
const regExpId= /^[A-za-z0-9]{4,12}$/; //id 형식 체크 정규식 대,소문자,숫자 12자리미만
const regExpEm = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; //이메일주소 형식 체크 정규식
const regExpPw = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; // 특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내의 암호 정규식
var certification = true; //연락처 인증을위한 변수
var emailChk = true; 	//이메일 중복여부 체크를 위한 변수

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
	
	if(confirm("정보를 수정 하시겠습니까?") === true){
	
		if(emailChk === true && certification === true){
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
