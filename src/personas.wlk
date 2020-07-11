import simulacion.*

class Persona {
	var property estaAislada = false
//<<<<<<< HEAD
/*	var property diaDeContagio = 0
	var property estaInfectada = false
	var property presentaSintomas = false
	
	method respetaCuarentena() = estaAislada

	method infectarse() {
		estaInfectada = true
		diaDeContagio = simulacion.diaActual()
	}// Daniel Mendez
	
	method presentaSintomas() = 	if (estaInfectada){
		return simulacion.tomarChance(simulacion.chanceDePresentarSintomas())
		} else {
			return false
		}// Daniel Mendez
		* Esto es mi ideal
		*/
//=======
	var property respetaLaCuarentena = false
	var property presentaSintomas = false
	var property diaEnQueSeInfeeto = 0
	var property estaInfectada = false
	var property tengoSintomas = false
	

	method infectarse() {
		estaInfectada = true
	}
	
	method aislarse() {
		estaAislada = true
	}
	
	method puedePresentarSintomas() {		
		const probabilidadDepresentarSintoma = 0.randomUpTo(100).truncate(0)
		
		if(probabilidadDepresentarSintoma <= 20){
			tengoSintomas = true
		}
	}
	
	method sePuedeInfectar() {
		const probabilidadDeContagio = 0.randomUpTo(100).truncate(0)
		
		return not estaAislada && not estaInfectada && (respetaLaCuarentena && probabilidadDeContagio <= 2) || (not respetaLaCuarentena && probabilidadDeContagio <= 30)
	}
//>>>>>>> b48bfc2e9987aef6c4c7e5ec9833cc06d6a6a79c
}

