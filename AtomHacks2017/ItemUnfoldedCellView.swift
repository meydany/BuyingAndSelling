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
import FirebaseStorage
import FirebaseStorageUI

class ItemUnfoldedCellView: UIView {
    
    public var cellIndex: Int = 0
    
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemPicture: UIImageView!
    @IBOutlet var sellerPicture: UIImageView!
    @IBOutlet var sellerName: UILabel!
    @IBOutlet var itemDescription: UITextView!
<<<<<<< HEAD
    @IBOutlet var submitButton: UIButton!
    @IBOutlet weak var itemPrace1: UILabel!
=======
>>>>>>> 945d06f12e57d431e58a6cae297aa6725c4385a4
    
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
<<<<<<< HEAD
        
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("Listings").child("Object\(cellIndex-1)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            print("index: " + String(self.cellIndex))
            let value = snapshot.value as! [String: String]
            print(value)
            self.itemName.text = value["ObjectName"]
            self.itemPrace1.text = "$" + value["Price"]!
            self.sellerName.text = value["PersonName"]
            self.itemDescription.text = value["Description"]
            
            let storageRef = FIRStorage.storage().reference()
            
                    // Reference to an image file in Firebase Storage
            print("images/\(value["ObjectName"]!).png")
            let reference = storageRef.child("images/\(value["ObjectName"]!).png")
          
                    // UIImageView in your ViewController
            let imageView: UIImageView = self.itemPicture
            
                    // Placeholder image
            let placeholderImage = UIImage(named: "placeholder.jpg")
            
                    // Load the image using SDWebImage
            imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
        }) { (error) in
            print(error.localizedDescription)
        }
        
=======

>>>>>>> 945d06f12e57d431e58a6cae297aa6725c4385a4
        addSubview(contentView)
    }
    
  
    @IBAction func requestMessage(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "https://m.me/1357531295")! as URL)
        print("HELLLOOOO")
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
    
    @IBAction func UIApplicationsharedopenURLNSURLstringhttpsmme1357531295asURLrequestMessage(_ sender: Any) {
    }
   
}
