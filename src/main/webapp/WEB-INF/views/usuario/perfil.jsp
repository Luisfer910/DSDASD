<%-- 
    Document   : perfil
    Created on : 12-04-2025, 10:58:43 p. m.
    Author     : LFMG9
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mi Perfil - Epe2Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container">
        <h1>Mi Perfil</h1>
        
        <c:if test="${not empty mensaje}">
            <div class="success-message">
                ${mensaje}
            </div>
        </c:if>
        
        <div class="profile-form">
            <form action="${pageContext.request.contextPath}/usuarios" method="post">
                <input type="hidden" name="accion" value="actualizar">
                
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" value="${usuario.nombre}" required>
                </div>
                
                <div class="form-group">
                    <label for="apellido">Apellido:</label>
                    <input type="text" id="apellido" name="apellido" value="${usuario.apellido}" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" value="${usuario.email}" readonly>
                </div>
                
                <div class="form-group">
                    <label for="telefono">Teléfono:</label>
                    <input type="tel" id="telefono" name="telefono" value="${usuario.telefono}">
                </div>
                
                <button type="submit" class="btn-primary">Actualizar perfil</button>
            </form>
        </div>
        
        <div class="profile-actions">
            <a href="${pageContext.request.contextPath}/reservas" class="btn-secondary">Ver mis reservas</a>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
</body>
</html>
