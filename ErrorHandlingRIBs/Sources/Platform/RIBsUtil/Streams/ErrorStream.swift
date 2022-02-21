//
//  ErrorStream.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/16.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

/// Stream 형태의 `Error`
public class ErrorStream: MutableStream {
    
    public typealias Element = Error
    
    public var value: Observable<Element> {
        return _value.asObservable()
    }
    
    /// 에러가 최초 발생된 RIB의 error stream
    public weak var startedPoint: PublishSubject<Element>?
    
    public func accept(_ element: Error) {
        _value.onNext(element)
    }
    
    public func accept(_ element: Element, startedPoint: PublishSubject<Element>) {
        self.startedPoint = startedPoint
        _value.onNext(element)
    }
    
    public func create(_ element: Element) {
        self.startedPoint = _value
        _value.onNext(element)
    }
    
    // MARK: - Private
    
    private let _value = PublishSubject<Element>()
}
