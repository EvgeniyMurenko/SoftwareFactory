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

    <title>We Builid SoftwareFactory :: Software Factory</title>

    <%@ include file="siteHeaderStyle.jsp" %>

</head>
<body>

<%@ include file="siteHeader.jsp" %>

<!-- Content -->
<section class="container content mb40">

    <div class="row pt40">
        <div class="col-md-7">

            <h3 class="mt40">스마트 시대형 국제표준화를 준수하는 소프트웨어 개발 운영 대행 전문 기업입니다.</h3>
            <p>한국의 ㈜굿앤굿 재무설계 법인이 주체가 되고 미국의 IT법인, 러시아, 우크라이나, 베트남 기업 및 대학들과 협력하고 있으며,<br/>
                재무설계 법인의 특성상 자금 및 법률 행정 지원과 더불어 소프트웨어가 동시에 지원이 되어야 기업이 성장할 수 있다는 새로운 시대적 요구에 따라 좋은 아이디어와 사업의 의지가 있는 스타트업
                기업의 종합 지원도 가능한 구조를 갖추고 있습니다.</p>
            <img src="/resources/indexPage/images/circle-logo.jpg" alt=""/>
            <h3>We Builid SoftwareFactory</h3>

            <div class="row mt20 mb40 clearfix">
                <div class="col-md-12 mb20">
                    <div class="mb10"><h3 class="mb0 mt0">Korea</h3></div>
                    <div>㈜굿앤굿 재무설계 법인</div>
                    <div><a href="http://www.gngasset.co.kr/" target="_blank">www.gngasset.co.kr</a></div>
                </div>
                <div class="col-md-12 mb20">
                    <div class="mb10"><h3 class="mb0 mt0">USA</h3></div>
                    <div>CHON&HOUGH 세무법인</div>
                    <div><a href="http://www.chonhoughpc.com/" target="_blank">www.chonhoughpc.com</a></div>
                </div>
                <div class="col-md-12 mb20">
                    <div class="mb10"><h3 class="mb0 mt0">Ukraine</h3></div>
                    <div>Shevchenko National University</div>
                    <div><a href="http://www.fit.univ.kiev.ua/" target="_blank">www.fit.univ.kiev.ua</a></div>
                    <div class="mt10 mb10">Factory headquarter Engineer Office<br/>(Kiev, ukraine)</div>
                    <div class="mt10"><a data-fancybox="gallery" href="/resources/indexPage/images/cafe.jpg"
                                         class="position-center"><img src="/resources/indexPage/images/cafe-small.jpg"
                                                                      alt=""></a></div>
                </div>
            </div>

            <div class="row mt200">
                <div class="col-md-12"><a data-fancybox="gallery" href="/resources/indexPage/images/staff.jpg"
                                          class="position-center"><img src="/resources/indexPage/images/staff-small.jpg"
                                                                       alt="" class="img-responsive staff"/></a></div>
            </div>

        </div>
    </div>

</section>
<!-- #End Content -->

<%@ include file="siteFooter.jsp" %>

<%@ include file="siteAuthorizationModal.jsp" %>

<%@ include file="siteFooterJavaScript.jsp" %>

</body>
</html>