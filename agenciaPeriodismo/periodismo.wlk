lass Pais{
	var property nombre
	var property pBI
	var property habitantes
	var property porcentajeUniversidad
	var property decil
	
	method pBI() = pBI/habitantes
	
	method gini() = decil.index(9)/decil.index(0)
	
	method ricos() = decil.max()
	
	method letrasNombre()=nombre.size()
	
	method decileQueSi() = decil.index(0)+decil.index(4)+decil.index(9)/habitantes
	
	method cifraPorEstrategias(estrategias) = return estrategias.map{estra=>estra.calculo(self)}

}

const argentina = new Pais(pBI = 1000, habitantes = 40000000, porcentajeUniversidad = 80, decil=[4290,9807,13681,16199,19259,24101,29614,36642,46579,87758], nombre = "argentina")
const brasil = new Pais(pBI = 100, habitantes = 30000000, porcentajeUniversidad = 90, decil=[4290,9807,13681,16199,19259,24101,29614,36642,46579,87758], nombre = "brasil")
const peru = new Pais(pBI = 700, habitantes = 700000, porcentajeUniversidad = 20, decil=[4290,9807,13681,16199,19259,24101,29614,36642,46579,87758], nombre = "peru")
const mexico = new Pais(pBI = 20000, habitantes = 2000000, porcentajeUniversidad = 40, decil=[4290,9807,13681,16199,19259,24101,29614,36642,46579,87758], nombre = "mexico")

object mundo{
	var property listaPaises = [argentina,brasil]
	method mejorPais(estrategia)= return listaPaises.max{unPais=>estrategia.calculo(unPais)}
}


object pBI{
	
	method calculo(pais)=pais.pBI()
	
}

object gini{
	method calculo(pais)=pais.gini()
}

object ingresosAltos{
	method calculo(pais) = pais.ricos()
	
}

object accesoUni{
	method calculo(pais)=pais.porcentajeUniversidad()
}

object nombrista{
	method calculo(pais)=pais.letrasNombre()
}

object decileQueSi{
	method calculo(pais)=pais.decileQueSi()
	
}

class  Diario {
	var pais
	var analistas
	
	var property articulos = []
	
	method agregarArticulo(nuevoArticulo, autor){ 
		articulos.add(nuevoArticulo)
		autor.publicarArticulo(nuevoArticulo)
			
	}
	
	method escribieronPoco(unosAnalistas) = unosAnalistas.filter{analista=>analista.escribioPoco()}
	
	method nombreDistinto(unosAnalistas) = unosAnalistas.filter{analista=>analista.nombreDistinto(pais.nombre())}
	
	method losQuePuedenEscribir(unosAnalistas) = self.escribieronPoco(self.nombreDistinto(unosAnalistas)) 
	
	
	method mandarAEscribir(){
		self.losQuePuedenEscribir(analistas).forEach{analista=>self.agregarArticulo(analista.escribirArticuloDe(pais),analista)}
	}
	
}

class Articulo{
	var property titulo
	var property cifra
	var property analista
}

class Analista{
	var nombre
	var property articulos
	
	method cifraDestacada(pais)
	
	method tituloPara(pais)
	
	method escribioPoco() = articulos.size()<3
	
	method nombreDistinto(palabra)= not(nombre.contains(palabra))
	
	method publicarArticulo(articulo) = articulos.add(articulo)
	
	method escribirArticulo(unTitulo,unaCifra) = new Articulo(titulo = unTitulo , cifra = unaCifra, analista = self)
	
	method escribirArticuloDe(pais)= return self.escribirArticulo(self.tituloPara(pais), self.cifraDestacada(pais))
	
	
}

class Clasico inherits Analista{
	const estrategia = pBI
	
	override method cifraDestacada(pais) =  estrategia.calculo(pais)
	override method tituloPara(pais) = "La situacion en " + pais.nombre()
			
}

class Rebelde inherits Analista{
	
    var property estrategia
	
	override method cifraDestacada(pais) = estrategia.calculo(mundo.mejorPais(estrategia))
	override method tituloPara(pais) = "Mejor pais del Mundo"
	
}

class Panqueque inherits Analista{
	var simpatizaCon
	var estrategiaPosi
	var estrategiaNeg 
	
	method estrategia(pais) = if(self.simpatiza(pais)){
		return estrategiaPosi
	}else
	{
		return estrategiaNeg
	}
	
	override method tituloPara(pais)= "La columna economica de "+ nombre
	
	override method cifraDestacada(pais) = self.estrategia(pais).calculo(pais)
	
	method nuevoSimpatizante(nombrePais) = simpatizaCon.add(nombrePais)
	
	method yaNoLePasaPlata(nombrePais) = simpatizaCon.remove(nombrePais)
	
	method simpatiza(unPais)= simpatizaCon.contains(unPais)
	
}

object juanCipayo inherits Panqueque(estrategiaPosi=accesoUni,estrategiaNeg=nombrista){
	
	override method simpatiza(unPais) = not(unPais==argentina)
	
	override method cifraDestacada(pais) = super(pais)*1.5
}


class Salieris inherits Analista{
	var plagiaA
	
	method cambiarPlagiado(nuevoPlagio) { plagiaA=nuevoPlagio}
	
	override method tituloPara(pais)= plagiaA.tituloPara(pais)
	
	override method cifraDestacada(pais) = plagiaA.cifraDestacada(pais)
	
	
}

class Guitarrista inherits Analista{
	override method tituloPara(pais)= "Fuente:Yo" + pais.nombre()
	
	override method cifraDestacada(pais) = 1.randomUpTo(1000)
	
}