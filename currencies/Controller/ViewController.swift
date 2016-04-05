//
//  ViewController.swift
//  currencies
//
//  Created by Tancrède Chazallet on 05/04/2016.
//  Copyright © 2016 Solera. All rights reserved.
//

import UIKit

class ViewController: SharedTableViewController {
	
	let totalPriceLabel = UILabel()
	
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
		
		// Total Price bar
		let totalPriceView = UIView()
		totalPriceView.backgroundColor = UIColor.grayColor()
		view.addSubview(totalPriceView)
		totalPriceView.keepBottomInset.vEqual = 0
		totalPriceView.keepHorizontalInsets.vEqual = 0
		totalPriceView.keepHeight.vEqual = 60
		
		let totalPriceTitleLabel = UILabel()
		totalPriceTitleLabel.text = "Total:"
		totalPriceView.addSubview(totalPriceTitleLabel)
		totalPriceTitleLabel.keepVerticallyCentered()
		totalPriceTitleLabel.keepLeftInset.vEqual = 10
		
		totalPriceLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Horizontal)
		totalPriceLabel.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
		totalPriceView.addSubview(totalPriceLabel)
		totalPriceLabel.keepVerticallyCentered()
		totalPriceLabel.keepRightInset.vEqual = 10
		totalPriceLabel.keepLeftOffsetTo(totalPriceTitleLabel).vEqual = 10
		totalPriceLabel.keepWidth.vMin = 80
		
		// We override the constraint of table
		tableView.keepBottomInset.deactivate()
		tableView.keepBottomOffsetTo(totalPriceView).vEqual = 0
		
		Session.instance.requestCurrencies()
		layoutTotal()
	}
	
	func layoutTotal() {
		var totalUSD:Float = 0.0
		for item in Session.instance.basket {
			totalUSD += item.good.unitPrice * Float(item.quantity)
		}
		let totalInSelectedCurrency = round(totalUSD * Session.instance.selectedCurrency.quote * 100)/100
		totalPriceLabel.text = "\(totalInSelectedCurrency)\(Session.instance.selectedCurrency.displayedName)"
	}
	
	// MARK: TABLE
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Session.instance.availableGoods.count
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return GoodCell.height
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let good = Session.instance.availableGoods[indexPath.row]
		let reuseIdentifier = "GoodCell"
		let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? GoodCell ?? GoodCell(reuseIdentifier: reuseIdentifier)
		
		cell.titleLabel.text = good.name
		cell.quantityLabel.text = "\(Session.instance.quantityInBasket(good))"
		cell.priceLabel.text = "\(good.unitPriceAtSelectedCurrency)\(Session.instance.selectedCurrency.displayedName)"
		cell.unitLabel.text = "/\(good.unit)"
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let good = Session.instance.availableGoods[indexPath.row]
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		
		Session.instance.setQuantityInBasket(Session.instance.quantityInBasket(good) + 1, forGood: good)
		
		if let cell = tableView.cellForRowAtIndexPath(indexPath) as? GoodCell {
			cell.quantityLabel.text = "\(Session.instance.quantityInBasket(good))"
		}
		
		layoutTotal()
	}
	
	// MARK: TABLE EDIT
	func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
		let good = Session.instance.availableGoods[indexPath.row]
		print("Remove (\(Session.instance.quantityInBasket(good)))")
		return "Remove (\(Session.instance.quantityInBasket(good)))"
	}
	
	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if (editingStyle == .Delete) {
			let good = Session.instance.availableGoods[indexPath.row]
			
			Session.instance.setQuantityInBasket(max(Session.instance.quantityInBasket(good) - 1, 0), forGood: good)
			
			if let cell = tableView.cellForRowAtIndexPath(indexPath) as? GoodCell {
				cell.quantityLabel.text = "\(Session.instance.quantityInBasket(good))"
			}
			
			layoutTotal()
		}
	}
	
	// MARK: ACTION
	func currencyButtonAction() {
		Session.instance.selectNextCurrency()
		navigationItem.rightBarButtonItem?.title = Session.instance.selectedCurrency.displayedName
		tableView.reloadData()
		layoutTotal()
	}
	
	// MARK: OBSERVERS
	func currenciesDidUpdate() {
		tableView.reloadData()
		layoutTotal()
	}
}

