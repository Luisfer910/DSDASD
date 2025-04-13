package com.epe2hotel.dao;

import com.epe2hotel.model.Reserva;
import com.epe2hotel.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.time.LocalDate;
import java.util.List;

/**
 *
 * @author LFMG9
 */

public class ReservaDAO {
    
    public List<Reserva> listarTodas() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Reserva> query = em.createQuery("SELECT r FROM Reserva r", Reserva.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public Reserva buscarPorId(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Reserva.class, id);
        } finally {
            em.close();
        }
    }
    
    public List<Reserva> buscarPorUsuario(Integer usuarioId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Reserva> query = em.createQuery(
                "SELECT r FROM Reserva r WHERE r.usuario.id = :usuarioId",
                Reserva.class
            );
            query.setParameter("usuarioId", usuarioId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Reserva> buscarPorHabitacion(Integer habitacionId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Reserva> query = em.createQuery(
                "SELECT r FROM Reserva r WHERE r.habitacion.id = :habitacionId",
                Reserva.class
            );
            query.setParameter("habitacionId", habitacionId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Reserva> buscarPorFechas(Integer habitacionId, LocalDate fechaEntrada, LocalDate fechaSalida) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Reserva> query = em.createQuery(
                "SELECT r FROM Reserva r WHERE r.habitacion.id = :habitacionId " +
                "AND r.estado != 'CANCELADA' " +
                "AND ((r.fechaEntrada <= :fechaSalida AND r.fechaSalida >= :fechaEntrada))",
                Reserva.class
            );
            query.setParameter("habitacionId", habitacionId);
            query.setParameter("fechaEntrada", fechaEntrada);
            query.setParameter("fechaSalida", fechaSalida);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Reserva> buscarPorEstado(String estado) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Reserva> query = em.createQuery(
                "SELECT r FROM Reserva r WHERE r.estado = :estado",
                Reserva.class
            );
            query.setParameter("estado", estado);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public void guardar(Reserva reserva) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            if (reserva.getId() == null) {
                em.persist(reserva);
            } else {
                em.merge(reserva);
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
            Reserva reserva = em.find(Reserva.class, id);
            if (reserva != null) {
                em.remove(reserva);
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
    
    public long contarReservas() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(r) FROM Reserva r", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }
    
    public List<Reserva> obtenerUltimasReservas(int cantidad) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Reserva> query = em.createQuery(
                "SELECT r FROM Reserva r ORDER BY r.fechaCreacion DESC",
                Reserva.class
            );
            query.setMaxResults(cantidad);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public long contarReservasPorEstado(String estado) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(r) FROM Reserva r WHERE r.estado = :estado",
                Long.class
            );
            query.setParameter("estado", estado);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
