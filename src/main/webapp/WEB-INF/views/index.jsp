<%-- 
    Document   : index
    Created on : 12-04-2025, 10:54:05 p. m.
    Author     : LFMG9
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservas Hotel - Tu mejor opción para hospedarte</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <main>
        <!-- Hero Section -->
        <section class="py-5">
            <div class="container">
                <div class="text-center mb-5">
                    <h1 class="display-4 fw-bold">¡Bienvenido al Sistema de Reservas de Hotel!</h1>
                    <p class="lead text-muted">Encuentra el hotel perfecto para tus vacaciones o viajes de negocios.</p>
                    <hr class="my-4">
                    <p>Busca entre nuestra amplia selección de hoteles en diferentes ciudades.</p>
                </div>
                
                <!-- Search Box -->
                <div class="card shadow mb-5">
                    <div class="card-body p-4">
                        <h2 class="card-title h4 mb-4">Buscar Hoteles</h2>
                        <form action="${pageContext.request.contextPath}/app/hoteles" method="get">
                            <input type="hidden" name="accion" value="buscar">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="ciudad" class="form-label">Ciudad</label>
                                    <input type="text" class="form-control" id="ciudad" name="ciudad" placeholder="¿A dónde vas?" required>
                                </div>
                                <div class="col-md-3">
                                    <label for="fechaEntrada" class="form-label">Fecha de Ingreso</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="fechaEntrada" name="fechaEntrada" placeholder="dd-mm-aaaa" required>
                                        <span class="input-group-text"><i class="bi bi-calendar"></i></span>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label for="fechaSalida" class="form-label">Fecha de Salida</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="fechaSalida" name="fechaSalida" placeholder="dd-mm-aaaa" required>
                                        <span class="input-group-text"><i class="bi bi-calendar"></i></span>
                                    </div>
                                </div>
                                <div class="col-md-2 d-flex align-items-end">
                                    <button type="submit" class="btn btn-primary w-100">Buscar</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Features Section -->
                <div class="row g-4 mb-5">
                    <div class="col-md-4">
                        <div class="card h-100 shadow-sm">
                            <div class="card-body text-center p-4">
                                <h3 class="h5 mb-3">Amplia Selección</h3>
                                <p class="card-text">Encuentra hoteles de todas las categorías, desde económicos hasta de lujo.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card h-100 shadow-sm">
                            <div class="card-body text-center p-4">
                                <h3 class="h5 mb-3">Reservas Fáciles</h3>
                                <p class="card-text">Proceso de reserva simple y rápido, con confirmación inmediata.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card h-100 shadow-sm">
                            <div class="card-body text-center p-4">
                                <h3 class="h5 mb-3">Gestión de Reservas</h3>
                                <p class="card-text">Gestiona tus reservas en cualquier momento, con opciones de modificación y cancelación.</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Featured Hotels -->
                <c:if test="${not empty hoteles}">
                    <h2 class="h3 mb-4">Hoteles Destacados</h2>
                    <div class="row row-cols-1 row-cols-md-3 g-4">
                        <c:forEach items="${hoteles}" var="hotel">
                            <div class="col">
                                <div class="card h-100 shadow-sm">
                                    <img src="${pageContext.request.contextPath}/resources/img/hotel-placeholder.jpg" class="card-img-top" alt="${hotel.nombre}">
                                    <div class="card-body">
                                        <h5 class="card-title">${hotel.nombre}</h5>
                                        <p class="card-text text-muted"><i class="bi bi-geo-alt"></i> ${hotel.ciudad}, ${hotel.pais}</p>
                                        <p class="card-text">
                                            <c:forEach begin="1" end="${hotel.estrellas}">
                                                <i class="bi bi-star-fill text-warning"></i>
                                            </c:forEach>
                                        </p>
                                        <a href="${pageContext.request.contextPath}/app/hoteles?accion=ver&id=${hotel.id}" class="btn btn-outline-primary">Ver detalles</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </section>
    </main>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
</body>
</html>