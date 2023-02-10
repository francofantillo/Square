//
//  CellSizes.swift
//  SqaureTest
//
//  Created by Franco Fantillo on 2023-02-09.
//

import UIKit

struct CellSizes {
	
	let width: CGFloat
	let height: CGFloat
	let cellMargin: CGFloat
	
	init(){
		
		self.cellMargin = 30
		let cellsPerRow = 2
		
		let numberOfCellDivides = cellsPerRow - 1
		let cellEndSpace = cellMargin * 2
		let cellDivideSpace = cellMargin * CGFloat(numberOfCellDivides)
		let totalSpaceToRemove = cellEndSpace + cellDivideSpace
	
		self.width = (UIScreen.main.bounds.width - totalSpaceToRemove) / CGFloat(cellsPerRow)
        self.height = self.width * 1.75
		
		print("Cell width is: \(width)")
		print("Cell height is: \(height)")
		print("Total Width is: \(UIScreen.main.bounds.width)")
		print("Total space reomved is: \(totalSpaceToRemove)")
	}
}
