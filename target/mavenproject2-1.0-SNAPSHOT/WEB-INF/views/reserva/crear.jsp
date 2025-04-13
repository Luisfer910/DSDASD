<%-- 
    Document   : crear
    Created on : 12-04-2025, 10:56:38 p. m.
    Author     : LFMG9
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crear Reserva - Epe2Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/app/resources/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container">
        <h1>Crear Reserva</h1>
        
        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>
        
        <div class="reservation-details">
            <h2>Detalles de la habitación</h2>
            <p><strong>Hotel:</strong> ${habitacion.hotel.nombre}</p>
            <p><strong>Tipo de habitación:</strong> ${habitacion.tipo}</p>
            <p><strong>Capacidad:</strong> ${habitacion.capacidad} personas</p>
            <p><strong>Precio por noche:</strong> $${habitacion.precioPorNoche}</p>
            <p><strong>Fecha de entrada:</strong> ${fechaEntrada}</p>
            <p><strong>Fecha de salida:</strong> ${fechaSalida}</p>
        </div>
        
        <div class="reservation-form">
            <h2>Completar reserva</h2>
            <form action="${pageContext.request.contextPath}/app/reservas" method="post">
                <input type="hidden" name="accion" value="crear">
                <input type="hidden" name="habitacionId" value="${habitacion.id}">
                <input type="hidden" name="fechaEntrada" value="${fechaEntrada}">
                <input type="hidden" name="fechaSalida" value="${fechaSalida}">
                
                <div class="form-group">
                    <label for="numeroPersonas">Número de personas:</label>
                    <select id="numeroPersonas" name="numeroPersonas" required>
                        <c:forEach begin="1" end="${habitacion.capacidad}" var="i">
                            <option value="${i}">${i} persona<c:if test="${i > 1}">s</c:if></option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="comentarios">Comentarios adicionales:</label>
                    <textarea id="comentarios" name="comentarios" rows="4"></textarea>
                </div>
                
                <button type="submit" class="btn-reserve">Confirmar reserva</button>
            </form>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="${pageContext.request.contextPath}/app/resources/js/script.js"></script>
</body>
</html>
s