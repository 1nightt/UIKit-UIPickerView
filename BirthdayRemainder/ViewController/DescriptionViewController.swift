import UIKit

final class DescriptionViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    weak var delegate: BirthdayListViewController?
    
    // MARK: - IBOutlet
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var dateTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var genderTextField: UITextField!
    @IBOutlet private weak var instagramTextField: UITextField!
    
    private var datePicker = UIDatePicker()
    private var agePicker = UIPickerView()
    private var genderPicker = UIPickerView()
    
    private var ageData = Array(1...100)
    private var gendersData = ["Мужчина", "Женщина"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Настройка agePicker
        agePicker.delegate = self
        agePicker.dataSource = self
        ageTextField.inputView = agePicker
        
        // Настройка genderPicker
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderTextField.inputView = genderPicker
        
        // Настройка datePicker
        createDatePicker()
        
        createToolbar()
        
        instagramTextField.delegate = self
        instagramTextField.addTarget(self, action: #selector(instagramAction), for: .editingDidBegin)
        
    }
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = createToolBarForDatePicker()
    }
    
    func createToolBarForDatePicker() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        return toolbar
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        self.dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == agePicker {
            return ageData.count
        } else if pickerView == genderPicker {
            return gendersData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == agePicker {
            return "\(ageData[row])"
        } else if pickerView == genderPicker {
            return gendersData[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == agePicker {
            ageTextField.text = "\(ageData[row])"
        } else if pickerView == genderPicker {
            genderTextField.text = gendersData[row]
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        ageTextField.inputAccessoryView = toolbar
        genderTextField.inputAccessoryView = toolbar
        //        dateTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: - IBAction
    
    @IBAction private func instagramAction(_ sender: UITextField) {
        let alertController = UIAlertController(title: "Введите Instagram", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "@example"
        }
        let okButton = UIAlertAction(title: "OK", style: .default) { _ in
            if let text = alertController.textFields?.first?.text {
                self.instagramTextField.text = text
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func addButtonAcrion(_ sender: UIBarButtonItem) {
        if nameTextField.text == "" || ageTextField.text == "" || dateTextField.text == "" || instagramTextField.text == "" {
            let alertController = UIAlertController(title: "Ошибка", message: "Введите все поля", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            self.present(alertController, animated: true, completion: nil)
        } else {
            delegate?.update(name: nameTextField.text ?? "", date: dateTextField.text ?? "", age: ageTextField.text ?? "")
            navigationController?.popViewController(animated: true)
            self.dismiss(animated: true)
        }
    }
}

