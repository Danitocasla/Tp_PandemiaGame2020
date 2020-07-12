import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	var property cantidadDeInfectados
	var property totalEnManzana
	
	method image() {
		if(self.todosInfectadoss()) return "rojo.png"
		else if(self.cantidadDeInfectados() < self.cantidadDePersonas()) return "naranjaOscuo.png"
		else if(self.cantidadDeInfectados().between(4,7)) return "naranja.png"
		else if(self.cantidadDeInfectados().between(1,3)) return "amarillo.png"
		else return "blanco.png"
	}
	
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}

	method pasarUnDia(){
		self.transladoDeUnHabitante()
	 	self.simulacionContagiosDiarios()
		self.curacion()
	}
	
	method curacion(){
		return if (not self.hayPersonaSana()) self.curarPersonas()
		else self.error("No se puede curar")
	}
	method curarPersonas(){
		return personas.forEach({pers => pers.estaInfectada(true)})
	}
	method hayPersonaSana(){
		return personas.any({pers => pers.diaEnQueSeInfecto() >= 20})
	}
	method personaSeMudaA(persona, manzanaDestino) {
		self.expulsarPersonaDeManzana(persona)
		manzanaDestino.agregarPersonaAManzana(persona)
	}
	method cantidadDePersonas(){
		return personas.size()
	}
	method cantidadContagiadores() {
		return self.cantidadDeInfectadosYNoAislados()
	}
	method noInfectados() {
		return personas.filter({ pers => not pers.estaInfectada() })
	}
	method infectados() {
		return personas.filter({pers => pers.estaInfectada()})
	}
	method cantidadDeInfectados(){
		return personas.size({pers => pers.estaInfectada()})
	}
	method listaDeAislados(){
		return personas.filter({pers => pers.estaAislada()})
	}
	method cantidadDeAislados(){
		return personas.count({pers => pers.estaAislada()})
	}
	method cantidadDeInfectadosYNoAislados(){
		return personas.count({pers => pers.estaInfectada()and not pers.estaAislada()})
	}	
	
	method simulacionContagiosDiarios() { 
		const cantidadContagiadores = self.cantidadContagiadores()
		if (cantidadContagiadores > 0) {
			self.noInfectados().forEach({ persona => 
				if (simulacion.debeInfectarsePersona(persona, cantidadContagiadores)) {
					persona.infectarse()
				}
			})
		}
	}
	
	method transladoDeUnHabitante() {
		const quienesSePuedenMudar = personas.filter({ pers => not pers.estaAislada() })
		    if (quienesSePuedenMudar.size() > 2) {
			const viajero = quienesSePuedenMudar.anyOne()
			const destino = simulacion.manzanas().filter({ manz => self.esManzanaVecina(manz) }).anyOne()
			self.personaSeMudaA(viajero, destino)			
		}
	}
	
	method agregarPersonaAManzana(unaPersona){
		personas.add(unaPersona)
	}
	
	method expulsarPersonaDeManzana(unaPersona){
		personas.remove(unaPersona)
	}
}
