//
//  HandleableErrorStream+Execute.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/03.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public extension HandleableErrorStream {
    /// DefaultError 발생 함수
    /// - with mapper: Error를 DefaultError로 매핑하는 closure
    func execute(with mapper: @escaping ((Error) -> DefaultError)) -> Disposable {
        return subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { handleableError in
                handleableError.handle(with: mapper)
            })
    }
}
