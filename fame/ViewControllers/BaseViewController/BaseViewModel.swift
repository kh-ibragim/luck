//
//  BaseViewModel.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import ReactiveKit
import Bond

class BaseViewModel: NSObject {
    let showHUD = PublishSubject<Bool, NoError>()
    let showBlurHUD = PublishSubject<Bool, NoError>()
    let errorMessages = PublishSubject<Error, NoError>()
    
    // error handler
    func sendErrorWithMessage(message: String) {
        
    }
    
}
