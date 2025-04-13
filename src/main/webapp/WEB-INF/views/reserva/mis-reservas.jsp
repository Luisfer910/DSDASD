<%-- 
    Document   : mis-reservas
    Created on : 12-04-2025, 10:57:14 p. m.
    Author     : LFMG9
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mis Reservas - Epe2Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/app/resources/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container">
        <h1>Mis Reservas</h1>
        
        <c:if test="${not empty mensaje}">
            <div class="success-message">
                ${mensaje}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>
        
        <div class="reservations-list">
            <c:choose>
                <c:when test="${empty reservas}">
                    <div class="no-results">
                        <h2>No tienes reservas</h2>
                        <p>Explora nuestros hoteles y realiza tu primera reserva.</p>
                        <a href="${pageContext.request.contextPath}/app/hoteles" class="btn-search">Ver hoteles</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${reservas}" var="reserva">
                        <div class="reservation-item">
                            <div class="reservation-details">
                                <h3>${reserva.habitacion.hotel.nombre} - ${reserva.habitacion.tipo}</h3>
                                <p><strong>Fecha de entrada:</strong> ${reserva.fechaEntrada}</p>
                                <p><strong>Fecha de salida:</strong> ${reserva.fechaSalida}</p>
                                <p><strong>Número de personas:</strong> ${reserva.numeroPersonas}</p>
                                <p><strong>Precio total:</strong> $${reserva.precioTotal}</p>
                                <p><strong>Estado:</strong> ${reserva.estado}</p>
                                
                                <c:if test="${reserva.estado != 'CANCELADA'}">
                                    <form action="${pageContext.request.contextPath}/app/reservas" method="post">
                                        <input type="hidden" name="accion" value="cancelar">
                                        <input type="hidden" name="reservaId" value="${reserva.id}">
                                        <button type="submit" class="btn-cancel">Cancelar reserva</button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="${pageContext.request.contextPath}/app/resources/js/script.js"></script>
</body>
</html>
