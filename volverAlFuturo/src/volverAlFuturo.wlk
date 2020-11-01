class Personaje{
	var nombre
	var apellido
	var edad
	var tiene = []
	var property altura
	
	method mismoApellido(otroApellido)= otroApellido == apellido
	
	method apellido()= apellido
	
	method esMayor() = edad>50
	
	method cambioEdad(anio){
		edad+=anio
		}
	
	method elementoPropio() = tiene.any{elemento=>elemento.esDe(self)}
	
	method agregarElemento(elemento) = tiene.add(elemento)
	
	method sacarElemento(elemento) = tiene.remove(elemento)
	
	method nombreOloroso(){nombre="Apestoso" + nombre}
	
	method elementoMasViejo()= if(tiene.size()>0){
		tiene.min{elemento=>elemento.fecha()}
		}
		else
		{
			throw "Error"
		}
		
	method problemaCon(unaFecha,unPersonaje){
		tiene.filter{elem=>elem.fecha()>unaFecha}.forEach{elem=>elem.problemaCon(unPersonaje)}
	}
}

class Elemento{
	var descripcion
	var property fecha 
	
	method esDe(alguien) = false
	
	method problemaCon(personaje){
		descripcion += "BTTF"
	}
	
}

class ElementoEspecial inherits Elemento{
	var duenio
	
	method esDe(alguien)= duenio==alguien
}
class Documentacion inherits Elemento{
	var aparece = []
	
    	override method esDe(alguien) = aparece.contains(alguien)
    
    	override method problemaCon(personaje){
    		super(personaje)
    		if(aparece.contain(personaje)){
    			aparece.remoce(personaje)
    	}
    }
}


object DeLorean{
	var combustible
	var fecha
	var lugar
	var viajeros = []
	
	method ponerCombustible(nuevoCombustible){
		combustible = nuevoCombustible
	}
	method tieneCombustible()= combustible != null
	
	method efectosSecundarios(){
		viajeros.forEach{viajero=>combustible.efectos(viajero)}
		
	}
	
	method subirPasajero(pasajero){
		viajeros.add(pasajero)
	}
	
	method bajarPasajero(pasajero){
		if(viajeros.contains(pasajero)){
			viajeros.remove(pasajero)
	}
	else
	{
		throw "No estaba el pasajero"
	}
	
	}
	
	method viajarA(nuevoLugar,nuevaFecha){
		if(self.tieneCombustible()){
			fecha=nuevaFecha
			lugar = nuevoLugar
			self.efectosSecundarios()
		}
		
	}

}

class Combustible{
	method efectos(persona)
}

object plutonio inherits Combustible{
	override method efectos(persona){
		persona.altura(persona.altura()-0.01)
	}
}
	
	
object electricidad inherits Combustible{
	override method efectos(persona){
		persona.sacarElemento(persona.elementoMasViejo())
	}
	
}

object nafta inherits Combustible{
	override method efectos(persona){
		if (persona.esMayor()){
			persona.cambioEdad(-5)
		}
		else
		{
			persona.cambioEdad(+10)
		}
	}
}

object basura inherits Combustible{
	override method efectos(persona){
		persona.nombreOloroso()
	}
}

class Destino{
	var nombre
	var fecha
	var personajes = []
	
	method antepasadosDe(persona)=personajes.filter{personaje=>persona.mismoApellido(personaje.apellido())}
}

const lejanoXIX =new Destino(nombre = "LejanoOeste", fecha = 1800, personajes=[])

/*const lentes = new Elemento(descripcion = "fachas", fecha = 1985)
const perro = new Elemento(descripcion = "einstein", fecha = 1980)
const controlRemoto = new Elemento(descripcion = "Control", fecha = 1985)
const fotoReloj = new Documentacion(descripcion = "fotoReloj", fecha = 1885, aparece=[drBrown])

const patineta = new ElementoEspecial(descripcion = "patineta", fecha = 2015, duenio = marty)
const fotoHermanos = new Documentacion(descripcion = "foto hermanos", fecha = 1985, aparece=[marty])

const drBrown = new Personaje(nombre="Emmet", apellido="Brown",edad = 71, altura = 1.80, tiene=[])
const marty = new Personaje(nombre="Marty",apellido= "McFly", edad = 25, altura = 1.70, tiene = [])
const jenny = new Personaje(nombre="Jenny",apellido="Parker",edad = 26, altura = 1.50, tiene = [])
const marta = new Personaje(nombre="Marta",apellido= "McFly", edad = 28, altura = 1.60, tiene = [])

* /
*/
