//
//  PreviousSearchWeatherDataCell.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import UIKit

class PreviousSearchWeatherDataCell: UICollectionViewCell {
    
    lazy var containerView:UIView = {
        var v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    lazy var titleLabel:UILabel = {
        var l = UILabel()
        return l
    }()
    
    lazy var weatherLabel:UILabel = {
        var l = UILabel()
        return l
    }()
    
    lazy var selectedImageView:UIImageView = {
        var v = UIImageView()
        v.image = #imageLiteral(resourceName: "Filled")
        v.isHidden = true
        return v
    }()
    
    lazy var seperatorView:UIView = {
        var v = UIView()
        v.backgroundColor = getColor(50,54, 67)
        return v
    }()
 
    var model:WeatherCacheModel?{
        didSet{
            loadDetails()
        }
    }
    var delegate:PreviousWeatherSearchVCDelegate?
    
    override func didMoveToWindow() {
        
        self.addSubview(containerView)
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(weatherLabel)
        self.addSubview(seperatorView)
        
        
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(weatherLabel.snp.left).offset(-20)
            make.centerY.equalTo(self)
        }
        
        weatherLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(-20)
        }
        
        seperatorView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(1)
        }
        
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGetureRecognizer))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapGetureRecognizer(){
        if delegate != nil{
            self.delegate!.openDetailsFor(model: self.model!.covertToWeatherDataResponseModel())
        }
    }
    
    func loadDetails(){
        if model != nil{
            titleLabel.text = model!.locationRegion + " " + model!.locationName + " ," + model!.locationCountry
            weatherLabel.text = "\(model!.feelsLikeC) °C"
        }
    }
}
