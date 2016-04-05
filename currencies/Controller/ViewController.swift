//
//  ViewController.swift
//  currencies
//
//  Created by Tancrède Chazallet on 05/04/2016.
//  Copyright © 2016 Solera. All rights reserved.
//

import UIKit

class ViewController: SharedTableViewController {
	
	// MARK: INIT
	init() {
		super.init(style: .Plain)
		
		title = "Goods"
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.currenciesDidUpdate), name: NOTIFICATION_CURRENCIES_DID_UPDATE, object: Session.instance)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: LAYOUT
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: Session.instance.selectedCurrency.displayedName, style: .Plain, target: self, action: #selector(ViewController.currencyButtonAction))
		
		Session.instance.requestCurrencies()
	}
	
	// MARK: TABLE
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Session.instance.availableGoods.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let good = Session.instance.availableGoods[indexPath.row]
		let reuseIdentifier = "cell"
		let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) ?? UITableViewCell(style: .Value1, reuseIdentifier: reuseIdentifier)
		
		cell.textLabel?.text = good.name
		cell.detailTextLabel?.text = "\(good.unitPriceAtSelectedCurrency)/\(good.unit)"
		return cell
	}
	
	// MARK: ACTION
	func currencyButtonAction() {
		Session.instance.selectNextCurrency()
		navigationItem.rightBarButtonItem?.title = Session.instance.selectedCurrency.displayedName
		tableView.reloadData()
	}
	
	// MARK: OBSERVERS
	func currenciesDidUpdate() {
		tableView.reloadData()
	}
}

