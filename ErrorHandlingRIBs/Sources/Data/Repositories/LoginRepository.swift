//
//  LoginRepository.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/18.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginRepositoryProtocol {
    func login(loginData: LoginData) -> Observable<LoginInfo>
}
