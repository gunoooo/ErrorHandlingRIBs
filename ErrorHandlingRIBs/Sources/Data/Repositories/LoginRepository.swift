//
//  LoginRepository.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/18.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation
import RxSwift

public protocol LoginRepositoryProtocol {
    func login(uuid: String, withId: String, withPassword: String) -> Observable<Customer>
}

public class LoginRepository: LoginRepositoryProtocol {
    public func login(uuid: String, withId: String, withPassword: String) -> Observable<Customer> {
        // TODO: Data Passing Logic
        return .empty()
    }
}
