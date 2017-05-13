//
//  ViewController.swift
//  AtomHacks2017
//
//  Created by Yoli Meydan on 5/13/17.
//  Copyright © 2017 AtomHacks. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var leftVc: UIViewController!
    var middleVc: UIViewController!
    
    var directionLockDisabled: Bool!
    
    var horizontalViews = [UIViewController]()
    var veritcalViews = [UIViewController]()
    
    var initialContentOffset = CGPoint() // scrollView initial offset
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        let view = (
            x: self.view.bounds.origin.x,
            y: self.view.bounds.origin.y,
            width: self.view.bounds.width,
            height: self.view.bounds.height
        )
        
        scrollView.frame = CGRect(x: view.x,
                                  y: view.y,
                                  width: view.width,
                                  height: view.height
        )
        
        self.view.addSubview(scrollView)
        
        let scrollWidth  = 2 * view.width
        let scrollHeight  = view.height
        scrollView.contentSize = CGSize(width: scrollWidth, height: scrollHeight)
        
        leftVc = ListItemViewController()
        leftVc.view.frame = CGRect(x: 0,
                                   y: 0,
                                   width: view.width,
                                   height: view.height
        )
        
        middleVc = ItemListingController()
        middleVc.view.frame = CGRect(x: view.width,
                                               y: 0,
                                               width: view.width,
                                               height: view.height
        )
        
        addChildViewController(leftVc)
        addChildViewController(middleVc)
        
        scrollView.addSubview(leftVc.view)
        scrollView.addSubview(middleVc.view)
        
        leftVc.didMove(toParentViewController: self)
        middleVc.didMove(toParentViewController: self)
        
        scrollView.contentOffset.x = middleVc.view.frame.origin.x
        scrollView.delegate = self
    }

    
    override func viewDidAppear(_ animated: Bool) {
        //self.present(ItemListingController(), animated: false, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

