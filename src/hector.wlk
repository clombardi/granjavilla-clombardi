import wollok.game.*
import cultivos.*

object hector {
	var property position = new Position(x = 3, y = 8)
	var property image = "player.png"
	var property plantasCosechadas = []
	
	method plantarMaiz(regionPrivilegiada) {
		var nuevaPlanta = new Maiz(position=self.position())
		if (regionPrivilegiada.incluye(position)) {
			nuevaPlanta.duplicarPrecio()
		}
		game.addVisual(nuevaPlanta)
	}

	method plantarTrigo() {
		game.addVisual(new Trigo(position=self.position()))
	}
	
	method regarPlanta() {
		// el colliders siempre devuelve una colección
		// puede ser vacía, de un elemento, o de muchos elementos
		// pero es *siempre* una colección
		game.colliders(self).forEach({ planta => planta.regate()})
	}
	
	method cosecharPlanta() {
		game.colliders(self).forEach({ planta =>
			game.removeVisual(planta) 
			plantasCosechadas.add(planta)
		})
	}
	
	method cantidadDePlantasCosechadas() {
		return plantasCosechadas.size()
	}
	
	method plataEnPlantasCosechadas() {
		return plantasCosechadas.sum({ p => p.precio() })
	}
	
	method moverEnDireccion(direccion) {
		self.position(direccion.siguientePosicion(self.position()))
	}
	
	method esPlanta() { return false }

	method teChocoElOso() { plantasCosechadas = [] }
}