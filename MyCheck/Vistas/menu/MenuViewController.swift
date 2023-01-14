//
//  MenuViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 11/10/22.
//

import UIKit
import GoogleSignIn

class MenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var tabkeMenu: UITableView!
    let options = ["Profile","Contratar","Salir"]
    let segues = ["profile","pago","logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.profilePicture.contentMode = UIView.ContentMode.scaleAspectFill
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.height / 2
        self.profilePicture.layer.masksToBounds = false
        self.profilePicture.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        
        cell.menuTitle.text = options[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(segues[indexPath.row] == "logout"){
            GIDSignIn.sharedInstance.signOut()
        }
        performSegue(withIdentifier: segues[indexPath.row], sender: nil)
    }
    
}
