//
//  MeCell.swift
//  VicDiet
//
//  Created by Ming Yang on 5/4/19.
//  Copyright © 2019 Ming Yang. All rights reserved.
//

import UIKit

class MeCell: UICollectionViewCell,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionViewNestedFirst: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.lightGray
        
        cv.dataSource = self
        cv.delegate = self
        
        
        return cv
        
    }()
    
    let cellId = "cellId"
    
//    lazy var tableView: UITableView = {
//        let tv = UITableView()
//        tv.dataSource = self
//        tv.delegate = self
//        return tv
//        
//    }()
    
    
    
    func setupViews(){
        
        addSubview(collectionViewNestedFirst)
        
        collectionViewNestedFirst.translatesAutoresizingMaskIntoConstraints = false
        collectionViewNestedFirst.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        collectionViewNestedFirst.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        collectionViewNestedFirst.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        collectionViewNestedFirst.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        collectionViewNestedFirst.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionViewNestedFirst.register(MeFirstCell.self, forCellWithReuseIdentifier: "phyCellId")
        
        collectionViewNestedFirst.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if(indexPath.item == 0){
            let cell = collectionViewNestedFirst.dequeueReusableCell(withReuseIdentifier: "phyCellId", for: indexPath)
            cell.backgroundColor = .white
            return cell
            
            
            
        }else{
            let cell = collectionViewNestedFirst.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .yellow
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(indexPath.item == 0){
            return CGSize(width: frame.width, height: (frame.height))
        }
        return CGSize(width: frame.width, height: (frame.height - 40)*2/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
