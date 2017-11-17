//
//  ViewController.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/14/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn

class Login: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().clientID = "1043267957905-kg07i2eguhhaleo2vkec60gr59pb5gts.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookLogin(sender: UIButton) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                //Saving users account to Firebase
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email , gender"]).start(completionHandler: { (connection, result, error) in
                    var userInfo: [String : Any] = [:]
                    if let name = (result as? [String : Any])?["name"] as? String {
                        userInfo["name"] = name
                    }
                    if let email = (result as? [String : Any])?["email"] as? String {
                        userInfo["email"] = email
                    }
                    if let profilePic = (((result as? [String : Any])?["picture"] as? [String : Any])?["data"] as? [String : Any])?["url"] as? String {
                        userInfo["profilePicture"] = profilePic
                    }
                    Database.database().reference().child("users").child(user!.uid).setValue(userInfo)
                })
                
                
                // Present the main view
                self.switchNavigation()
            })
            
        }
    }
    
    @IBAction func googleBTM(sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil{
            print(error!.localizedDescription)
            return
        }
        print(user.authentication)
        logInWithGoogle(authentication: user.authentication)
    }
    
    func logInWithGoogle(authentication: GIDAuthentication){
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }else{
                Database.database().reference().child("users").child(user!.uid).setValue(["name" : user!.displayName!, "email" : user!.email!])
                self.switchNavigation()
            }
        }
    }
    
    //Go to the next storyboard
    private func switchNavigation(){
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
            UIApplication.shared.keyWindow?.rootViewController = viewController
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}



