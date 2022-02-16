//
//  WrongIDError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/17.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

public struct WrongIDError: Error,
                            HasMessage {
    
    public var message: String
}
