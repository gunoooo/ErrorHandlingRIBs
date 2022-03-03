//
//  HandleableErrorStream+MapToInteractableError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public extension HandleableErrorStream {
    /// HandleableError -> InteractableError
    func mapToInteractableError(errorStream: HandleableErrorStream) -> Observable<InteractableError> {
        return map {
            $0.mapToInteractableError(errorStream: errorStream)
        }
    }
}
