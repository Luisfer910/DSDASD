<%-- 
    Document   : listar
    Created on : 12-04-2025, 10:55:35 p. m.
    Author     : LFMG9
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hoteles Disponibles - Reservas Hotel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/app/resources/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
 <main class="container py-4">
    <div class="container py-3">
        <h1 class="mb-3">Hoteles disponibles <c:if test="${not empty ciudad}">en ${ciudad}</c:if></h1>
        
        <!-- Search Box -->
        <div class="card shadow mb-4">
            <div class="card-body p-3">
                <form action="${pageContext.request.contextPath}/app/hoteles" method="get">
                    <input type="hidden" name="accion" value="buscar">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <label for="ciudad" class="form-label">Destino:</label>
                            <input type="text" class="form-control" id="ciudad" name="ciudad" placeholder="¿A dónde vas?" value="${ciudad}" required>
                        </div>
                        <div class="col-md-4 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary w-100">Buscar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Hotel List -->
        <div class="row">
            <c:choose>
                <c:when test="${empty hoteles}">
                    <div class="col-12 text-center py-4">
                        <h2>No se encontraron hoteles</h2>
                        <p class="text-muted">Intenta con diferentes criterios de búsqueda.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${hoteles}" var="hotel">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card h-100 shadow-sm">

        
<c:choose>
    <c:when test="${hotel.id == 1}">
        <img src="/tu-aplicacion/resources/img/hoteles/1.jpg" 
             class="card-img-top" alt="Hotel Majestic" style="height: 200px; object-fit: cover;">
    </c:when>
    <c:when test="${hotel.id == 2}">
        <img src="/tu-aplicacion/resources/img/hoteles/2.jpg" 
             class="card-img-top" alt="Hotel Costanera" style="height: 200px; object-fit: cover;">
    </c:when>
    <c:when test="${hotel.id == 3}">
        <img src="/tu-aplicacion/resources/img/hoteles/3.jpg" 
             class="card-img-top" alt="Hotel Montaña" style="height: 200px; object-fit: cover;">
    </c:when>
    <c:otherwise>
        <img src="/tu-aplicacion/resources/img/hotel-default.jpg" 
             class="card-img-top" alt="Hotel" style="height: 200px; object-fit: cover;">
    </c:otherwise>
</c:choose>
                
                                <div class="card-body">
                                    <h5 class="card-title">${hotel.nombre}</h5>
                                    <p class="card-text text-muted"><i class="bi bi-geo-alt"></i> ${hotel.direccion}, ${hotel.ciudad}, ${hotel.pais}</p>
                                    <p class="card-text">
                                        <c:forEach begin="1" end="${hotel.estrellas}">
                                            <i class="bi bi-star-fill text-warning"></i>
                                        </c:forEach>
                                    </p>
                                    <p class="card-text small">${hotel.descripcion}</p>
                                </div>
                                <div class="card-footer bg-white border-top-0 pt-0">
                                    <a href="${pageContext.request.contextPath}/app/hoteles?accion=ver&id=${hotel.id}" class="btn btn-outline-primary w-100">Ver detalles</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>

    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/app/resources/js/script.js"></script>
</body>
</html> 