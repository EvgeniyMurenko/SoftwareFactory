<%@ page import="com.SoftwareFactory.model.Notice" %>
<%@ page import="java.io.File" %>
<%@ page import="com.SoftwareFactory.constant.MainPathEnum" %>
<%@ page import="com.SoftwareFactory.constant.GlobalEnum" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html lang="kr">

<%Notice notice = (Notice) request.getAttribute("notice");%>
<%boolean isNew = (boolean) request.getAttribute("isNew");%>

<head>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no, minimal-ui" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="format-detection" content="address=no" />

    <meta name="description" content="" />
    <meta name="keywords" content="" />

    <title>
        <%if (!isNew) {
            out.print("Edit notice :: 소프트웨어팩토리");
        }else {
            out.print("Add new notice :: 소프트웨어팩토리");
        }%>
    </title>

    <%@ include file="headerStyles.jsp" %>

</head>
<body>
<!-- Wrapper -->
<div id="wrapper">

    <!-- Sidebar -->
    <div id="sidebar-wrapper">

        <%@ include file="leftCategoriesMenu.jsp" %>

    </div>
    <!-- #End Sidebar -->

    <!-- Page Content -->
    <div id="page-content-wrapper">

        <%@ include file="topLine.jsp" %>

        <!-- Content section -->
        <section class="container-fluid content">
            <h3><i class="fa fa-user"></i>
                <%if (!isNew) {
                    out.print("Edit notice");
                }else {
                    out.print("Add new notice");
                }%>
            </h3>

            <div class="mb20">
                <a href="<c:out value="/notice/"/>" class="btn btn-primary"><i class="fa fa-times-circle pr10"></i>Back</a>
            </div>

            <form action="/notice/saveNotice?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-md-6">

                        <input type="hidden" name="id" value="<%if (!isNew)out.print(notice.getId());%>">

                        <div class="form-group">
                            <div class="checkbox">
                                <input id="active" class="styled" type="checkbox" name="activ" <%if (!isNew && notice.getActiv()) out.print("checked");%>>
                                <label for="active">Active notice</label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label">Title</label>
                            <input type="text" name="title" class="form-control" placeholder="Title" value="<%if (!isNew) out.print(notice.getTitle());%>"/>
                        </div>

                        <!-- Files -->
                        <% if(!isNew && notice.getFilePath()!= null){
                            File directory = new File(notice.getFilePath());
                            File[] files= directory.listFiles();
                            for (int i=0; i<files.length; i++){
                                String fileName =files[i].getName();
                                out.print("<br><a href="+ GlobalEnum.webRoot+"/download/"+notice.getId()+"/"+fileName+"/"+">"+fileName+"</a>");
                            }
                        <%}%>
                        <!-- #End files -->

                        <!-- Attach files -->
                        <div class="form-group">
                            <label class="control-label">Attach files</label>
                            <input id="chatUpload" name="file[]" multiple type="file">
                        </div>
                        <!-- #End Attach files -->

                        <div class="form-group">
                            <label class="control-label">Text</label>
                            <textarea class="form-control" id="editor" rows="3" name="text">
                                <%if (!isNew) out.print(notice.getNoticeText());%>
                            </textarea>
                        </div>

                        <div class="form-group text-right">
                            <button type="submit" name="save" class="btn btn-primary"><i class="fa fa-check pr10"></i>Save</button>
                        </div>
                    </div>
                </div>
            </form>

        </section>
        <!-- Content section -->

    </div>
    <!-- #End Page-content -->

</div>
<!-- #End Wrapper -->

<%@ include file="footerJavaScript.jsp" %>

</body>
</html>