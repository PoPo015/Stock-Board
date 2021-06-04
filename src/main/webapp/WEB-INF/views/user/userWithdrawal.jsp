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
						<button class="btn btn-primary" onclick="location.href='/user/pwChange'" style="display:block; width:100%">비밀번호 변경</button>
						<button class="btn btn-danger" onclick="location.href='/user/withdrawal'" style="display:block; width:100%;">회원 탈퇴</button>

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
</body>

</html>
