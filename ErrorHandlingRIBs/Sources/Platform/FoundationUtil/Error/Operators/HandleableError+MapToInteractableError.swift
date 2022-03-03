//
//  HandleableError+MapToInteractableError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

public extension HandleableError {
    /// HandleableError -> InteractableError
    func mapToInteractableError(errorStream: HandleableErrorStream) -> InteractableError {
        return InteractableError(self, errorStream: errorStream)
    }
}
