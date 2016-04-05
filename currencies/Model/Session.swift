//
//  Session.swift
//  currencies
//
//  Created by Tancrède Chazallet on 05/04/2016.
//  Copyright © 2016 Solera. All rights reserved.
//

import Foundation

class Session {
	static let instance = Session()
	
	let availableGoods: [Good]
	
	private init() { // private ensure singleton pattern
		availableGoods = [
			Good(name: "Peas", unit: "Bag", pricePerUnit: 0.95),
			Good(name: "Eggs", unit: "Dozen", pricePerUnit: 2.10),
			Good(name: "Milk", unit: "Bottle", pricePerUnit: 1.30),
			Good(name: "Beans", unit: "Can", pricePerUnit: 0.73)
		]
	}
}