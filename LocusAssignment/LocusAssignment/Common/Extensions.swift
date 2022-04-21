//
//  Extensions.swift
//  LocusAssignment
//
//  Created by Ajeet Sharma on 21/04/22.
//

import Foundation
import UIKit
extension UIViewController{
    
    func showAlertWithMessage(message:String){
        
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
