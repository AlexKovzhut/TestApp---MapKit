//
//  Alert.swift
//  TestApp - MapKit
//
//  Created by Alexander Kovzhut on 14.10.2021.
//

import UIKit

extension UIViewController {
    
    //Вызов алерта на добавление адреса
    func alertAddAdress(title: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = placeholder
        }
        
        let alertOK = UIAlertAction(title: "Ok", style: .default) { (action) in
            let textField = alertController.textFields?.first
            guard let text = textField?.text else { return }
            completionHandler(text)//Передаем текст из поля алерта
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .default) { (_) in
        }
        
        alertController.addAction(alertOK)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    //Алерт для ошибки
    func alertError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertOK = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(alertOK)
        
        present(alertController, animated: true, completion: nil)
        
    }
}
