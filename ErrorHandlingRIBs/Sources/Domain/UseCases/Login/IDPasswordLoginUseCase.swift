//
//  IDPasswordLoginUseCase.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/07.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

// MARK: - Error Case

public enum IDPasswordLoginErrorCase: ErrorCaseable {
    public typealias ErrorContent = HasMessage
    
    case WrongIDError
    case WrongPasswordError
}

// MARK: - Input

public struct IDPasswordLoginInput: LoginInput {
    public let id: String
    public let password: String
}

// MARK: - UseCase Protocol

public protocol IDPasswordLoginUseCaseProtocol: LoginUseCaseProtocol where Input == IDPasswordLoginInput {
    func execute(input: Input) -> Observable<LoginOutput>
}

// MARK: - UseCase Impl

public final class IDPasswordLoginUseCase: IDPasswordLoginUseCaseProtocol {
    
    let loginRepository: LoginRepositoryProtocol
    let deviceRepository: DeviceRepositoryProtocol
    
    public init(
        loginRepository: LoginRepositoryProtocol,
        deviceRepository: DeviceRepositoryProtocol
    ) {
        self.loginRepository = loginRepository
        self.deviceRepository = deviceRepository
    }
    
    public func execute(input: IDPasswordLoginInput) -> Observable<LoginOutput> {
        return loginRepository.login(uuid: deviceRepository.uuid, withId: input.id, withPassword: input.password)
            .map { LoginOutput(customer: $0) }
            .catch { throw $0.mapTo(type: IDPasswordLoginErrorCase.self) ?? $0 }
    }
}
