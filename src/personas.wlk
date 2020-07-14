import simulacion.*

class Persona {
	var property estaAislada = false

	var property presentaSintomas = false
	var property diaEnQueSeInfecto = 0
	var property estaInfectada = false

	method respetaCuarentena() = estaAislada
	
	method infectarse() {
		if (not self.estaInfectada()) { 
			estaInfectada = true
			diaEnQueSeInfecto = simulacion.diaActual()
			}
	}
	
	method aislarse() {
		estaAislada = true
	}
	

	method presentaSintomas() { 
		if (estaInfectada){
			return simulacion.tomarChance(simulacion.chanceDePresentarSintomas())
		}
		else {
			return false
		}	
	}
	
	method diasDeEnfermo(){
		return simulacion.diaActual() - diaEnQueSeInfecto
	}// Daniel Mendez
	
	method curarse(){
		self.estaInfectada(false)

	}
}
