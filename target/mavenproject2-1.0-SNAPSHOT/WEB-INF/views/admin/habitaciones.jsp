<%-- 
    Document   : habitaciones
    Created on : 13-04-2025, 3:40:29 a. m.
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
    <title>Gestión de Habitaciones - Epe2Hotel</title>
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/app/admin?accion=habitaciones">
                                <i class="bi bi-door-open"></i> Habitaciones
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/app/admin?accion=reservas">
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
                    <h1 class="h2">
                        <c:choose>
                            <c:when test="${not empty hotel}">
                                Habitaciones de ${hotel.nombre}
                            </c:when>
                            <c:otherwise>
                                Gestión de Habitaciones
                            </c:otherwise>
                        </c:choose>
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <c:choose>
                            <c:when test="${not empty hotel}">
                                <a href="${pageContext.request.contextPath}/app/admin?accion=editarHabitacion&hotelId=${hotel.id}" class="btn btn-sm btn-outline-primary me-2">
                                    <i class="bi bi-plus-lg"></i> Nueva Habitación
                                </a>
                                <a href="${pageContext.request.contextPath}/app/admin?accion=hoteles" class="btn btn-sm btn-outline-secondary">
                                    <i class="bi bi-arrow-left"></i> Volver a Hoteles
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/app/admin?accion=editarHabitacion" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-plus-lg"></i> Nueva Habitación
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <!-- Mensaje de éxito/error -->
                <c:if test="${not empty param.mensaje}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${param.mensaje}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <!-- Habitaciones Table -->
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="bi bi-table me-1"></i> Listado de Habitaciones
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="habitacionTable" class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Hotel</th>
                                        <th>Tipo</th>
                                        <th>Capacidad</th>
                                        <th>Precio/Noche</th>
                                        <th>Disponible</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${habitaciones}" var="habitacion">
                                        <tr>
                                            <td>${habitacion.id}</td>
                                            <td>${habitacion.hotel.nombre}</td>
                                            <td>${habitacion.tipo}</td>
                                            <td>${habitacion.capacidad} personas</td>
                                            <td><fmt:formatNumber value="${habitacion.precioPorNoche}" type="currency" currencySymbol="$" /></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${habitacion.disponible}">
                                                        <span class="badge bg-success">Disponible</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">No Disponible</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="${pageContext.request.contextPath}/app/admin?accion=editarHabitacion&id=${habitacion.id}" class="btn btn-sm btn-primary">
                                                        <i class="bi bi-pencil"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal${habitacion.id}">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </div>
                                                
                                                <!-- Delete Modal -->
                                                <div class="modal fade" id="deleteModal${habitacion.id}" tabindex="-1" aria-labelledby="deleteModalLabel${habitacion.id}" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="deleteModalLabel${habitacion.id}">Confirmar eliminación</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                ¿Estás seguro de que deseas eliminar la habitación "${habitacion.tipo}" del hotel "${habitacion.hotel.nombre}"?
                                                                <p class="text-danger mt-2">
                                                                    <i class="bi bi-exclamation-triangle-fill"></i> Esta acción no se puede deshacer y eliminará todas las reservas asociadas.
                                                                </p>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                                                <a href="${pageContext.request.contextPath}/app/admin?accion=eliminarHabitacion&id=${habitacion.id}&hotelId=${habitacion.hotel.id}" class="btn btn-danger">Eliminar</a>
                                                            </div>
                                                        </div>
                                                    </div>
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
    <script src
