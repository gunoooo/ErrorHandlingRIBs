//
//  HasInteractableErrorStream.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

/// `InteractableErrorStream`을 제공하는 프로토콜
public protocol HasInteractableErrorStream {
    var errorStream: InteractableErrorStream { get }
}
