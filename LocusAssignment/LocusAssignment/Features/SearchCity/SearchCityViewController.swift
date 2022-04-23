//
//  SearchCityViewController.swift
//  LocusAssignment
//
//  Created by Ajeet Sharma on 21/04/22.
//

import UIKit
import Network

class SearchCityViewController: MasterViewController {
    
    //MARK:- UIController object
    @IBOutlet weak var lookupButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    var viewModel:SearchCityViewModel = SearchCityViewModel()
    let monitor = NWPathMonitor()
    
    //MARK:- UIViewcontroller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lookupButtonUIChanges()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.cityTextField.text = ""
    }
    //MARK:- UI Changes --
    func lookupButtonUIChanges(){
        self.lookupButton.layer.cornerRadius = 5.0
        self.lookupButton.layer.borderWidth = 1.0
        self.lookupButton.layer.borderColor = UIColor.white.cgColor
    }
    
    //MARK:- Navigation
    func showWeatherListScreen(){
        self.loadingView.stopAnimating()
        guard let responseObj = self.viewModel.model.response?[0] else{return}
        let vc:WeatherListViewController = self.storyboard?.instantiateViewController(identifier: "WeatherListViewController") as! WeatherListViewController
        
        guard let lat = responseObj.lat, let long = responseObj.lon else{
            return
        }
        
        vc.viewModel.model.lat = lat
        vc.viewModel.model.lon = long
        
        if let cityName:String = responseObj.name{
            vc.viewModel.model.cityNameStr = cityName
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
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
            self.loadingView.startAnimating()
            self.viewModel.callGeoCodingUsingCityName {
                DispatchQueue.main.async {
                    self.loadingView.stopAnimating()
                }
                if let response:GeoCodingResponse = self.viewModel.model.response{
                    if response.count == 0{
                        DispatchQueue.main.async {
                            self.showAlertWithMessage(message: "Please enter valid city name")
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            self.showWeatherListScreen()
                        }
                    }
                }
            } errorHandler: { (error) in
                DispatchQueue.main.async {
                    self.loadingView.stopAnimating()
                }
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
