//
//  ItemFoldedCellView.swift
//  AtomHacks2017
//
//  Created by Yoli Meydan on 5/13/17.
//  Copyright © 2017 AtomHacks. All rights reserved.
//

//
//  ProfileFoldingCellView.swift
//  FoldingCellTest
//
//  Created by Admin on 5/5/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import UIKit

class ItemUnfoldedCellView: UIView {
    
    public var cellIndex: Int = 0
    
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemPicture: UIImageView!
    @IBOutlet var sellerPicture: UIImageView!
    @IBOutlet var sellerName: UILabel!
    @IBOutlet var itemPrice: UILabel!
    @IBOutlet var itemDescription: UITextView!
    @IBOutlet var submitButton: UIButton!
    
    init(index: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        cellIndex = index
        print("Unfolded Index: \(cellIndex)")
        
        setupContentView()
        customizeCell()
    }
    
    func setupContentView() {
        let contentView =  Bundle.main.loadNibNamed("ItemUnfoldedCellView", owner: self, options: nil)?[0] as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(contentView)
    }
    
    func customizeCell() {
        numberLabel.text = "#\(cellIndex)"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupContentView()
    }
    
}
