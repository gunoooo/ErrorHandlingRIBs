//
//  IDPasswordLoginInteractor.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/07.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs
import RxSwift

protocol IDPasswordLoginRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol IDPasswordLoginPresentable: Presentable {
    var listener: IDPasswordLoginPresentableListener? { get set }
}

protocol IDPasswordLoginListener: AnyObject {
    func didFinishIDPasswordLogin(with customer: Customer)
}

protocol IDPasswordLoginInteractorDependency: ErrorHandleableInteractorDependency {
    var uuid: String { get }
    var idPasswordLoginUseCase: IDPasswordLoginUseCase { get }
}

final class IDPasswordLoginInteractor: PresentableInteractor<IDPasswordLoginPresentable>,
                                       IDPasswordLoginInteractable,
                                       IDPasswordLoginPresentableListener,
                                       HasInteractorDependency,
                                       InteractorErrorHandlable {

    weak var router: IDPasswordLoginRouting?
    
    weak var listener: IDPasswordLoginListener?
    
    let dependency: IDPasswordLoginInteractorDependency
    
    init(dependency: IDPasswordLoginInteractorDependency, presenter: IDPasswordLoginPresentable) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
		errorStream
            .filterDefault { error in
                // TODO: 알럿 처리
            }
            .send()
			.disposeOnDeactivate(interactor: self)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func login(id: String, password: String) {
        dependency.idPasswordLoginUseCase
            .execute(input: .init(uuid: dependency.uuid, id: id, password: password))
            .take(1)
            .filter(type: IDPasswordLoginErrorCase.self) { error in
                switch error.errorCase {
                case .WrongIDError:
                    break
                case .WrongPasswordError:
                    break
                }
            }
            .catchAndThrow(to: self)
            .subscribe(onNext: { [weak self] loginOutput in
                self?.listener?.didFinishIDPasswordLogin(with: loginOutput.customer)
            })
            .disposeOnDeactivate(interactor: self)
    }
}
