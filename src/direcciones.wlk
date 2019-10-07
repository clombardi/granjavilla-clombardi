import wollok.game.*

object norte {
	method siguientePosicion(position) {
		if (position.y() == game.height() - 1) {
			return position
		} else {
			return position.up(1)
		}
	}
	
	method posicionesDesde(position) {
		return (position.y()..game.height()-1).map({n => game.at(position.x(), n)})
	}
}

object sur {
	method siguientePosicion(position) {
		if (position.y() == 0) {
			return position
		} else {
			return position.down(1)
		}
	}		
	method posicionesDesde(position) {
		return (0..position.y()).map({n => game.at(position.x(), n)})
	}
}

object oeste {
	method siguientePosicion(position) {
		if (position.x() == 0) {
			return position
		} else {
			return position.left(1)
		}
	}		
	method posicionesDesde(position) {
		return (0..position.x()).map({n => game.at(n, position.y())})
	}
}

object este {
	method siguientePosicion(position) {
		if (position.x() == game.width() - 1) {
			return position
		} else {
			return position.right(1)
		}
	}		
	method posicionesDesde(position) {
		return (position.x()..game.width()-1).map({n => game.at(n, position.y())})
	}
}

class Region {
	var property inicio
	var property fin
	
	method incluye(position) {
		return position.x().between(inicio.x(), fin.x())
			and position.y().between(inicio.y(), fin.y())
	}
	
	method extremos() {
		return [inicio, game.at(inicio.x(), fin.y()), fin, game.at(fin.x(), inicio.y())]
	}
}

class Banderita {
	var property position
	method image() = "banderita.jpg" 
	method esPlanta() { return false }
	method teChocoElOso() { }
}