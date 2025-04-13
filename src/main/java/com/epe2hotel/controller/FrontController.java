package com.epe2hotel.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "FrontController", urlPatterns = {"/app/*"})
public class FrontController extends HttpServlet {
    // Este controlador recibe todas las peticiones que comienzan con /app/
    // y debería redirigir a los controladores específicos

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        procesarSolicitud(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        procesarSolicitud(request, response);
    }

    
private void procesarSolicitud(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    String path = request.getPathInfo();
    
    // Para depuración
    System.out.println("Path: " + path);
    System.out.println("Context Path: " + request.getContextPath());
    System.out.println("Request URI: " + request.getRequestURI());
    
    if (path == null || path.equals("/")) {
        request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
        return;
    }
        
    switch (path) {
        case "/hoteles":
            new HotelController().procesarSolicitud(request, response);
            break;
        case "/habitaciones":
            new HabitacionController().procesarSolicitud(request, response);
            break;
        case "/reservas":
            new ReservaController().procesarSolicitud(request, response);
            break;
        case "/usuarios":
            new UsuarioController().procesarSolicitud(request, response);
            break;
        case "/login":
            new UsuarioController().procesarLogin(request, response);
            break;
        case "/registro":
            new UsuarioController().procesarRegistro(request, response);
            break;
        case "/admin":
            // Redirigir al servlet AdminController
            request.getRequestDispatcher("/admin").forward(request, response);
            break;
        case "/admin/dashboard":
            // Nuevo caso para el dashboard de administrador
            new AdminController().mostrarDashboard(request, response);
            break;
        case "/usuario/perfil":
            // Nuevo caso para el perfil de usuario
            new UsuarioController().mostrarPerfil(request, response);
            break;
        default:
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            break;
    }
}

}
