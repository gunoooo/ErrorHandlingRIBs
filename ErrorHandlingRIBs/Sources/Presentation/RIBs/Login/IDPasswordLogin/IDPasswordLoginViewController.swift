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

protocol IDPasswordLoginPresentableListener: AnyObject {
    func login(id: String, password: String)
}

final class IDPasswordLoginViewController: UIViewController,
                                           IDPasswordLoginPresentable,
                                           IDPasswordLoginViewControllable {

    weak var listener: IDPasswordLoginPresentableListener?
}
