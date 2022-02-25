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

extension RootInteractorDependency {
    var errorStream: HandleableErrorStream {
        fatalError("")
    }
}

final class RootInteractor: PresentableInteractor<RootPresentable>, 
                            RootInteractable,
                            RootPresentableListener,
                            HasInteractorDependency,
                            HasInteractableErrorStream,
                            ErrorHandleable {

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
        
//        let errorStream = errorStream
//            .default { error in
//                // TODO: 알럿처리
//            }
//
//        errorStream
//            .mapTo(type: RootErrorCase.Messaging.self)
//            .handle { [weak self] caseableErrorContent in
//                switch caseableErrorContent.errorCase {
//                    case .SecureError:
//                        // TODO: 알럿처리
//                        self?.listener?.exitApp()
//                }
//            }
//            .disposeOnDeactivate(interactor: self)
//
//        errorStream
//            .mapTo(type: RootErrorCase.Messaging.self)
//            .handle { [weak self] caseableErrorContent in
//                switch caseableErrorContent.errorCase {
//                    case .SecureError:
//                        // TODO: 알럿처리
//                        self?.listener?.exitApp()
//                }
//            }
//            .disposeOnDeactivate(interactor: self)
        
        errorStream
            .default { error in
                // TODO: 알럿처리
            }
            .handle(type: RootErrorCase.Messaging.self) { [weak self] error in
                switch error.errorCase {
                    case .SecureError:
                        // TODO: 알럿처리
                        self?.listener?.exitApp()
                }
            }
//            .handle(type: RootErrorCase.DetailMessaging.self) { error in
//                switch error.errorCase {
//                    case .ConnectionError:
//                        break
//                }
//            }
            .subscribe(onNext: { _ in
                print("123")
            }, onError: { _ in
                print("123")
            }, onCompleted: {
                print("123")
            }, onDisposed: {
                print("123")
            })
            .disposeOnDeactivate(interactor: self)
        
//        dependency.errorStream.onNext(
//            HandleableError(ConnectionError(message: "연결오류", detailMessage: ""), handler: self)
//        )
        
        dependency.parentErrorStream.onNext(HandleableError(ConnectionError(message: "연결오류", detailMessage: ""), handler: self))
    }
}
