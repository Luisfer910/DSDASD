package com.epe2hotel.controller;

import com.epe2hotel.model.Hotel;
import com.epe2hotel.model.Habitacion;
import com.epe2hotel.model.Usuario;
import com.epe2hotel.service.HotelService;
import com.epe2hotel.service.HabitacionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/*")
public class AdminController extends HttpServlet {
    
    private final HotelService hotelService;
    private final HabitacionService habitacionService;
    
    public AdminController() {
        this.hotelService = new HotelService();
        this.habitacionService = new HabitacionService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Verificar si el usuario es administrador
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        if (usuario == null || !usuario.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/app/login?error=acceso_denegado");
            return;
        }
        
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            mostrarDashboard(request, response);
        } else if (path.equals("/hoteles")) {
            listarHoteles(request, response);
        } else if (path.equals("/habitaciones")) {
            listarHabitaciones(request, response);
        } else {
            mostrarDashboard(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    public void mostrarDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Cargar datos para el dashboard
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }

    private void listarHoteles(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Hotel> hoteles = hotelService.listarTodos();
        request.setAttribute("hoteles", hoteles);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/hoteles.jsp").forward(request, response);
    }
    
    private void listarHabitaciones(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Habitacion> habitaciones = habitacionService.listarTodas();
        request.setAttribute("habitaciones", habitaciones);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/habitaciones.jsp").forward(request, response);
    }
}
