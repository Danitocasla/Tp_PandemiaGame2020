import simulacion.*

class Persona {
	var property estaAislada = false
	var property presentaSintomas = false
	var property diaEnQueSeInfecto = 0
	var property estaInfectada = false
	var property respetaCuarentena = false
	
	method infectarse() {
		if (not self.estaInfectada()) { 
			estaInfectada = true
			diaEnQueSeInfecto = simulacion.diaActual()
			self.calculaSintomas()
			}
	}
	
	method aislarse() {
		estaAislada = true
	}
	
	method calculaSintomas() { 
		self.presentaSintomas(simulacion.tomarChance(simulacion.chanceDePresentarSintomas()))
	}
	
	method diasDeEnfermo(){
		return simulacion.diaActual() - diaEnQueSeInfecto
	}// Daniel Mendez
	
	method curarse(){
		self.estaInfectada(false)
	}
}