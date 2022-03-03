//
//  RootInteractor.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/19.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

protocol RootListener: AnyObject {
    func exitApp()
}

protocol RootInteractorDependency: ErrorHandleableInteractorDependency {}

final class RootInteractor: PresentableInteractor<RootPresentable>, 
                            RootInteractable,
                            RootPresentableListener,
                            HasInteractorDependency,
                            ErrorInteractable {

    weak var router: RootRouting?
    
    weak var listener: RootListener?
    
    let dependency: RootInteractorDependency
    
    init(dependency: RootInteractorDependency, presenter: RootPresentable) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        errorStream
            .filter(type: RootErrorCase.Messaging.self) { [weak self] error in
                switch error.errorCase {
                    case .SecureError:
                        // TODO: 알럿처리
                        self?.listener?.exitApp()
                }
            }
            .filter(type: RootErrorCase.DetailMessaging.self) { error in
                switch error.errorCase {
                    case .ConnectionError:
                        break
                }
            }
            .filterDefault { error in
                // TODO: 알럿처리
            }
            .send()
            .disposeOnDeactivate(interactor: self)
    }
}
