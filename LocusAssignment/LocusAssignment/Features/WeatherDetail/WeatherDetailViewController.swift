//
//  WeatherDetailViewController.swift
//  LocusAssignment
//
//  Created by Ajeet Sharma on 21/04/22.
//

import UIKit

class WeatherDetailViewController: MasterViewController {
    var cityNameString:String?
    var response:CurrentWheatherDataResponse?
    //MARK:- UI Object declarations
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tempreatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    //MARK:- UIViewcontroller lifecycle methods ---
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showDataOnUI()
    }
    //MARK:- Show data on UI ---
    func showDataOnUI(){
        if let cityName = self.cityNameString{
            self.headerLabel.text = cityName
        }
        if let tempr = self.response?.main?.temp{
            let temprecture:Double = tempr - 273.15
            self.tempreatureLabel.text = String(format: "%.2f° C",temprecture)
        }
        if let feelLike = self.response?.main?.feelsLike{
            let temprecture:Double = feelLike - 273.15
            self.feelsLikeLabel.text = String(format: "%.2f° C",temprecture)
        }
        if let weatherMain = self.response?.weather?[0].main{
            self.mainLabel.text = weatherMain.capitalized
        }
        if let description = self.response?.weather?[0].weatherDescription{
            self.descriptionLabel.text = description.capitalized
        }
    }
    //MARK:- UIButton action methods ---
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
