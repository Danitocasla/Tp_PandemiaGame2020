import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	var property curarATodos = false
	
	method agregarPersona(unaPersona) = personas.add(unaPersona)
	method sacarPersona(unaPersona) = personas.remove(unaPersona)
		
	method image() {
		// reeemplazarlo por los distintos colores de acuerdo a la cantidad de infectados
		// también vale reemplazar estos dibujos horribles por otros más lindos
		var color
		if(self.cantidadInfectades().between(1,3)){
			color = "amarillo.png"
		}
		else if(self.cantidadInfectades().between(4,7)){
			color = "naranja.png"
		}
		else if(self.cantidadInfectades().between(8,self.totalXManzana()-1)){
			color = "naranjaOscuro.png"
		}
		else if(self.cantidadInfectades()==self.totalXManzana()){
			color = "rojo.png"
		}
		else {color = "blanco.png" }
		return color
	}// Daniel Mendez
	
	//total de personas por manzana
	method totalXManzana() = personas.size()

	
	// cantidad total de infectades
	method cantidadInfectades() = self.totalXManzana() - self.noInfectades().size()
	
	// este les va a servir para el movimiento
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}

	method pasarUnDia() {
		self.transladoDeUnHabitante()
		self.simulacionContagiosDiarios()
		self.curacion()
	}
	
	method curacion(){
		if(curarATodos){
		personas.forEach({pers=>pers.curarse()})
		self.curarATodos(false)
		}
		else {
		self.personasACurar().forEach({pers=>pers.curarse()})
		}
	}
	
	method personasACurar() = personas.filter({
		pers=>pers.diasDeEnfermo()>20
	})

	method personaSeMudaA(persona, manzanaDestino) {
		self.sacarPersona(persona)
		manzanaDestino.agregarPersona(persona)
	}

	
	method cantidadContagiadores() {
		return personas.count({
			pers => pers.estaInfectada() and not pers.estaAislada()
		})
	}
	
	method infectades(){
		return personas.filter({ pers => pers.estaInfectada() })
	}
	
	method infectadesConSintomas(){
		return self.infectades().filter({ pers => pers.presentaSintomas() })
	}
	
	method noInfectades() {
		return personas.filter({ pers => not pers.estaInfectada() })
	} 	
	
	method simulacionContagiosDiarios() { 
		const cantidadContagiadores = self.cantidadContagiadores()
		if (cantidadContagiadores > 0) {
			self.noInfectades().forEach({ persona => 
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
	
	method cantidadConSintomas(){
		return self.infectades().count({
			pers => pers.presentaSintomas()
		})
	}// Daniel Mendez
	method aislarInfectadesConSintoma(){
		self.infectadesConSintomas().forEach({
			pers => pers.estaAislada(true)
		})
	}// Daniel Mendez
	
	method estadoDeManzana(){
		return "Personas " + self.totalXManzana() + 
			" 
Infectades " + self.infectades().size() + 
				" 
Síntomas " + self.cantidadConSintomas() + 
				"
Aislados " + self.cantidadDeAislados()
	}
	
	method cantidadDeAislados(){
		return personas.count({
			pers => pers.estaAislada()
		})
	}
	method hacerRespetarCuarentena(){
		personas.forEach({pers => pers.respetaCuarentena(true)})
	}
}