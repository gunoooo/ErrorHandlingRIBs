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

public typealias IDPasswordLoginUseCaseError = CaseableError<IDPasswordLoginErrorCase>

// MARK: - Input/Output

public struct IDPasswordLoginInput: LoginInput {
    public let uuid: String
    public let id: String
    public let password: String
}

// MARK: - ID Password Login Impl

public typealias IDPasswordLoginUseCase = LoginUseCase<IDPasswordLoginInput>

public extension LoginUseCase where Input == IDPasswordLoginInput {
    
    func execute(input: Input) -> Observable<LoginOutput> {
        return loginRepository.login(uuid: input.uuid, withId: input.id, withPassword: input.password)
            .map { LoginOutput(customer: $0) }
            .catch { throw $0.mapTo(type: IDPasswordLoginErrorCase.self) ?? $0 }
    }
}
