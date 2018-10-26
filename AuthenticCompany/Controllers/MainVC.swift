//
//  MainVC.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    lazy var navBar:CustomNavBar = {
        var v = CustomNavBar()
        v.delegate = self
        return v
    }()
    
    lazy var mapContainerView:UIView = {
        var v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    lazy var previousWeatherContainerView:UIView = {
        var v = UIView()
        v.backgroundColor = .green
        return v
    }()
    
    fileprivate var currentSelectedIndex:Int = 0{
        didSet{
            changeContainerViewWithAnimation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews(){
        self.view.backgroundColor = .white
        
        self.view.addSubview(navBar)
        self.view.addSubview(mapContainerView)
        self.view.addSubview(previousWeatherContainerView)
        
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(checkIfiPhoneXOrNot() ? 88 : 64)
        }
        
        mapContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.left.right.bottom.equalTo(0)
        }
        
        previousWeatherContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.left.right.bottom.equalTo(0)
        }
        
        self.currentSelectedIndex = 0
    }
    
    private func changeContainerViewWithAnimation(){
        if self.currentSelectedIndex == 0{
            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                self.mapContainerView.alpha = 1
                self.previousWeatherContainerView.alpha = 0
            }, completion: nil)
        }else{
            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                self.mapContainerView.alpha = 0
                self.previousWeatherContainerView.alpha = 1
            }, completion: nil)
        }
    }
}

extension MainVC:CustomNavBarDelegate{
    func didSegmentChanged(index:Int){
        self.currentSelectedIndex = index
    }
}
