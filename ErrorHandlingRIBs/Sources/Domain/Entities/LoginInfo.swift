//
//  LoginInfo.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/18.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

/// 로그인 성공시 내려오는 정보
public struct LoginInfo {
    public let cusno: String
    public let loginType: LoginType
}
