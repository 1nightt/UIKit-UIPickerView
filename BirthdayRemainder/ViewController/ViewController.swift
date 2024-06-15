//ViewController регистрации

import UIKit
import Foundation

final class ViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var emailTextField: UITextField!
    
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var togglePasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        let iconClose = UIImage(named: "closeeye")
        let iconOpen = UIImage(named: "openeye")
        togglePasswordButton.setImage(iconClose, for: .normal)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - IBAction
    
    // Глазок
    @IBAction private func togglePasswordButton(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        
        let imageName = passwordTextField.isSecureTextEntry ? "closeeye" : "openeye"
        togglePasswordButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    // Основная кнопка
    @IBAction private func nextBoardButton(_ sender: UIButton) {
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Ошибка", message: "Введите все данные", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        } else if !isValidEmail(emailTextField.text!) {
            let alertController = UIAlertController(title: "Ошибка", message: "Введите верный email", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // Проверка email
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
}

// Работа кнопки return на клавиатуре
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
