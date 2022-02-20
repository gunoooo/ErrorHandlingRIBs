//
//  Rx+Catching.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/17.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public extension ObservableType {
    /// 에러 발생시 dependency의 errorStream으로 Error를 이동시키는 함수
    /// - Parameters:
    ///  - to dependency: 에러 발생시 onNext 시킬 `InteractorDependency`  (`HasErrorStream`)
    ///
    /// - returns:
    /// 에러가 필터링된 Observable
    func `catch`(to dependency: HasErrorStream) -> Observable<Element> {
        return `catch` { error in
            dependency.errorStream.accept(error)
            return .empty()
        }
    }
}
