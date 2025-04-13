<%-- 
    Document   : 404
    Created on : 12-04-2025, 10:59:04 p. m.
    Author     : LFMG9
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error 404 - Página no encontrada</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/app/resources/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container">
        <div class="error-container">
            <h1>404</h1>
            <h2>Página no encontrada</h2>
            <p>Lo sentimos, la página que estás buscando no existe o ha sido movida.</p>
            <a href="${pageContext.request.contextPath}/app/" class="btn-primary">Volver al inicio</a>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="${pageContext.request.contextPath}/app/resources/js/script.js"></script>
</body>
</html>
