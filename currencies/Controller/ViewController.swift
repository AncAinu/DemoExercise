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
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: LAYOUT
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
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
		cell.detailTextLabel?.text = "\(good.unitPrice)/\(good.unit)"
		return cell
	}
}

