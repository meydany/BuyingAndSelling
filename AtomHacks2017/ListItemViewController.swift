//
//  SellViewController.swift
//  FirebaseTest
//
//  Created by Admin on 5/13/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Eureka
import FirebaseStorage

class ListItemViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        form +++ Section("Your info")
            <<< NameRow(){ row in
                row.title = "Seller's Name"
            }
            <<< NameRow(){ row in
                row.title = "Object's Name"
            }
            <<< IntRow(){ row in
                row.title = "Price"
            }
            <<< ImageRow(){ row in
                row.title = "Picture"
                row.sourceTypes = [.PhotoLibrary, .Camera]
                row.clearAction = .yes(style: UIAlertActionStyle.destructive)
                }
                .cellUpdate { cell, row in
                    cell.accessoryView?.layer.cornerRadius = 17
                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            }
            
            +++ Section("Section2")
            <<< SwitchRow(){
                $0.title = "Submit"
                }.onChange({ row in
                    let pic = (self.form.allRows[3] as! ImageRow).value
                    //self.present(TestVC(pic: pic!), animated: true, completion: nil)
                    print("submitting")
                    
                    let rows = self.form.allRows
                    
                    
                    
                    let storage = FIRStorage.storage()
                    let picRef = "images/\((rows[1] as! NameRow).value!).png"
                    let storageRef = storage.reference().child(picRef)
                    
                    let uploadTask = storageRef.put(UIImagePNGRepresentation(pic!)!, metadata: nil) { metadata, error in
                        if let error = error {
                            // Uh-oh, an error occurred!
                        } else {
                            // Metadata contains file metadata such as size, content-type, and download URL.
                            let downloadURL = metadata!.downloadURL()
                        }
                    }
                    
                    
                    
                    let ref = FIRDatabase.database().reference()
                    let info = [
                        "ObjectName": (rows[0] as! NameRow).value,
                        "personName": (rows[1] as! NameRow).value,
                        "price": String(describing: (rows[2] as! IntRow).value!),
                        "picRef": picRef
                    ]
                    
                    ref.child("Listings").child("Object\(times)").setValue(info)
                })
        
    }
}
