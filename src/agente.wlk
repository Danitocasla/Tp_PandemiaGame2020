import wollok.game.*
import manzanas.*
import personas.*
import simulacion.*

object agenteDeSalud {
	var property image = "agente.png"
	var property position = game.at(0,0)
	
	method configurarFlechas(alto,ancho){
		keyboard.up().onPressDo{ self.mover(arriba,alto,ancho)}
		keyboard.down().onPressDo{ self.mover(abajo,alto,ancho)}
		keyboard.left().onPressDo{ self.mover(izquierda,alto,ancho)}
		keyboard.right().onPressDo{ self.mover(derecha,alto,ancho)}
   }
   
   method mover(direccion, limite1, limite2){
   		if(self.position().x().between(0,limite1) and self.position().y().between(0,limite1) ){
			self.position(direccion.siguiente(self.position()))
		}
		else {
			game.say(self, "Por acá no es")
			position = game.origin()
		}
		
	}
	
	method aislarInfectadoConSintoma(){
		simulacion.aislarATodosInfectadesConSintoma()
	}
	method convencerRespetar(){
		game.onCollideDo(self, {man => man.hacerRespetarCuarentena()})
	}
}
object izquierda { 
	method siguiente(position) = position.left(1) 
}

object derecha { 
	method siguiente(position) = position.right(1) 
}

object abajo { 
	method siguiente(position) = position.down(1) 
}

object arriba { 
	method siguiente(position) = position.up(1) 
}