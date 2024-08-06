//
//  SignupViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//

import UIKit

class SignupViewController: UIViewController {
    
    private let storageProvider: StorageProvider
    
    init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBgPink
        setupUI()
    }
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nombre"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Contraseña"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Telefóno"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Dirección"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private func setupUI() {
        let signupLabel = createLabel(text: "Signup")
       
        let saveButton = createButton(title: "Guardar", backgroundColor: .customTabItemPink2, action: #selector(saveButtonTapped))
        
        view.addSubview(signupLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(phoneTextField)
        view.addSubview(addressTextField)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            signupLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: signupLabel.bottomAnchor, constant: 20),
            nameTextField.widthAnchor.constraint(equalToConstant: 300),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            phoneTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            phoneTextField.widthAnchor.constraint(equalToConstant: 300),
            phoneTextField.heightAnchor.constraint(equalToConstant: 40),
            
            addressTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addressTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            addressTextField.widthAnchor.constraint(equalToConstant: 300),
            addressTextField.heightAnchor.constraint(equalToConstant: 40),
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
            saveButton.widthAnchor.constraint(equalToConstant: 300),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }

    private func createButton(title: String, backgroundColor: UIColor, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    @objc private func saveButtonTapped() {
        //navigationController?.popViewController(animated: true)
        // Guardar usuario en CoreData y
        storageProvider.saveUser(name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, address: addressTextField.text!, phone: phoneTextField.text!)
        //regresar a LoginViewController
        navigationController?.popViewController(animated: true)
    }
}
