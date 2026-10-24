import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal

        let button = UIButton(type: .system)
        button.setTitle("Показать алерт", for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func showAlert() {
        let alert = UIAlertController(title: "Внимание", message: "Вы действительно хотите продолжить?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { _ in
            print("Нажата кнопка «Да»")
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: { _ in
            print("Нажата кнопка «Нет»")
        }))

        present(alert, animated: true)
    }
}
