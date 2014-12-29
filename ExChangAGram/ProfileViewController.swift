//
//  ProfileViewController.swift
//  ExChangAGram
//
//  Created by BenLacroix on 28/12/2014.
//  Copyright (c) 2014 Benobab. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, FBLoginViewDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fbLoginView: FBLoginView!
     

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Ici on set le delegate du facebook login view et on prévient qu'on veut acceder aux infos publiques, et qu'on pourra poster sur le mur les photos par exemple
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile","publish_actions"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     
     
     @IBAction func showMapButtonPressed(sender: UIButton) {
      performSegueWithIdentifier("showMapVC", sender: nil)
     }
     
     
     //Facebook Func
    
    func loginView(loginView: FBLoginView!, handleError error: NSError!) {
        println("Error: \(error.localizedDescription)")
        
    }
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        //ici on récupère les infos du profile FB une fois connecté
        nameLabel.text =  user.name
        //récupération de la photo de profil actuel
        let userImageUrl = "https://graph.facebook.com/\(user.objectID)/picture?type=large&square"
        let url = NSURL(string: userImageUrl)
        let imageData = NSData(contentsOfURL: url!)
        self.profileImageView.image = UIImage(data: imageData!)
    }
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        self.profileImageView.hidden = false
        self.nameLabel.hidden = false
        
    }
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        self.profileImageView.hidden = true
        self.nameLabel.hidden = true
    }
    

}
