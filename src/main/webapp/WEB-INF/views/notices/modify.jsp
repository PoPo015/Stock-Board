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

    <!-- Bootstrap Core CSS -->
    <link href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="${pageContext.request.contextPath}/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
	
	<!-- 비정상적인 접근시 차단 -->
	<c:if test="${userId != details.writer}">
		<c:redirect url="http://localhost:5109/notices/list"></c:redirect>
	</c:if>

    <div id="wrapper">

	<!-- 네비게이션바 -->
	<%@include file="../common/navbar.jsp" %>
   
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">작성</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="table-responsive">
                                <div class="table table-bordered table-striped">

									<form action="/notices/modify" method="post" style="text-align:center" id="frm">
										<br>

										<div>
											제목 <input type="text" style="width: 90%" name="title" id="title" value="${details.title}">
										</div>
										<br>

										<div>
											내용
											<textarea style="width: 90%" name="content" id="content">${details.content}</textarea>
										</div>
										<input type="hidden" name="bno" value="${details.bno}">
										<input type="hidden" name="writer" value="${details.writer}">
										
										<input type="file" id="file" name="file">
										
										<div style="float: right">
											<button type="button" class="btn btn-success" onclick="registerClick()">수정</button>
											<button type="button" class="btn btn-default" onclick="location.href='/notices/details/${details.bno}'">취소</button>
										</div>
									</form>

								</div>
                            </div>
                                <!-- 동적 파일 추가 리스트 -->
                            	<div id="fileList">
                            	</div>
                            
                        </div>
                    </div>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
    

    <!-- Bootstrap Core JavaScript -->
    <script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="${pageContext.request.contextPath}/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="${pageContext.request.contextPath}/resources/dist/js/sb-admin-2.js"></script>


<script>

//ajax 파일업로드
$("#file").change(function(){
	
	 console.log("파일 변경사항 존재");
	 let formData = new FormData();					 //form 에 file을 담기 위해 생성 
	 let inputFile = $("input[name='file']");			 //file 객체를 변수에담음
	 let file = inputFile[0].files;
	 
	var fileOriginal = file[0].name; //파일이름
   //파일 이름에서 뒤에부터 . 을찾아서 그 인덱스의 +1 번쨰를 문자를 뗴고, 다소문자로변경
   var fileKind = fileOriginal.substring(file[0].name.lastIndexOf(".") +1).toLowerCase();
   console.log("파일이름 :" + fileOriginal);
   console.log("확장자명 :" + fileKind);
	
	//파일 용량 5메가로 제한
	console.log(file[0].size);
	if(file[0].size > 10 * 1024 * 1024){
		alert("파일 용량이 너무 큽니다.");
		return false;
	}
   
   //파일 확장자 검증
   if(fileKind != "jpg" && fileKind != "png" && fileKind != "gif" && fileKind != "jpeg"){
      alert("이미지 파일만 가능합니다");
      $("#file").val(""); //파일목록 비우기
      return false;   
   }
   
	 formData.append("file", file[0]);
	 
  

    //processData, contentType는 false로 지정
    $.ajax({
          type : "post",
          url : "/upload/uploadAjax",
          data : formData,
          processData : false,
          contentType : false,
          beforeSend : showLoadingBar(),			//로딩바 실행
          success : function(data) {
       	   
         		let fileList = "<p id='fileRemoveBno"+data.fileBno+"'>"
				fileList += "<img src="+data.imgFilePath+">"+data.fileOriginalNm+""
         		fileList += "<button id='fileRemove' onclick=fileRemove(`"+encodeURIComponent(data.fileUuidNm)+"`,"+data.fileBno+",`"+data.filePathDay+"`)>삭제</button><p>"
          		$("#fileList").append(fileList);

         		$("#file").val("");					//file 비우기
         		let str = "<input type='hidden' name='fileBno' id='fileBno"+data.fileBno+"' value="+data.fileBno+">"		//테이블의 PK값 form에 추가
          		$("#frm").append(str);

         		
         		setTimeout(function() {
					showLoadingBarRemove();				//로딩창 지우기
	          		  console.log('로딩창지운다');
         		}, 3000);

          },
          error : function(error) {
       	   	showLoadingBarRemove();
				alert("파일업로드 실패");
          }, 
       }); 
});



(function () {
	console.log("즉시실행함수!");	

	$.ajax({
		url: "/upload/uploadGet",
		type: "get",
		data: {"bno" : ${details.bno}},
		success: function(data) {
				console.log("성공" + JSON.stringify(data));
				
				$.each(data, function(index, value){

					console.log(index + ":" + value.imgFilePath.replaceAll(" ","%20"));	
					
					//확장자 체크해야함.
					let str = "<p id='fileRemoveBno"+value.fileBno+"'>" 
						str +="<img src="+value.imgFilePath.replaceAll(" ","%20")+" style=width:30%>"
						str += "<button id='fileRemove' onclick=fileRemove(`"+encodeURIComponent(value.fileUuidNm)+"`,"+value.fileBno+",`"+value.filePathDay+"`)>삭제</button><p>"
					$("#fileList").append(str)
				});
			
		},
		error: function(err){
			console.log("실패");
		}
	});
})();

//파일삭제 !!!!!!!여기부터작업해야함
function fileRemove(Nm, fileBno, filePath){
	 let fileName = decodeURIComponent(Nm);
	 console.log("파일삭제버튼클릭 --정보--");
	 console.log("파일이름:" +fileName);
	 console.log("파일번호:" +fileBno);
	 console.log("파일경로:" + filePath);
	 
	 $("#fileBno"+fileBno+"").remove();				//폼안에 있는 hidden 값삭제
	 $("#fileRemoveBno"+fileBno+"").remove();		//실시간 파일 올라가있는 자료삭제
	 
   	$.ajax({
			    url:"/upload/removeUploadAjax", 
			    type:"post",
			    contentType: "application/json; charset=utf-8",
			    data : JSON.stringify({
			    	"fileOriginalNm" : fileName,
			    	"fileBno" : fileBno,
			    	"filePathDay" : filePath,
			    }),
			    success: function(data) {
					alert("파일삭제 성공");
			    },
			    error: function(err) {
					alert("파일삭제 실패");
			    }
			});	 
}


</script>

<script>

   //새글작성 버튼 클릭
   function registerClick(){
	   
	   let title = $("#title").val().trim();
	   let content = $("#content").val().trim();
	   
 	   if(title.length === 0 || title === " "){
		console.log(title);
		console.log(title.length);
		$("#title").focus();
		alert("제목을 입력해주세요.");
		return false;
 	   }
 	   
 	   if(content.length ===0 || content === " "){
 			console.log(content);
 			console.log(content.length)
 		    alert("내용을 입력해주세요");
 			$("#content").focus();
 		   return false;
 	   }
 	   
      $("#frm").submit();      
   }


</script>

<script>
   //새글작성 버튼 클릭
   function registerClick(){

      $("#frm").submit();      
   }


   //로딩바
   function showLoadingBar() {
	   var maskHeight = $(document).height(); 
	   var maskWidth = window.document.body.clientWidth; 
	   var mask = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>"; 
	   var loadingImg = '';
	   loadingImg += "<div id='loadingImg' style='position:absolute; left:50%; top:40%; display:none; z-index:10000;'>"; 
	   loadingImg += " <img src='/resources/common/loading.gif'>"; 
	   loadingImg += "</div>"; $('body').append(mask).append(loadingImg); 
	   $('#mask').css({ 'width' : maskWidth , 'height': maskHeight , 'opacity' : '0.3' }); 
	   $('#mask').show();
	   $('#loadingImg').show(); 
	}
   
	//로딩바삭제
   function showLoadingBarRemove(){
	   
	   $("#mask").remove();
	   $("#loadingImg").remove();
   }
   
</script>

</body>

</html>
