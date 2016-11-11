//
//  AccountViewController.swift
//  TechHeroes
//
//  Created by Kyle Yoon on 11/10/16.
//  Copyright © 2016 Kyle Yoon. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account"
        
        LISDKSessionManager.createSession(withAuth: [LISDK_BASIC_PROFILE_PERMISSION],
                                          state: "some state",
                                          showGoToAppStoreDialog: false,
                                          successBlock: { success in
                                            print("SUCCESS")
            },
                                          errorBlock: { error in
                                            print("FAILURE")
        })
    }
    
}
