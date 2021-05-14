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

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.html">SB Admin v2.0</a>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-envelope fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-messages">
                        <li>
                            <a href="#">
                                <div>
                                    <strong>John Smith</strong>
                                    <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
                                </div>
                                <div>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eleifend...</div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <strong>John Smith</strong>
                                    <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
                                </div>
                                <div>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eleifend...</div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <strong>John Smith</strong>
                                    <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
                                </div>
                                <div>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eleifend...</div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a class="text-center" href="#">
                                <strong>Read All Messages</strong>
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </li>
                    </ul>
                    <!-- /.dropdown-messages -->
                </li>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-tasks fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-tasks">
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Task 1</strong>
                                        <span class="pull-right text-muted">40% Complete</span>
                                    </p>
                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                                            <span class="sr-only">40% Complete (success)</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Task 2</strong>
                                        <span class="pull-right text-muted">20% Complete</span>
                                    </p>
                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
                                            <span class="sr-only">20% Complete</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Task 3</strong>
                                        <span class="pull-right text-muted">60% Complete</span>
                                    </p>
                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                                            <span class="sr-only">60% Complete (warning)</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Task 4</strong>
                                        <span class="pull-right text-muted">80% Complete</span>
                                    </p>
                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                                            <span class="sr-only">80% Complete (danger)</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a class="text-center" href="#">
                                <strong>See All Tasks</strong>
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </li>
                    </ul>
                    <!-- /.dropdown-tasks -->
                </li>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-bell fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-alerts">
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-comment fa-fw"></i> New Comment
                                    <span class="pull-right text-muted small">4 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-twitter fa-fw"></i> 3 New Followers
                                    <span class="pull-right text-muted small">12 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-envelope fa-fw"></i> Message Sent
                                    <span class="pull-right text-muted small">4 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-tasks fa-fw"></i> New Task
                                    <span class="pull-right text-muted small">4 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-upload fa-fw"></i> Server Rebooted
                                    <span class="pull-right text-muted small">4 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a class="text-center" href="#">
                                <strong>See All Alerts</strong>
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </li>
                    </ul>
                    <!-- /.dropdown-alerts -->
                </li>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                                <input type="text" class="form-control" placeholder="구글 검색">
                                <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </span>
                            </div>
                            <!-- /input-group -->
                        </li>
                        <li>
                            <a href="list"><i class="fa fa-dashboard fa-fw"></i> 공지사항</a>
                        </li>
                        
                        <li>
                            <a href="/stock/list"><i class="glyphicon glyphicon-usd"></i> 실시간 VI데이터</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-table fa-fw"></i> 자유게시판</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-edit fa-fw"></i> 문의게시판</a>
                        </li>
                        

<!--                         <li> -->
<!--                             <a href="#"><i class="fa fa-sitemap fa-fw"></i> Multi-Level Dropdown<span class="fa arrow"></span></a> -->
<!--                             <ul class="nav nav-second-level"> -->
<!--                                 <li> -->
<!--                                     <a href="#">Second Level Item</a> -->
<!--                                 </li> -->
<!--                                 <li> -->
<!--                                     <a href="#">Second Level Item</a> -->
<!--                                 </li> -->
<!--                                 <li> -->
<!--                                     <a href="#">Third Level <span class="fa arrow"></span></a> -->
<!--                                     <ul class="nav nav-third-level"> -->
<!--                                         <li> -->
<!--                                             <a href="#">Third Level Item</a> -->
<!--                                         </li> -->
<!--                                         <li> -->
<!--                                             <a href="#">Third Level Item</a> -->
<!--                                         </li> -->
<!--                                         <li> -->
<!--                                             <a href="#">Third Level Item</a> -->
<!--                                         </li> -->
<!--                                         <li> -->
<!--                                             <a href="#">Third Level Item</a> -->
<!--                                         </li> -->
<!--                                     </ul> -->
<!--                                     /.nav-third-level -->
<!--                                 </li> -->
<!--                             </ul> -->
<!--                             /.nav-second-level -->
<!--                         </li> -->
                        <li>
                            <a href="#"><i class="fa fa-files-o fa-fw"></i> 로그인<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="blank.html"> 마이페이지</a>
                                </li>
                                <li>
                                    <a href="login.html"> 로그아웃</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

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
	                            <button type="button" class="btn btn-success" style="float:right" onclick="registerClick()">공지사항 작성</button>
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
