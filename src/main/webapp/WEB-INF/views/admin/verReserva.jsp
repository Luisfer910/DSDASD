<%-- 
    Document   : verReserva
    Created on : 13-04-2025, 3:45:02 a. m.
    Author     : LFMG9
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Detalles de Reserva - Epe2Hotel</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/app/resources/css/admin.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
                <div class="position-sticky pt-3">
                    <div class="text-center mb-4">
                        <h5 class="text-white">Epe2Hotel Admin</h5>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/app/admin">
                                <i class="bi bi-speedometer2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/app/admin?accion=hoteles">
                                <i class="bi bi-building"></i> Hoteles
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/app/admin?accion=habitaciones">
                                <i class="bi bi-door-open"></i> Habitaciones
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/app/admin?accion=reservas">
                                <i class="bi bi-calendar-check"></i> Reservas
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/app/admin?accion=usuarios">
                                <i class="bi bi-people"></i> Usuarios
                            </a>
                        </li>
                        <li class="nav-item mt-5">
                            <a class="nav-link" href="${pageContext.request.contextPath}/app/">
                                <i class="bi bi-house"></i> Ir al sitio
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/app/logout">
                                <i class="bi bi-box-arrow-right"></i> Cerrar sesión
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
            
            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Detalles de Reserva #${reserva.id}</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/app/admin?accion=reservas" class="btn btn-sm btn-outline-secondary">
                            <i class="bi bi-arrow-left"></i> Volver
                        </a>
                    </div>
                </div>
                
                <!-- Mensaje de éxito/error -->
                <c:if test="${not empty param.mensaje}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${param.mensaje}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <div class="row">
                    <!-- Detalles de la Reserva -->
                    <div class="col-md-8">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="bi bi-info-circle me-1"></i> Información de la Reserva
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Estado:</h6>
                                        <c:choose>
                                            <c:when test="${reserva.estado eq 'PENDIENTE'}">
                                                <span class="badge bg-warning">Pendiente</span>
                                            </c:when>
                                            <c:when test="${reserva.estado eq 'CONFIRMADA'}">
                                                <span class="badge bg-success">Confirmada</span>
                                            </c:when>
                                            <c:when test="${reserva.estado eq 'CANCELADA'}">
                                                <span class="badge bg-danger">Cancelada</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${reserva.estado}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Fecha de Creación:</h6>
                                        <p><fmt:formatDate value="${reserva.fechaCreacion}" pattern="dd/MM/yyyy HH:mm" /></p>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Fecha de Entrada:</h6>
                                        <p><fmt:formatDate value="${reserva.fechaEntrada}" pattern="dd/MM/yyyy" /></p>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Fecha de Salida:</h6>
                                        <p><fmt:formatDate value="${reserva.fechaSalida}" pattern="dd/MM/yyyy" /></p>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Hotel:</h6>
                                        <p>${reserva.habitacion.hotel.nombre}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Habitación:</h6>
                                        <p>${reserva.habitacion.tipo} (Capacidad: ${reserva.habitacion.capacidad} personas)</p>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Precio por Noche:</h6>
                                        <p><fmt:formatNumber value="${reserva.habitacion.precioPorNoche}" type="currency" currencySymbol="$" /></p>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Precio Total:</h6>
                                        <p class="fw-bold text-primary"><fmt:formatNumber value="${reserva.precioTotal}" type="currency" currencySymbol="$" /></p>
                                    </div>
                                </div>
                                
                                <hr>
                                
                                <h5 class="mt-4">Cambiar Estado</h5>
                                <form action="${pageContext.request.contextPath}/app/admin?accion=cambiarEstadoReserva" method="post" class="row g-3">
                                    <input type="hidden" name="id" value="${reserva.id}">
                                    <div class="col-md-6">
                                        <select class="form-select" name="estado" required>
                                            <option value="PENDIENTE" ${reserva.estado eq 'PENDIENTE' ? 'selected' : ''}>Pendiente</option>
                                            <option value="PENDIENTE" ${reserva.estado eq 'PENDIENTE' ? 'selected' : ''}>Pendiente</option>
                                            <option value="CONFIRMADA" ${reserva.estado eq 'CONFIRMADA' ? 'selected' : ''}>Confirmada</option>
                                            <option value="CANCELADA" ${reserva.estado eq 'CANCELADA' ? 'selected' : ''}>Cancelada</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <button type="submit" class="btn btn-primary">Actualizar Estado</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Información del Usuario -->
                    <div class="col-md-4">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="bi bi-person me-1"></i> Información del Usuario
                            </div>
                            <div class="card-body">
                                <h6 class="fw-bold">Nombre:</h6>
                                <p>${reserva.usuario.nombre} ${reserva.usuario.apellido}</p>
                                
                                <h6 class="fw-bold">Email:</h6>
                                <p>${reserva.usuario.email}</p>
                                
                                <h6 class="fw-bold">Teléfono:</h6>
                                <p>${reserva.usuario.telefono}</p>
                                
                                <h6 class="fw-bold">Rol:</h6>
                                <p>
                                    <c:choose>
                                        <c:when test="${reserva.usuario.rol eq 'ADMIN'}">
                                            <span class="badge bg-danger">Administrador</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-info">Cliente</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                
                                <a href="${pageContext.request.contextPath}/app/admin?accion=verUsuario&id=${reserva.usuario.id}" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-person-badge"></i> Ver Perfil Completo
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
