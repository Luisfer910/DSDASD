package com.epe2hotel.service;

import com.epe2hotel.dao.UsuarioDAO;
import com.epe2hotel.model.Usuario;
import java.util.List;

/**
 *
 * @author LFMG9
 */

public class UsuarioService {
    
    private final UsuarioDAO usuarioDAO;
    
    public UsuarioService() {
        this.usuarioDAO = new UsuarioDAO();
    }
    
    public List<Usuario> listarTodos() {
        return usuarioDAO.listarTodos();
    }
    
    public Usuario buscarPorId(Integer id) {
        return usuarioDAO.buscarPorId(id);
    }
    
    public Usuario buscarPorEmail(String email) {
        return usuarioDAO.buscarPorEmail(email);
    }
    
    public void guardar(Usuario usuario) {
        usuarioDAO.guardar(usuario);
    }
    
    public boolean validarCredenciales(String email, String password) {
        Usuario usuario = usuarioDAO.buscarPorEmail(email);
        if (usuario != null) {
            // En una aplicación real, deberías usar hash + salt para las contraseñas
            return password.equals(usuario.getPassword());
        }
        return false;
    }
    
    public Usuario registrarUsuario(String nombre, String apellido, String email, String password, String telefono) {
        Usuario existente = usuarioDAO.buscarPorEmail(email);
        if (existente != null) {
            throw new IllegalArgumentException("El email ya está registrado");
        }
        
        Usuario usuario = new Usuario();
        usuario.setNombre(nombre);
        usuario.setApellido(apellido);
        usuario.setEmail(email);
        usuario.setPassword(password); // En una aplicación real, deberías hacer hash de la contraseña
        usuario.setTelefono(telefono);
        usuario.setAdmin(false); // Por defecto, los usuarios no son administradores
        
        usuarioDAO.guardar(usuario);
        return usuario;
    }
    
    public void hacerAdmin(Integer usuarioId) {
        Usuario usuario = usuarioDAO.buscarPorId(usuarioId);
        usuario.setAdmin(true);
        usuarioDAO.guardar(usuario);
    }
    
    public void quitarAdmin(Integer usuarioId) {
        Usuario usuario = usuarioDAO.buscarPorId(usuarioId);
        usuario.setAdmin(false);
        usuarioDAO.guardar(usuario);
    }
    
    public long contarUsuarios() {
        return usuarioDAO.contarUsuarios();
    }

    public Usuario autenticar(String email, String password) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
