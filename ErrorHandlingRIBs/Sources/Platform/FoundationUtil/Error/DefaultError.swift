//
//  DefaultError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

public struct DefaultError: Error {
    
    public var message: String
    
    public var detailMessage: String
}
