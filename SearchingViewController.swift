//
//  SearchingViewController.swift
//  VicDiet
//
//  Created by Ming Yang on 5/4/19.
//  Copyright © 2019 Ming Yang. All rights reserved.
//

import UIKit

import Firebase
import FirebaseStorage


class SearchingViewController: UIViewController{
    

    private let letterArray = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    private let ref = Database.database().reference().child("OpenDataRepository").child("FoodNutrient")
    
    private var dataRefHandle: DatabaseHandle?
    //let uid = Auth.auth().currentUser?.uid
    
    let sv = SearchingView()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Cancel", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleCancel(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /*
     Remove all observers when deinitializing
     */
    deinit {
        ref.removeAllObservers()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sv.searchingViewController = self
        
        
        fetchSearching()
        setupViews()
        
    }

    
    
    
    func fetchSearching(){
        for i in 0...25{
            ref.child("\(i)").observe(.childAdded, with: { (snapshot) -> Void in
                
                if let dictionary = snapshot.value as? [String:AnyObject]{
                  
                    self.sv.fixedDimensionalArray[i].names.append(FoodObject(name: dictionary["Food Name"] as! String, protein: dictionary["Protein (g)"] as! NSNumber,surveyFlag: dictionary["Survey flag"] as! String,calcium: dictionary["Calcium (Ca) (mg)"] as! NSNumber,totalFat: dictionary["Total fat (g)"] as! NSNumber, sodium: dictionary["Sodium (Na) (mg)"] as! NSNumber,vitaminC: dictionary["Vitamin C (mg)"] as! NSNumber,vitaminA: dictionary["Vitamin A retinol equivalents (µg)"] as! NSNumber))
                    self.sv.fixedDimensionalArray[i].isExpanded = true
                    self.sv.tableView.reloadData()
                    //print(dictionary)
                }
                
            })
            
        }
    }
    
    
    

    
    
    func  setupViews(){
        
        sv.backgroundColor = .white
        
        //setup searching bar on the top
        let realSearchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width*2/3, height: self.navigationController?.navigationBar.frame.height ?? 20))
        realSearchBar.placeholder = "Click To Search"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: realSearchBar)
        realSearchBar.delegate = self
        
        
        //setup cancel button on the top
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelButton)
        
        //setup searching result view at the bottom of searching bar
        view.addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        sv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        sv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        sv.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
    }

}

