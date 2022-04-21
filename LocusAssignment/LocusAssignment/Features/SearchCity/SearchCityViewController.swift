//
//  SearchCityViewController.swift
//  LocusAssignment
//
//  Created by Ajeet Sharma on 21/04/22.
//

import UIKit

class SearchCityViewController: UIViewController {
    
    //MARK:- UIController object
    @IBOutlet weak var lookupButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!

    var viewModel:SearchCityViewModel = SearchCityViewModel()
    

    
    //MARK:- UIViewcontroller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lookupButton.layer.cornerRadius = 5.0
        self.lookupButton.layer.borderWidth = 1.0
        self.lookupButton.layer.borderColor = UIColor.white.cgColor
        
    }
    
    //MARK:- UIButton action methods
    @IBAction func lookupButtonAction(_ sender: Any) {
       
        let validationResult = self.validationsCheck()
        
        if !validationResult.0{
            self.showAlertWithMessage(message: validationResult.1)
        }
        else{
            //Call api --
            self.viewModel.model.cityName = self.cityTextField.text
            self.viewModel.callGeoCodingUsingCityName {
                
                if let response:GeoCodingResponse = self.viewModel.model.response{
                    if response.count == 0{
                        DispatchQueue.main.async {
                            self.showAlertWithMessage(message: "Please enter valid city name")
                        }
                        
                    }
                }
            } errorHandler: { (error) in
                self.showAlertWithMessage(message: error.localizedDescription)
            }

        }
        
    }
    
}

extension SearchCityViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}

extension SearchCityViewController{
    
    func validationsCheck()->(Bool,String){
        if self.cityTextField.text?.trimmingCharacters(in: .whitespaces).count == 0{
         return (false, "Please Enter City")
        }
        else{
            return (true, "")
        }
    }
    
}
