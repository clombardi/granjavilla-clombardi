import wollok.game.*

object oso {
	var property position = new Position(x = 3, y = 12)
	
	method image() = "oso.jpg"
	
	method moverEnDireccion(direccion) {
		self.position(direccion.siguientePosicion(self.position()))
	}

	method esPlanta() { return false }	
}

object indicadorMovimientoOso {
	const property position = new Position(x = 0, y = game.height()-1)
	method image() = "flechas.png"
	method esPlanta() { return false }	
}