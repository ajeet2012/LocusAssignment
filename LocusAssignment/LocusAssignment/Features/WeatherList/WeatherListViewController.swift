//
//  WeatherListViewController.swift
//  LocusAssignment
//
//  Created by Ajeet Sharma on 21/04/22.
//

import UIKit

class WeatherListTableViewCell:UITableViewCell{
    @IBOutlet weak var weatherLabel:UILabel!
    @IBOutlet weak var tempratureLabel:UILabel!
}

class WeatherListViewController: MasterViewController {

    var viewModel:WeatherListViewModel = WeatherListViewModel()
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var tableViewWeather: UITableView!
    
    //MARK:- UIViewcontroller lifecycle methods --
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let cityName:String = self.viewModel.model.cityNameStr{
            self.headerLabel.text = cityName
        }
        else{
            self.headerLabel.text = "-"
        }
        self.callWeatherApi()
        
    }
    //MARK:- UIButton action methods ---
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- API call
    func callWeatherApi(){
        self.loadingView.startAnimating()
        self.viewModel.apiCallToFetchWeatherReport {
            
            DispatchQueue.main.async {
                self.loadingView.stopAnimating()
            }
            if let response:CurrentWheatherDataResponse = self.viewModel.model.response{
                
                if let statusCode = response.cod{
                    if statusCode != 200 {
                        
                        if let message = response.message{
                            self.showAlertWithMessage(message: message)
                        }
                        else{
                            self.showAlertWithMessage(message: "Something went wrong")
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            self.tableViewWeather.reloadData()
                        }
                    }
                }
                
            }
                //if let statusCode = response.
            
        } errorHandler: { (error) in
            DispatchQueue.main.async {
                self.loadingView.stopAnimating()
            }
            self.showAlertWithMessage(message: error.localizedDescription)

        }

        
    }
    //MARK:- Navigation
    func showDetailScreen(){
        guard let responseObj = self.viewModel.model.response else{return}
        let vc:WeatherDetailViewController = self.storyboard?.instantiateViewController(identifier: "WeatherDetailViewController") as! WeatherDetailViewController      
        vc.response = responseObj
        if let cityName:String = responseObj.name{
            vc.cityNameString = cityName
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WeatherListViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        guard let weatherObj = self.viewModel.model.response?.weather else{
            return 0
        }
        return weatherObj.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:WeatherListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WeatherListTableViewCell")
        as! WeatherListTableViewCell
        
         
        if let weatherObjMain:String = self.viewModel.model.response?.weather?[indexPath.row].main{
            
            cell.weatherLabel.text = weatherObjMain
        }
        
        if let tempreture = self.viewModel.model.response?.main?.temp{
         
            let temprecture:Double = tempreture - 273.15
            cell.tempratureLabel.text = String(format: "%.2f?? C",temprecture)
                
        }

        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.showDetailScreen()
    }
}
