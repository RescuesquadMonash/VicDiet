//
//  SwipingPhysicalInputController.swift
//  VicDiet
//
//  Created by Ming Yang on 1/4/19.
//  Copyright © 2019 Ming Yang. All rights reserved.
//

import UIKit
import Firebase

struct Page {
    let imageName: String
    let headerText: String
    let bodyText: String
}

struct PhysicalInfo {
    static var age = "Blank"
    static var gender = "Blank"
    static var weight = "Blank"
}

class SwipingPhysicalInputView: UIView, UICollectionViewDataSource, UICollectionViewDelegate,UITextFieldDelegate, UICollectionViewDelegateFlowLayout{
    
    
    var guidanceLauncher: GuidanceLauncher?
    
    
    //var swippingTextDict: SwippingTextDict?
    
    var age: String?
    var gender: String?
    var weight: String?
    let ref = Database.database().reference().child("User").child("reuserableUser")
    
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //cv.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 103/255, alpha: 1)
        //cv.backgroundColor = UIColor(red: 125/255, green: 206/255, blue: 148/255, alpha: 1)
        cv.backgroundColor = .brown
        cv.dataSource = self
        cv.delegate = self
        
        
        cv.isPagingEnabled = true
        
        
        
        return cv
        
    }()
    
    
    
    let pages = [
        Page(imageName: "swipingPageImage", headerText: "How old are you?", bodyText: "You should input your age here(Eg: 13)"),
        Page(imageName: "swipingPageImage", headerText: "What is your gender?", bodyText: "You should input your gender here: (\("Male") or \("Female"))"),
        Page(imageName: "swipingPageImage", headerText: "How heavy are you?", bodyText: "You should input your weight in \("Kg")")
        
    ]
    
    
    
//    let imageName = ["swipingPageImage","swipingPageImage","swipingPageImage"]
//    let headerStrings = ["Let us know your age.", "What is your gender?", "How heavy are you?"]
    
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        
        return button
    }()
    @objc private func handlePrev(){
        
        if(pageControl.currentPage == 0){
            UIView.animate(withDuration: 0.2, animations: {self.guidanceLauncher?.blackView.alpha = 0})
        }else{
            let prevIndex = max(pageControl.currentPage - 1, 0)
            
            let indexPath = IndexPath(item: prevIndex, section: 0)
            
            pageControl.currentPage = prevIndex
            
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
     
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.purple, for: .normal)
        
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        return button
    }()
    

    
    func displayMessage(_ message: String,_ title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.guidanceLauncher?.homePageController?.present(alertController, animated: true, completion: nil)
    }
    
    @objc private func handleNext(){
        
        
        if(pageControl.currentPage + 1 == pages.count){

            
            if let currentCell = self.guidanceLauncher?.swipingPhysicalInputView.collectionView.cellForItem(at: IndexPath(item: 2, section: 0)) as? SwipingPhysicalInputPageCell{
                weight = currentCell.inputTextField.text
                
                if(Int(weight!) != nil){
                    UIView.animate(withDuration: 0.2, animations: {self.guidanceLauncher?.blackView.alpha = 0})
                    let indexPath = IndexPath(item: 0, section: 0)
                    pageControl.currentPage = 0
                    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                    //firebase write
                    ref.child("Age").setValue(age)
                    ref.child("Gender").setValue(gender)
                    ref.child("Weight").setValue(weight)

                    
                    self.guidanceLauncher?.homePageController?.collectionView.reloadData()
           
                    
                }else{
                    displayMessage("Weight input is not a number!","Input Error")
                }
                
            }
        } else{
            if let currentCell = self.guidanceLauncher?.swipingPhysicalInputView.collectionView.cellForItem(at: IndexPath(item: pageControl.currentPage, section: 0)) as? SwipingPhysicalInputPageCell{
                print(currentCell.inputTextField.tag)
                print(currentCell.inputTextField.text)
                
                if (pageControl.currentPage == 0){
                    
                    age = currentCell.inputTextField.text
                    if(Int(age!) != nil) {
                        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
                        let indexPath = IndexPath(item: nextIndex, section: 0)
                        pageControl.currentPage = nextIndex
                        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                    }else{
                        displayMessage("Age input is not a integer!","Input Error")
                    }
                }else{
                    gender = currentCell.inputTextField.text
                    if(gender?.lowercased() == "male") || (gender?.lowercased() == "female"){
                        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
                        let indexPath = IndexPath(item: nextIndex, section: 0)
                        pageControl.currentPage = nextIndex
                        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                    }else{
                        displayMessage("Gender input is not valid!","Input Error")
                    }
                }
            }
            
            
            
//            let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
//            let indexPath = IndexPath(item: nextIndex, section: 0)
//            pageControl.currentPage = nextIndex
//            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        }
    }
    
    
    
    lazy var pageControl: UIPageControl = {
        
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .orange
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 244/255, alpha: 1)
        
        return pc
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .yellow
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        setupBottomControls()
        collectionView.backgroundColor = .white
        collectionView.register(SwipingPhysicalInputPageCell.self, forCellWithReuseIdentifier: "cellId")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SwipingPhysicalInputPageCell
        
        if(indexPath.item == 0){
            cell.inputTextField.rightView = cell.ageTextView
            
            cell.inputTextField.rightViewMode = .always
        }else if(indexPath.item == 2){
            cell.inputTextField.rightView = cell.weightTextView
            cell.inputTextField.rightViewMode = .always
        }
        
        cell.inputTextField.tag = indexPath.item
        cell.inputTextField.delegate = self
        
        let page = pages[indexPath.item]
        cell.page = page

        return cell
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.move().x / self.frame.width
        print(targetContentOffset.move().x)
        print(self.frame.width)
        pageControl.currentPage = Int(index)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    fileprivate func setupBottomControls(){
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton,pageControl,nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        addSubview(bottomControlsStackView)
        NSLayoutConstraint.activate([
            bottomControlsStackView.topAnchor.constraint(equalTo: self.topAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1)
            ])
        print(self.frame.height/20)
        
    }
    
}
