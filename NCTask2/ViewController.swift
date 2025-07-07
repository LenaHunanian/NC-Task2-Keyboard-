//
//  ViewController.swift
//  NCTask2
//
//  Created by Lena Hunanian on 07.07.25.
//

import UIKit

class ViewController: UIViewController {
    private let textField = UITextField()
    private var bottomConstraint: NSLayoutConstraint?


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTextField()
        setupObservers()
        
    }
    
    private func setupTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text here..."
        textField.font = .systemFont(ofSize: 16)
        view.addSubview(textField)
        
        bottomConstraint = textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            bottomConstraint!
        ])
    }
    
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }


    @objc private func handleKeyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else {
                  return
              }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        bottomConstraint?.constant = -keyboardHeight - 20
        UIView.animate(withDuration: duration.doubleValue) {
            self.view.layoutIfNeeded()
        }
        

        
    }
    @objc private func handleKeyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else {
            return
        }

        bottomConstraint?.constant = -20

        UIView.animate(withDuration: duration.doubleValue) {
            self.view.layoutIfNeeded()
            
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

