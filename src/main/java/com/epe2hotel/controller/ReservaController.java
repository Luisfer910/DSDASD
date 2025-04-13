package com.epe2hotel.controller;

import com.epe2hotel.model.Habitacion;
import com.epe2hotel.model.Reserva;
import com.epe2hotel.model.Usuario;
import com.epe2hotel.service.HabitacionService;
import com.epe2hotel.service.ReservaService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 *
 * @author LFMG9
 */

public class ReservaController {
    
    private final ReservaService reservaService;
    private final HabitacionService habitacionService;
    
    public ReservaController() {
        this.reservaService = new ReservaService();
        this.habitacionService = new HabitacionService();
    }
    
    public void procesarSolicitud(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        // Verificar si el usuario está autenticado
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            accion = "misReservas";
        }
        
        switch (accion) {
            case "misReservas":
                misReservas(request, response, usuario);
                break;
            case "crearForm":
                mostrarFormularioCrear(request, response);
                break;
            case "crear":
                crearReserva(request, response, usuario);
                break;
            case "cancelar":
                cancelarReserva(request, response, usuario);
                break;
            default:
                misReservas(request, response, usuario);
                break;
        }
    }
    
    private void misReservas(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws ServletException, IOException {
        List<Reserva> reservas = reservaService.buscarPorUsuario(usuario.getId());
        request.setAttribute("reservas", reservas);
        request.getRequestDispatcher("/WEB-INF/views/reserva/mis-reservas.jsp").forward(request, response);
    }
    
    private void mostrarFormularioCrear(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Integer habitacionId = Integer.parseInt(request.getParameter("habitacionId"));
        String fechaEntradaStr = request.getParameter("fechaEntrada");
        String fechaSalidaStr = request.getParameter("fechaSalida");
        
        Habitacion habitacion = habitacionService.buscarPorId(habitacionId);
        
        request.setAttribute("habitacion", habitacion);
        request.setAttribute("fechaEntrada", fechaEntradaStr);
        request.setAttribute("fechaSalida", fechaSalidaStr);
        request.getRequestDispatcher("/WEB-INF/views/reserva/crear.jsp").forward(request, response);
    }
    
    private void crearReserva(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws ServletException, IOException {
        Integer habitacionId = Integer.parseInt(request.getParameter("habitacionId"));
        String fechaEntradaStr = request.getParameter("fechaEntrada");
        String fechaSalidaStr = request.getParameter("fechaSalida");
        Integer numeroPersonas = Integer.parseInt(request.getParameter("numeroPersonas"));
        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate fechaEntrada = LocalDate.parse(fechaEntradaStr, formatter);
        LocalDate fechaSalida = LocalDate.parse(fechaSalidaStr, formatter);
        
        try {
            reservaService.crearReserva(usuario.getId(), habitacionId, fechaEntrada, fechaSalida, numeroPersonas);

            request.setAttribute("mensaje", "Reserva creada exitosamente");
            misReservas(request, response, usuario);
        } catch (Exception e) {
            request.setAttribute("error", "Error al crear la reserva: " + e.getMessage());
            mostrarFormularioCrear(request, response);
        }
    }
    
    private void cancelarReserva(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws ServletException, IOException {
        Integer reservaId = Integer.parseInt(request.getParameter("reservaId"));
        
        try {
            reservaService.cancelarReserva(reservaId);
            request.setAttribute("mensaje", "Reserva cancelada exitosamente");
        } catch (Exception e) {
            request.setAttribute("error", "Error al cancelar la reserva: " + e.getMessage());
        }
        
        misReservas(request, response, usuario);
    }
}
