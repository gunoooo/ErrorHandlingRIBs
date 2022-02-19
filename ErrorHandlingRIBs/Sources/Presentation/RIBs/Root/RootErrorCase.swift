//
//  RootErrorCase.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/20.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

enum RootErrorCase: ErrorCaseable {
    
    typealias ErrorContent = HasMessage & HasDetailMessage
    
    case SecureError
}
