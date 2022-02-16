//
//  HasDependency.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/16.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

public protocol HasDependency {
    associatedtype DependencyType
    var dependency: DependencyType { get }
}
