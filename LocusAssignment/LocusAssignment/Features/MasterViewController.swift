//
//  MasterViewController.swift
//  LocusAssignment
//
//  Created by Ajeet Sharma on 23/04/22.
//

import UIKit
import NVActivityIndicatorView

class MasterViewController: UIViewController {
    var loadingView:NVActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLoadingView()
    }
    //MARK:- Add loading view ---
    func addLoadingView(){
        loadingView = NVActivityIndicatorView(frame: CGRect(x: Constants.screenWidth - 80, y: Constants.screenHeight - 80, width: 80, height: 80), type: .lineSpinFadeLoader, color: .white, padding: 20)
        self.view.addSubview(loadingView)
        self.loadingView.center = self.view.center
        self.loadingView.backgroundColor = .black
        self.loadingView.alpha = 0.5
        self.loadingView.layer.borderWidth = 1.0
        self.loadingView.layer.borderColor = UIColor.lightGray.cgColor
        self.loadingView.layer.cornerRadius = 10.0
        self.loadingView.layer.masksToBounds =  true
    }
}
