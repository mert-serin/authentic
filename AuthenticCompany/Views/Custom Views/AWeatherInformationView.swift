//
//  AWeatherInformationView.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import UIKit

class AWeatherInformationView:UIView{
    
    lazy var containerView:UIView = {
        var v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        v.layer.masksToBounds = true
        return v
    }()
    
    lazy var weatherImageView:UIImageView = {
        var i = UIImageView()
        i.backgroundColor = .black
        return i
    }()
    
    lazy var weatherTypeLabel:UILabel = {
        var l = UILabel()
        l.textAlignment = .center
        return l
    }()
    
    lazy var weatherLocationLabel:UILabel = {
       var l = UILabel()
        return l
    }()
    
    lazy var weatherLabel:UILabel = {
        var l = UILabel()
        return l
    }()
    
    var model:WeatherDataResponseModel?{
        didSet{
            
        }
    }
    
    override func didMoveToWindow() {
        self.addSubview(containerView)
        self.containerView.addSubview(weatherImageView)
        self.containerView.addSubview(weatherTypeLabel)
        self.containerView.addSubview(weatherLocationLabel)
        self.containerView.addSubview(weatherLabel)
        
        containerView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        weatherImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(40)
            make.width.height.equalTo(50)
        }
        
        weatherTypeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weatherImageView.snp.bottom).offset(5)
            make.centerX.equalTo(weatherImageView)
            make.left.equalTo(0)
        }
        
        weatherLocationLabel.snp.makeConstraints { (make) in
            make.left.equalTo(weatherImageView.snp.right).offset(20)
            make.right.equalTo(weatherLabel.snp.left).offset(-20)
            make.top.equalTo(weatherLocationLabel)
        }
        
        weatherLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(containerView)
        }
    }
    
    
    private func loadDetails(){
        
    }
}
