//
//  Rx+Catch.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/17.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public extension ObservableType {
    /// 에러 발생시 errorHandler의 errorStream으로 Error를 이동시키는 함수
    ///
    /// - Parameters:
    ///  - to errorStreamProvider: 에러 발생시 onNext 시킬 `HandleableErrorStream`을 소유한 객체
    ///  - handler: ErrorHandleable`을 채택하여 에러 처리 로직이 구현된 객체
    ///
    /// - returns:
    /// 에러가 필터링된 Observable
    func catchAndThrow(to errorStreamProvider: HasHandleableErrorStream, handler: ErrorHandleable) -> Observable<Element> {
        return `catch` { error in
            errorStreamProvider.errorStream.onNext(HandleableError(error, handler: handler))
            return .empty()
        }
    }
}
