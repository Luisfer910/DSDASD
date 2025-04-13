// Esperar a que el DOM esté cargado
document.addEventListener('DOMContentLoaded', function() {
    
    // Configurar fechas mínimas para los campos de fecha
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);
    
    const formatDate = (date) => {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    };
    
    // Configurar fecha mínima para campos de fecha de entrada
    const fechaEntradaInputs = document.querySelectorAll('input[name="fechaEntrada"]');
    fechaEntradaInputs.forEach(input => {
        input.min = formatDate(today);
        
        // Si no tiene valor, establecer la fecha actual
        if (!input.value) {
            input.value = formatDate(today);
        }
    });
    
    // Configurar fecha mínima para campos de fecha de salida
    const fechaSalidaInputs = document.querySelectorAll('input[name="fechaSalida"]');
    fechaSalidaInputs.forEach(input => {
        input.min = formatDate(tomorrow);
        
        // Si no tiene valor, establecer la fecha de mañana
        if (!input.value) {
            input.value = formatDate(tomorrow);
        }
    });
    
    // Asegurar que la fecha de salida sea posterior a la fecha de entrada
    fechaEntradaInputs.forEach(input => {
        input.addEventListener('change', function() {
            const fechaEntrada = new Date(this.value);
            const fechaSalida = new Date(fechaEntrada);
            fechaSalida.setDate(fechaSalida.getDate() + 1);
            
            const fechaSalidaInput = this.form.querySelector('input[name="fechaSalida"]');
            if (fechaSalidaInput) {
                fechaSalidaInput.min = formatDate(fechaSalida);
                
                // Si la fecha de salida es anterior a la nueva fecha de entrada + 1 día
                if (new Date(fechaSalidaInput.value) <= fechaEntrada) {
                    fechaSalidaInput.value = formatDate(fechaSalida);
                }
            }
        });
    });
    
    // Mostrar mensajes de éxito o error temporalmente
    const successMessage = document.querySelector('.success-message');
    const errorMessage = document.querySelector('.error-message');
    
    if (successMessage || errorMessage) {
        setTimeout(function() {
            if (successMessage) successMessage.style.display = 'none';
            if (errorMessage) errorMessage.style.display = 'none';
        }, 5000);
    }
});
