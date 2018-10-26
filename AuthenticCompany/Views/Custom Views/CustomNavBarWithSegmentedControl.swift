//
//  CustomNavBar.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import UIKit
import SnapKit
class CustomNavBarWithSegmentedControl: UIView {
    
    lazy var containerView:UIView = {
        var v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    lazy var segmentedControl:UISegmentedControl = {
        var segments = ["Map", "Previous"]
        var s = UISegmentedControl(items: segments)
        s.selectedSegmentIndex = 0
        s.addTarget(self, action: #selector(segmentedControlChanged(segmentedControl:)), for: .valueChanged)
        return s
    }()
    
    lazy var seperatorView:UIView = {
        var v = UIView()
        v.backgroundColor = getColor(235, 235, 235)
        return v
    }()
    
    var delegate:CustomNavBarDelegate?
    
    override func didMoveToWindow() {
        self.addSubview(containerView)
        self.containerView.addSubview(segmentedControl)
        self.containerView.addSubview(seperatorView)
        
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
        
        segmentedControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(containerView)
            make.bottom.equalTo(-8)
        }
        
        seperatorView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(1)
        }
    }
    
    @objc private func segmentedControlChanged(segmentedControl:UISegmentedControl){
        if delegate != nil{
            self.delegate!.didSegmentChanged(index:segmentedControl.selectedSegmentIndex)
        }
    }
    
}
