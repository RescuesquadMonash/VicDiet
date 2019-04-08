//
//  SearchingView.swift
//  VicDiet
//
//  Created by Ming Yang on 6/4/19.
//  Copyright © 2019 Ming Yang. All rights reserved.
//

import UIKit
import Firebase

class SearchingView: UIView, UITableViewDelegate, UITableViewDataSource{
    
    var searchingViewController: SearchingViewController?
    //var foodObjectSet = [FoodObject]()
    //var foodObjectSetSet = [[FoodObject]()]
    
    var fixedDimensionalArray = [ExpandableNames]()
    var filteredFixedDimensionalArray = [ExpandableNames]()
    
    var detailList = [String]()
    
    
    var isSearching: Bool = false 
    
    let cellId = "cellId"
    
    //var homePageController: HomePageController?
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        return tv
        
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for i in 0...25{

            fixedDimensionalArray.append(ExpandableNames(isExpanded: true, names: [FoodObject]()))
            filteredFixedDimensionalArray.append(ExpandableNames(isExpanded: true, names: [FoodObject]()))
            
        }
        
        
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if isSearching{
            
            if (!filteredFixedDimensionalArray[section].isExpanded){
                return 0
            }
            return filteredFixedDimensionalArray[section].names.count
            
        }
        
        if (!fixedDimensionalArray[section].isExpanded){
            return 0
        }
        
        return fixedDimensionalArray[section].names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellId)
        if isSearching{
            let name = filteredFixedDimensionalArray[indexPath.section].names[indexPath.row].name
            let detail = filteredFixedDimensionalArray[indexPath.section].names[indexPath.row].surveyFlag
            cell.textLabel!.text = name
            cell.detailTextLabel?.text = detail
            
        }else{
            let name = fixedDimensionalArray[indexPath.section].names[indexPath.row].name
            let detail = fixedDimensionalArray[indexPath.section].names[indexPath.row].surveyFlag
            cell.textLabel!.text = name
            cell.detailTextLabel?.text = detail
            
        }
        
        
        return cell
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fixedDimensionalArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //let viewWidth = tableView.frame.width
        
        let button = UIButton(type: .system)
        button.setTitle("Click To Close", for: .normal)
        button.backgroundColor = UIColor(red: 140/255, green: 235/255, blue: 160/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        
        button.tag = section
        
        return button
        
    }
    
    
    @objc func handleExpandClose(button: UIButton){
        
        if isSearching{
            
            let section = button.tag
            var indexPaths = [IndexPath]()
            for row in filteredFixedDimensionalArray[section].names.indices {
                let indexPath = IndexPath(row: row, section: section)
                indexPaths.append(indexPath)
            }
            
            let isExpanded = filteredFixedDimensionalArray[section].isExpanded
            filteredFixedDimensionalArray[section].isExpanded = !isExpanded
            
            button.setTitle(isExpanded ? "Click To Open" : "Click To Close", for: .normal)
            
            if (isExpanded){
                tableView.deleteRows(at: indexPaths, with: .fade)
                
            } else{
                tableView.insertRows(at: indexPaths, with: .fade)
            }
            
        } else{
            
            let section = button.tag
            var indexPaths = [IndexPath]()
            for row in fixedDimensionalArray[section].names.indices {
                let indexPath = IndexPath(row: row, section: section)
                indexPaths.append(indexPath)
            }
            
            let isExpanded = fixedDimensionalArray[section].isExpanded
            fixedDimensionalArray[section].isExpanded = !isExpanded
            
            button.setTitle(isExpanded ? "Click To Open" : "Click To Close", for: .normal)
            
            if (isExpanded){
                tableView.deleteRows(at: indexPaths, with: .fade)
                
            } else{
                tableView.insertRows(at: indexPaths, with: .fade)
            }
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodDetailTableViewController = FoodDetailTableViewController()
        
        
//        let oldNavigationController = self.searchingViewController?.navigationController
//        oldNavigationController?.pushViewController(foodDetailTableViewController, animated: true)
        
        if isSearching{
            
            
            let name = filteredFixedDimensionalArray[indexPath.section].names[indexPath.row].name
            let detail = filteredFixedDimensionalArray[indexPath.section].names[indexPath.row].surveyFlag
            let protein = filteredFixedDimensionalArray[indexPath.section].names[indexPath.row].protein
            let calcium = filteredFixedDimensionalArray[indexPath.section].names[indexPath.row].calcium
            let totalFat = filteredFixedDimensionalArray[indexPath.section].names[indexPath.row].totalFat
            let sodium = filteredFixedDimensionalArray[indexPath.section].names[indexPath.row].sodium
            let vitaminC = filteredFixedDimensionalArray[indexPath.section].names[indexPath.row].vitaminC
            let vitaminA = filteredFixedDimensionalArray[indexPath.section].names[indexPath.row].vitaminA
            
            detailList.append(name)
            detailList.append(detail)
            detailList.append("\(protein)")
            detailList.append("\(calcium)")
            detailList.append("\(totalFat)")
            detailList.append("\(sodium)")
            detailList.append("\(vitaminC)")
            detailList.append("\(vitaminA)")
            
//
//            cell.textLabel!.text = name
//            cell.detailTextLabel?.text = detail
            
        }else{
            let name = fixedDimensionalArray[indexPath.section].names[indexPath.row].name
            let detail = fixedDimensionalArray[indexPath.section].names[indexPath.row].surveyFlag
            let protein = fixedDimensionalArray[indexPath.section].names[indexPath.row].protein
            let calcium = fixedDimensionalArray[indexPath.section].names[indexPath.row].calcium
            let totalFat = fixedDimensionalArray[indexPath.section].names[indexPath.row].totalFat
            let sodium = fixedDimensionalArray[indexPath.section].names[indexPath.row].sodium
            let vitaminC = fixedDimensionalArray[indexPath.section].names[indexPath.row].vitaminC
            let vitaminA = fixedDimensionalArray[indexPath.section].names[indexPath.row].vitaminA
            
            detailList.append(name)
            detailList.append(detail)
            detailList.append("\(protein)")
            detailList.append("\(calcium)")
            detailList.append("\(totalFat)")
            detailList.append("\(sodium)")
            detailList.append("\(vitaminC)")
            detailList.append("\(vitaminA)")
            
//            cell.textLabel!.text = name
//            cell.detailTextLabel?.text = detail
            
        }
        foodDetailTableViewController.detailList = detailList
        foodDetailTableViewController.fixedDimensionalArray = fixedDimensionalArray
        foodDetailTableViewController.searchingViewController = self.searchingViewController
        detailList = [String]()
        let oldNavigationController = self.searchingViewController?.navigationController
        
        oldNavigationController?.pushViewController(foodDetailTableViewController, animated: true)
        
    }
    
    private let ref = Database.database().reference().child("OpenDataRepository").child("FoodNutrient")
    
//    func fetchSearching(){
//        for i in 0...25{
//            ref.child("\(i)").observe(.childAdded, with: { (snapshot) -> Void in
//
//                if let dictionary = snapshot.value as? [String:AnyObject]{
//
//                    self.sv.fixedDimensionalArray[i].names.append(FoodObject(name: dictionary["Food Name"] as! String, protein: dictionary["Protein (g)"] as! NSNumber,surveyFlag: dictionary["Survey flag"] as! String,calcium: dictionary["Calcium (Ca) (mg)"] as! NSNumber,totalFat: dictionary["Total fat (g)"] as! NSNumber, sodium: dictionary["Sodium (Na) (mg)"] as! NSNumber,vitaminC: dictionary["Vitamin C (mg)"] as! NSNumber,vitaminA: dictionary["Vitamin A retinol equivalents (µg)"] as! NSNumber))
//                    self.sv.fixedDimensionalArray[i].isExpanded = true
//                    self.sv.tableView.reloadData()
//                    //print(dictionary)
//                }
//
//            })
//
//        }
//    }
    
}
