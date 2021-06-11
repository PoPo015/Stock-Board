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
	<!-- common.jsp파일로 사용 -->
<!--     Bootstrap Core CSS -->
<%--     <link href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"> --%>

<!--     Custom CSS -->
<%--     <link href="${pageContext.request.contextPath}/resources/dist/css/sb-admin-2.css" rel="stylesheet"> --%>

<!--     Custom Fonts -->
<%--     <link href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"> --%>

<!--     MetisMenu CSS -->
<%--     <link href="${pageContext.request.contextPath}/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet"> --%>


    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->


<style type="text/css">
	
	.width{
		width: 90%;
	}
	
	.right{
		float:right;
	}	

</style>


</head>

<body>


	<!-- 네비게이션바 -->
	<%@include file="../common/navbar.jsp" %>
	
	   <div id="page-wrapper" >
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">공지사항 상세보기</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
					<!-- 부트스트랩 상세보기 -->
							<div class="panel panel-default">
								<div class="panel-heading clearfix">
									<span> 
									<a href="#"><c:out value="${details.writer}" /></a>
									
										<i class="fa fa-eye right">
										<c:out value="${details.viewsCount}" />
										</i>&nbsp; 
									
										<i class="fa fa-font-awesome right"> 
										<c:out value="#${details.bno}" />&nbsp;
										</i>
										
									</span> 
									<br>
									<span><fmt:formatDate value="${details.regTime}" pattern="yyyy-MM-dd KK:mm:ss" /></span>
									<c:if test="${details.updateTime != null}">
									<span style="color:gray">(<fmt:formatDate value="${details.updateTime}" pattern="yyyy-MM-dd KK:mm:ss" /> 수정됨)</span>
									</c:if>
								</div>
								
								<div class="content-container clearfix">
									<div class="content-function-cog share-btn-wrapper" style="border-bottom: 1px solid gray">
										<h3>
											&nbsp;&nbsp;&nbsp;
											<c:out value="${details.title}" />
										</h3>
									</div>
								<div style="display:flex;">
									<div class="col-xs-11" id="dataList" style="min-height:300px">
										<h4>
											<c:out value="${details.content}" />
										</h4>
									</div>

									<div class="col-xs-1" style="text-align:center; border-left: 1px solid gray">

										<!-- 좋아요(로그인이 되어있다면) -->
										<c:if test="${!empty userId}">
										<div class="content-function-group">
											<div id="likeHand" class="note-evaluate-wrapper">
												<a href="javascript:void(0)" onclick="like()">
													<i class="fa fa-thumbs-o-up"></i>
												</a>
												
												<div><c:out value = "${details.likeCount}" /></div>

<!-- 												<a href="javascript:void(0)" onclick="dislike()"> -->
<!-- 													<i id="" class="glyphicon glyphicon-thumbs-down" title=""></i> -->
<!-- 												</a> -->
											</div>
										</div>
										</c:if>
										<!-- 좋아요 -->
										
										<c:if test="${userId == details.writer}">
										<!--수정삭제 -->
										<div style="font-size:15px; position: absolute; bottom: 5%; left: 40%">
											<a class="glyphicon glyphicon-cog" data-toggle="dropdown" href="#"></a>
											<ul class="dropdown-menu dropdown-user">
												<li><a href="/notices/modify/${details.bno}" id="modified"><i class="glyphicon glyphicon-edit"></i>수정</a></li>
												<li><a href="#" id="delete"> <i class="glyphicon glyphicon-trash"></i>삭제</a></li>
											</ul>
										</div>	
										<!--수정삭제 -->
										</c:if>
									</div>
								</div>
							</div>
						</div>
							
							<!-- 댓글 -->
			 <c:if test="${!empty userId}">
				<div class="panel panel-default">
				  <div class="panel-heading">댓글</div>
					  <div class="panel-body">
						<textarea rows="3" style="width:90%" placeholder="댓글 쓰기" id="reply"></textarea>
						<button type="button" id="replyReg">등록</button>
					  </div>
				</div>
			</c:if>	
		<!-- 부트스트랩 상세보기 -->
                    </div>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            
            <!-- 댓글목록 -->
            <div class="row">
				<div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                        
							<!-- 동적태그 추가  -->
							<div class="panel panel-info">
								<div class="panel-heading clearfix">
									<div id="replyList">
									
									</div>
								</div>
							</div>
							<!-- 동적태그 추가 end  -->	
                    </div>
                </div>
            </div>
		</div>
        	<!-- 댓글목록 -->    
        </div>
        <!-- /#page-wrapper -->
    </div>
    <!-- /#wrapper -->



<script>
//게시글에 좋아요를 해당 사용자가 눌렀는지 조회
(function () {
	$.ajax({
		url: "/notices/like",
		type: "post",
		contentType: "application/json; charset=UTF-8",
		data: JSON.stringify({
			"bno" : ${details.bno}
		}),
		success: function(data) {
			console.log("좋아요 클릭 조회 완료");
			if(data.result === "like"){
				
				let str = '<a href="javascript:void(0)" onclick="dislike()">'
					str += '<i class="fa fa-thumbs-up"></i></a>'
					str += '<div>${details.likeCount}</div>'
					$("#likeHand").html(str);
			}
			
		},
		error: function(err){
			console.log("좋아요 클릭 조회 실패");
		}
	});
})();

//파일목록 가져오기
(function () {
	$.ajax({
		url: "/upload/uploadGet",
		type: "get",
		data: {"bno" : ${details.bno}},
		success: function(data) {
				console.log("파일목록 조회 성공");
				
				$.each(data, function(index, value){

					console.log(index + ":" + value.imgFilePath.replaceAll(" ","%20"));	
					
					//확장자 체크해야함.
					let str ="<img src="+value.imgFilePath.replaceAll(" ","%20")+" style=width:100%>"
					
					$("#dataList").append(str)
				});
			
		},
		error: function(err){
			console.log("파일목록 조회 실패");
		}
	});
})();

//즉시 실행함수로, 댓글목록을 불러옴
var reply = function() {  
	
	$.ajax({
		url: "/notices/replyList/${details.bno}",
		type: "get",
		dataType: "text",						//서버로부터  반환을 text형식으로 받겠다
		contentType: "application/json; charset=utf-8",
		success: function(data){
			let replygetList ="";
			let replyList = JSON.parse(data);	//서버에서 String타입 데이터를 json타입으로 변경해서 끄내씀
			console.log("댓글목록 조회 완료");

			//서버에서 반환된 객체수만큼 반복문으로 동적코드 추가
			for(let i in replyList){
// 				console.log(replyList[i].rno);
				let encodeReply = encodeURI(replyList[i].reply);
				
				
				replygetList += "<div style='border: solid 1px' data-replyId="+replyList[i].rno+">"
				replygetList += "<div id='replyHeader'>" + replyList[i].replyer + "</div>"
				replygetList += "<div style='color:gray;font-size:5px'>("+timeFormat(replyList[i].regTime)+")</div>"
				replygetList += "<div id='replyBody'>" + replyList[i].reply 
				//로그인한 계정과, 댓글 작성자가 동일할경우 댓글수정 노출
				if(replyList[i].replyer === '${userId}'){
					replygetList += "<div class='btn-group content-function-group' style='float:right; padding:0 8px;font-size:16px'>"     				
					replygetList += "<a class='glyphicon glyphicon-cog' data-toggle='dropdown' href='#'></a>"
					replygetList += "<ul class='dropdown-menu dropdown-user'>"
					replygetList += "<li><a onclick='replyModify("+replyList[i].rno+",`"+encodeReply+"`)' data-replyId="+replyList[i].rno+">"
					replygetList += "<i class='glyphicon glyphicon-edit'></i>수정</a></li>"
					replygetList +=	"<li><a onclick='replyDelete("+replyList[i].rno+")'> <i class='glyphicon glyphicon-trash'></i>삭제</a></li>"
					replygetList += "</ul></div>"
				}
				
				replygetList += "</div></div>"
			}
			
			$("#replyList").html(replygetList);
		},
		error: function (request, status, error){
			console.log("댓글목록 조회 실패");
		}
	});
};
reply();
</script>


<script>
//좋아요 클릭함수
function like(){
	console.log("좋아요");
	if(confirm("정말 게시글을 좋아요 하시겠습니까?")){
		$.ajax({
			url: "/notices/like",
			type: "post",
			contentType: "application/json; charset=UTF-8",
			data: JSON.stringify({
				"bno" : ${details.bno},
				"checkLikeAndDislike" : true
			}),
			success: function(data) {

				if(data.result === "success"){
					let str = '<a href="javascript:void(0)" onclick="dislike()">'
					str += '<i class="fa fa-thumbs-up"></i></a>'
					str += '<div>'+data.likeCount+'</div>'
					$("#likeHand").html(str);
				}else if(data.result === "like"){
					alert("이미 좋아요가 되있습니다..");
				}else{
					alert("비정상적인 접근 \n 로그인을 해주세요.");
				}
			
			},
			error: function(err){
				console.log("실패");
			}
		});
	}
}
//좋아요 취소함수
function dislike(){
	console.log("좋아요 취소");

	if(confirm("좋아요를 취소하시겠습니까?")){
		$.ajax({
			url: "/notices/disLike",
			type: "post",
			contentType: "application/json; charset=UTF-8",
			data: JSON.stringify({
				"bno" : ${details.bno},
				"checkLikeAndDislike" : true
			}),
			success: function(data) {
				if(data.result === "success"){
					let str = '<a href="javascript:void(0)" onclick="like()">'
						str += '<i class="fa fa-thumbs-o-up"></i></a>'
						str += '<div>'+data.likeCount+'</div>'
					
					$("#likeHand").html(str);					
				}else if(data.result === "error"){
					alert("비정상적인 좋아요 취소");
				}				
			
			},
			error: function(err){
				console.log("실패");
			}
		});
	}
}

</script>

<script>


	//수정버튼클릭
	$("#modified").click(function(){
		console.log("수정 클릭");
	});
	
	//삭제버튼 클릭
	$("#delete").click(function(){
		console.log("삭제 클릭")
		
		if(confirm("정말 삭제하시겠습니까?") == true){
			console.log("진짜삭제했다");
			location.href="/notices/delete/${details.bno}";		
		}else{
			return;
		}
	});

	//댓글 등록버튼 클릭
	$("#replyReg").click(function(){
		
	let replyChg ="";
	
		$.ajax({
			url: "/notices/reply",
			type: "post",
			dataType: "text",							//서버로부터  반환을 text형식으로 받겠다
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify ({						//자바에는 json타입이 없으니 String 객체로 변환후 서버로 전송
				"bno" : ${details.bno},
				"reply" : $("#reply").val(),
				"replyer" : "${userId}"
			}),
			success: function(data){
				$("#reply").val('');					//댓글 등록후, 등록 칸 지움
				let replyList = JSON.parse(data);		//서버 String 타입의 vo객체를 object형식으로 변환
				console.log("댓글등록성공" + replyList.reply);
				let encodeReply = encodeURI(replyList.reply);
				
				
				
				replyChg += "<div style='border: solid 1px' data-replyId=" +replyList.rno+ ">"
				replyChg += "<div id='replyHeader'>" + replyList.replyer + "</div>"
				replyChg += "<div style='color:gray;font-size:5px'>("+timeFormat(replyList.regTime)+")</div>"
				replyChg += "<div id='replyBody'>" + replyList.reply 
				replyChg += "<div class='btn-group content-function-group' style='float:right; padding:0 8px;font-size:16px' >"     				
				replyChg += "<a class='glyphicon glyphicon-cog' data-toggle='dropdown' href='#'></a>"
				replyChg += "<ul class='dropdown-menu dropdown-user'>"
				replyChg += "<li><a onclick='replyModify("+replyList.rno+",`"+encodeReply+"`)' data-replyId="+replyList.rno+">"
				replyChg += "<i class='glyphicon glyphicon-edit'></i>수정</a></li>"
				replyChg +=	"<li><a onclick='replyDelete("+replyList.rno+")'> <i class='glyphicon glyphicon-trash'></i>삭제</a></li>"
				replyChg += "</ul></div>"
				replyChg += "</div></div>"
				
				
				$("#replyList").append(replyChg);//댓글 등록후 등록된 요소추가
				
			},
			error: function (request, status, error){
				console.log("댓글등록실패");
			}
		});
	})
	
	//날짜포맷 라이브러리를 이용한 js 날짜 포맷함수
	function timeFormat(time) {
		return moment(time).format('YYYY-MM-DD HH:mm:ss');
	}
	
	//댓글수정 
	function replyModify(rno, reply){
		console.log("rno--" + rno);
		console.log("reply--" + decodeURI(reply));
		
		let getreply = decodeURI(reply);
		let replyChg ="";
		
		replyChg += "<textarea rows='3' cols='90' name='reply' id='replyChg"+rno+"'>"+ getreply +"</textarea>"
		replyChg += "<button onclick='replyModifyAjax("+rno+")'>수정</button><button onclick='reply()'>취소</button>"
				
		$("div[data-replyid="+rno+"]").html(replyChg);
				
	}
	//댓글수정 ajax
	function replyModifyAjax(rno){
		
		$.ajax({
			url: "/notices/replyModify",
			type: "post",
			dataType: "text",							//서버로부터  반환을 text형식으로 받겠다
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify ({						//자바에는 json타입이 없으니 String 객체로 변환후 서버로 전송
				"rno" : rno,
				"reply" : $("#replyChg"+rno+"").val()
			}),
			success: function(data){
				console.log("댓글 수정 성공");
				reply();
			},
			error: function (request, status, error){
				console.log("댓글 수정 실패");
			}
		})	
	};
	
	function replyDelete(rno){
		console.log("삭제 눌르다" + rno);
		
		if(confirm("정말 삭제하시겠습니까?") == true){
		
			$.ajax({
				url: "/notices/replyDelete/"+rno+"",
				type: "post",
				success: function(data){
					console.log("댓글 삭제 성공");
					reply();
				},
				error: function (request, status, error){
					console.log("댓글 삭제 실패");
				}
			})	
			
		}else{
			return;
		}
		
	}
	
	
</script>

</body>

</html>
