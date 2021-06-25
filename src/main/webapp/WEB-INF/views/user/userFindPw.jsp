<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/common.jsp" %>

<!DOCTYPE html>
<html lang="en">

<head>
	

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
                    <h1 class="page-header">비밀번호 찾기</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
					<!-- 회원가입 정보 -->
					<form class="form-horizontal" name="frm" id="frm" action="/user/login" method="post">
					<p>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</p>
					이름:
						<input type="text">
					이메일 주소:	
						<input type="text">

					</form>
					
                        </div>
                    </div>
                    
                </div>
            <!-- /.row -->

        </div>
        <!-- /#page-wrapper -->

    </div>
 </div>
    <!-- /#wrapper -->

</body>

</html>
