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
					       <label for="remember_me">
							 <input type="checkbox" id="remember_me">로그인유지
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
						<button>네이버 로그인</button>
						<button>구글 로그인</button>
						<button>카카오 로그인</button>
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
$(function(){
    var responseMessage = "<c:out value="${err}" />";
    
    if(responseMessage !== ""){
        alert("${err}");
    }
}) 


</script>

</body>

</html>
