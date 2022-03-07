//
//  LoginUseCase.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/07.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

// MARK: - Input/Output

public protocol LoginInput {
    var uuid: String { get }
}

public struct LoginOutput {
    public let customer: Customer
}

// MARK: - UseCase Protocol

public protocol LoginUseCaseProtocol {
    associatedtype Input: LoginInput
    func execute(input: Input) -> Observable<LoginOutput>
}

// MARK: - UseCase Impl

public class LoginUseCase<Input: LoginInput>: LoginUseCaseProtocol {
    
    public let loginRepository: LoginRepositoryProtocol
    
    public init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }
    
    public func execute(input: Input) -> Observable<LoginOutput> {
        return .never()
    }
}
