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
	}// Daniel Mendez
	
	method crearYAgregarA(unaManzana){
		const nuevaPersona = new Persona()
		unaManzana.agregarPersona(nuevaPersona)
	}// Daniel Mendez
	
	// paso de dia en el game
	method pasoDeDia(){
		//movimiento y contagio a cada manzana
		manzanas.forEach({m=>m.pasarUnDia()})
		diaActual += 1
		console.println("Termino el Día")
	}// Daniel Mendez
	
	method agregarInfectadoAlAzar(){
		const personaInfectada = new Persona()
		personaInfectada.infectarse()         
		self.manzanaAlAzar().agregarPersona(personaInfectada)
	}// Daniel Mendez
	
	method manzanaAlAzar(){
		return manzanas.get(0.randomUpTo(manzanas.size()-1))
	}// Daniel Mendez
	
	method estadoGeneral(){
		return "Dia Actual nro: " + self.diaActual() +
		" Total de Persosnas: " + self.totalDePersonas() + 
		" Infectades: " + self.contidadInfectadesTotal() + " Con sintomas: " +
		self.cantidadTotalConSintomas()
	}// Daniel Mendez
	
	method totalDePersonas() {
		return manzanas.sum({
			m => m.totalXManzana()
		})
	}// Daniel Mendez
	
	method contidadInfectadesTotal() {
		return manzanas.sum({
			m => m.cantidadInfectades()
		})
	}// Daniel Mendez
	
	method cantidadTotalConSintomas(){
		return manzanas.sum({
			m => m.cantidadConSintomas()
		})
	}// Daniel Mendez
	method curarATodes(){
		manzanas.forEach({m => m.curarATodos(true)})
	}// Daniel Mendez
	method aislarATodosInfectadesConSintoma(){
		manzanas.forEach({m => m.aislarInfectadesConSintoma()})
	}//Daniel Mendez
}