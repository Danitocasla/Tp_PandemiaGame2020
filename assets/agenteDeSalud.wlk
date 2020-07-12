import wollok.game.*

object agenteDeSalud{
	var property position 
	
	method image(){
		return "agenteDeSalud.png"
	}
	method moverDerecha(){
		self.position(self.position().right(1))
	}
	method moverIzquierda(){
		self.position(self.position().left(1))
	}
	method moverArriba(){
		self.position(self.position().up(1))
	}
	method moverAbajo(){
		self.position(self.position().down(1))
	}
	method aislarPersonas(){	
		
	}
	method hacerRespetarLaCuarentena(){
		
	}
}
