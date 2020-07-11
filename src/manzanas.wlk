import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	var property cantidadDeInfectados
	var property totalEnManzana
	
	method image() {
		if (cantidadDeInfectados.between(0,4)) return "amarillo.png"
		else if(cantidadDeInfectados.between(3,7)) return "naranja.png"
		else if(cantidadDeInfectados > 7 and cantidadDeInfectados < totalEnManzana) return "rojo.png"
		return "blanco.png"
	}
	
	// este les va a servir para el movimiento
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}

	method pasarUnDia() {
		self.transladoDeUnHabitante()
		self.simulacionContagiosDiarios()
		
		// despues agregar la curacion
	}
	
	method personaSeMudaA(persona, manzanaDestino) {
		self.expulsarPersonaDeManzana(persona)
		manzanaDestino.agregarPersonaAManzana(persona)
	}
	
	method cantidadContagiadores() {
		return self.infectadosYAislados()
	}
	
	method noInfectados() {
		return personas.filter({ pers => not pers.estaInfectada() })
	}
	method infectados() {
		return personas.filter({pers => pers.estaInfectada()})
	}
	method cantidadDeInfectados(){
		return personas.count({pers => pers.estaInfectada()})
	}
	method noAislados(){
		return personas.filter({pers =>not pers.estaAislada()})
	}
	method aislados(){
		return personas.filter({pers => pers.estaAislada()})
	}
	method cantidadDeAislados(){
		return personas.count({pers => pers.estaAislado()})
	}
	method infectadosYAislados(){
		return personas.count({pers => pers.estaInfectada() and pers.estaAislado()})
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
