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
	let unitPrice: Float
	let unit: String
	
	init(name: String, unit: String, pricePerUnit unitPrice: Float) {
		self.name = name
		self.unit = unit
		self.unitPrice = unitPrice
	}
}