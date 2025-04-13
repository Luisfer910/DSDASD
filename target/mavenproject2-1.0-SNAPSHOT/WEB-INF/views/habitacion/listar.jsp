<%-- 
    Document   : listar
    Created on : 12-04-2025, 10:56:18 p. m.
    Author     : LFMG9
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Habitaciones - ${hotel.nombre} - Epe2Hotel</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/app/resources/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container py-5">
        <!-- Hotel Info Header -->
        <div class="mb-4">
            <h1 class="mb-2">${hotel.nombre}</h1>
            <p class="text-muted">
                <i class="bi bi-geo-alt"></i> ${hotel.direccion}, ${hotel.ciudad}, ${hotel.pais}
                &nbsp;&nbsp;
                <c:forEach begin="1" end="${hotel.estrellas}">
                    <i class="bi bi-star-fill text-warning"></i>
                </c:forEach>
            </p>
        </div>
        
        <!-- Search Box -->
        <div class="card shadow mb-5">
            <div class="card-body">
                <h5 class="card-title mb-3">Buscar disponibilidad</h5>
                <form action="${pageContext.request.contextPath}/app/habitaciones" method="get" class="row g-3">
                    <input type="hidden" name="accion" value="buscarDisponibles">
                    <input type="hidden" name="hotelId" value="${hotel.id}">
                    
                    <div class="col-md-5">
                        <label for="fechaEntrada" class="form-label">Fecha de entrada:</label>
                        <input type="date" class="form-control" id="fechaEntrada" name="fechaEntrada" 
                               value="${fechaEntrada}" required>
                    </div>
                    
                    <div class="col-md-5">
                        <label for="fechaSalida" class="form-label">Fecha de salida:</label>
                        <input type="date" class="form-control" id="fechaSalida" name="fechaSalida" 
                               value="${fechaSalida}" required>
                    </div>
                    
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="bi bi-search"></i> Buscar
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Search Results Info -->
        <c:if test="${not empty fechaEntrada and not empty fechaSalida}">
            <div class="alert alert-info mb-4">
                <i class="bi bi-info-circle-fill"></i> 
                Mostrando habitaciones disponibles del ${fechaEntrada} al ${fechaSalida}
            </div>
        </c:if>
        
        <!-- Room List -->
        <h2 class="mb-4">Habitaciones disponibles</h2>
        
        <div class="row">
            <c:choose>
                <c:when test="${empty habitaciones}">
                    <div class="col-12 text-center py-5">
                        <i class="bi bi-emoji-frown display-1 text-muted"></i>
                        <h3 class="mt-3">No se encontraron habitaciones disponibles</h3>
                        <p class="text-muted">Intenta con diferentes fechas o contacta directamente con el hotel.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${habitaciones}" var="habitacion">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card h-100 shadow-sm">
                                <!-- Room Image Placeholder (puedes reemplazarlo con imágenes reales) -->
                                <div class="bg-light text-center py-5">
                                    <i class="bi bi-building text-secondary" style="font-size: 4rem;"></i>
                                </div>
                                
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <h5 class="card-title">${habitacion.tipo}</h5>
                                        <span class="badge bg-success">Disponible</span>
                                    </div>
                                    
                                    <ul class="list-unstyled">
                                        <li class="mb-2">
                                            <i class="bi bi-people"></i> Capacidad: 
                                            <strong>${habitacion.capacidad} personas</strong>
                                        </li>
                                        <li class="mb-2">
                                            <i class="bi bi-cash"></i> Precio por noche: 
                                            <strong>$${habitacion.precioPorNoche}</strong>
                                        </li>
                                    </ul>
                                    
                                    <p class="card-text text-muted">${habitacion.descripcion}</p>
                                </div>
                                
                                <div class="card-footer bg-white border-top-0 pt-0">
                                    <c:choose>
                                        <c:when test="${not empty fechaEntrada and not empty fechaSalida}">
                                            <a href="${pageContext.request.contextPath}/reservas?accion=crearForm&habitacionId=${habitacion.id}&fechaEntrada=${fechaEntrada}&fechaSalida=${fechaSalida}" 
                                               class="btn btn-success w-100">
                                                <i class="bi bi-calendar-check"></i> Reservar ahora
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-warning text-center mb-0 py-2">
                                                <small><i class="bi bi-exclamation-triangle"></i> Selecciona fechas para reservar</small>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Back Button -->
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/app/hoteles" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Volver a hoteles
            </a>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/app/resources/js/script.js"></script>
</body>
</html>
