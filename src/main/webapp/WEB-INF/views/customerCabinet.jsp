<%@ page import="java.util.Locale" %>
<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<%@ page import="com.SoftwareFactory.model.Project" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.SoftwareFactory.model.Case" %>
<%@ page import="com.SoftwareFactory.model.Message" %>
<%@ page import="com.SoftwareFactory.constant.MessageEnum" %>
<%@ page import="java.util.ArrayList" %><%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no, minimal-ui" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="format-detection" content="address=no" />

    <meta name="description" content="" />
    <meta name="keywords" content="" />

    <title>소팩소개 :: Software Factory</title>

    <link href="/resources/newIndexPage/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/resources/newIndexPage/css/bootstrap-select.min.css" rel="stylesheet" />
    <link href="/resources/newIndexPage/css/jquery.fancybox.min.css" rel="stylesheet" />
    <link href="/resources/newIndexPage/css/jquery.sweet-alert.min.css" rel="stylesheet" />
    <link href="/resources/newIndexPage/css/font-awesome.min.css" rel="stylesheet" />
    <link href="/resources/newIndexPage/css/awesome-bootstrap-checkbox.min.css" rel="stylesheet" />
    <link href="/resources/newIndexPage/css/fileinput.min.css" rel="stylesheet" />
    <link href="/resources/newIndexPage/css/style.css" rel="stylesheet" />
    <link href="/resources/newIndexPage/css/responsive.css" rel="stylesheet" />

    <!--[if lt IE 9]>
    <script src="/resources/newIndexPage/js/html5shiv.js"></script>
    <script src="/resources/newIndexPage/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<!-- Header -->
<header class="container header">
    <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-6 logo">
            <a href="<c:url value="/cabinet/"/>">소프트웨어<span>팩토리</span></a>
            <div class="small-logo">SoFAC : <i>Software Factory</i></div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 text-right login">
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <span class="avatar-welcome"><%out.print((String)request.getAttribute("customerName"));%> 님 접속을 환영합니다.</span>
                    <a href="javascript:void(0);" class="dropdown-toggle avatar" data-toggle="dropdown"><i class="fa fa-user"></i></a>
                    <ul class="dropdown-menu">
                        <li class="dropdown-menu-header text-center">설정</li>
                        <li><a href="javascript:void(0);"><i class="fa fa-user"></i> 윤곽</a></li>
                        <li><a href="<c:url value="/logout" />"><i class="fa fa-lock"></i> 로그 아웃</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</header>
<div class="header-line"></div>
<!-- #End Header -->

<section class="container mb20">
    <div class="row">
        <div class="col-md-3">


            <!-- Projects -->
            <h3 class="mt0">프로젝트</h3>
            <ul class="projects-list">
                <%
                    String currentProjectId= (String) request.getAttribute("projectId");
                    List<Project> projectSet =  (List<Project>)request.getAttribute("projects");
                    Project generalDiscussionProject = projectSet.get(projectSet.size()-1);
                    for(Project project : projectSet){
                        if (!project.getProjectName().equals("#$GENERAL")){
                        /*    int countNewMessage = 0;
                            for(Case aCase : project.getCases()){
                                for(Message msg : aCase.getMessages()){
                                    if(msg.getIsRead().equals(MessageEnum.NOTREAD.toString())){

                                        //if(msg.getUser().getId().equals()) =====> must check current user
                                        countNewMessage++;
                                    }
                                }
                            }*/
                %>
                <%  String projectId= Long.toString(project.getId()); %>
                <li><a href="/cabinet/project/<%out.print(projectId); %>" <%if (projectId.equals(currentProjectId)) out.print("class=\"active\"");%>     ><i class="fa fa-angle-double-right"></i> <% out.println(project.getProjectName()); %></a></li>

                        <%}
                    }%>

            </ul>
            <!-- #End Projects -->

            <!-- Discussion room -->
            <h3 class="mt20">일반 토론</h3>
            <ul class="projects-list">
                <li><a href="/cabinet/project/<%out.print(generalDiscussionProject.getId()); %>"  <%if (Long.toString(generalDiscussionProject.getId()).equals(currentProjectId)) out.print("class=\"active\"");%>><i class="fa fa-angle-double-right"></i>Discussion room</a></li>
            </ul>
            <!-- #End Discussion room -->

        </div>
        <div class="col-md-9">
            <!-- Breadcrumbs -->
            <ol class="breadcrumb">
                <li><a href="<c:url value="/cabinet/" />"><i class="fa fa-home"></i></a></li>
                <li class="active"><%out.print((String)request.getAttribute("currentProjectCasesName"));%></li>
            </ol>
            <!-- #End Breadcrumbs -->

            <div class="row mb20">
                <div class="col-md-6">

                    <!-- table pagination -->
                    <div class="holder"></div>
                    <!-- #End table pagination -->

                </div>
                <div class="col-md-6 text-right"><a href="<c:url value="/newCase"/>" class="btn btn-primary">새 CASE 생성</a></div>
            </div>
            <!-- Projects list table -->
            <table class="table table-striped">

                <thead>
                <tr>
                    <th>Title</th>
                    <th class="text-center">Project</th>
                    <th class="text-center">Progress</th>
                    <th class="hidden-xs text-center">Date</th>
                    <th class="hidden-xs text-center">Update</th>
                    <th class="hidden-xs text-center">Messages</th>
                </tr>
                </thead>

                <%
                    ArrayList<Case> cases =  (ArrayList<Case>)request.getAttribute("cases");
                    Iterator<Case> caseIterator = cases.iterator();
                    while (caseIterator.hasNext()) {
                        Case aCase = caseIterator.next();
                %>

                    <tbody id="itemContainer">
                        <tr class="unread checked" onclick= location.href("/cabinet/case/<%    out.print(Long.toString(aCase.getId()));   %>");>
                            <td><a href="javascript:void(0);"><%  out.print(aCase.getProjectTitle().toString());  %></a></td>
                            <td class="text-center"><a href="javascript:void(0);"><% out.print(aCase.getProject().getProjectName()); %></a></td>
                            <td class="text-center"><%  out.print(aCase.getStatus()); %></td>
                            <td class="hidden-xs text-center"><%  out.print(aCase.getCreationDate().toString().substring(0, 10));  %></td>

                            <% List<Message> messages = new ArrayList<>(aCase.getMessages());
                                Message msg = messages.get(0); %>

                            <td class="hidden-xs text-center"><time class="timeago" datetime="<%  out.print(msg.getMessageTime()); %>"></time></td>
                            <td class="hidden-xs text-center"><%  out.print(aCase.getMessages().size());   %></td>
                        </tr>
                    <%}%>
                </tbody>
            </table>
            <!-- #End Projects list table -->
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="container footer mb20">
    <div class="mt20 text-center">Copyright &copy; 2017. All rights reserved.</div>
</footer>
<!-- #End Footer -->

<script src="/resources/newIndexPage/js/jquery.min.js"></script>
<script src="/resources/newIndexPage/js/jquery-ui.min.js"></script>
<script src="/resources/newIndexPage/js/jquery.mousewheel.min.js"></script>
<script src="/resources/newIndexPage/js/jquery.fancybox.min.js"></script>
<script src="/resources/newIndexPage/js/jquery.sweet-alert.min.js"></script>
<script src="/resources/newIndexPage/js/jquery.timeago.js"></script>
<script src="/resources/newIndexPage/js/jquery.timeago.ko.js"></script>
<script src="/resources/newIndexPage/js/bootstrap.min.js"></script>
<script src="/resources/newIndexPage/js/bootstrap-form-helpers.min.js"></script>
<script src="/resources/newIndexPage/js/bootstrap-select.min.js"></script>
<script src="/resources/newIndexPage/js/bootstrap.validator.min.js"></script>
<script src="/resources/newIndexPage/js/fileinput.min.js"></script>
<script src="/resources/newIndexPage/js/sortable.min.js"></script>
<script src="/resources/newIndexPage/js/form-validation.min.js"></script>
<script src="/resources/newIndexPage/js/pagination.min.js"></script>
<script src="/resources/newIndexPage/js/main.js"></script>
</body>
</html>
