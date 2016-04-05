//
//  Good.swift
//  currencies
//
//  Created by Tancrède Chazallet on 05/04/2016.
//  Copyright © 2016 Solera. All rights reserved.
//

import Foundation

class Good {
	let name: String
	let unit: String
	let unitPrice: Float // Always from USD
	var unitPriceAtSelectedCurrency: Float {
		return self.unitPrice(Session.instance.selectedCurrency)
	}
	
	init(name: String, unit: String, pricePerUnit unitPrice: Float) {
		self.name = name
		self.unit = unit
		self.unitPrice = unitPrice
	}
	
	func unitPrice(currency: Currency) -> Float {
		return round(unitPrice * currency.quote * 100)/100
	}
}