package com.epe2hotel.controller;

import com.epe2hotel.model.Hotel;
import com.epe2hotel.service.HotelService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author LFMG9
 */

public class HotelController {
    
    private final HotelService hotelService;
    
    public HotelController() {
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
                listarHoteles(request, response);
                break;
            case "ver":
                verHotel(request, response);
                break;
            case "buscar":
                buscarHoteles(request, response);
                break;
            default:
                listarHoteles(request, response);
                break;
        }
    }
    
    private void listarHoteles(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Hotel> hoteles = hotelService.listarTodos();
        request.setAttribute("hoteles", hoteles);
        request.getRequestDispatcher("/WEB-INF/views/hotel/listar.jsp").forward(request, response);
    }
    
    private void verHotel(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        Hotel hotel = hotelService.buscarPorId(id);
        request.setAttribute("hotel", hotel);
        request.getRequestDispatcher("/WEB-INF/views/hotel/ver.jsp").forward(request, response);
    }
    
    private void buscarHoteles(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String ciudad = request.getParameter("ciudad");
        List<Hotel> hoteles = hotelService.buscarPorCiudad(ciudad);
        request.setAttribute("hoteles", hoteles);
        request.setAttribute("ciudad", ciudad);
        request.getRequestDispatcher("/WEB-INF/views/hotel/listar.jsp").forward(request, response);
    }
}
