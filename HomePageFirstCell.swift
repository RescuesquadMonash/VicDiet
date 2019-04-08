//
//  HomePageFirstCell.swift
//  VicDiet
//
//  Created by Ming Yang on 3/4/19.
//  Copyright © 2019 Ming Yang. All rights reserved.
//

import UIKit



class HomePageFirstCell: UICollectionViewCell,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    let cellId = "cellId"
    let cellIdTwo = "cellIdTwo"
    
    lazy var collectionViewNestedFirst: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.isPagingEnabled = true
        
        cv.dataSource = self
        cv.delegate = self
        
        
        return cv
        
    }()
    
    
    let everyDayDashboardFirstTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "System Note Here:", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        textView.backgroundColor = UIColor.white
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    
    
    let everyDayDashboardTitileTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Intake Dashborad", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        textView.backgroundColor = UIColor.white
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        collectionViewNestedFirst.register(GraphicContentCell.self, forCellWithReuseIdentifier: cellId)
        collectionViewNestedFirst.register(GraphicContentContinueCell.self, forCellWithReuseIdentifier: cellIdTwo)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(indexPath.item == 0){
            let cell = collectionViewNestedFirst.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GraphicContentCell
            return cell
        }
        if(indexPath.item == 1){
            let cell = collectionViewNestedFirst.dequeueReusableCell(withReuseIdentifier: cellIdTwo, for: indexPath) as! GraphicContentContinueCell
            return cell
        }
        let cell = collectionViewNestedFirst.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GraphicContentCell
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: self.collectionViewNestedFirst.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    func setupLayout(){
        
        //backgroundColor = UIColor.blue
        
        
        addSubview(everyDayDashboardTitileTextView)
        addSubview(collectionViewNestedFirst)
        addSubview(everyDayDashboardFirstTextView)

        everyDayDashboardTitileTextView.translatesAutoresizingMaskIntoConstraints = false
        everyDayDashboardTitileTextView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        everyDayDashboardTitileTextView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        everyDayDashboardTitileTextView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        everyDayDashboardTitileTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        collectionViewNestedFirst.translatesAutoresizingMaskIntoConstraints = false
        collectionViewNestedFirst.topAnchor.constraint(equalTo: everyDayDashboardTitileTextView.bottomAnchor, constant: 10).isActive = true
        collectionViewNestedFirst.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionViewNestedFirst.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionViewNestedFirst.heightAnchor.constraint(equalToConstant: 150).isActive = true

        everyDayDashboardFirstTextView.translatesAutoresizingMaskIntoConstraints = false
        everyDayDashboardFirstTextView.topAnchor.constraint(equalTo: collectionViewNestedFirst.bottomAnchor, constant: 50).isActive = true
        everyDayDashboardFirstTextView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        everyDayDashboardFirstTextView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        everyDayDashboardFirstTextView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        
        
    }
    
    
    
}

