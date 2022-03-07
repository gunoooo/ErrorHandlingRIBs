//
//  IDPasswordLoginBuilder.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/07.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs

protocol IDPasswordLoginDependency: Dependency {
    var uuid: String { get }
}

final class IDPasswordLoginComponent: Component<IDPasswordLoginDependency>,
                                      IDPasswordLoginInteractorDependency {
               
    override var handleableErrorSubject: HandleableErrorSubject {
        shared {
            .init()
        }
    }
    
    var uuid: String {
        dependency.uuid
    }
    
    var idPasswordLoginUseCase: IDPasswordLoginUseCase {
        shared {
            .init(loginRepository: LoginRepository())
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
        let viewController = IDPasswordLoginViewController()
		let interactor = IDPasswordLoginInteractor(dependency: component, presenter: viewController)
        interactor.listener = listener
        return IDPasswordLoginRouter(interactor: interactor, viewController: viewController)
    }
}
