//
//  SwipingPhysicalInputPageCell.swift
//  VicDiet
//
//  Created by Ming Yang on 1/4/19.
//  Copyright © 2019 Ming Yang. All rights reserved.
//

import UIKit

class SwipingPhysicalInputPageCell: UICollectionViewCell,UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var agePicker = UIPickerView()
    
    
    
    
    var page: Page? {
        didSet{
            guard let unwrappedPage = page else {
                return
            }
            
            
            bootImageView.image = UIImage(named: unwrappedPage.imageName)
            
            let physicalAttributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
            
            physicalAttributedText.append(NSMutableAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
            
            bootDescriptionTextView.attributedText = physicalAttributedText
            
            bootDescriptionTextView.textAlignment = .center
        }
    }
    
    
    
    
    private let bootImageView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage(named: "swipingPageImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let bootDescriptionTextView: UITextView = {
        let textView = UITextView()
        let physicalAttributedText = NSMutableAttributedString(string: "Let us know your age?", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        
        physicalAttributedText.append(NSMutableAttributedString(string: "\n\n\nDifferent ages in people will be very important to evalute your standard intake and health condition.", attributes: [NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        textView.attributedText = physicalAttributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
        
        
    }()
    
    let ageTextView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        let attributedText = NSMutableAttributedString(string: "Years Old", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
        textView.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .right
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    let weightTextView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        let attributedText = NSMutableAttributedString(string: "KG", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
        textView.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()

    
    let inputTextField: LogInTextField = {
        let textField = LogInTextField()
        //let viewForText = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        //viewForText.backgroundColor = .yellow
        
        //textField.rightView = viewForText
        //textField.rightViewMode = .always
        
        return textField
        
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        agePicker.delegate = self
        agePicker.dataSource = self
        //inputTextField.inputView = agePicker
        //inputTextField.delegate = self
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func setupLayout(){
        
        
//        let topImageContainerView = UIView()
//        addSubview(topImageContainerView)
//        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
//        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        topImageContainerView.addSubview(bootImageView)
//        bootImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
//        bootImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
//        bootImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
//        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        
        
        
        addSubview(bootDescriptionTextView)
        
        bootDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        bootDescriptionTextView.topAnchor.constraint(equalTo: topAnchor, constant: frame.height/9).isActive = true
        bootDescriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        bootDescriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        bootDescriptionTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        //bootDescriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 50).isActive = true
        
        
        addSubview(inputTextField)
        
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.topAnchor.constraint(equalTo: bootDescriptionTextView.bottomAnchor, constant: -self.frame.height*0.015).isActive = true
        inputTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        inputTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -self.frame.height*0.5).isActive = true
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    
}
