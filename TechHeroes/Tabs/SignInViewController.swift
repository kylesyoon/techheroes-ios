//
//  SignInViewController.swift
//  TechHeroes
//
//  Created by Kyle Yoon on 11/13/16.
//  Copyright © 2016 Kyle Yoon. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBAction func didTapSignInWithLinkedIn(_ sender: Any) {
        LISDKSessionManager.createSession(withAuth: [LISDK_BASIC_PROFILE_PERMISSION, LISDK_EMAILADDRESS_PERMISSION],
                                          state: "some state",
                                          showGoToAppStoreDialog: true,
                                          successBlock: { returnState in
                                            // What to do with return state?
                                            let accessToken = LISDKSessionManager.sharedInstance().session.accessToken
                                            // Persist values from access token securely for reauthentication
                                            self.fetchUserInfo()
                                            
        },
                                          errorBlock: { error in
                                            print("FAILED :(")
                                            if let error = error {
                                                print("\(error)")
                                            }
        })
    }
    
    func fetchUserInfo() {
        LISDKAPIHelper.sharedInstance().apiRequest("https://api.linkedin.com/v1/people/~?format=json", method: "GET", body: nil, success: {
            response in
            
        }, error: {
            error in
        })
    }
    
}
