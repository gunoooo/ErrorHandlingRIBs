//
//  InteractableErrorStream+Send.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/03.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public extension InteractableErrorStream {
    /// 에러 전송 함수
    func send(before handler: ((DefaultError) -> Void)? = nil) -> Disposable {
        return subscribe(onNext: { interactableError in
            if let defaultError = interactableError.handleableError.error as? DefaultError {
                handler?(defaultError)
                return
            }
            interactableError.send()
        })
    }
}
