//
//  LoginUseCase.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/07.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

// MARK: - Input/Output

public protocol LoginInput {}

public struct LoginOutput {
    public let customer: Customer
}

// MARK: - UseCase Protocol

public protocol LoginUseCaseProtocol {
    associatedtype Input: LoginInput
    func execute(input: Input) -> Observable<LoginOutput>
}
