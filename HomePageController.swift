//
//  HomePageController.swift
//  VicDiet
//
//  Created by Ming Yang on 2/4/19.
//  Copyright © 2019 Ming Yang. All rights reserved.
//

import UIKit


let navigationTitles = ["Home","Food","Tips","Me"]


class HomePageController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    
    
    let firstCellId = "firstCellId"
    let secondCellId = "secondCellId"
    let thirdCellId = "thirdCellId"
    let forthCellId = "forthCellId"
    
    var guidanceLauncher: GuidanceLauncher?
    
    func setupGuidanceBarButtons(){
        //let guidanceImage = UIImage(named: "setting")?.withRenderingMode((.alwaysOriginal))
        
        let guidanceImage = UIImage(named: "icon_guidance")?.withRenderingMode((.alwaysOriginal))
        let guidanceBarButtonItem = UIBarButtonItem(image: guidanceImage, style: .plain, target: self, action: #selector(handleGuidance))
        navigationItem.rightBarButtonItem = guidanceBarButtonItem
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 125/255, green: 206/255, blue: 148/255, alpha: 1)
    }
     
    @objc func handleGuidance(){
        guidanceLauncher = GuidanceLauncher()
        guidanceLauncher?.showGuidance()
        guidanceLauncher?.homePageController = self
    }

    
    lazy var mainMenuBar: MainMenuBar = {
        let mmb = MainMenuBar()
        mmb.homePageController = self
        
        return mmb
        
    }()
    

    
    fileprivate func setupBottomMenu(){
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [mainMenuBar])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guidanceLauncher = GuidanceLauncher()
        guidanceLauncher?.homePageController = self
        
        navigationItem.title = "Home"
        
        setupGuidanceBarButtons()
        
        setupCollectionView()
        
        setupBottomMenu()
        
        
    }
    

    
    func setupCollectionView(){
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.lightGray
        
        
        
        
        
        
        collectionView?.register(HomePageFirstCell.self, forCellWithReuseIdentifier: firstCellId)
        collectionView?.register(FoodCell.self, forCellWithReuseIdentifier: secondCellId)
        collectionView?.register(TipsCell.self, forCellWithReuseIdentifier: thirdCellId)
        collectionView?.register(MeCell.self, forCellWithReuseIdentifier: forthCellId)
        
        
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView?.isPagingEnabled = true
        
        
        
        
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.item == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: firstCellId, for: indexPath)
            cell.backgroundColor = UIColor.white
            
            
            return cell
        }
        if (indexPath.item == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondCellId, for: indexPath) as! FoodCell
            cell.navigationController = self.navigationController
            
            
            cell.backgroundColor = UIColor.white
            return cell
        }
        if (indexPath.item == 2){
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: thirdCellId, for: indexPath)
//            cell.backgroundColor = UIColor.white
//            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: forthCellId, for: indexPath)
        cell.backgroundColor = UIColor.white
        return cell
    }
    
 
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let index = targetContentOffset.move().x / view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        
        let previousCell = mainMenuBar.collectionView.cellForItem(at: mainMenuBar.previousIndexClicked!) as! MenuCell
        previousCell.imageView.image = UIImage(named: mainMenuBar.imageNames[mainMenuBar.previousIndexClicked!.item])
        
        let cell = mainMenuBar.collectionView.cellForItem(at: indexPath as IndexPath) as! MenuCell
        cell.imageView.image = UIImage(named: mainMenuBar.selectedImages[indexPath.item])
        mainMenuBar.previousIndexClicked = indexPath as IndexPath
        
        
        
        navigationItem.title = navigationTitles[indexPath.item]
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("aa")
        print(UINavigationBar.appearance().frame.height)
        print(self.navigationController?.navigationBar.frame.height)
        print("aa")
        return CGSize(width: view.frame.width, height: view.frame.height - 23 - (self.navigationController?.navigationBar.frame.height)!)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func scrollToMainMenuIndex(menuIndex: Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        
    }
    

    
    
    
}




