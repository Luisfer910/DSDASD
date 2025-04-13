package com.epe2hotel.service;

import com.epe2hotel.dao.HotelDAO;
import com.epe2hotel.model.Hotel;
import java.util.List;

/**
 *
 * @author LFMG9
 */

public class HotelService {
    
    private final HotelDAO hotelDAO;
    
    public HotelService() {
        this.hotelDAO = new HotelDAO();
    }
    
    public List<Hotel> listarTodos() {
        return hotelDAO.listarTodos();
    }
    
    public Hotel buscarPorId(Integer id) {
        return hotelDAO.buscarPorId(id);
    }
    
    public void guardar(Hotel hotel) {
        hotelDAO.guardar(hotel);
    }
    
    public void eliminar(Integer id) {
        hotelDAO.eliminar(id);
    }
    
    public List<Hotel> buscarPorCiudad(String ciudad) {
        return hotelDAO.buscarPorCiudad(ciudad);
    }
    
    public List<Hotel> buscarPorNombre(String nombre) {
        return hotelDAO.buscarPorNombre(nombre);
    }
    
    public long contarHoteles() {
        return hotelDAO.contarHoteles();
    }
}
