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
								<b>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</b><br>
								이름:
								<input type="text" id="userNm"><br>
								이메일:	
								<input type="text" id="userEmail">
								<button type="button" id="idFindBtn">인증번호 받기</button>
									<!-- 이메일 인증 동적생성 -->
									<div id="Certification">
									
									</div>
								
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
	$("#idFindBtn").click(function(){
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
					$("#idFindBtn").remove();
	        		console.log("아이디 찾기 ajax성공");
					let str = "<input type='text' placeholder='인증번호를 입력하세요' id=''>"
						str += "<button type='button'>확인</button>"
		        	
						$("#Certification").html(str);
	        	}else{
	        		alert("입력하신 정보와 일치하는 정보가 없습니다 \n 정보를 확인해주세요")
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
