package com.epe2hotel.dao;

import com.epe2hotel.model.Habitacion;
import com.epe2hotel.model.Hotel;
import com.epe2hotel.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.math.BigDecimal;
import java.util.List;

/**
 *
 * @author LFMG9
 */

public class HabitacionDAO {
    
    public List<Habitacion> listarTodas() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Habitacion> query = em.createQuery("SELECT h FROM Habitacion h", Habitacion.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public Habitacion buscarPorId(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Habitacion.class, id);
        } finally {
            em.close();
        }
    }
    
    public void guardar(Habitacion habitacion) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            if (habitacion.getId() == null) {
                em.persist(habitacion);
            } else {
                em.merge(habitacion);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
    
    public void eliminar(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Habitacion habitacion = em.find(Habitacion.class, id);
            if (habitacion != null) {
                em.remove(habitacion);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
    
    public List<Habitacion> buscarPorHotel(Integer hotelId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Habitacion> query = em.createQuery(
                "SELECT h FROM Habitacion h WHERE h.hotel.id = :hotelId",
                Habitacion.class
            );
            query.setParameter("hotelId", hotelId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Habitacion> buscarPorTipo(String tipo) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Habitacion> query = em.createQuery(
                "SELECT h FROM Habitacion h WHERE h.tipo = :tipo",
                Habitacion.class
            );
            query.setParameter("tipo", tipo);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Habitacion> buscarPorCapacidad(int capacidadMinima) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Habitacion> query = em.createQuery(
                "SELECT h FROM Habitacion h WHERE h.capacidad >= :capacidadMinima",
                Habitacion.class
            );
            query.setParameter("capacidadMinima", capacidadMinima);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Habitacion> buscarPorRangoPrecio(BigDecimal precioMin, BigDecimal precioMax) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Habitacion> query = em.createQuery(
                "SELECT h FROM Habitacion h WHERE h.precioPorNoche BETWEEN :precioMin AND :precioMax",
                Habitacion.class
            );
            query.setParameter("precioMin", precioMin);
            query.setParameter("precioMax", precioMax);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public long contarHabitaciones() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(h) FROM Habitacion h", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }
    
    public long contarHabitacionesPorHotel(Integer hotelId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(h) FROM Habitacion h WHERE h.hotel.id = :hotelId",
                Long.class
            );
            query.setParameter("hotelId", hotelId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
