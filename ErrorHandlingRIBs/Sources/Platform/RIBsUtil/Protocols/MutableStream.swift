//
//  MutableStream.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/20.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public protocol MutableStream: Stream {
    
    func accept(_ element: Element)
}
