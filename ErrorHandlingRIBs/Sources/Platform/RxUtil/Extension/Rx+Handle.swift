//
//  Rx+Handle.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/22.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public extension ObservableType where Element: CaseableErrorContentType {
    func handle(_ handler: @escaping ((Element) -> Void)) -> Disposable {
        return subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: handler)
    }
}
