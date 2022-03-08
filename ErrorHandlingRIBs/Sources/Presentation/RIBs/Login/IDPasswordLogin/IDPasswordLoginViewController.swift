//
//  IDPasswordLoginViewController.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/07.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol IDPasswordLoginDisplayLogic: AnyObject {
    func setTextIDErrorLable(message: String)
    func setTextPasswordErrorLable(message: String)
}

protocol IDPasswordLoginViewControllable: ViewControllable {
    var interactor: IDPasswordLoginBusinessLogic? { get set }
}

final class IDPasswordLoginViewController: UIViewController,
                                           IDPasswordLoginViewControllable,
                                           IDPasswordLoginDisplayLogic {
    
    weak var interactor: IDPasswordLoginBusinessLogic?
    
    func setTextIDErrorLable(message: String) {
        // TODO: 아이디 필드 하단에 error message 표현
    }
    
    func setTextPasswordErrorLable(message: String) {
        // TODO: 비밀번호 필드 하단에 error message 표현
    }
}
