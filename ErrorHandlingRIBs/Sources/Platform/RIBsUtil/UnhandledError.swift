//
//  UnhandledError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/20.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

public struct UnhandledError: Error {
    
    public var message: String
    
    public var detailMessage: String
}
