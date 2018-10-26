//
//  PreviousWeatherSearchVC.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import UIKit
import MapKit
class PreviousWeatherSearchVC: UIViewController {

    var cachedObjects = CacheManager.shared.object{
        didSet{
            collectionView.reloadData()
        }
    }
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    override func viewDidLoad() {
        setupViews()
        setupCollectionView()
    }
    
    private func setupViews(){
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.register(PreviousSearchWeatherDataCell.self, forCellWithReuseIdentifier: "PreviousSearchWeatherDataCell")
        
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        
        collectionView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.cachedObjects = CacheManager.shared.object
    }

}

extension PreviousWeatherSearchVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviousSearchWeatherDataCell", for: indexPath) as! PreviousSearchWeatherDataCell
        cell.delegate = self
        cell.model = self.cachedObjects[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cachedObjects.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //Cell Size
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

extension PreviousWeatherSearchVC:PreviousWeatherSearchVCDelegate{
    func openDetailsFor(model: WeatherDataResponseModel) {
        let vc = WeatherDetailVC()
        vc.model = model
        self.present(vc, animated: true, completion: nil)
    }
}
