//
//  SharedTableViewController.swift
//  currencies
//
//  Created by Tancrède Chazallet on 05/04/2016.
//  Copyright © 2016 Solera. All rights reserved.
//

import UIKit
import SwiftKeepLayout

class SharedTableViewController: SharedViewController, UITableViewDataSource, UITableViewDelegate {
	let tableView: UITableView
	
	// MARK: INIT
	init(style: UITableViewStyle) {
		self.tableView = UITableView(frame: CGRectZero, style: style)
		
		super.init()
		
		tableView.dataSource = self
		tableView.delegate = self
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: LAYOUT
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(tableView)
		tableView.keepInsets.vEqual = 0
	}
	
	// MARK: TABLE
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		assert(false, "you should override this method")
		return UITableViewCell()
	}
}
