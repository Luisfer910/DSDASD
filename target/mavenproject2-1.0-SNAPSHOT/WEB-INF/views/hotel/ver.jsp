<%-- 
    Document   : ver
    Created on : 12-04-2025, 10:56:00 p. m.
    Author     : LFMG9
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${hotel.nombre} - Epe2Hotel</title>
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
        <!-- Hotel Header -->
        <div class="row mb-5">
            <div class="col-lg-8">
                <h1 class="mb-2">${hotel.nombre}</h1>
                <p class="text-muted mb-2">
                    <i class="bi bi-geo-alt"></i> ${hotel.direccion}, ${hotel.ciudad}, ${hotel.pais}
                </p>
                <div class="mb-3">
                    <c:forEach begin="1" end="${hotel.estrellas}">
                        <i class="bi bi-star-fill text-warning"></i>
                    </c:forEach>
                </div>
                
                <!-- Hotel Amenities (puedes agregar esto si tienes datos) -->
                <div class="d-flex flex-wrap gap-3 mb-4">
                    <span class="badge bg-light text-dark p-2">
                        <i class="bi bi-wifi"></i> WiFi gratis
                    </span>
                    <span class="badge bg-light text-dark p-2">
                        <i class="bi bi-p-square"></i> Estacionamiento
                    </span>
                    <span class="badge bg-light text-dark p-2">
                        <i class="bi bi-cup-hot"></i> Desayuno
                    </span>
                    <span class="badge bg-light text-dark p-2">
                        <i class="bi bi-water"></i> Piscina
                    </span>
                </div>
            </div>
            
            <!-- Hotel Rating Card -->
            <div class="col-lg-4">
                <div class="card shadow-sm">
                    <div class="card-body text-center">
                        <div class="display-4 fw-bold text-primary mb-2">9.2</div>
                        <p class="mb-1">Excelente</p>
                        <p class="text-muted small">Basado en 245 opiniones</p>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <!-- Hotel Description -->
            <div class="col-lg-8 mb-4">
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <h2 class="card-title h4 mb-3">Descripción</h2>
                        <p class="card-text">${hotel.descripcion}</p>
                    </div>
                </div>
                
                <!-- Hotel Location (puedes agregar un mapa aquí) -->
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <h2 class="card-title h4 mb-3">Ubicación</h2>
                        <div class="bg-light p-3 text-center">
                            <i class="bi bi-map display-1 text-muted"></i>
                            <p class="mt-2">Mapa no disponible</p>
                        </div>
                        <p class="mt-3">
                            <i class="bi bi-geo-alt"></i> ${hotel.direccion}, ${hotel.ciudad}, ${hotel.pais}
                        </p>
                    </div>
                </div>
                
                <!-- Hotel Rooms -->
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <h2 class="card-title h4 mb-3">Tipos de habitaciones</h2>
                        
                        <c:choose>
                            <c:when test="${empty hotel.habitaciones}">
                                <p class="text-muted">No hay información de habitaciones disponible.</p>
                            </c:when>
                            <c:otherwise>
                                <div class="list-group">
                                    <c:forEach items="${hotel.habitaciones}" var="habitacion">
                                        <div class="list-group-item">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <h5 class="mb-1">${habitacion.tipo}</h5>
                                                <c:choose>
                                                    <c:when test="${habitacion.disponible}">
                                                        <span class="badge bg-success">Disponible</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">No disponible</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <p class="mb-1">Capacidad: ${habitacion.capacidad} personas</p>
                                            <p class="mb-1">Precio por noche: $${habitacion.precioPorNoche}</p>
                                            <small class="text-muted">${habitacion.descripcion}</small>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <!-- Sidebar - Search Box -->
            <div class="col-lg-4">
                <div class="card shadow-sm sticky-lg-top" style="top: 20px; z-index: 1;">
                    <div class="card-header bg-primary text-white">
                        <h3 class="card-title h5 mb-0">Buscar habitaciones disponibles</h3>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/app/habitaciones" method="get">
                            <input type="hidden" name="accion" value="buscarDisponibles">
                            <input type="hidden" name="hotelId" value="${hotel.id}">
                            
                            <div class="mb-3">
                                <label for="fechaEntrada" class="form-label">Fecha de entrada:</label>
                                <input type="date" class="form-control" id="fechaEntrada" name="fechaEntrada" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="fechaSalida" class="form-label">Fecha de salida:</label>
                                <input type="date" class="form-control" id="fechaSalida" name="fechaSalida" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="huespedes" class="form-label">Huéspedes:</label>
                                <select class="form-select" id="huespedes" name="huespedes">
                                    <option value="1">1 persona</option>
                                    <option value="2" selected>2 personas</option>
                                    <option value="3">3 personas</option>
                                    <option value="4">4 personas</option>
                                </select>
                            </div>
                            
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="bi bi-search"></i> Buscar habitaciones
                            </button>
                        </form>
                    </div>
                </div>
            </div>
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
    
    <!-- Script para inicializar fechas -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Configurar fechas mínimas
            const today = new Date();
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            
            const formatDate = (date) => {
                const year = date.getFullYear();
                const month = String(date.getMonth() + 1).padStart(2, '0');
                const day = String(date.getDate()).padStart(2, '0');
                return `${year}-${month}-${day}`;
            };
            
            // Configurar fecha de entrada
            const fechaEntrada = document.getElementById('fechaEntrada');
            fechaEntrada.min = formatDate(today);
            fechaEntrada.value = formatDate(today);
            
            // Configurar fecha de salida
            const fechaSalida = document.getElementById('fechaSalida');
            fechaSalida.min = formatDate(tomorrow);
            fechaSalida.value = formatDate(tomorrow);
            
            // Asegurar que la fecha de salida sea posterior a la fecha de entrada
            fechaEntrada.addEventListener('change', function() {
                const entrada = new Date(this.value);
                const salida = new Date(entrada);
                salida.setDate(salida.getDate() + 1);
                
                fechaSalida.min = formatDate(salida);
                
                // Si la fecha de salida es anterior a la nueva fecha de entrada + 1 día
                if (new Date(fechaSalida.value) <= entrada) {
                    fechaSalida.value = formatDate(salida);
                }
            });
        });
    </script>
</body>
</html>
