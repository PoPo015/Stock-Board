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
							<h1 style="text-align: center">회원 탈퇴시 아래의 조치가 취해집니다.</h1>
								<ul>
									<li>회원 탈퇴 일로부터 계정과 닉네임을 포함한 계정 정보(아이디/이메일/닉네임)는 '개인 정보 보호 정책'에 따라 7일간 보관(잠김) 되며, 7일이 경과된 후에는 모든 개인 정보는 완전히 삭제되며 더 이상 복구할 수 없게 됩니다
									<li>작성된 게시물은 삭제되지 않으며, 익명처리 후 PoPo로 소유권이 귀속됩니다.
									<li>게시물 삭제가 필요한 경우에는 관리자(kst005109@naver.com)로 문의해 주시기 바랍니다.
								</ul>
								<form>
								<input type="password" class="form-control" id="userPw" name="userPw" placeholder="탈퇴를 원할시 ,현재패스워드를 입력해주세요."><br><br>
								</form>
						<button class="btn btn-primary" onclick="location.href='/user/myPage'" style="display:block; width:100%">아니오</button>
						<button class="btn btn-danger" onclick="userWithdrawl()" style="display:block; width:100%;">예, 탈퇴하겠습니다.</button>

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
	
	
	if(confirm("정말 회원 탈퇴 하시겠습니까?")){
		let userPw = $("#userPw").val();
		console.log("진짜눌러버렸다.." + userPw);
		
		$.ajax({
			url : "/user/withdrawal",
			type: "post",
			async: false,						//동기방식 여기부터 해야함. (동기 = 이작업이 끝나야 다른작업가능  ,비동기 = 백으로 돌려서 할수있음)
			success: function(data){
				console.log("성공");				
			},
			error: function(error){
				console.log("실패");
			}
		})
	}
}
</script>
    
    
</body>

</html>
