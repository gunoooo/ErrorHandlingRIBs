//
//  LoginData.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/18.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

/// 로그인 시 필요한 정보
public protocol LoginData {
    /// 기기정보
    var uuid: String { get }
}

public struct IDPassword: LoginData {
    public let uuid: String
    public let id: String
    public let password: String
}
