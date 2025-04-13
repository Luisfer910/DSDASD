package com.epe2hotel.service;

import com.epe2hotel.dao.HabitacionDAO;
import com.epe2hotel.dao.ReservaDAO;
import com.epe2hotel.dao.UsuarioDAO;
import com.epe2hotel.model.Habitacion;
import com.epe2hotel.model.Reserva;
import com.epe2hotel.model.Usuario;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

/**
 *
 * @author LFMG9
 */

public class ReservaService {
    
    private final ReservaDAO reservaDAO;
    private final UsuarioDAO usuarioDAO;
    private final HabitacionDAO habitacionDAO;
    
    public ReservaService() {
        this.reservaDAO = new ReservaDAO();
        this.usuarioDAO = new UsuarioDAO();
        this.habitacionDAO = new HabitacionDAO();
    }
    
    public List<Reserva> listarTodas() {
        return reservaDAO.listarTodas();
    }
    
    public Reserva buscarPorId(Integer id) {
        return reservaDAO.buscarPorId(id);
    }
    
    public List<Reserva> buscarPorUsuario(Integer usuarioId) {
        return reservaDAO.buscarPorUsuario(usuarioId);
    }
    
    public List<Reserva> buscarPorUsuario(Usuario usuario) {
        return reservaDAO.buscarPorUsuario(usuario.getId());
    }
    
    public List<Reserva> buscarPorHabitacion(Integer habitacionId) {
        return reservaDAO.buscarPorHabitacion(habitacionId);
    }
    
    public boolean esHabitacionDisponible(Integer habitacionId, LocalDate fechaEntrada, LocalDate fechaSalida) {
        List<Reserva> reservas = reservaDAO.buscarPorFechas(habitacionId, fechaEntrada, fechaSalida);
        return reservas.isEmpty();
    }
    
    public BigDecimal calcularPrecioTotal(Integer habitacionId, LocalDate fechaEntrada, LocalDate fechaSalida) {
        Habitacion habitacion = habitacionDAO.buscarPorId(habitacionId);
        long dias = ChronoUnit.DAYS.between(fechaEntrada, fechaSalida);
        
        if (dias <= 0) {
            dias = 1; // Mínimo un día
        }
        
        return habitacion.getPrecioPorNoche().multiply(BigDecimal.valueOf(dias));
    }
    
    public Reserva crearReserva(Integer usuarioId, Integer habitacionId, LocalDate fechaEntrada, LocalDate fechaSalida) {
        if (!esHabitacionDisponible(habitacionId, fechaEntrada, fechaSalida)) {
            throw new IllegalStateException("La habitación no está disponible en las fechas seleccionadas");
        }
        
        Usuario usuario = usuarioDAO.buscarPorId(usuarioId);
        Habitacion habitacion = habitacionDAO.buscarPorId(habitacionId);
        BigDecimal precioTotal = calcularPrecioTotal(habitacionId, fechaEntrada, fechaSalida);
        
        Reserva reserva = new Reserva();
        reserva.setUsuario(usuario);
        reserva.setHabitacion(habitacion);
        reserva.setFechaEntrada(fechaEntrada);
        reserva.setFechaSalida(fechaSalida);
        reserva.setPrecioTotal(precioTotal);
        reserva.setEstado("PENDIENTE");
        reserva.setFechaCreacion(LocalDate.now());
        
        reservaDAO.guardar(reserva);
        return reserva;
    }
    
    public void guardar(Reserva reserva) {
        reservaDAO.guardar(reserva);
    }
    
    public void cambiarEstado(Integer reservaId, String nuevoEstado) {
        Reserva reserva = reservaDAO.buscarPorId(reservaId);
        reserva.setEstado(nuevoEstado);
        reservaDAO.guardar(reserva);
    }
    
    public void cancelarReserva(Integer reservaId) {
        cambiarEstado(reservaId, "CANCELADA");
    }
    
    public long contarReservas() {
        return reservaDAO.contarReservas();
    }
    
    public List<Reserva> obtenerUltimasReservas(int cantidad) {
        return reservaDAO.obtenerUltimasReservas(cantidad);
    }

    public void crearReserva(Integer id, Integer habitacionId, LocalDate fechaEntrada, LocalDate fechaSalida, Integer numeroPersonas) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
