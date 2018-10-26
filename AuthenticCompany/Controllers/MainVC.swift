//
//  MainVC.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    lazy var navBar:CustomNavBarWithSegmentedControl = {
        var v = CustomNavBarWithSegmentedControl()
        v.delegate = self
        return v
    }()
    
    lazy var containerView:UIView = {
        var v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    fileprivate var currentSelectedIndex:Int = 0{
        didSet{
            instantiateVCWithIdentifier(identifier: getViewNameForCurrentIndex())
        }
    }
    
    var mapVC:UINavigationController?
    var previousWeatherSearchVC:UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews(){
        self.view.backgroundColor = .green
        
        self.view.addSubview(navBar)
        self.view.addSubview(containerView)

        
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(checkIfiPhoneXOrNot() ? 88 : 64)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.left.right.bottom.equalTo(0)
        }
        
        self.currentSelectedIndex = 0
        
        
    }
    
    func instantiateVCWithIdentifier(identifier:String){
        
        var V1:UIViewController?
        
        switch identifier {
        case "MapVC":
            if mapVC == nil{
                let vc = MapVC()
                let nvc = UINavigationController(rootViewController: vc)
                nvc.isNavigationBarHidden = true
                self.mapVC = nvc
                V1 = nvc
            }else{
                V1 = mapVC!
            }
        case "PreviousWeatherSearchVC":
            if previousWeatherSearchVC == nil{
                let vc = PreviousWeatherSearchVC()
                let nvc = UINavigationController(rootViewController: vc)
                nvc.isNavigationBarHidden = true
                self.previousWeatherSearchVC = nvc
                V1 = nvc
            }else{
                V1 = previousWeatherSearchVC!
            }
        default:
            break
        }
        
        for v in containerView.subviews{
            v.removeFromSuperview()
        }
        
        //Add initialized view to main view and its scroll view also set bounds
        self.addChildViewController(V1!)
        self.containerView.addSubview(V1!.view)
        V1!.didMove(toParentViewController: self)
        
        V1!.view.frame = containerView.bounds
        //Create frame for the view and define its urigin point with respect to View 1
        
        var V1Frame: CGRect = V1!.view.frame
        V1Frame.origin.x = 0
        V1!.view.frame = V1Frame
    }
    
    func getViewNameForCurrentIndex() -> String{
        switch self.currentSelectedIndex {
        case 0: return "MapVC"
        case 1: return "PreviousWeatherSearchVC"
        default: return ""
        }
    }
    
    
}

extension MainVC:CustomNavBarDelegate{
    func didSegmentChanged(index:Int){
        self.currentSelectedIndex = index
    }
}
