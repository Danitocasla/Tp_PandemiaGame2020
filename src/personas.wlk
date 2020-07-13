import simulacion.*

class Persona {
	var property estaAislada = false
	var property respetaCuarentena = false
	var property diaEnQueSeInfecto = 0
	var property estaInfectada = false
	var property tengoSintomas = false
	var property probabilidadDePresentarSintomas = 0
	

	method infectarse() {
		if (not self.estaInfectada()) {
		  estaInfectada = true
		  diaEnQueSeInfecto = simulacion.diaActual()
		  probabilidadDePresentarSintomas = 0.randomUpTo(100)
		}
	}		 
		
	method aislarse() {
		estaAislada = true
	}
	
	method presentaSintomas() {			
		if(probabilidadDePresentarSintomas <= simulacion.chanceDePresentarSintomas()){
			tengoSintomas = true
		}
	 }
	
	method vaARespetarLaCuarentena() {
		respetaCuarentena = true
	}
}
