//
//  Stream.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/20.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public protocol Stream {
    
    associatedtype Element
    
    var value: Observable<Element> { get }
    
    func subscribe(_ onNext: @escaping ((Element) -> Void)) -> Disposable
}

public extension Stream {
    func subscribe(_ onNext: @escaping ((Element) -> Void)) -> Disposable {
        return value.subscribe(onNext: onNext)
    }
}
