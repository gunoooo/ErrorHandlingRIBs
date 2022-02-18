//
//  Dependency+.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/18.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs

protocol Dependency: RIBs.Dependency,
                     HasErrorStream {}

extension Component: Dependency {}
