<%-- 
    Document   : footer
    Created on : 12-04-2025, 10:55:13 p. m.
    Author     : LFMG9
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<footer class="bg-dark text-light py-4 mt-5">
  <div class="container">
    <div class="row">
      <div class="col-md-4 mb-3">
        <h5>Reservas Hotel</h5>
        <p>Tu plataforma de reservas de hoteles de confianza.</p>
      </div>
      <div class="col-md-4 mb-3">
        <h5>Enlaces rápidos</h5>
        <ul class="list-unstyled">
          <li><a href="${pageContext.request.contextPath}/app/" class="text-decoration-none text-light">Inicio</a></li>
          <li><a href="${pageContext.request.contextPath}/app/hoteles" class="text-decoration-none text-light">Hoteles</a></li>
          <li><a href="${pageContext.request.contextPath}/app/login" class="text-decoration-none text-light">Iniciar Sesión</a></li>
          <li><a href="${pageContext.request.contextPath}/app/registro" class="text-decoration-none text-light">Registrarse</a></li>
        </ul>
      </div>
      <div class="col-md-4 mb-3">
        <h5>Contacto</h5>
        <p>Email: info@reservashotel.com</p>
        <p>Teléfono: +56 9 1234 5678</p>
      </div>
    </div>
    <div class="text-center pt-3 border-top border-secondary">
      <p class="mb-0">&copy; 2025 Sistema de Reservas de Hotel</p>
    </div>
  </div>
</footer>