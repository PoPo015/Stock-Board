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
                    <h1 class="page-header">아이디 찾기</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
							<div style="text-align:center">
<!-- 								<b>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</b><br> -->
								<b>가입하실때 입력하신 이메일주소와 이름이 동일하면, 작성하신 메일로 아이디를 전송합니다.</b><br>
								이름:
								<input type="text" id="userNm"><br>
								이메일:	
								<input type="text" id="userEmail">
								<span id="Certification">
									<button type="button" id="idFindBtn">전송</button>
								</span>
							</div>
                        </div>
                    </div>
                    
                </div>
            <!-- /.row -->

        </div>
        <!-- /#page-wrapper -->

    </div>
 </div>
    <!-- /#wrapper -->

<script>
$( document ).on("click", "#idFindBtn", function(){
		console.log("전송 클릭");
	
		if($("#userNm").val() === "undefined" || $("#userNm").val() === ""){
			$("#userNm").focus();
			alert("이름을 작성해주세요.");
			return false;
		}
		
		if($("#userEmail").val() === "undefined" || $("#userEmail").val() === ""){
			$("#userEmail").focus();
			alert("이메일을 작성해주세요.");
			return false;			
		}
		
		$("#idFindBtn").remove();
		
		$.ajax({
	        url: "/user/userFindId",
	        type: "post",
	        data: {
	           "userNm": $("#userNm").val(),
	           "userEmail" : $("#userEmail").val()
	        },
	        success: function(data) {
	        	console.log(data)
	        	if(data === "success"){
					alert("메일 전송완료. \n 메일을 확인해주세요.");
	        	}else{
	        		let str = '<button type="button" id="idFindBtn">전송</button>';
	        		$("#Certification").html(str);
	        		
	        		alert("입력하신 정보와 일치하는 정보가 없습니다. \n 정보를 확인해주세요");
	        	}
	        
	        },
	        error: function(error) {
				console.log("아이디 찾기 ajax 실패");
	        }
	   });
	
	});

</script>


</body>

</html>
