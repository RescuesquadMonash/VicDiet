//
//  SearchingViewController+Search.swift
//  VicDiet
//
//  Created by Ming Yang on 6/4/19.
//  Copyright © 2019 Ming Yang. All rights reserved.
//

import UIKit


extension SearchingViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        sv.isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        sv.isSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        sv.isSearching = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        sv.isSearching = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        for i in 0...25{
            self.sv.filteredFixedDimensionalArray[i].names.removeAll(keepingCapacity: false)
            
            print(self.sv.fixedDimensionalArray[i].names.count)
        }
        let predicate = searchBar.text!.lowercased()
        for i in 0...25{
            self.sv.filteredFixedDimensionalArray[i].names = self.sv.fixedDimensionalArray[i].names.filter{$0.name.lowercased().contains(predicate)}
            self.sv.filteredFixedDimensionalArray[i].names.sort(by: {$0.name < $1.name})
            
            print(self.sv.filteredFixedDimensionalArray[i].names.count)
            
        }
        
        for j in 0...25{
            
            if(self.sv.filteredFixedDimensionalArray[j].names.count != 0){
                self.sv.isSearching = true
                break
            }
            
            self.sv.isSearching = false
        }
        
        
        self.sv.tableView.reloadData()
        
    }
    
    
    
    
    
}
