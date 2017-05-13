//
//  ItemFoldingCell.swift
//  AtomHacks2017
//
//  Created by Yoli Meydan on 5/13/17.
//  Copyright © 2017 AtomHacks. All rights reserved.
//

import Foundation
import UIKit
import FoldingCell
import EasyPeasy

class ItemFoldingCell: FoldingCell {
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        currentIndex += 1
        
        containerView = createContainerView()
        foregroundView = createForegroundView()
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.33,0.26,0.26]
        return durations[itemIndex]
    }
}

extension ItemFoldingCell {
    
    fileprivate func createForegroundView() -> RotatedView {
        let foregroundView = Init(RotatedView(frame: .zero)) {
            $0.backgroundColor = .red
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(foregroundView)
        
        // add constraints
        foregroundView <- [
            Height(DIVISION_HEIGHT),
            Left(8),
            Right(8),
        ]
        
        
        // add identifier
        let top = (foregroundView <- [Top(8)]).first
        top?.identifier = "ForegroundViewTop"
        
        self.foregroundViewTop = top
        
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        
        foregroundView.addSubview(ItemFoldedCellView(index: currentIndex))
        foregroundView.layoutIfNeeded()
        
        return foregroundView
    }
    
    fileprivate func createContainerView() -> UIView {
        let containerView = Init(UIView(frame: .zero)) {
            $0.backgroundColor = .green
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(containerView)
        
        // add constraints
        containerView <- [
            Height(CGFloat(DIVISION_HEIGHT * NUM_OF_DIVISION)),
            Left(8),
            Right(8),
        ]
        
        // add identifier
        let top = (containerView <- [Top(8)]).first
        top?.identifier = "ContainerViewTop"
        
        self.containerViewTop = top
        
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        
        containerView.addSubview(ItemUnfoldedCellView(index: currentIndex))
        containerView.layoutIfNeeded()
        
        print(containerView.frame.width)
        print(containerView.frame.height)
        
        return containerView
    }
}
