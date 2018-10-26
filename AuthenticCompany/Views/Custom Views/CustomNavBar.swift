//
//  CustomNavBar.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import Foundation
import UIKit

class CustomNavBar: UIView {
    
    lazy var containerView:UIView = {
        var i = UIView()
        i.backgroundColor = .white
        return i
    }()
    
    lazy var leftBarButton:UIButton = {
        var u = UIButton()
        u.setImage(#imageLiteral(resourceName: "back-ic"), for: .normal)
        u.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 0)
        return u
    }()
    
    lazy var titleLabel:UILabel = {
        var a = UILabel()
        a.adjustsFontSizeToFitWidth = true
        a.numberOfLines = 1
        a.font = UIFont(name: "NunitoSans-Regular", size: 18)
        return a
    }()
    
    lazy var seperatorView:UIView = {
        var v = UIView()
        v.backgroundColor = getColor(235, 235, 235)
        return v
    }()
    
    
    override func didMoveToWindow() {
        
        self.addSubview(containerView)
        containerView.addSubview(leftBarButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(seperatorView)
        
        
        containerView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        leftBarButton.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.height.equalTo(40)
            make.bottom.equalTo(0)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(containerView)
            make.bottom.equalTo(-10)
        }
        
        seperatorView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        
    }
    
}
