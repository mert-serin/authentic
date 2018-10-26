//
//  WeatherDetailVC.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import UIKit
import Nuke
class WeatherDetailVC: UIViewController {
    
    lazy var navBar:CustomNavBar = {
        var v = CustomNavBar()
        v.leftBarButton.addTarget(self, action: #selector(leftBarButtonAction), for: .touchUpInside)
        return v
    }()
    
    lazy var weatherImageView:UIImageView = {
        var i = UIImageView()
        return i
    }()
    
    lazy var weatherTypeLabel:UILabel = {
        var l = UILabel()
        l.textAlignment = .center
        return l
    }()
    
    lazy var weatherLocationLabel:UILabel = {
        var l = UILabel()
        l.textColor = .black
        return l
    }()
    
    lazy var weatherLabel:UILabel = {
        var l = UILabel()
        l.textColor = .black
        return l
    }()
    
    var model:WeatherDataResponseModel?{
        didSet{
            loadDetails()
        }
    }

    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews(){
        self.view.addSubview(navBar)
        self.view.addSubview(weatherImageView)
        self.view.addSubview(weatherTypeLabel)
        self.view.addSubview(weatherLocationLabel)
        self.view.addSubview(weatherLabel)
        
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(checkIfiPhoneXOrNot() ? 88 : 64)
        }
        
        weatherImageView.snp.makeConstraints { (make) in
            make.top.equalTo(40 + (checkIfiPhoneXOrNot() ? 88 : 64))
            make.centerX.equalTo(self.view)
            make.width.height.equalTo(50)
        }
        
        weatherTypeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weatherImageView.snp.bottom).offset(20)
            make.centerX.equalTo(weatherImageView)
        }
        
        weatherLocationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weatherTypeLabel.snp.bottom).offset(30)
            make.left.equalTo(40)
        }
        
        weatherLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(weatherLocationLabel)
            make.right.equalTo(-40)
        }
        self.view.backgroundColor = .white
    }
    
    @objc private func leftBarButtonAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func loadDetails(){
        if model != nil{
            var temp = "https://\(model!.current.condition.icon.dropFirst(2))"
            
            Nuke.loadImage(with: URL(string:temp)!, into: weatherImageView)
            weatherTypeLabel.text = model!.current.condition.text
            
            weatherLocationLabel.text = model!.location.region + " " + model!.location.name + " ," + model!.location.country
            weatherLabel.text = "\(model!.current.feelsLikeC) °C"
        }
    }

}
