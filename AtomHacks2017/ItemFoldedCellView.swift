//
//  ItemFoldedCellView.swift
//  AtomHacks2017
//
//  Created by Yoli Meydan on 5/13/17.
//  Copyright © 2017 AtomHacks. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class ItemFoldedCellView: UIView {
    
    public var cellIndex: Int = 0
    
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var sellerName: UILabel!
    @IBOutlet var itemCost: UILabel!
    
    init(index: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        cellIndex = index
        print("Folded Index: \(cellIndex)")
        
        setupContentView()
        customizeCell()
    }
    
    func setupContentView() {
        let contentView =  Bundle.main.loadNibNamed("ItemFoldedCellView", owner: self, options: nil)?[0] as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //contentView.frame = bounds
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("Listings").child("Object\(cellIndex-1)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            print("index: " + String(self.cellIndex))
            let value = snapshot.value as! [String: String]
            print(value)
            self.itemName.text = value["ObjectName"]
            self.itemCost.text = "$" + value["Price"]!
            self.sellerName.text = value["PersonName"]
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
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
