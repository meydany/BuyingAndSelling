//
//  ItemListingController.swift
//  AtomHacks2017
//
//  Created by Yoli Meydan on 5/13/17.
//  Copyright © 2017 AtomHacks. All rights reserved.
//

import Foundation
import UIKit
import FoldingCell
import EasyPeasy
import FirebaseDatabase

var DIVISION_HEIGHT: CGFloat = 150 //height of one division
var NUM_OF_DIVISION: CGFloat = 3 //remember to also change in FoldingCell
var CELL_SPACING: CGFloat = 8 //space between cells
var CELL_COUNT: Int = 1

var currentIndex: Int = -1; //sus dont judge

class ItemListingController: UITableViewController {

    let closeHeight: CGFloat = DIVISION_HEIGHT + (2 * CELL_SPACING)
    let openHeight: CGFloat = DIVISION_HEIGHT * NUM_OF_DIVISION + 16
    var itemHeight = [CGFloat](repeating: DIVISION_HEIGHT + (2 * CELL_SPACING), count:CELL_COUNT)
    
    var cellHeights = [CGFloat]()
    var loaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = closeHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        registerCell()
        let ref = FIRDatabase.database().reference()

        ref.child("Listings").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as! [String: [String: String]]
            CELL_COUNT = value.count
            self.loaded = true
            self.tableView.reloadData()
            print("reload")
        }) { (error) in
            print(error.localizedDescription)
        }
        
        for _ in 0...CELL_COUNT {
            cellHeights.append(closeHeight)
        }
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "Image"))
    }

    
    fileprivate func registerCell() {
        tableView.register(ItemFoldingCell.self, forCellReuseIdentifier: String(describing: ItemFoldingCell.self)) //registers custom cell as part of the tableView
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard case let cell as ItemFoldingCell = cell else {
            return
        }
        
        cell.backgroundColor = UIColor.clear
        
        if cellHeights[(indexPath as NSIndexPath).row] == closeHeight {
            cell.selectedAnimation(false, animated: false, completion:nil)
        } else {
            cell.selectedAnimation(true, animated: false, completion: nil)
        }
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loaded {
            return CELL_COUNT
        }
        else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemFoldingCell.self), for: indexPath)
        
        cell.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        print(cell.tag)//cheeeeeeky
        
        var duration = 0.0
        if itemHeight[indexPath.row] == closeHeight {
            itemHeight[indexPath.row] = openHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
        }else {
            itemHeight[indexPath.row] = closeHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }

}
