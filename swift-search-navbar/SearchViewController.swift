//
//  SearchViewController.swift
//  swift-search-navbar
//
//  Created by Michael Richardson on 26/08/2019.
//  Copyright © 2019 Michael Richardson. All rights reserved.
//

import UIKit

public class SearchViewController: UIViewController {
    
    let primaryColor = UIColor(r: 255, g: 105, b: 99)
    let primaryDarkColor = UIColor(r: 179, g: 39, b: 34)
    
    private let searchBar: SearchBarView = {
        let view = SearchBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let statusBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        // Setup views
        statusBar.backgroundColor = primaryColor
        self.view.addSubview(statusBar)
        
        statusBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        statusBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        statusBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        statusBar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        searchBar.title = "My View Controller"
        searchBar.backgroundColor = primaryColor
        searchBar.textInput.inputBackgroundColor = primaryDarkColor
        searchBar.textInput.inputTextColor = .white
        searchBar.delegate = self
        self.view.addSubview(searchBar)
        
        searchBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: searchBar.minHeaderHeight).isActive = true
        searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
}


extension SearchViewController: SearchBarViewDelegate {
    
    func performSearch(_ searchText: String) {
        
    }
    
    func onClearClicked() {
        
    }
    
    func goBack() {
        
    }
    
}
