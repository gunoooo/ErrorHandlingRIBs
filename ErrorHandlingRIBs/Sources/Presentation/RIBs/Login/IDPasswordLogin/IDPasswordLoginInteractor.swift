//
//  IDPasswordLoginInteractor.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/07.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs
import RxSwift

protocol IDPasswordLoginBusinessLogic: AnyObject {
    func login(input: IDPasswordLoginInput)
}

protocol IDPasswordLoginInteractable: Interactable {
    var router: IDPasswordLoginRoutingLogic? { get set }
    var listener: IDPasswordLoginListener? { get set }
}

protocol IDPasswordLoginListener: AnyObject {
    func didFinishIDPasswordLogin(with customer: Customer)
}

protocol IDPasswordLoginInteractorDependency: ErrorHandleableInteractorDependency {
    var idPasswordLoginUseCase: IDPasswordLoginUseCase { get }
}

final class IDPasswordLoginInteractor: PresentableInteractor<IDPasswordLoginPresentationLogic>,
                                       IDPasswordLoginInteractable,
                                       IDPasswordLoginBusinessLogic,
                                       HasInteractorDependency,
                                       InteractorErrorHandlable {
    
    weak var router: IDPasswordLoginRoutingLogic?
    
    weak var listener: IDPasswordLoginListener?
    
    let dependency: IDPasswordLoginInteractorDependency
    
    init(dependency: IDPasswordLoginInteractorDependency, presenter: IDPasswordLoginPresentationLogic) {
        self.dependency = dependency
        super.init(presenter: presenter)
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        handleError(errorStream: errorStream)
            .send()
            .disposeOnDeactivate(interactor: self)
    }
    
    func handleError(errorStream: Observable<InteractableError>) -> Observable<InteractableError> {
        errorStream
            .filterDefault { error in
                // TODO: 알럿 처리
            }
    }
    
    func login(input: IDPasswordLoginInput) {
        dependency.idPasswordLoginUseCase
            .execute(input: input)
            .take(1)
            .filter(type: IDPasswordLoginErrorCase.self) { [weak self] error in
                switch error.errorCase {
                case .WrongIDError:
                    self?.presenter.presentWrongIDError(wrongIDError: error.errorContent)
                case .WrongPasswordError:
                    self?.presenter.presentWrongPasswordError(wrongPasswordError: error.errorContent)
                }
            }
            .catchAndThrow(to: self)
            .subscribe(onNext: { [weak self] loginOutput in
                self?.listener?.didFinishIDPasswordLogin(with: loginOutput.customer)
            })
            .disposeOnDeactivate(interactor: self)
    }
}
