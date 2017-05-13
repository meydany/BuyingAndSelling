//
//  ConfigurationBlock.swift
//  AtomHacks2017
//
//  Created by Yoli Meydan on 5/13/17.
//  Copyright © 2017 AtomHacks. All rights reserved.
//
import Foundation


internal func Init<Type>(_ value : Type, block: (_ object: Type) -> Void) -> Type
{
    block(value)
    return value
}
