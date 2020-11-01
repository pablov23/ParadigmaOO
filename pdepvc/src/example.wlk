class Carpeta{
	var nombre
	var contiene = []
	
	method contieneArchivo(nombreArchivo) = contiene.any{arch=>arch.nombre()==nombreArchivo}
	
	method buscarArchivo(nombreArchivo) = contiene.find({arch=>arch.nombre()==nombreArchivo})
	
	method crearArchivo(nombreArchivo){
		contiene.add(new Archivo(nombre = nombreArchivo, contenido=null))
	}
	
	method eliminarArch(nombreArchivo){
		contiene.remove(self.buscarArchivo(nombreArchivo))
	}
	
}


class Archivo{
	var property nombre
	var contenido
	
	
	method agregarAlFinal(texto){
		contenido+=texto
	}
	
}

