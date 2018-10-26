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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews(){
        self.view.backgroundColor = .green
        
        self.view.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(checkIfiPhoneXOrNot() ? 88 : 64)
        }
    }
    
    
}

extension MainVC:CustomNavBarDelegate{
    func didSegmentChanged(index:Int){
        print(index)
    }
}
