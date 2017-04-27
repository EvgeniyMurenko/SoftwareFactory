<%@ page import="com.SoftwareFactory.model.Case" %>
<%@ page import="com.SoftwareFactory.model.ManagerInfo" %>
<%@ page import="com.SoftwareFactory.constant.ProjectEnum" %>
<%@ page import="com.SoftwareFactory.model.Message" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.SoftwareFactory.comparator.MessageByDateComparator" %>
<%@ page import="java.io.File" %>
<%@ page import="com.SoftwareFactory.constant.GlobalEnum" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.SoftwareFactory.constant.StatusEnum" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no, minimal-ui" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="format-detection" content="address=no" />

    <meta name="description" content="" />
    <meta name="keywords" content="" />

    <title>Cases List :: 소프트웨어팩토리</title>

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

            <% Case aCase = (Case) request.getAttribute("case");%>
            <% ManagerInfo managerInfo = (ManagerInfo) request.getAttribute("managerInfo");%>
            <%SimpleDateFormat dateFormatShow = new SimpleDateFormat("yyyy-MM-dd HH:mm");%>

            <h3><i class="fa fa-pie-chart"></i>Case ID: <%out.print(aCase.getId());%></h3>

            <div class="mb20 pull-left">
                <a href="/cases/" class="btn btn-primary"><i class="fa fa-times-circle pr10"></i>Cancel write Case</a>
            </div>

            <%if (aCase.getProject().getProjectName().equals(ProjectEnum.projectNameEstimate.getDbValue())){%>
                <div class="pull-right">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#openProject"><i class="fa fa-plus-circle pr10"></i>Open Project</button>
                </div>
            <%} else if (aCase.getProject().getProjectName().equals(ProjectEnum.projectNameNormal.getDbValue())){%>
                <div class="pull-right">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#openProject"><i class="fa fa-plus-circle pr10"></i>Open Project</button>
                </div>
            <%}%>
            <!-- Information from table -->
            <table class="table table-striped table-bordered" width="100%" cellspacing="0">
                <thead>
                <tr>
                    <th width="20">ID</th>
                    <th>Case issue</th>
                    <th width="150">Project</th>
                    <th width="170">Date</th>
                    <th width="50">Status</th>
                    <th width="140">Appointment time</th>
                    <th width="70">Messages</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td align="center"><%out.print(aCase.getId());%></td>
                    <td><%out.print(aCase.getProjectTitle());%></td>
                    <td align="center">
                        <% if (aCase.getProject().getProjectName().equals(ProjectEnum.projectNameNormal.getDbValue())) {
                            out.print(ProjectEnum.projectNameNormal.getValue());
                        }else if (aCase.getProject().getProjectName().equals(ProjectEnum.projectNameEstimate.getDbValue())) {
                            out.print(ProjectEnum.projectNameEstimate.getValue());
                        } else out.print(aCase.getProject().getProjectName()); %>
                    </td>
                    <td align="center"><%out.print(dateFormatShow.format(aCase.getCreationDate()));%></td>
                    <td align="center"><i class="fa fa-circle-o"></i></td>
                    <td align="center"><time class="timeago" datetime="<%out.print(aCase.getMessages().iterator().next().getMessageTime()); %>"></time></td>
                    <td align="center"><%out.print(aCase.getMessages().size());%></td>
                </tr>
                </tbody>
            </table>
            <!-- Information from table -->

            <div class="border-bottom mb20"></div>

            <section class="cases-messages-section">
                <%ArrayList<Message> messages = new ArrayList<Message>(aCase.getMessages());
                messages.sort(new MessageByDateComparator());%>
                <%for (Message message : messages){
                    Long userId =  new Long(message.getUser().getId());

                    if(aCase.getProject().getCustomerInfo().getId().equals(userId)) {%>

                        <!-- User case message -->
                        <div class="user-message">

                            <div class="clearfix border-bottom pb5 mb10">
                                <div class="name"><%out.print(aCase.getProject().getCustomerInfo().getName());%></div>
                                <div class="date"><% out.print(dateFormatShow.format(message.getMessageTime())); %></div>
                            </div>

                            <!-- Message body -->
                            <div class="description">
                                <% out.print(message.getMessageText());%>
                                <% if (message.getMessagePath()!=null) {
                                    File directory = new File(message.getMessagePath());
                                    if (directory.exists()) {
                                        File[] files = directory.listFiles();
                                        for (int i = 0; i < files.length; i++) {
                                            String fileName = files[i].getName();
                                            out.print("<p><a href=" + GlobalEnum.webRoot + "/download/" + message.getId() + "/" + fileName + "/" + ">" + fileName + "</a>");
                                        }
                                    }
                                } %>
                            </div>
                            <!-- #End Message body -->

                        </div>
                        <!-- #End User case message -->

                    <%}else{%>
                        <!-- Manager case message -->
                        <div class="manager-message">

                            <div class="clearfix border-bottom pb5 mb10">
                                <div class="date"><% out.print(dateFormatShow.format(message.getMessageTime())); %></div>
                                <%if(managerInfo != null ){%>
                                    <div class="name"><%out.print(managerInfo.getName());%></div>
                                <%} else {%>
                                    <div class="name">MANAGER NAME</div>
                                <%}%>
                            </div>

                            <!-- Message body -->
                            <div class="description">
                                <% out.print(message.getMessageText());%>
                                <% if (message.getMessagePath()!=null) {
                                    File directory = new File(message.getMessagePath());
                                    if (directory.exists()) {
                                        File[] files = directory.listFiles();
                                        for (int i = 0; i < files.length; i++) {
                                            String fileName = files[i].getName();
                                            out.print("<p><a href=" + GlobalEnum.webRoot + "/download/" + message.getId() + "/" + fileName + "/" + ">" + fileName + "</a>");
                                        }
                                    }
                                } %>
                            </div>
                            <!-- #End Message body -->

                        </div>
                        <!-- #End Manager case message -->
                    <%}%>
                <%}%>
            </section>

            <div class="border-bottom mb20"></div>

            <%if (!aCase.getStatus().equals(StatusEnum.CLOSE.toString())){%>
                <!-- Case answer section -->
                <form action="/cases/<% out.print(Long.toString(aCase.getId())); %>/print_answer?${_csrf.parameterName}=${_csrf.token}" method="POST" enctype="multipart/form-data" >
                    <div class="row">
                        <div class="col-md-4">

                            <!-- Appointment time -->
                            <h4 class="mb10">Appointment time</h4>
                            <div class="form-group">
                                <div class="input-group date" id="datetimepicker">
                                    <input type="text" name="appointmentTime" class="form-control" />
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div>
                            <!-- #End Appointment time -->

                            <!-- Attach files -->
                            <h4 class="mb10">Attach files</h4>
                            <div class="form-group">
                                <input id="chatUpload" name="file[]" multiple type="file">
                            </div>
                            <!-- #End Attach files -->

                        </div>

                        <!-- Case message -->
                        <div class="col-md-8">
                            <h4 class="mb10">Message</h4>
                            <div class="form-group">
                                <textarea id="editor" name="message" rows="3"></textarea>
                            </div>
                        </div>
                        <!-- #End Case message -->

                    </div>

                    <div class="form-group text-right mt20">
                        <button type="submit" class="btn btn-primary"><i class="fa fa-paper-plane-o pr10"></i>Send answer</button>
                    </div>

                </form>
                <!-- Case answer section -->
            <%}%>

        </section>
        <!-- Content section -->

    </div>
    <!-- #End Page-content -->

</div>
<!-- #End Wrapper -->

<!-- Open Project -->
<div id="openProject" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <form action="/cases/<%out.print(aCase.getProject().getId());%>/createNewProject?${_csrf.parameterName}=${_csrf.token}" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h3 class="modal-title">Open Project</h3>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label class="control-label" for="project">Project name</label>
                        <input type="text" id="project" name="project_name" class="form-control" required/>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="submit" name="save" class="btn btn-primary">Save</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </form>

    </div>
</div>
<!-- #End Open Project -->

<%@ include file="footerJavaScript.jsp" %>



</body>
</html>