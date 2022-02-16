//
//  ErrorStream.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/16.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

/// Stream 형태의 `Error`
public typealias ErrorStream = PublishSubject<Error>
