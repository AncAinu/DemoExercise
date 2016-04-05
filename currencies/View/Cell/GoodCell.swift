//
//  GoodCell.swift
//  currencies
//
//  Created by Tancrède Chazallet on 05/04/2016.
//  Copyright © 2016 Solera. All rights reserved.
//

import UIKit
import SwiftKeepLayout

class GoodCell: UITableViewCell {
	static let height = 50
	
	let quantityLabel = UILabel()
	let titleLabel = UILabel()
	let priceLabel = UILabel()
	let unitLabel = UILabel()
	
	init(reuseIdentifier: String?) {
		super.init(style: .Default, reuseIdentifier: reuseIdentifier)
		
		quantityLabel.textColor = UIColor.grayColor()
		contentView.addSubview(quantityLabel)
		quantityLabel.keepVerticallyCentered()
		quantityLabel.keepLeftInset.vEqual = 10
		quantityLabel.keepWidth.vEqual = 20
		
		priceLabel.textColor = UIColor.grayColor()
		priceLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Horizontal)
		priceLabel.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
		contentView.addSubview(priceLabel)
		priceLabel.keepVerticallyCentered()
		//priceLabel.keepWidth.vEqual = 80
		
		unitLabel.font = UIFont.systemFontOfSize(10)
		unitLabel.textColor = UIColor.grayColor()
		contentView.addSubview(unitLabel)
		unitLabel.keepTopAlignTo(priceLabel).vEqual = 0
		unitLabel.keepRightInset.vEqual = 5
		unitLabel.keepWidth.vEqual = 40
		unitLabel.keepLeftOffsetTo(priceLabel).vEqual = 0
		
		titleLabel.textColor = UIColor.blackColor()
		contentView.addSubview(titleLabel)
		titleLabel.keepVerticallyCentered()
		titleLabel.keepLeftOffsetTo(quantityLabel).vEqual = 10
		titleLabel.keepRightOffsetTo(priceLabel).vEqual = 10
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}