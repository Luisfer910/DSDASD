package com.epe2hotel.controller;

import com.epe2hotel.model.Habitacion;
import com.epe2hotel.model.Hotel;
import com.epe2hotel.service.HabitacionService;
import com.epe2hotel.service.HotelService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 *
 * @author LFMG9
 */

public class HabitacionController {
    
    private final HabitacionService habitacionService;
    private final HotelService hotelService;
    
    public HabitacionController() {
        this.habitacionService = new HabitacionService();
        this.hotelService = new HotelService();
    }
    
    public void procesarSolicitud(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            accion = "listar";
        }
        
        switch (accion) {
            case "listar":
                listarHabitaciones(request, response);
                break;
            case "listarPorHotel":
                listarHabitacionesPorHotel(request, response);
                break;
            case "buscarDisponibles":
                buscarHabitacionesDisponibles(request, response);
                break;
            default:
                listarHabitaciones(request, response);
                break;
        }
    }
    
    private void listarHabitaciones(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Habitacion> habitaciones = habitacionService.listarTodas();
        request.setAttribute("habitaciones", habitaciones);
        request.getRequestDispatcher("/WEB-INF/views/habitacion/listar.jsp").forward(request, response);
    }
    
    private void listarHabitacionesPorHotel(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Integer hotelId = Integer.parseInt(request.getParameter("hotelId"));
        Hotel hotel = hotelService.buscarPorId(hotelId);
        List<Habitacion> habitaciones = habitacionService.buscarPorHotel(hotelId);
        
        request.setAttribute("hotel", hotel);
        request.setAttribute("habitaciones", habitaciones);
        request.getRequestDispatcher("/WEB-INF/views/habitacion/listar.jsp").forward(request, response);
    }
    
    private void buscarHabitacionesDisponibles(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Integer hotelId = Integer.valueOf(request.getParameter("hotelId"));
        String fechaEntradaStr = request.getParameter("fechaEntrada");
        String fechaSalidaStr = request.getParameter("fechaSalida");
        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate fechaEntrada = LocalDate.parse(fechaEntradaStr, formatter);
        LocalDate fechaSalida = LocalDate.parse(fechaSalidaStr, formatter);
        
        Hotel hotel = hotelService.buscarPorId(hotelId);
        List<Habitacion> habitaciones = habitacionService.buscarDisponiblesPorFechas(hotelId, fechaEntrada, fechaSalida);
        
        request.setAttribute("hotel", hotel);
        request.setAttribute("habitaciones", habitaciones);
        request.setAttribute("fechaEntrada", fechaEntradaStr);
        request.setAttribute("fechaSalida", fechaSalidaStr);
        request.getRequestDispatcher("/WEB-INF/views/habitacion/listar.jsp").forward(request, response);
    }
}
