//
//  LoginViewController.swift
//  JSQMessage
//
//  Created by Luís Fernando Zaltron on 02/04/16.
//  Copyright © 2016 Luís Fernando Zaltron. All rights reserved.
//

import UIKit

import Firebase

class LoginViewController: UIViewController {

    var ref: Firebase!
    
    @IBAction func loginButton(sender: AnyObject) {
        logar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Firebase(url: "https://jsqmessage.firebaseio.com/")
        // Do any additional setup after loading the view.
    }

    func logar() {
        ref.authAnonymouslyWithCompletionBlock({ (error, authData) in
            if error != nil {
                print (error.description)
                return
            }
            self.performSegueWithIdentifier("LoginToChat", sender: nil)
        })
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepareForSegue(segue, sender: sender)

        let navVc = segue.destinationViewController as! UINavigationController
        let chatVc = navVc.viewControllers.first as! ChatViewController
        chatVc.senderId = ref.authData.uid
        chatVc.senderDisplayName = ""
    }

}
