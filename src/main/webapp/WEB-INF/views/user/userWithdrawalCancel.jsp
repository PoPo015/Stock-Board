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
                    <h1 class="page-header">회원탈퇴</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
							<h1 style="text-align: center">회원탈퇴 예약된 계정입니다.</h1>
								<ul>
									<U><li><fmt:formatDate value="${userRegWithdrawal}" pattern="MM월 dd일"/>에 회원탈퇴됩니다.</li></U>
									<li>회원 탈퇴를 철회 하시려면 현재 비밀번호를 입력해주세요.</li>
								</ul>
						<input type="password" class="form-control" id="userPw" name="userPw" placeholder="탈퇴 철회시 ,현재패스워드를 입력해주세요."><br><br>
						<button class="btn btn-primary" onclick="location.href='/notices/list'" style="display:block; width:100%">아니오</button>
						<button class="btn btn-danger" onclick="userWithdrawl()" style="display:block; width:100%;">탈퇴를 철회하겠습니다.</button>

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
function userWithdrawl(){
	
	if(confirm("정말 회원탈퇴를 철회하시겠습니까?")){
		
		$.ajax({
			url : "/user/withdrawalCancel",
			type: "post",
			contentType : "application/json; charset=utf-8",
			async: false,						//동기방식  (동기 = 이작업이 끝나야 다른작업가능  ,비동기 = 백으로 돌려서 할수있음)
			data : JSON.stringify({
				"userPw": $("#userPw").val()
			}),
			success: function(data){
				console.log("회원탈퇴철회 성공");
				console.log(data);
				
				if(data === "success"){
					alert("회원탈퇴 철회 성공");
					location.href = "/user/myPage";
				}else{
					alert("비밀번호를 확인해주세요");
				}
			},
			error: function(error){
				console.log("회원탈퇴철회 실패");
			}
		})
	}
}
</script>
    
    
</body>

</html>
