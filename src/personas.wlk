  
class Persona {
	var property estaAislada = false
	var property respetaLaCuarentena = false
	var property presentaSintomas = false
	var property diaEnQueSeInfecto = 0
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

}

object agenteDeSalud{
	var property position 
	
	method image(){
		return "agenteDeSalud.png"
	}
	method moverDerecha(){
		self.position(self.position().right(1))
	}
	method moverIzquieda(){
		self.position(self.position().left(1))
	}
	method moverArriba(){
		self.position(self.position().up(1))
	}
	method moverAbajo(){
		self.position(self.position().down(1))
	}
	method curarPersona(){
		
	}
	
}