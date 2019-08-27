//
//  IconTextField.swift
//  swift-search-navbar
//
//  Created by Michael Richardson on 26/08/2019.
//  Copyright © 2019 Michael Richardson. All rights reserved.
//

import UIKit

protocol IconTextFieldDelegate {
    func didStartTyping(text: String)
    func didEndTyping(text: String)
    func textDidChange(text: String)
    func didReturnText(text: String)
    func didClearText()
}

class IconTextField: UIView, UITextFieldDelegate {
    
    var inputTextColor: UIColor = .white {
        didSet {
            self.imageView.tintColor = inputTextColor
            self.textField.textColor = inputTextColor
        }
    }
    
    var inputBackgroundColor: UIColor = .white {
        didSet {
            self.backgroundColor = inputBackgroundColor
            self.layer.borderColor = inputBackgroundColor.cgColor
        }
    }
    
    var icon: String?
    var iconSize: CGFloat = 40
    var placeholder: String?
    
    var delegate: IconTextFieldDelegate?
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var textField: UITextField = {
        let input = UITextField()
        input.textColor = UIColor.white
        input.font = UIFont(name: "Helvetica", size: 14.0)
        input.tintColor = UIColor.red
        input.autocapitalizationType = .words
        input.clearButtonMode = .whileEditing
        input.delegate = self
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupViews(icon: icon, placeholder: placeholder, dark: true)
    }
    
    init(icon: String, placeholder: String, dark: Bool = true){
        super.init(frame: CGRect.zero)
        setupViews(icon: icon, placeholder: placeholder, dark: dark)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setFirstResponder(){
        DispatchQueue.main.async {
            self.textField.becomeFirstResponder()
        }
    }
    
    public func removeFirstResponder(){
        DispatchQueue.main.async {
            self.textField.resignFirstResponder()
            self.textField.endEditing(true)
        }
    }
    
    private func setupViews(icon: String?, placeholder: String?, dark: Bool){
        // Setup the view
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20.0
        backgroundColor = inputBackgroundColor
        layer.borderColor = inputBackgroundColor.cgColor
        imageView.tintColor = inputTextColor
        textField.textColor = inputTextColor
        
        if let icon = icon {
            imageView.image = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
        }
        
        addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 3).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        if let placeholder = placeholder {
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        
        addSubview(textField)
        
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegate?.didStartTyping(text: textField.text!)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.didEndTyping(text: textField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.delegate?.didReturnText(text: textField.text!)
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async {
            self.delegate?.didClearText()
            textField.resignFirstResponder()
        }
        return true
    }
    
    @objc
    func textChanged(_ textField: UITextField){
        self.delegate?.textDidChange(text: textField.text!)
    }
    
}
