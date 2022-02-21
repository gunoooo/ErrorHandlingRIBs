//
//  InteractorErrorStream+Handle.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/22.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public extension InteractorErrorStream {
    /// UnhandledError 발생시 처리 함수
    /// - handler: 현재 RIB에서 발생된 에러가 `Error Scope` 에 포함되지 않는 경우 이벤트
    func handle(_ handler: @escaping ((UnhandledError) -> Void)) -> Disposable {
        return value.subscribe(onNext: { error, errorStream in
            if let unhandledError = error as? UnhandledError {
                handler(unhandledError)
            }
        })
    }
}
