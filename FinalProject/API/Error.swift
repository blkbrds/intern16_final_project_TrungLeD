//
//  Error.swift
//  FinalProject
//
//  Created by Hai Ca on 9/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension Error {

    public var code: Int {
        let `self` = self as NSError
        return self.code
    }
}
