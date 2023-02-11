//
//  EmployeeCell.swift
//  Square
//
//  Created by Franco Fantillo on 2023-02-09.
//

import UIKit
import SwiftUI

class EmployeeCell : UICollectionViewCell {

    var employee: Employee? {
        didSet {
            guard let employee = employee else { return }
            contentController.rootView = .init(employee: employee)
        }
    }
    
    private let contentController = UIHostingController<ContentView>(rootView: .init(employee: .example))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(contentController.view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentController.view.frame = contentView.bounds
        contentController.view.backgroundColor = .clear
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        preconditionFailure("Unavailable")
    }
}
