//
//  Currency.swift
//  currencies
//
//  Created by Tancrède Chazallet on 05/04/2016.
//  Copyright © 2016 Solera. All rights reserved.
//

import Foundation

class Currency {
	let name: String
	var displayedName: String {
		return name.substringFromIndex(name.characters.startIndex.advancedBy(3))
	}
	var quote: Float
	
	init(name: String, quote: Float) {
		self.name = name
		self.quote = quote
	}
}