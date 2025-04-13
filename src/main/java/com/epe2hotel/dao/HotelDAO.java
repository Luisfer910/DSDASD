package com.epe2hotel.dao;

import com.epe2hotel.model.Hotel;
import com.epe2hotel.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

/**
 *
 * @author LFMG9
 */

public class HotelDAO {
    
    public List<Hotel> listarTodos() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Hotel> query = em.createQuery("SELECT h FROM Hotel h", Hotel.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public Hotel buscarPorId(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Hotel.class, id);
        } finally {
            em.close();
        }
    }
    
    public void guardar(Hotel hotel) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            if (hotel.getId() == null) {
                em.persist(hotel);
            } else {
                em.merge(hotel);
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
            Hotel hotel = em.find(Hotel.class, id);
            if (hotel != null) {
                em.remove(hotel);
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
    
    public List<Hotel> buscarPorCiudad(String ciudad) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Hotel> query = em.createQuery(
                "SELECT h FROM Hotel h WHERE LOWER(h.ciudad) LIKE :ciudad",
                Hotel.class
            );
            query.setParameter("ciudad", "%" + ciudad.toLowerCase() + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Hotel> buscarPorNombre(String nombre) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Hotel> query = em.createQuery(
                "SELECT h FROM Hotel h WHERE LOWER(h.nombre) LIKE :nombre",
                Hotel.class
            );
            query.setParameter("nombre", "%" + nombre.toLowerCase() + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public long contarHoteles() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(h) FROM Hotel h", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }
}
