//
//  InteractorErrorStream.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/17.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

/// `Interactor`에서 핸들링될 에러
///
/// `Error`와 `ErrorStream`이 결합된 형태
///
/// - Parameters:
///  - Error: 현재 Interactor로 넘어온 에러
///  - ErrorStream: 부모 Interactor의 ErrorStream
public typealias InteractorError = (Error, ErrorStream)

/// `Interactor`에서 핸들링될 에러의 스트림
public typealias InteractorErrorStream = Observable<InteractorError>
