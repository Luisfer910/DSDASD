<%-- 
    Document   : reservas
    Created on : 13-04-2025, 3:44:31 a. m.
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
    <title>Gestión de Reservas - Epe2Hotel</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
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
                    <h1 class="h2">Gestión de Reservas</h1>
                </div>
                
                <!-- Mensaje de éxito/error -->
                <c:if test="${not empty param.mensaje}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${param.mensaje}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <!-- Filtros -->
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="bi bi-funnel me-1"></i> Filtros
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/app/admin" method="get" class="row g-3">
                            <input type="hidden" name="accion" value="reservas">
                            
                            <div class="col-md-4">
                                <label for="estado" class="form-label">Estado</label>
                                <select class="form-select" id="estado" name="estado">
                                    <option value="">Todos</option>
                                    <option value="PENDIENTE" ${param.estado == 'PENDIENTE' ? 'selected' : ''}>Pendiente</option>
                                    <option value="CONFIRMADA" ${param.estado == 'CONFIRMADA' ? 'selected' : ''}>Confirmada</option>
                                    <option value="CANCELADA" ${param.estado == 'CANCELADA' ? 'selected' : ''}>Cancelada</option>
                                </select>
                            </div>
                            
                            <div class="col-md-4">
                                <label for="fechaDesde" class="form-label">Fecha Desde</label>
                                <input type="date" class="form-control" id="fechaDesde" name="fechaDesde" value="${param.fechaDesde}">
                            </div>
                            
                            <div class="col-md-4">
                                <label for="fechaHasta" class="form-label">Fecha Hasta</label>
                                <input type="date" class="form-control" id="fechaHasta" name="fechaHasta" value="${param.fechaHasta}">
                            </div>
                            
                            <div class="col-12 text-end">
                                <button type="submit" class="btn btn-primary">Filtrar</button>
                                <a href="${pageContext.request.contextPath}/app/admin?accion=reservas" class="btn btn-secondary">Limpiar</a>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Reservas Table -->
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="bi bi-table me-1"></i> Listado de Reservas
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="reservaTable" class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Usuario</th>
                                        <th>Hotel</th>
                                        <th>Habitación</th>
                                        <th>Fecha Entrada</th>
                                        <th>Fecha Salida</th>
                                        <th>Precio Total</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${reservas}" var="reserva">
                                        <tr>
                                            <td>${reserva.id}</td>
                                            <td>${reserva.usuario.nombre} ${reserva.usuario.apellido}</td>
                                            <td>${reserva.habitacion.hotel.nombre}</td>
                                            <td>${reserva.habitacion.tipo}</td>
                                            <td><fmt:formatDate value="${reserva.fechaEntrada}" pattern="dd/MM/yyyy" /></td>
                                            <td><fmt:formatDate value="${reserva.fechaSalida}" pattern="dd/MM/yyyy" /></td>
                                            <td><fmt:formatNumber value="${reserva.precioTotal}" type="currency" currencySymbol="$" /></td>
                                            <td>
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
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="${pageContext.request.contextPath}/app/admin?accion=verReserva&id=${reserva.id}" class="btn btn-sm btn-primary">
                                                        <i class="bi bi-eye"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    
    <script>
        $(document).ready(function() {
            $('#reservaTable').DataTable({
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/es-ES.json'
                },
                responsive: true,
                order: [[0, 'desc']]
            });
        });
    </script>
</body>
</html>
