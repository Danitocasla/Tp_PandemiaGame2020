import simulacion.*

class Persona {
	var property estaAislada = false
	var property presentaSintomas = false
	var property diaDeContagio = 0
	var property estaInfectada = false
//	var property tengoSintomas = false  para eso esta presentaSintomas  

	method respetaCuarentena() = estaAislada
	
	method infectarse() {
		estaInfectada = true
		diaDeContagio = simulacion.diaActual()
	}
	
	method aislarse() {
		estaAislada = true
	}
	
	// cambiaria nombrte por presentaSintomas y modificaria al property directamente
	method puedePresentarSintomas() {
	// reemplazar con los metodos de simulacion - CORREGIR
	// los sintomas los presenta SOLO si estaInfectada de acuerdo la probabilidad que esta en
	// simulacion - ver
			
//		const probabilidadDepresentarSintoma = 0.randomUpTo(100).truncate(0)
		
//		if(probabilidadDepresentarSintoma <= 20){
//			tengoSintomas = true
	}
	
	// esta demas o no encuentro motivo
//	method sePuedeInfectar() {
	//	const probabilidadDeContagio = 0.randomUpTo(100).truncate(0)
		
		//return not estaAislada && not estaInfectada && (respetaLaCuarentena && probabilidadDeContagio <= 2) || (not respetaLaCuarentena && probabilidadDeContagio <= 30)
	//}
	// falta la posibilidad de curarse
	
	// 
}
