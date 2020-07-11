import simulacion.*

class Persona {
	var property estaAislada = false
	var property diaDeContagio = 0
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
}

