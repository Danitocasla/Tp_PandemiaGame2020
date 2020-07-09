import personas.*
import manzanas.*

object simulacion {
	var property diaActual = 0
	const property manzanas = []
	
	// parametros del juego
	const property chanceDePresentarSintomas = 30
	const property chanceDeContagioSinCuarentena = 25
	const property chanceDeContagioConCuarentena = 2
	const property personasPorManzana = 10
	const property duracionInfeccion = 20

	/*
	 * este sirve para generar un azar
	 * p.ej. si quiero que algo pase con 30% de probabilidad pongo
	 * if (simulacion.tomarChance(30)) { ... } 
	 */ 	
	method tomarChance(porcentaje) = 0.randomUpTo(100) < porcentaje

	method agregarManzana(manzana) { manzanas.add(manzana) }
	
	method debeInfectarsePersona(persona, cantidadContagiadores) {
		const chanceDeContagio = if (persona.respetaCuarentena()) 
			self.chanceDeContagioConCuarentena() 
			else 
			self.chanceDeContagioSinCuarentena()
		return (1..cantidadContagiadores).any({n => self.tomarChance(chanceDeContagio) })	
	}

	method crearManzana() {
		const nuevaManzana = new Manzana()
		(1..self.personasPorManzana()).forEach({p=>
				self.crearYAgregarA(nuevaManzana)
		})
		return nuevaManzana
	}
	// en manzana debo tener method agregarPersona(unaPersona)
	method crearYAgregarA(unaManzana){
		const nuevaPersona = new Persona()
		unaManzana.agregarPersona(nuevaPersona)
	}
	
	// probar con código de manzanas terminado
	method pasoDeDia(){
		//movimiento y contagio a cada manzana
		manzanas.forEach({m=>m.pasarUnDia()})
		diaActual += 1
	}
	// en personas debe estar el property estaInfectada
	method agregarInfectadoA(unaManzana){
		const personaInfectada = new Persona()
		personaInfectada.estaInfectada(true)         
		unaManzana.agregarPersona(personaInfectada)
	}
		
}