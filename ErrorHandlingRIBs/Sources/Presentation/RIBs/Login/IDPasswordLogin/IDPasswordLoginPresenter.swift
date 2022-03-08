//
//  IDPasswordLoginPresenter.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/08.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs
import RxSwift

protocol IDPasswordLoginPresentationLogic: AnyObject {
    func presentWrongIDError(wrongIDError: HasMessage)
    func presentWrongPasswordError(wrongPasswordError: HasMessage)
}

protocol IDPasswordLoginPresentable {
    var viewController: IDPasswordLoginDisplayLogic? { get set }
}

final class IDPasswordLoginPresenter: IDPasswordLoginPresentable,
                                      IDPasswordLoginPresentationLogic {
    
    weak var viewController: IDPasswordLoginDisplayLogic?
    
    func presentWrongIDError(wrongIDError: HasMessage) {
        viewController?.setTextIDErrorLable(message: wrongIDError.message)
    }
    
    func presentWrongPasswordError(wrongPasswordError: HasMessage) {
        viewController?.setTextPasswordErrorLable(message: wrongPasswordError.message)
    }
}
