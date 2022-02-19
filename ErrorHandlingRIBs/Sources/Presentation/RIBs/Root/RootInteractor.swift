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

protocol RootInteractorDependency: ErrorHandlingInteractorDependency {}

final class RootInteractor: PresentableInteractor<RootPresentable>, 
                            RootInteractable,
                            RootPresentableListener,
                            HasInteractorDependency,
                            HasInteractorErrorStream {

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
        
        errorStream.mapTo(type: RootErrorCase.self)
            .subscribe(onNext: { [weak self] errorContent, errorCase in
                switch errorCase {
                    case .SecureError:
                        // TODO: 알럿처리
                        self?.listener?.exitApp()
                }
            })
            .disposeOnDeactivate(interactor: self)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
