package com.epe2hotel.service;

import com.epe2hotel.dao.HabitacionDAO;
import com.epe2hotel.dao.ReservaDAO;
import com.epe2hotel.model.Habitacion;
import com.epe2hotel.model.Hotel;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author LFMG9
 */

public class HabitacionService {
    
    private final HabitacionDAO habitacionDAO;
    private final ReservaDAO reservaDAO;
    
    public HabitacionService() {
        this.habitacionDAO = new HabitacionDAO();
        this.reservaDAO = new ReservaDAO();
    }
    
    public List<Habitacion> listarTodas() {
        return habitacionDAO.listarTodas();
    }
    
    public Habitacion buscarPorId(Integer id) {
        return habitacionDAO.buscarPorId(id);
    }
    
    public void guardar(Habitacion habitacion) {
        habitacionDAO.guardar(habitacion);
    }
    
    public void eliminar(Integer id) {
        habitacionDAO.eliminar(id);
    }
    
    public List<Habitacion> buscarPorHotel(Integer hotelId) {
        return habitacionDAO.buscarPorHotel(hotelId);
    }
    
    public List<Habitacion> buscarDisponiblesPorHotel(Integer hotelId, LocalDate fechaEntrada, LocalDate fechaSalida) {
        List<Habitacion> habitaciones = habitacionDAO.buscarPorHotel(hotelId);
        
        return habitaciones.stream()
                .filter(h -> esHabitacionDisponible(h.getId(), fechaEntrada, fechaSalida))
                .collect(Collectors.toList());
    }
    
    public boolean esHabitacionDisponible(Integer habitacionId, LocalDate fechaEntrada, LocalDate fechaSalida) {
        return reservaDAO.buscarPorFechas(habitacionId, fechaEntrada, fechaSalida).isEmpty();
    }
    
    public long contarHabitaciones() {
        return habitacionDAO.contarHabitaciones();
    }

    public List<Habitacion> buscarDisponiblesPorFechas(Integer hotelId, LocalDate fechaEntrada, LocalDate fechaSalida) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
