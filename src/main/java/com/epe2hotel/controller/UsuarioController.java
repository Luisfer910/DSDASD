package com.epe2hotel.controller;

import com.epe2hotel.model.Usuario;
import com.epe2hotel.service.UsuarioService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author LFMG9
 */

public class UsuarioController {
    
    private final UsuarioService usuarioService;
    
    public UsuarioController() {
        this.usuarioService = new UsuarioService();
    }
    
    public void procesarSolicitud(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        // Verificar si el usuario está autenticado
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            accion = "perfil";
        }
        
        switch (accion) {
            case "perfil":
                mostrarPerfil(request, response, usuario);
                break;
            case "actualizar":
                actualizarPerfil(request, response, usuario);
                break;
            default:
                mostrarPerfil(request, response, usuario);
                break;
        }
    }
    
    public void procesarLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("autenticar".equals(accion)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            Usuario usuario = usuarioService.autenticar(email, password);
            
            if (usuario != null) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                session.setAttribute("usuarioId", usuario.getId());
                session.setAttribute("usuarioNombre", usuario.getNombre());
                
                response.sendRedirect(request.getContextPath() + "/");
            } else {
                request.setAttribute("error", "Email o contraseña incorrectos");
                request.getRequestDispatcher("/WEB-INF/views/usuario/login.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("/WEB-INF/views/usuario/login.jsp").forward(request, response);
        }
    }
    
    public void procesarRegistro(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("registrar".equals(accion)) {
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String telefono = request.getParameter("telefono");
            
            // Validar datos
            if (usuarioService.buscarPorEmail(email) != null) {
                request.setAttribute("error", "El email ya está registrado");
                request.getRequestDispatcher("/WEB-INF/views/usuario/registro.jsp").forward(request, response);
                return;
            }
            
            // Crear nuevo usuario
            Usuario usuario = new Usuario(nombre, apellido, email, password, telefono);
            
            usuarioService.guardar(usuario);
            
            // Iniciar sesión automáticamente
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            session.setAttribute("usuarioId", usuario.getId());
            session.setAttribute("usuarioNombre", usuario.getNombre());
            
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            request.getRequestDispatcher("/WEB-INF/views/usuario/registro.jsp").forward(request, response);
        }
    }
    
    public void procesarLogout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        response.sendRedirect(request.getContextPath() + "/");
    }
    
    private void mostrarPerfil(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws ServletException, IOException {
        request.setAttribute("usuario", usuario);
        request.getRequestDispatcher("/WEB-INF/views/usuario/perfil.jsp").forward(request, response);
    }
    
    private void actualizarPerfil(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String telefono = request.getParameter("telefono");
        
        usuario.setNombre(nombre);
        usuario.setApellido(apellido);
        usuario.setTelefono(telefono);
        
        usuarioService.guardar(usuario);
        
        HttpSession session = request.getSession();
        session.setAttribute("usuario", usuario);
        session.setAttribute("usuarioNombre", usuario.getNombre());
        
        request.setAttribute("mensaje", "Perfil actualizado exitosamente");
        mostrarPerfil(request, response, usuario);
    }
}
