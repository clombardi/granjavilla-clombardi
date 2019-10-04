class Maiz {
	var property position
	var property esAdulta = false 
	
	method image() {
		if (esAdulta) {
			return "corn_adult.png"
		} else {
			return "corn_baby.png"
		}
	}
	
	method regate() {
		if (not esAdulta) { esAdulta = true }
	}
	method teChocoElOso() {
		self.regate()
	}
}

class Trigo {
	var property position
	
	method image() { return "wheat_0.png" }
	method regate() { /* a completar */ }
	method teChocoElOso() {
		if (position.x() > 0) {
			position = position.left(1)
		}
	}
}