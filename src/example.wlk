object paquete{
	var property destino = puente
	var property precio = 50
	
	method estaPago() = precio == 0
	
	method pagar(){
		precio -= 50
		mensajeria.sumarFondos(50)
	}

	method puedeSerEntregado(mensajero) = 
		destino.puedePasar(mensajero)
	
	method puedeSerEnviado(mensajero) = 
		self.estaPago() and destino.puedePasar(mensajero)
}

object paquetito {
	const property estaPago = true
	var property destino = puente
	var property precio = 0
	
	method puedeSerEntregado(mensajero) =
		destino.puedePasar(mensajero)
	
	
	method pagar() { mensajeria.sumarFondos(0) }
}

object paquetonViajero {
	const destinos = []
	var precio = 0
	
	method precio() = precio
	
	method destinos() = destinos
	
	method sumarDestino(destino) {
		destinos.add(destino)
		precio += 100
		}
		
	method quitarDestino(destino) =
		destinos.remove(destino)
	
	method estaPago() = self.precio() == 0
	
	method pagarEnPartes() {
		mensajeria.sumarFondos(100)
		precio -= 100
	}
	
	method pagar(){
		mensajeria.sumarFondos(self.precio())
		precio = 0
		
	}
	
	method puedeSerEntregado(mensajero) =
		destinos.all({p => p.puedePasar(mensajero)})
		
	method puedeSerEnviado(mensajero) =
		self.estaPago() and destinos.all({p => p.puedePasar(mensajero)})
	
}

object paqueteDeLosMensajeros {
	var property destino = fronteraDeLaPesadilla
	var property precio = 400
	
	method estaPago() = self.precio() == 0
	
	method pagar(){
		mensajeria.sumarFondos(self.precio())
		precio = 0
		
	}
	
	method puedeSerEntregado(mensajero) =
		destino.puedePasar(mensajero)
		
	method puedeSerEnviado(mensajero) =
		self.estaPago() and destino.puedePasar(mensajero)
}


object puente {
	method puedePasar(persona) = persona.peso() <= 1000 
}

object matrix {
	method puedePasar(persona) = persona.puedeLlamar()
}

object fronteraDeLaPesadilla {
	method puedePasar(persona) = persona.conocimiento() > 15
}

object roberto {
	var property vehiculo = camion
	var peso = 90 + vehiculo.peso()
	var puedeLlamar = false
	var property conocimiento = 10
	
	method peso() = peso
	
	method puedeLlamar() = puedeLlamar
	
}

object bici {
	
	method peso() = 5
	
}

object camion {
	
	var property nroAcoplados = 1
	
	method peso() = 500 * self.nroAcoplados()
}

object chuckNorris {
	var property peso = 80
	const property puedeLlamar = true
	var property conocimiento = 50
}

object neo {
	var property peso = 0
	var property tieneCredito = false
	var property conocimiento = 45
	
	method puedeLlamar() = tieneCredito
}

object cazador {
	var peso = 90 
	var puedeLlamar = false
	var property conocimiento = 70
	
	method peso() = peso
	
	method puedeLlamar() = puedeLlamar
}

object mensajeria {
	const mensajeros = []
	const enviosPendientes = []
	var property facturacion = 0
	
	method mensajeros() = mensajeros
	
	method enviosPendientes() = enviosPendientes
	
	method sumarFondos(fondos) {
		facturacion += fondos
	}
	
	method contratar(mensajero) = 
		mensajeros.add(mensajero)
		
	method despedir(mensajero) =
		mensajeros.remove(mensajero)
		
	method despedirATodos() =
		mensajeros.clear()
		
	method esMensajeriaGrande() =
		mensajeros.size() > 2
		
	method puedeEntregarElPrimero() =
		paquete.puedeSerEntregado(mensajeros.first())
		
	method pesoUltimoMensajero() =
		mensajeros.last().peso()
		
	method sePuedeEntregar(paquete) =
		mensajeros.any({m => paquete.puedeSerEntregado(m)})
		
	method puedenEntregar(paquete) =
		mensajeros.filter({m => paquete.puedeSerEntregado(m)})
		
	method tieneSobrepeso() =
		mensajeros.sum({m => m.peso()}) > 500
		
	method enviarPaquete(paquete){
		if(self.sePuedeEntregar(paquete)){
			paquete.pagar()
		}
		else {
			enviosPendientes.add(paquete)
		}
	}
	
	method sumarPendiente(paquete) =
		enviosPendientes.add(paquete)
	
	method removerPendiente(paquete) =
		enviosPendientes.remove(paquete)
	
	method facturacion() = facturacion
	
	method enviarPaquetes(paquetes) = 
		paquetes.forEach({p => self.enviarPaquete(p)})
		
	method enviarPendienteMasCaro() {
		var pendienteMasCaro = enviosPendientes.max({p => p.precio()})
		self.enviarPaquete(pendienteMasCaro)
		self.removerPendiente(pendienteMasCaro)
		}
}