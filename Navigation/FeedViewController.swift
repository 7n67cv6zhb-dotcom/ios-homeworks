import UIKit

class FeedViewController: UIViewController {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
        view.backgroundColor = .systemBackground

        let firstButton = makeButton(title: "Первый пост")
        let secondButton = makeButton(title: "Второй пост")

        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            firstButton.heightAnchor.constraint(equalToConstant: 44),
            secondButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func makeButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(openPost(_:)), for: .touchUpInside)
        return button
    }

    @objc private func openPost(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.post = Post(title: sender.currentTitle ?? "Пост")
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
