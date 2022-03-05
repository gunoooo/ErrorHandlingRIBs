//
//  DefaultError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public struct DefaultError: Error {
    
    public var message: String
    
    public var detailMessage: String
}

public extension ObservableType where Element == HandleableError {
    /// DefaultError 발생 함수
    ///
    /// - Parameters:
    ///     - mapper: Error를 DefaultError로 매핑하는 closure
    func execute(with mapper: @escaping (Error) -> DefaultError) -> Disposable {
        return observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { handleableError in
                handleableError.execute(with: mapper)
            })
    }
}

public extension ObservableType where Element == InteractableError {
    /// DefaultError 필터링 함수
    ///
    /// - note: send 함수 전에 필수로 실행해야함
    ///
    /// - returns:
    /// `DefaultError 타입이 필터링된 에러`
    func filterDefault(_ handler: @escaping ((DefaultError) -> Void)) -> Observable<InteractableError> {
        return compactMap { interactableError in
            if let defaultError = interactableError.handleableError.error as? DefaultError {
                handler(defaultError)
                return nil
            }
            return interactableError
        }
    }
}
