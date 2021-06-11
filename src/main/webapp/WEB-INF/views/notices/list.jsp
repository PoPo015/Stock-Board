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

</head>

<body>

    <div id="wrapper">
	
	<!-- 네비게이션바 -->
	<%@include file="../common/navbar.jsp" %>



        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">공지 사항</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <h3>목록
                            	<c:if test="${!empty userId}"> <!-- 로그인했을시 -->
	                            <button type="button" class="btn btn-success" style="float:right" onclick="registerClick()">공지사항 작성</button>
                            	</c:if>
                            </h3> 
                            
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>제목</th>
                                            <th>작성자</th>
                                            <th>작성시간</th>
                                            <th class="col-xs-1 item-icon fa fa-comment"></th>
                                            <th class="col-xs-1 glyphicon glyphicon-thumbs-up"></th>
                                           	<th class="col-xs-1 item-icon fa fa-eye"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
										<tr>	
										<c:forEach items="${noticesList}" var="list">
											<tr>
												<td class="col-xs-1"><c:out value="${list.bno}"/></td>
												<td class="col-xs-5"><a href="details/${list.bno}"><c:out value="${list.title}"/></a></td>
												<td class="col-xs-2"><c:out value="${list.writer}"/></td>
												<td class="col-xs-4"><fmt:formatDate value="${list.regTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>	
												<td class="col-xs-1"><c:out value="${list.replyCount}"/></td>
												<td class="col-xs-1"><c:out value="${list.likeCount}"/></td>
												<td class="col-xs-1"><c:out value="${list.viewsCount}"/></td>								
											</tr>
										</c:forEach>	
                                    </tbody>
                                </table>
                                
                                <!-- 페이징,검색 -->
<!--                            <div> -->
<!-- 									<form action> -->
<!-- 										<select> -->
<!-- 											<option value="title" selected>제목</option> -->
<!-- 											<option value="content">내용</option> -->
<!-- 											<option value="writer">작성자</option> -->
<!-- 										</select>  -->
<!-- 										<input type="text"> -->
<!-- 										<button type="submit">검색</button> -->
<!-- 									</form> -->


<!-- 									<nav style="float:right"> -->
<!-- 									  <ul class="pagination" style="float:right"> -->
<!-- 									    <li> -->
<!-- 									      <a href="#" aria-label="Previous"> -->
<!-- 									        <span aria-hidden="true">&laquo;</span> -->
<!-- 									      </a> -->
<!-- 									    </li> -->
<!-- 									    <li class="active"><a href="#">1</a></li> -->
<!-- 									    <li><a href="#">2</a></li> -->
<!-- 									    <li><a href="#">3</a></li> -->
<!-- 									    <li><a href="#">4</a></li> -->
<!-- 									    <li><a href="#">5</a></li> -->
<!-- 									    <li> -->
<!-- 									      <a href="#" aria-label="Next"> -->
<!-- 									        <span aria-hidden="true">&raquo;</span> -->
<!-- 									      </a> -->
<!-- 									    </li> -->
<!-- 									  </ul> -->
<!-- 								</nav> -->
<!-- 							</div>	 -->
								<!-- 페이징처리 -->
								
								
<%-- 								${page.toString()} --%>
							<!-- 페이징처리 -->	
							<nav class="service-box">
								<ul class="pagination pull-right">

									<c:if test="${page.prev}">
										<li class="paginate_button previous"><a
											href="list?pageNum=${page.startPage - 1 }">Previous</a></li>
									</c:if>

									<c:forEach var="num" begin="${page.startPage}" end="${page.endPage}">
										<li class="paginate_button ${page.cri.pageNum == num ? "active" : ""} ">

											<c:if test="${page.cri.keyword != null}">
												<a href="list?pageNum=${num}&amount=${page.cri.amount}&type=${page.cri.type}&keyword=${page.cri.keyword}">${num}</a>
											</c:if> <c:if test="${page.cri.keyword == null}">
												<a href="list?pageNum=${num}&amount=${page.cri.amount}">${num}</a>
											</c:if>
									</c:forEach>

									<c:if test="${page.next}">
										<li class="paginate_button next"><a
											href="list?pageNum=${page.endPage + 1 }">Next</a></li>
									</c:if>
								</ul>

								<form action="/notices/list" method="get">

									<select name="type">
										<option value="title"
											${page.cri.type eq "title" ? "selected" : ""}>제목</option>
										<option value="content"
											${page.cri.type eq "content" ? "selected" :""}>내용</option>
										<option value="writer"
											${page.cri.type eq "writer" ? "selected" :""}>작성자</option>

									</select>

									<!-- 검색조건유지 -->
									<input type="text" name="keyword" value="${page.cri.keyword != null ? page.cri.keyword : ''}">

									<button type="submit">검색</button>

								</form>
							</nav>
						<!-- 페이징처리 -->	
								
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

	<!-- common.jsp파일로 사용 -->
<!--     jQuery -->
<%--     <script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script> --%>

<!--     Bootstrap Core JavaScript -->
<%--     <script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.min.js"></script> --%>

<!--     Custom Theme JavaScript -->
<%--     <script src="${pageContext.request.contextPath}/resources/dist/js/sb-admin-2.js"></script> --%>

<!--     Metis Menu Plugin JavaScript -->
<%--     <script src="${pageContext.request.contextPath}/resources/vendor/metisMenu/metisMenu.min.js"></script> --%>


<script>

	//새글작성 버튼 클릭
	function registerClick(){
	
		location.href="register";
		
	}


</script>

</body>

</html>
