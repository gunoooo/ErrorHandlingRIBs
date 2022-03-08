//
//  IDPasswordLoginBuilder.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/07.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs

protocol IDPasswordLoginDependency: Dependency {
    var deviceRepository: DeviceRepositoryProtocol { get }
}

final class IDPasswordLoginComponent: Component<IDPasswordLoginDependency>,
                                      IDPasswordLoginInteractorDependency {
               
    override var handleableErrorSubject: HandleableErrorSubject {
        shared {
            .init()
        }
    }
    
    var idPasswordLoginUseCase: IDPasswordLoginUseCase {
        shared {
            .init(
                loginRepository: LoginRepository(),
                deviceRepository: dependency.deviceRepository
            )
        }
    }
}

// MARK: - Builder

protocol IDPasswordLoginBuildable: Buildable {
    func build(withListener listener: IDPasswordLoginListener) -> IDPasswordLoginRouting
}

final class IDPasswordLoginBuilder: Builder<IDPasswordLoginDependency>, IDPasswordLoginBuildable {

    override init(dependency: IDPasswordLoginDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: IDPasswordLoginListener) -> IDPasswordLoginRouting {
        let component = IDPasswordLoginComponent(dependency: dependency)
        let presenter = IDPasswordLoginPresenter()
        let viewController = IDPasswordLoginViewController()
		let interactor = IDPasswordLoginInteractor(dependency: component, presenter: presenter)
        let router = IDPasswordLoginRouter(interactor: interactor, viewController: viewController)
        
        presenter.viewController = viewController
        viewController.interactor = interactor
        interactor.listener = listener
        interactor.router = router
        
        return router
    }
}
