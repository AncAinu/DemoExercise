//
//  Session.swift
//  currencies
//
//  Created by Tancrède Chazallet on 05/04/2016.
//  Copyright © 2016 Solera. All rights reserved.
//

import Foundation
import Alamofire

let NOTIFICATION_CURRENCIES_DID_UPDATE = "NOTIFICATION_CURRENCIES_DID_UPDATE"

class Session {
	static let instance = Session()
	
	let availableGoods: [Good]
	var currencies = [Currency]()
	private(set) var selectedCurrency: Currency
	
	private(set) var basket: [(good: Good, quantity: Int)]
	
	private init() { // private ensure singleton pattern
		availableGoods = [
			Good(name: "Peas", unit: "Bag", pricePerUnit: 0.95),
			Good(name: "Eggs", unit: "Dozen", pricePerUnit: 2.10),
			Good(name: "Milk", unit: "Bottle", pricePerUnit: 1.30),
			Good(name: "Beans", unit: "Can", pricePerUnit: 0.73)
		]
		
		basket = availableGoods.map{($0, 0)} // Fonctionnal programming is good :D
		
		currencies = [Currency(name: "USDUSD", quote: 1)]
		selectedCurrency = currencies.first!
	}
	
	// MARK: CURRENCIES
	func requestCurrencies() {
		Alamofire.request(.GET, CURRENCY_LAYER_API_BASE_URL, parameters: [
			CURRENCY_LAYER_PARAMETER_ACCESS_KEY: CURRENCY_LAYER_ACCESS_KEY,
			CURRENCY_LAYER_PARAMETER_CURRENCIES: CURRENCY_LAYER_CURRENCIES,
			CURRENCY_LAYER_PARAMETER_FORMAT: CURRENCY_LAYER_FORMAT
			]).responseJSON { response in
				if let json = response.result.value as? [String: AnyObject] {
					if let quotes = json["quotes"] as? [String: Float] {
						for key in quotes.keys {
							var currency = self.findCurrency(key)
							if currency == nil {
								currency = Currency(name: key, quote: 1)
								self.currencies += [currency!]
							}
							currency!.quote = quotes[key]!
						}
						
						// Notify
						NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_CURRENCIES_DID_UPDATE, object: self)
					}
				}
		}
	}
	
	func findCurrency(name: String) -> Currency? {
		return currencies.filter({$0.name == name}).first
	}
	
	func selectNextCurrency() {
		if let i = currencies.indexOf({$0 === selectedCurrency}) where i < currencies.count-1 {
			selectedCurrency = currencies[i+1]
		}
		else {
			selectedCurrency = currencies.first!
		}
	}
	
	// MARK: BASKET
	func quantityInBasket(good: Good) -> Int {
		if let i = basket.indexOf({$0.good === good}) {
			return basket[i].quantity
		}
		assert(false, "the basket should always find the good as they are initialized together and are supposed to be immutable (outside Session)")
	}
	
	func setQuantityInBasket(quantity: Int, forGood good: Good) {
		if let i = basket.indexOf({$0.good === good}) {
			basket[i].quantity = quantity
			return
		}
		assert(false, "the basket should always find the good as they are initialized together and are supposed to be immutable (outside Session)")
	}
}