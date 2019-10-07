import wollok.game.*
import hector.*
import oso.*
import cultivos.*
import direcciones.*

object juegoGranja {
	var personajeActual = hector	
	var elOsoSeMueve = false
	var property tiempo = 50
	var regionPrivilegiada = new Region(inicio = game.at(3,3), fin=game.at(6,7))

	method configurarTeclado() {
		keyboard.s().onPressDo({game.say(hector, "hola gente")})
//		keyboard.o().onPressDo({personajeActual = oso})
//		keyboard.h().onPressDo({personajeActual = hector})
		keyboard.m().onPressDo({ hector.plantarMaiz(regionPrivilegiada) })
		keyboard.t().onPressDo({ hector.plantarTrigo() })
		keyboard.r().onPressDo({ hector.regarPlanta() })
		keyboard.c().onPressDo({ hector.cosecharPlanta() })
		keyboard.p().onPressDo({ 
			game.say(hector, 
				"tengo cosechadas " + hector.cantidadDePlantasCosechadas() + " plantas"
			)
		})
		keyboard.g().onPressDo({ 
			game.say(hector, "tengo $ " + hector.plataEnPlantasCosechadas())
		})
//		keyboard.a().onPressDo({self.arrancarOso()})
//		keyboard.d().onPressDo({self.detenerOso()})
		keyboard.d().onPressDo({self.cambiarMovimientoOso()})
		
		self.configurarMovimiento()
	}
	
	method configurarMovimiento() {
		keyboard.up().onPressDo({ 
			if (personajeActual.position().y() < game.height() - 1) {
				personajeActual.position(personajeActual.position().up(1))
			}
		})				 
		keyboard.down().onPressDo({ 
			if (personajeActual.position().y() > 0) {
				personajeActual.position(personajeActual.position().down(1))
			}
		})				 
		keyboard.left().onPressDo({ 
			if (personajeActual.position().x() > 0) {
				personajeActual.position(personajeActual.position().left(1))
			}
		})				 
		keyboard.right().onPressDo({ 
			if (personajeActual.position().x() < game.width() - 1) {
				personajeActual.position(personajeActual.position().right(1))
			}
		})				 
	}

	method configurarMovimiento_cheto() {
		keyboard.up().onPressDo({ personajeActual.moverEnDireccion(norte) })				 
		keyboard.down().onPressDo({ personajeActual.moverEnDireccion(sur) })				 
		keyboard.left().onPressDo({ personajeActual.moverEnDireccion(oeste) })				 
		keyboard.right().onPressDo({ personajeActual.moverEnDireccion(este) })				 
	}

	method configurarPersonajes() {
	 	game.addVisual(hector)
	 	game.addVisual(oso)
	 	regionPrivilegiada.extremos().forEach({ p => game.addVisual(new Banderita(position = p))})
	}
	
	method configurarColisiones() {
		game.whenCollideDo(oso, { objeto => objeto.teChocoElOso() })	
	}

	method configurarAcciones() {
		game.onTick(1000, "movimientoOso", {
			var dado = 0.randomUpTo(4).truncate(0)
			if (dado == 0 and oso.position().y() < game.height() - 1) {
				oso.position(oso.position().up(1))
			} else if (dado == 1 and oso.position().y() > 0) {
				oso.position(oso.position().down(1))
			} else if (dado == 2 and oso.position().x() > 0) {
				oso.position(oso.position().left(1))
			} else if (dado == 3 and oso.position().x() < game.width() - 1) {
				oso.position(oso.position().right(1))
			}
		})
//		game.onTick(1000, "movimientoOso", {oso.moverEnDireccion(este)})
//		game.onTick(1000, "movimientoOso", {oso.moverEnDireccion(self.direccionAlAzar())})
		game.onTick(1000, "tiempo", { self.pasoDelTiempo() })
	}	
	
	method arrancarOso() {
		if (!elOsoSeMueve) {
//			game.onTick(1000, "movimientoOso", {oso.moverEnDireccion(self.direccionAlAzar())})
			game.onTick(1000, "movimientoOso", {oso.moverEnDireccion(self.delOsoHaciaUnaPlanta())})
			game.addVisual(indicadorMovimientoOso)
			elOsoSeMueve = true
		}
	}
	
	method detenerOso() {
		if (elOsoSeMueve) {
			game.removeTickEvent("movimientoOso")
			game.removeVisual(indicadorMovimientoOso)
			elOsoSeMueve = false
		}
	}
	
	method cambiarMovimientoOso() {
		if (elOsoSeMueve) {
			self.detenerOso()
		} else {
			self.arrancarOso()
		}
	}	
	
	method pasoDelTiempo() {
		tiempo = tiempo - 1
		if (tiempo == 10) {
			game.addVisual(indicadorTiempo)
		}
		if (tiempo == 0) {
			game.stop()
		}
	}
	
	method direccionAlAzar() {
		var indice = 0.randomUpTo(4).truncate(0)
		return self.direcciones().get(indice)
	}
	
	method direcciones() = [norte, sur, este, oeste]
	
	method delOsoHaciaUnaPlanta() {
		var direccion = self.direcciones().findOrDefault({dir => 
			dir.posicionesDesde(dir.siguientePosicion(oso.position())).any({ pos => 
				self.hayPlantaEn(pos)
			})
		}, self.direccionAlAzar())
		return direccion
	}
	
	method hayPlantaEn(position) {
		return game.getObjectsIn(position).any({ obj => obj.esPlanta() })
	}
}

object indicadorTiempo {
	const property position = new Position(x = game.width()-1, y = game.height()-1)
	method image() = "rojo.jpg"
	method esPlanta() { return false }	
	method teChocoElOso() { }
}