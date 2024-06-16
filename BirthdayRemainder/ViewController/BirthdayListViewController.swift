// VC, в котором содержится описание о пользователе
import UIKit

protocol BirthdayListDelegate {
    func update(name: String, date: String, age: String)
}

final class BirthdayListViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var nameLabek: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Visual Components
    var photoValue: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DescriptionViewController else { return }
        destination.delegate = self
    }
    
    // MARK: - Methods
    func update(name: String, date: String, age: String) {
        nameLabek.text = name.capitalized
        ageLabel.text = age + " лет"
        dateLabel.text = date
        
        let foto = UIImageView(frame: CGRect(x: 20, y: 135, width: 80, height: 80))
        foto.image = UIImage(systemName: "person.circle.fill")
        foto.tintColor = .systemGray
        foto.layer.cornerRadius = 30
        foto.layer.masksToBounds = true
        self.view.addSubview(foto)
    }
    
    
}

