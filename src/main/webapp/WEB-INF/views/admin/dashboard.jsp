<%-- 
    Document   : dashboard
    Created on : 13-04-2025, 3:24:00 a. m.
    Author     : LFMG9
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Panel de Administración - Epe2Hotel</title>
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin">
                                <i class="bi bi-speedometer2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin?accion=hoteles">
                                <i class="bi bi-building"></i> Hoteles
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin?accion=habitaciones">
                                <i class="bi bi-door-open"></i> Habitaciones
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin?accion=reservas">
                                <i class="bi bi-calendar-check"></i> Reservas
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin?accion=usuarios">
                                <i class="bi bi-people"></i> Usuarios
                            </a>
                        </li>
                        <li class="nav-item mt-5">
                            <a class="nav-link" href="${pageContext.request.contextPath}/">
                                <i class="bi bi-house"></i> Ir al sitio
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right"></i> Cerrar sesión
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
            
            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Dashboard</h1>
                </div>
                
                <!-- Stats Cards -->
                <div class="row">
                    <div class="col-md-3 mb-4">
                        <div class="card bg-primary text-white h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase">Hoteles</h6>
                                        <h1>${totalHoteles}</h1>
                                    </div>
                                    <i class="bi bi-building display-4"></i>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a href="${pageContext.request.contextPath}/admin?accion=hoteles" class="text-white text-decoration-none">Ver detalles</a>
                                <i class="bi bi-chevron-right text-white"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card bg-success text-white h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase">Habitaciones</h6>
                                        <h1>${totalHabitaciones}</h1>
                                    </div>
                                    <i class="bi bi-door-open display-4"></i>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a href="${pageContext.request.contextPath}/admin?accion=habitaciones" class="text-white text-decoration-none">Ver detalles</a>
                                <i class="bi bi-chevron-right text-white"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card bg-warning text-white h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase">Reservas</h6>
                                        <h1>${totalReservas}</h1>
                                    </div>
                                    <i class="bi bi-calendar-check display-4"></i>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a href="${pageContext.request.contextPath}/admin?accion=reservas" class="text-white text-decoration-none">Ver detalles</a>
                                <i class="bi bi-chevron-right text-white"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card bg-danger text-white h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase">Usuarios</h6>
                                        <h1>${totalUsuarios}</h1>
                                    </div>
                                    <i class="bi bi-people display-4"></i>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a href="${pageContext.request.contextPath}/admin?accion=usuarios" class="text-white text-decoration-none">Ver detalles</a>
                                <i class="bi bi-chevron-right text-white"></i>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Latest Bookings -->
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="bi bi-table me-1"></i> Últimas Reservas
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Usuario</th>
                                        <th>Hotel</th>
                                        <th>Habitación</th>
                                        <th>Fechas</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${ultimasReservas}" var="reserva">
                                        <tr>
                                            <td>${reserva.id}</td>
                                            <td>${reserva.usuario.nombre} ${reserva.usuario.apellido}</td>
                                            <td>${reserva.habitacion.hotel.nombre}</td>
                                            <td>${reserva.habitacion.tipo}</td>
                                            <td>${reserva.fechaEntrada} - ${reserva.fechaSalida}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${reserva.estado == 'CONFIRMADA'}">
                                                        <span class="badge bg-success">Confirmada</span>
                                                    </c:when>
                                                    <c:when test="${reserva.estado == 'PENDIENTE'}">
                                                        <span class="badge bg-warning text-dark">Pendiente</span>
                                                    </c:when>
                                                    <c:when test="${reserva.estado == 'CANCELADA'}">
                                                        <span class="badge bg-danger">Cancelada</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${reserva.estado}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin?accion=verReserva&id=${reserva.id}" class="btn btn-sm btn-primary">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer small text-muted">
                        <a href="${pageContext.request.contextPath}/admin?accion=reservas" class="text-decoration-none">Ver todas las reservas</a>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</body>
</html>
