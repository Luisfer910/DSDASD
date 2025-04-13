package com.epe2hotel.model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LFMG9
 */

@Entity
@Table(name = "habitaciones")
public class Habitacion implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "hotel_id", nullable = false)
    private Hotel hotel;
    
    @Column(nullable = false)
    private String tipo;
    
    @Column(nullable = false)
    private Integer capacidad;
    
    @Column(name = "precio_por_noche", nullable = false)
    private BigDecimal precioPorNoche;
    
    @Column(columnDefinition = "TEXT")
    private String descripcion;
    
    @Column(nullable = false)
    private Boolean disponible = true;
    
    @OneToMany(mappedBy = "habitacion", cascade = CascadeType.ALL)
    private List<Reserva> reservas = new ArrayList<>();
    
    // Constructor vacío
    public Habitacion() {
    }
    
    // Constructor con parámetros
    public Habitacion(Hotel hotel, String tipo, Integer capacidad, BigDecimal precioPorNoche, String descripcion, Boolean disponible) {
        this.hotel = hotel;
        this.tipo = tipo;
        this.capacidad = capacidad;
        this.precioPorNoche = precioPorNoche;
        this.descripcion = descripcion;
        this.disponible = disponible;
    }
    
    // Getters y Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Hotel getHotel() {
        return hotel;
    }

    public void setHotel(Hotel hotel) {
        this.hotel = hotel;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Integer getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(Integer capacidad) {
        this.capacidad = capacidad;
    }

    public BigDecimal getPrecioPorNoche() {
        return precioPorNoche;
    }

    public void setPrecioPorNoche(BigDecimal precioPorNoche) {
        this.precioPorNoche = precioPorNoche;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Boolean getDisponible() {
        return disponible;
    }

    public void setDisponible(Boolean disponible) {
        this.disponible = disponible;
    }

    public List<Reserva> getReservas() {
        return reservas;
    }

    public void setReservas(List<Reserva> reservas) {
        this.reservas = reservas;
    }
    
    // Método helper para añadir reserva
    public void addReserva(Reserva reserva) {
        reservas.add(reserva);
        reserva.setHabitacion(this);
    }
    
    @Override
    public String toString() {
        return "Habitacion{" + "id=" + id + ", tipo=" + tipo + ", hotel=" + hotel.getNombre() + '}';
    }
}
