package com.epe2hotel.model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

/**
 *
 * @author LFMG9
 */

@Entity
@Table(name = "reservas")
public class Reserva implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "usuario_id", nullable = false)
    private Usuario usuario;
    
    @ManyToOne
    @JoinColumn(name = "habitacion_id", nullable = false)
    private Habitacion habitacion;
    
    @Column(name = "fecha_entrada", nullable = false)
    private LocalDate fechaEntrada;
    
    @Column(name = "fecha_salida", nullable = false)
    private LocalDate fechaSalida;
    
    @Column(name = "numero_personas", nullable = false)
    private Integer numeroPersonas;
    
    @Column(name = "precio_total", nullable = false)
    private BigDecimal precioTotal;
    
    @Column(nullable = false)
    private String estado = "PENDIENTE"; // PENDIENTE, CONFIRMADA, CANCELADA
    
    // Constructor vacío
    public Reserva() {
    }
    
    // Constructor con parámetros
    public Reserva(Usuario usuario, Habitacion habitacion, LocalDate fechaEntrada, LocalDate fechaSalida, Integer numeroPersonas, BigDecimal precioTotal) {
        this.usuario = usuario;
        this.habitacion = habitacion;
        this.fechaEntrada = fechaEntrada;
        this.fechaSalida = fechaSalida;
        this.numeroPersonas = numeroPersonas;
        this.precioTotal = precioTotal;
    }
    
    // Getters y Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Habitacion getHabitacion() {
        return habitacion;
    }

    public void setHabitacion(Habitacion habitacion) {
        this.habitacion = habitacion;
    }

    public LocalDate getFechaEntrada() {
        return fechaEntrada;
    }

    public void setFechaEntrada(LocalDate fechaEntrada) {
        this.fechaEntrada = fechaEntrada;
    }

    public LocalDate getFechaSalida() {
        return fechaSalida;
    }

    public void setFechaSalida(LocalDate fechaSalida) {
        this.fechaSalida = fechaSalida;
    }

    public Integer getNumeroPersonas() {
        return numeroPersonas;
    }

    public void setNumeroPersonas(Integer numeroPersonas) {
        this.numeroPersonas = numeroPersonas;
    }

    public BigDecimal getPrecioTotal() {
        return precioTotal;
    }

    public void setPrecioTotal(BigDecimal precioTotal) {
        this.precioTotal = precioTotal;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    @Override
    public String toString() {
        return "Reserva{" + "id=" + id + ", usuario=" + usuario.getNombre() + ", habitacion=" + habitacion.getTipo() + ", hotel=" + habitacion.getHotel().getNombre() + '}';
    }

    public void setFechaCreacion(LocalDate now) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
