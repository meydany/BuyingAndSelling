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
import FirebaseDatabase

class ItemFoldedCellView: UIView {
    
    public var cellIndex: Int = 0
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
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
        
        ref.child("Listings").child("Object\(cellIndex)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            print(self.cellIndex)
            let value = snapshot.value as! [String: String]
            print(value)
            self.mainLabel.text = value["ObjectName"]
            self.secondLabel.text = "$" + value["Price"]!
            self.thirdLabel.text = value["PersonName"]
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        addSubview(contentView)
    }
    
    func customizeCell() {
        mainLabel.text = "Cell: \(cellIndex)"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupContentView()
    }
    
}
