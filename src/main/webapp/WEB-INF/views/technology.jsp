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

    <title>실시간 데이터 교환 엔진 (ExD) :: Software Factory</title>

    <%@ include file="siteHeaderStyle.jsp" %>

</head>
<body>

<%@ include file="siteHeader.jsp" %>

<!-- Content -->
<section class="container content other-font2 mb40">
    <div class="row pt40">
        <div class="col-md-8">

            <h3>실시간 데이터 교환 엔진 (ExD)</h3>
            <p>ExD(Engine of High speed Realtime exchange Data) 엔진은 1997에 최초로 탄생하여 실시간 데이터 통신 시대를 여는데 핵심적인 역할을 하였으며, 한국
                및 일본의 실시간 주가공급 시스템 및 유명 메신저의 서버 엔진으로 활용되어 왔습니다.<br/>
                이 엔진은 노하우만 살리고 기술적인 부분은 구소련의 자연과학 기술을 보유한 유능한 엔지니어들에 의해서 모바일 지원용으로 전면 교체 개발 되어 있습니다.<br/>
                이것은 고객님들의 어플 개발시 막대한 비용절감 및 고성능 앱 개발에 큰 도움이 될 것입니다.</p>

            <div class="row">
                <div class="col-md-12 mt20"><a data-fancybox="gallery" href="/resources/indexPage/images/shema9.jpg"><img
                        src="/resources/indexPage/images/shema9.jpg" alt="" class="img-responsive"></a></div>
                <div class="col-md-12 clearfix mt40"><a data-fancybox="gallery"
                                                        href="/resources/indexPage/images/shema10.jpg"><img
                        src="/resources/indexPage/images/shema10.jpg" alt="" class="img-responsive"></a></div>
            </div>

            <h3>SPRIM Socket</h3>
            <p>실시간 통신 기술에서는 Socket 통신을 사용합니다.<br/>
                스마트폰 시대에도 Socket 통신을 사용하지만 스마트폰은 항상 이동하고 있으므로 통신 접속의 유지 기술이 매우 중요합니다.
            </p>
            <p><b>SPRIM(Socket protocol redefinition for intelligent mobile)</b> 소켓 전송 <b>기술은 스마트폰에서</b><br/>
                <b>안정적인 통신을 보장하는 최적의 알고리즘 정리한 특허 기술 입니다.</b></p>

            <div class="row">
                <div class="col-md-12 mt20 mb40"><a data-fancybox="gallery"
                                                    href="/resources/indexPage/images/shema11.jpg"><img
                        src="/resources/indexPage/images/shema11.jpg" alt="" class="img-responsive"></a></div>
            </div>

            <div class="row">
                <div class="col-md-4 col-sm-4 col-xs-6" style="border-right: 3px dotted #aaa;"><img
                        src="/resources/indexPage/images/serf7.jpg" alt="" class="img-responsive"></div>
                <div class="col-md-8 col-sm-12 col-xs-12">
                    <h3>SoFAC의 기술제공 정책</h3>

                    <p>소프트웨어팩토리는<br/>
                        스마트 시대에 필요한 핵심 엔진을 보유하고 있으며 앱 개발시 엔진 적용 및 기술료를 받지 않는 것을 기본 정책으로 하고 있습니다.</p>

                </div>
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