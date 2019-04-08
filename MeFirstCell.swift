//
//  MeFirstCell.swift
//  VicDiet
//
//  Created by Ming Yang on 8/4/19.
//  Copyright © 2019 Ming Yang. All rights reserved.
//

import UIKit
import Firebase

class MeFirstCell: UICollectionViewCell{
    let ref = Database.database().reference().child("User")
    
    
    let ageTextView: UITextView = {
        let textView = UITextView()
        //textView.backgroundColor = .brown
        let physicalAttributedText = NSMutableAttributedString(string: "Age:", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
        textView.attributedText = physicalAttributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    let genderTextView: UITextView = {
        let textView = UITextView()
        //textView.backgroundColor = .brown
        let physicalAttributedText = NSMutableAttributedString(string: "Gender:", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
        
        textView.attributedText = physicalAttributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    let weightTextView: UITextView = {
        let textView = UITextView()
        //textView.backgroundColor = .brown
        let physicalAttributedText = NSMutableAttributedString(string: "Weight:", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
        textView.attributedText = physicalAttributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    let ageValueTextView: UITextView = {
        let textView = UITextView()
        //textView.backgroundColor = .green
        let physicalAttributedText = NSMutableAttributedString(string: PhysicalInfo.age, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
        textView.attributedText = physicalAttributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .right
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    let genderValueTextView: UITextView = {
        let textView = UITextView()
        //textView.backgroundColor = .green
        let physicalAttributedText = NSMutableAttributedString(string: PhysicalInfo.gender, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
        
        textView.attributedText = physicalAttributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .right
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    let weightValueTextView: UITextView = {
        let textView = UITextView()
        //textView.backgroundColor = .green
        let physicalAttributedText = NSMutableAttributedString(string: PhysicalInfo.weight, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
        textView.attributedText = physicalAttributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .right
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCellView()
        fetchUser()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchUser(){
        
        
        
        ref.observe(.childAdded, with: { (snapshot) -> Void in
            
            if let dictionary = snapshot.value as? [String:String]{
                
                if let dictionary = snapshot.value as? [String:AnyObject]{
                    let age = dictionary["Age"] as? String
                    let gender = dictionary["Gender"] as? String
                    let weight = dictionary["Weight"] as? String

                    let ageAttributedText = NSMutableAttributedString(string: age!, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
                    self.ageValueTextView.attributedText = ageAttributedText
                    let genderAttributedText = NSMutableAttributedString(string: gender!, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
                    self.genderValueTextView.attributedText = genderAttributedText
                    let weightAttributedText = NSMutableAttributedString(string: weight!, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
                    self.weightValueTextView.attributedText = weightAttributedText
                }
            }
            
        })
        
        ref.observe(.childChanged, with: { (snapshot) -> Void in
            
            if let dictionary = snapshot.value as? [String:String]{
                
                if let dictionary = snapshot.value as? [String:AnyObject]{
                    let age = dictionary["Age"] as? String
                    let gender = dictionary["Gender"] as? String
                    let weight = dictionary["Weight"] as? String
                    
                    
                    let ageAttributedText = NSMutableAttributedString(string: age!, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
                    self.ageValueTextView.attributedText = ageAttributedText
                    let genderAttributedText = NSMutableAttributedString(string: gender!, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
                    self.genderValueTextView.attributedText = genderAttributedText
                    let weightAttributedText = NSMutableAttributedString(string: weight!, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
                    self.weightValueTextView.attributedText = weightAttributedText
                }
            }
            
        })
        
        
    }

    deinit {
        ref.removeAllObservers()
    }
    
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage(named: "icon_userPhoto2"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
//
//        imageView.layer.borderWidth = 1
//        imageView.layer.masksToBounds = false
//        imageView.layer.borderColor = UIColor.black.cgColor
//        imageView.layer.cornerRadius = imageView.frame.height/2
//        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    func setupCellView(){
        
        
        
        
        addSubview(userImageView)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.topAnchor.constraint(equalTo: topAnchor, constant: -frame.height*0.12).isActive = true
        userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        userImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65).isActive = true
        userImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        
        
        
        
        addSubview(ageTextView)
        ageTextView.translatesAutoresizingMaskIntoConstraints = false
        ageTextView.topAnchor.constraint(equalTo: userImageView.bottomAnchor,constant: frame.height*0.01).isActive = true
        ageTextView.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor,constant: frame.width*0.15).isActive = true
        ageTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
        ageTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        addSubview(ageValueTextView)
        ageValueTextView.translatesAutoresizingMaskIntoConstraints = false
        ageValueTextView.topAnchor.constraint(equalTo: userImageView.bottomAnchor,constant: frame.height*0.01).isActive = true
        ageValueTextView.trailingAnchor.constraint(equalTo: userImageView.trailingAnchor,constant: -frame.width*0.15).isActive = true
        ageValueTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
        ageValueTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true

        
        addSubview(genderTextView)
        genderTextView.translatesAutoresizingMaskIntoConstraints = false
        genderTextView.topAnchor.constraint(equalTo: ageTextView.bottomAnchor,constant: frame.height*0.04).isActive = true
        genderTextView.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor,constant: frame.width*0.15).isActive = true
        genderTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
        genderTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        addSubview(genderValueTextView)
        genderValueTextView.translatesAutoresizingMaskIntoConstraints = false
        genderValueTextView.topAnchor.constraint(equalTo: ageValueTextView.bottomAnchor,constant: frame.height*0.04).isActive = true
        genderValueTextView.trailingAnchor.constraint(equalTo: userImageView.trailingAnchor,constant: -frame.width*0.15).isActive = true
        genderValueTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
        genderValueTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        
        
        addSubview(weightTextView)
        weightTextView.translatesAutoresizingMaskIntoConstraints = false
        weightTextView.topAnchor.constraint(equalTo: genderTextView.bottomAnchor,constant: frame.height*0.04).isActive = true
        weightTextView.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor,constant: frame.width*0.15).isActive = true
        weightTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
        weightTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        
        addSubview(weightValueTextView)
        weightValueTextView.translatesAutoresizingMaskIntoConstraints = false
        weightValueTextView.topAnchor.constraint(equalTo: genderValueTextView.bottomAnchor,constant: frame.height*0.04).isActive = true
        weightValueTextView.trailingAnchor.constraint(equalTo: userImageView.trailingAnchor,constant: -frame.width*0.15).isActive = true
        weightValueTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05).isActive = true
        weightValueTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        
        

//
        
        
    }
    
    
    
    
}
