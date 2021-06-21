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

</head>

<body>
    <div id="wrapper">

	<!-- 네비게이션바 -->
	<%@include file="../common/navbar.jsp" %>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">비밀번호변경</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
<!--             <div class="row"> -->
<!--                 <div class="col-lg-12"> -->
<!--                     <div class="panel panel-default"> -->
<!--                         <div class="panel-body"> -->
<!-- <!-- 					회원가입 정보 --> 
<!-- 					         <div class="form-group"> -->
<!-- 					         <input type="text" class="form-control" id="userId" name="userId" maxlength="12"> -->
<!-- 					         </div> -->
<!-- 					         <div class="form-group"> -->
<!-- 					         <input type="text" class="form-control" id="userId" name="userId" maxlength="12"> -->
<!-- 					         </div> -->
<!-- 					         <div class="form-group"> -->
<!-- 					         <input type="text" class="form-control" id="userId" name="userId" maxlength="12"> -->
<!-- 							 </div>		          -->
<!-- 					     <div class="form-group"> -->
<!-- 					       <div class="col-sm-offset-2 col-sm-10"> -->
<!-- 					         <button type="button" class="btn btn-primary" id="createUser">정보 수정</button> -->
<!-- 					         <button type="button" class="btn btn-default">취소</button> -->
<!-- 					       </div> -->
<!-- 					    </div> -->
                       
<!--                       </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--                 /.col-lg-6 -->
<!--             </div> -->

	<div class="col-sm-8 col-sm-offset-2">
        <div class="panel panel-default panel-margin-10">
        <form id="frm" action="/user/pwChange" method="post">
            <div class="panel-body panel-body-content text-center">
                <p class="lead">변경하실 비밀번호를 입력해 주세요.</p>
                <div class="form-group">
                    <input type="password" name="userPw" id="userPw" class="form-control form-control-inline text-center" placeholder="현재 비밀번호">
                </div>
                <div class="form-group">
                    <input type="password" name="newPassword" id="password" class="form-control form-control-inline text-center" placeholder="새 비밀번호">
                </div>
                <div class="form-group">
                    <input type="password" name="passwordConfirm" class="form-control form-control-inline text-center" placeholder="새 비밀번호 확인">
                </div>
                <button type="button" class="btn btn-primary" onclick="pwChange()">비밀번호 변경</button> 
                <a href="/user/myPage" class="btn btn-default">취소</a>
            </div>
       </form>
        </div>
    </div>

            <!-- /.row -->

        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

<script>
var regExpPw = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; // 특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내의 암호 정규식

/* 	//pw 정규식검증
	$("#userPw").change(function() {
		console.log("pw 변경사항있음.");
		if(!regExpPw.test($("#userPw").val())){
			$("#userPw").focus();
			alert("비밀번호를 확인해주세요");
			return false;
		}
	});

	//pwcheck 확인
	$("#passwordConfirm").change(function() {
		console.log("pw체크 변경사항있음.");
		if($("#newPassword").val() !== $("#passwordConfirm").val()){
			$("#passwordConfirm").focus();
			alert("입력한 패스워드가 다릅니다. 확인해주세요");
			return false;
		}
	});
	 */
	
	//공백 검증 코드 필요
function pwChange(){

	if(!regExpPw.test($("#userPw").val())){
		$("#userPw").focus();
		alert("비밀번호를 확인해주세요");
		return false;
	}
//임시 주석	
// 	if(!regExpPw.test($("newPassword").val())){
// 		$("#newPaasword").focus();
// 		alert("새 비밀번호를 확인해주세요. \n 비밀번호는 특수문자,영문자,숫자가 포함된 8글자 이상입니다.");
// 		return false;
// 	}
	
	if($("#newPassword").val() !== $("#passwordConfirm").val()){
		$("#passwordConfirm").focus();
		alert("입력한 패스워드가 다릅니다. 확인해주세요");
		return false;
	}
		
		$("#frm").submit();
}

</script>


</body>

</html>
