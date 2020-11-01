  
object graboland {
	var costoDeVida
	var policias = 500
	const lotes = []
	method agregarLote(lote) {
		lotes.add(lote)
	}
	
	method cantPolicias() = policias
	
	method cantLotes()= lotes.size()
	
	method lotesSuficientes()= lotes.filter{lote=>lote.ingresoSuficiente(costoDeVida)}
	
	method cantLotesSuficientes()=self.lotesSuficientes().size()
	 
	method porcentajeLotesProduccionSuficiente() {
		return self.cantLotesSuficientes()/self.cantLotes()
	}
	
	method incrementoGeneralizado(porcentaje){
		self.lotesSuficientes().filter{lote=>not(lote.excedidoSuelo())}.forEach{elem=>elem.incrementarRendimiento(porcentaje)}
	}
	method lotesCultivan(unCultivo)=lotes.filter{lote=>lote.cultivo()==unCultivo}
	
				
	method cambiaPor(unCultivo,nuevoCultivo){
		self.lotesCultivan(unCultivo).forEach{lote=>lote.cultivo(nuevoCultivo)}
	}
		
	}
	
	
	
	class Iniciativa{
	 	var participantes	
		var propuesta
		
		method esExitosa()
		method efectos() = propuesta.efecto()
	}


class Tractorazo inherits Iniciativa{
	
	 override method esExitosa() = participantes>10000 && graboland.cantPolicias()<participantes 
	 
}

class ProyectoLey inherits Iniciativa{
	
	 override method esExitosa() = participantes>100 
	 
}

class Virtual inherits Iniciativa{
	var trolls
	var likes
	 
	 override method esExitosa() = participantes>1000 && 5*trolls<likes
	 
}

object duplicarProductividad{
	method efecto(){
		graboland.duplicarProductividad()
	}
}

class CambiarCultivo{
	var cultivoViejo
	var cultivoNuevo
	method efecto(){
		graboland.cambiaPor(cultivoViejo,cultivoNuevo)
	}
}
class CambiarHectareas{
	var porcentaje
	method efecto(){

	}
	
}


class Lote {
	var hectareas
	var rendimiento
	
	var property cultivo
	
	method ingresoAnual()= hectareas*rendimiento
	
	method ingresoSuficiente(costoVida) = self.ingresoAnual() > costoVida
	
	method excedidoSuelo()=hectareas < 50*(1/cultivo.indiceIntesidad())
	
	method incrementarRendimiento(porcentaje) {rendimiento += rendimiento*(porcentaje/100)}
}

class Cultivo{
	var nombre
	var indiceIntensidad
}