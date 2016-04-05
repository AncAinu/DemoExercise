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
	
	private init() { // private ensure singleton pattern
		availableGoods = [
			Good(name: "Peas", unit: "Bag", pricePerUnit: 0.95),
			Good(name: "Eggs", unit: "Dozen", pricePerUnit: 2.10),
			Good(name: "Milk", unit: "Bottle", pricePerUnit: 1.30),
			Good(name: "Beans", unit: "Can", pricePerUnit: 0.73)
		]
		
		currencies = [Currency(name: "USDUSD", quote: 1)]
		selectedCurrency = currencies.first!
	}
	
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
}