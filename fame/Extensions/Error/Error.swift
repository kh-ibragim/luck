//
//  Error.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Foundation

extension NSError {
    func errorWithDescriprionAndErrorCode(errorCode: Int, description: String) -> NSError {
        let userInfo: [AnyHashable : Any] = [NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: description, comment: "")]
        let error = NSError(domain: "ShiploopHttpResponseErrorDomain", code: errorCode, userInfo: userInfo as? [String : Any])
        return error
    }
}
