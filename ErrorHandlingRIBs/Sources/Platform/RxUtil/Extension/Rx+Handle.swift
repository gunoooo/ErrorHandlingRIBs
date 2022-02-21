//
//  Rx+Handle.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/22.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public extension Observable {
    func handle(_ handler: @escaping ((Element) -> Void)) -> Disposable {
        return subscribe(onNext: handler)
    }
}
