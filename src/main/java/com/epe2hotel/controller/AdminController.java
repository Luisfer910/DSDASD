package com.epe2hotel.controller;

import com.epe2hotel.model.Hotel;
import com.epe2hotel.model.Habitacion;
import com.epe2hotel.model.Reserva;
import com.epe2hotel.model.Usuario;
import com.epe2hotel.service.HotelService;
import com.epe2hotel.service.HabitacionService;
import com.epe2hotel.service.ReservaService;
import com.epe2hotel.service.UsuarioService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

public class AdminController {
    
    private final HotelService hotelService;
    private final HabitacionService habitacionService;
    private final ReservaService reservaService;
    private final UsuarioService usuarioService;
    
    public AdminController() {
        this.hotelService = new HotelService();
        this.habitacionService = new HabitacionService();
        this.reservaService = new ReservaService();
        this.usuarioService = new UsuarioService();
    }
    
    public void procesarPeticion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        // Verificar si el usuario es administrador
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        if (usuario == null || !usuario.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/app/login?error=acceso_denegado");
            return;
        }
        
        if (accion == null) {
            mostrarDashboard(request, response);
        } else {
            switch (accion) {
                case "hoteles":
                    listarHoteles(request, response);
                    break;
                case "habitaciones":
                    listarHabitaciones(request, response);
                    break;
                case "reservas":
                    listarReservas(request, response);
                    break;
                case "usuarios":
                    listarUsuarios(request, response);
                    break;
                case "editarHotel":
                    editarHotel(request, response);
                    break;
                case "guardarHotel":
                    guardarHotel(request, response);
                    break;
                case "eliminarHotel":
                    eliminarHotel(request, response);
                    break;
                case "editarHabitacion":
                    editarHabitacion(request, response);
                    break;
                case "guardarHabitacion":
                    guardarHabitacion(request, response);
                    break;
                case "eliminarHabitacion":
                    eliminarHabitacion(request, response);
                    break;
                case "verReserva":
                    verReserva(request, response);
                    break;
                case "cambiarEstadoReserva":
                    cambiarEstadoReserva(request, response);
                    break;
                case "verUsuario":
                    verUsuario(request, response);
                    break;
                default:
                    mostrarDashboard(request, response);
            }
        }
    }
    
    private void mostrarDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Obtener estadísticas para el dashboard
        long totalHoteles = hotelService.contarHoteles();
        long totalHabitaciones = habitacionService.contarHabitaciones();
        long totalReservas = reservaService.contarReservas();
        long totalUsuarios = usuarioService.contarUsuarios();
        
        // Obtener últimas reservas
        List<Reserva> ultimasReservas = reservaService.obtenerUltimasReservas(5);
        
        request.setAttribute("totalHoteles", totalHoteles);
        request.setAttribute("totalHabitaciones", totalHabitaciones);
        request.setAttribute("totalReservas", totalReservas);
        request.setAttribute("totalUsuarios", totalUsuarios);
        request.setAttribute("ultimasReservas", ultimasReservas);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
    
    private void listarHoteles(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Hotel> hoteles = hotelService.listarTodos();
        request.setAttribute("hoteles", hoteles);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/hoteles.jsp").forward(request, response);
    }
    
    private void listarHabitaciones(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String hotelId = request.getParameter("hotelId");
        List<Habitacion> habitaciones;
        
        if (hotelId != null && !hotelId.isEmpty()) {
            habitaciones = habitacionService.buscarPorHotel(Integer.parseInt(hotelId));
            request.setAttribute("hotelId", hotelId);
            Hotel hotel = hotelService.buscarPorId(Integer.parseInt(hotelId));
            request.setAttribute("hotel", hotel);
        } else {
            habitaciones = habitacionService.listarTodas();
        }
        
        request.setAttribute("habitaciones", habitaciones);
        request.getRequestDispatcher("/WEB-INF/views/admin/habitaciones.jsp").forward(request, response);
    }
    
    private void listarReservas(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Reserva> reservas = reservaService.listarTodas();
        request.setAttribute("reservas", reservas);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/reservas.jsp").forward(request, response);
    }
    
    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Usuario> usuarios = usuarioService.listarTodos();
        request.setAttribute("usuarios", usuarios);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/usuarios.jsp").forward(request, response);
    }
    
    // Métodos para gestionar hoteles
    private void editarHotel(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        Hotel hotel;
        
        if (id != null && !id.isEmpty()) {
            hotel = hotelService.buscarPorId(Integer.parseInt(id));
        } else {
            hotel = new Hotel();
        }
        
        request.setAttribute("hotel", hotel);
        request.getRequestDispatcher("/WEB-INF/views/admin/editarHotel.jsp").forward(request, response);
    }
    
    private void guardarHotel(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String direccion = request.getParameter("direccion");
        String ciudad = request.getParameter("ciudad");
        String pais = request.getParameter("pais");
        String estrellasStr = request.getParameter("estrellas");
        String descripcion = request.getParameter("descripcion");
        
        Hotel hotel;
        
        if (idStr != null && !idStr.isEmpty()) {
            hotel = hotelService.buscarPorId(Integer.parseInt(idStr));
        } else {
            hotel = new Hotel();
        }
        
        hotel.setNombre(nombre);
        hotel.setDireccion(direccion);
        hotel.setCiudad(ciudad);
        hotel.setPais(pais);
        hotel.setEstrellas(Integer.parseInt(estrellasStr));
        hotel.setDescripcion(descripcion);
        
        hotelService.guardar(hotel);
        
        response.sendRedirect(request.getContextPath() + "/app/admin?accion=hoteles&mensaje=Hotel guardado exitosamente");
    }
    
    private void eliminarHotel(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        
        if (id != null && !id.isEmpty()) {
            hotelService.eliminar(Integer.parseInt(id));
        }
        
        response.sendRedirect(request.getContextPath() + "/app/admin?accion=hoteles&mensaje=Hotel eliminado exitosamente");
    }
    
    // Métodos para gestionar habitaciones
    private void editarHabitacion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        String hotelId = request.getParameter("hotelId");
        
        Habitacion habitacion;
        
        if (id != null && !id.isEmpty()) {
            habitacion = habitacionService.buscarPorId(Integer.parseInt(id));
        } else {
            habitacion = new Habitacion();
            if (hotelId != null && !hotelId.isEmpty()) {
                Hotel hotel = hotelService.buscarPorId(Integer.parseInt(hotelId));
                habitacion.setHotel(hotel);
            }
        }
        
        List<Hotel> hoteles = hotelService.listarTodos();
        
        request.setAttribute("habitacion", habitacion);
        request.setAttribute("hoteles", hoteles);
        request.getRequestDispatcher("/WEB-INF/views/admin/editarHabitacion.jsp").forward(request, response);
    }
    
    private void guardarHabitacion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        String hotelIdStr = request.getParameter("hotelId");
        String tipo = request.getParameter("tipo");
        String capacidadStr = request.getParameter("capacidad");
        String precioPorNocheStr = request.getParameter("precioPorNoche");
        String descripcion = request.getParameter("descripcion");
        String disponibleStr = request.getParameter("disponible");
        
        Habitacion habitacion;
        
        if (idStr != null && !idStr.isEmpty()) {
            habitacion = habitacionService.buscarPorId(Integer.parseInt(idStr));
        } else {
            habitacion = new Habitacion();
        }
        
        Hotel hotel = hotelService.buscarPorId(Integer.parseInt(hotelIdStr));
        
        habitacion.setHotel(hotel);
        habitacion.setTipo(tipo);
        habitacion.setCapacidad(Integer.parseInt(capacidadStr));
        habitacion.setPrecioPorNoche(new BigDecimal(precioPorNocheStr));
        habitacion.setDescripcion(descripcion);
        habitacion.setDisponible("on".equals(disponibleStr));
        
        habitacionService.guardar(habitacion);
        
        response.sendRedirect(request.getContextPath() + "/app/admin?accion=habitaciones&hotelId=" + hotelIdStr + "&mensaje=Habitación guardada exitosamente");
    }
    
    private void eliminarHabitacion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        String hotelId = request.getParameter("hotelId");
        
        if (id != null && !id.isEmpty()) {
            habitacionService.eliminar(Integer.parseInt(id));
        }
        
        if (hotelId != null && !hotelId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/app/admin?accion=habitaciones&hotelId=" + hotelId + "&mensaje=Habitación eliminada exitosamente");
        } else {
            response.sendRedirect(request.getContextPath() + "/app/admin?accion=habitaciones&mensaje=Habitación eliminada exitosamente");
        }
    }
    
    // Métodos para gestionar reservas
    private void verReserva(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        
        if (id != null && !id.isEmpty()) {
            Reserva reserva = reservaService.buscarPorId(Integer.parseInt(id));
            request.setAttribute("reserva", reserva);
            request.getRequestDispatcher("/WEB-INF/views/admin/verReserva.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/app/admin?accion=reservas");
        }
    }
    
    private void cambiarEstadoReserva(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        String estado = request.getParameter("estado");
        
        if (id != null && !id.isEmpty() && estado != null && !estado.isEmpty()) {
            Reserva reserva = reservaService.buscarPorId(Integer.parseInt(id));
            reserva.setEstado(estado);
            reservaService.guardar(reserva);
            
            response.sendRedirect(request.getContextPath() + "/app/admin?accion=verReserva&id=" + id + "&mensaje=Estado de reserva actualizado");
        } else {
            response.sendRedirect(request.getContextPath() + "/app/admin?accion=reservas");
        }
    }
    
    // Métodos para gestionar usuarios
    private void verUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        
        if (id != null && !id.isEmpty()) {
            Usuario usuario = usuarioService.buscarPorId(Integer.parseInt(id));
            List<Reserva> reservasUsuario = reservaService.buscarPorUsuario(usuario);
            
            request.setAttribute("usuario", usuario);
            request.setAttribute("reservas", reservasUsuario);
            request.getRequestDispatcher("/WEB-INF/views/admin/verUsuario.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/app/admin?accion=usuarios");
        }
    }
}
