//
//  SearchBarView.swift
//  swift-search-navbar
//
//  Created by Michael Richardson on 26/08/2019.
//  Copyright © 2019 Michael Richardson. All rights reserved.
//

import UIKit

protocol SearchBarViewDelegate {
    func performSearch(_ searchText: String)
    func onClearClicked()
    func goBack()
}

class SearchBarView: UIView, IconTextFieldDelegate {
    
    private let animationDuration: TimeInterval = 0.1
    private var isSearchVisible = false
    
    let headerHeight: CGFloat = 40.0
    let headerPadding: CGFloat = 4
    
    var minHeaderHeight: CGFloat {
        return headerPadding // Spacing
            + headerHeight // Search input
            + headerPadding // Spacing
    }
    
    var delegate: SearchBarViewDelegate?
    var viewController: UIViewController?
    
    var title: String = "" {
        didSet {
            self.headerTitle.text = title
        }
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.white
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(SearchBarView.handleBack), for: .touchUpInside)
        return button
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.white
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(SearchBarView.handleSearch), for: .touchUpInside)
        return button
    }()
    
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont(name: "HelveticaBold", size: 18.0)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textInput: IconTextField = {
        let view = IconTextField(icon: "search_icon", placeholder: "Search for something...")
        view.delegate = self
        view.textField.returnKeyType = .search
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
        clipsToBounds = true
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(backButton)
        
        backButton.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        backButton.topAnchor.constraint(equalTo: topAnchor, constant: headerPadding).isActive = true
        backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: headerHeight).isActive = true
        
        addSubview(searchButton)
        
        searchButton.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        searchButton.topAnchor.constraint(equalTo: topAnchor, constant: headerPadding).isActive = true
        searchButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: headerHeight).isActive = true
        
        addSubview(textInput)
        
        textInput.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        textInput.topAnchor.constraint(equalTo: topAnchor, constant: headerPadding).isActive = true
        textInput.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 0).isActive = true
        textInput.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        textInput.alpha = 0
        
        addSubview(headerTitle)
        
        headerTitle.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        headerTitle.topAnchor.constraint(equalTo: topAnchor, constant: headerPadding).isActive = true
        headerTitle.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: -8).isActive = true
        headerTitle.rightAnchor.constraint(equalTo: searchButton.leftAnchor, constant: 8).isActive = true
    }
    
    @objc
    func handleBack() {
        self.delegate?.goBack()
    }
    
    @objc
    func handleSearch() {
        updateHeader()
    }
    
    private func updateHeader(){
        if isSearchVisible {
            UIView.animate(withDuration: animationDuration) {
                self.textInput.alpha = 0
                self.headerTitle.alpha = 1
                self.searchButton.alpha = 1
                self.layoutIfNeeded()
            }
        }
        else {
            UIView.animate(withDuration: animationDuration) {
                self.textInput.alpha = 1
                self.headerTitle.alpha = 0
                self.searchButton.alpha = 0
                self.layoutIfNeeded()
            }
            self.textInput.setFirstResponder()
        }
        
        isSearchVisible = !isSearchVisible
    }
    
    func didStartTyping(text: String) {
    }
    
    func didEndTyping(text: String) {
    }
    
    func textDidChange(text: String) {
        self.delegate?.performSearch(text)
    }
    
    func didReturnText(text: String) {
    }
    
    func didClearText() {
        updateHeader()
        self.delegate?.onClearClicked()
    }
    
}
