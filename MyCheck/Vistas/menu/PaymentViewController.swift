//
//  PaymentViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 21/11/22.
//

import UIKit
import MFCard

class PaymentViewController: UIViewController,MFCardDelegate {
    
    
    @IBOutlet var myCard: MFCardView!
    
    func cardTypeDidIdentify(_ cardType: String) {
        print(cardType)
    }
    
    func cardDidClose() {
        print("Card Close")
    }
    
    func cardDoneButtonClicked(_ card: Card?, error: String?) {
        if error == nil{
        print(card!)
        }else{
        print(error!)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCard  = MFCardView(withViewController: self)
        myCard.delegate = self
        myCard.autoDismiss = true
        myCard.toast = true
        //myCard.showCard()
    }

}
