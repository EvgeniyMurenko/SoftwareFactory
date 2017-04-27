<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html lang="kr">
<head>

    <%@ include file="siteHeaderMeta.jsp" %>

    <title>SoFAC의 특징 :: Software Factory</title>

    <%@ include file="siteHeaderStyle.jsp" %>

</head>
<body>

<%@ include file="siteHeader.jsp" %>

<!-- Content -->
<section class="container content mb40">

    <div class="row pt40">
        <div class="col-md-8">

            <h3>소프트웨어 팩토리 협력 업체</h3>

            <p class="mt30">소프트웨어팩토리는 소프트웨어 개발에 필요한 인프라를 갖추고 있으며<br/>
                온라인을 기반으로 개발을 대행하는 전문 기업입니다.</p>

            <p>그러나 고객님의 업무 특성상 온라인 업무가 불가능할 경우 SoFAC의 지점 및 협력업체를<br/>
                통하여 대면 서비스를 받으실 수 있습니다.</p>

            <p>온라인 문의를 통해서 요청하시거나 아래 리스트를 통해서 직접 개발 관련 문의 및 접촉을 하실 수 있습니다.</p>

            <div class="row mb20">
                <div class="col-md-10"><a data-fancybox="gallery" href="resources/indexPage/images/image003.jpg"><img
                        src="resources/indexPage/images/image003.jpg" alt="" class="img-responsive"/></a></div>
            </div>

            <section style="border-bottom: 1px solid #eee; padding: 10px 0" class="clearfix">
                <div class="row mt20 mb20 clearfix">
                    <div class="col-md-3"><img src="resources/indexPage/images/small-logo-green.jpg" alt=""
                                               class="img-responsive"/></div>
                </div>

                <div>㈜세이퍼스드론<br/>
                    유틸리티형 드론 제작 전문 업체<br/>
                    <a href="http://www.safeusdrone.com/" target="_blank">www.safeusdrone.com</a><br/>
                    000-0000-0000<br/>
                </div>
            </section>

            <section style="border-bottom: 1px solid #eee; padding: 10px 0" class="clearfix">
                <div class="row mt20 mb20 clearfix">
                    <div class="col-md-3"><img src="resources/indexPage/images/small-logo-green.jpg" alt=""
                                               class="img-responsive"/></div>
                </div>

                <div>㈜세이퍼스드론<br/>
                    유틸리티형 드론 제작 전문 업체<br/>
                    <a href="http://www.safeusdrone.com/" target="_blank">www.safeusdrone.com</a><br/>
                    000-0000-0000<br/>
                </div>
            </section>

        </div>

    </div>
</section>
<!-- #End Content -->

<%@ include file="siteFooter.jsp" %>

<%@ include file="siteAuthorizationModal.jsp" %>

<%@ include file="siteFooterJavaScript.jsp" %>

</body>
</html>
