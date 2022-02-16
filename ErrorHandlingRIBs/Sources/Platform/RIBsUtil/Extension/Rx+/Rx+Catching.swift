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
    /// - Parameters:
    ///  - to interactor: 에러 발생시 onNext 시킬 `Interactor`  (`HasInteractorDependency`)
    ///
    /// - returns:
    /// 에러가 필터링된 Observable
    func `catch`(to interactor: HasInteractorDependency) -> Observable<Element> {
        return `catch` { error in
            guard let errorHandlingInteractorDependency = interactor.interactorDependency as? ErrorHandlingInteractorDependency else {
                fatalError("\(interactor.interactorDependency) should conform to \(ErrorHandlingInteractorDependency.self)")
            }
            errorHandlingInteractorDependency.errorStream.onNext(error)
            return .empty()
        }
    }
}
