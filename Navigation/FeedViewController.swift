import UIKit

class FeedViewController: UIViewController {

    var post = Post(title: "Мой первый пост")

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
        view.backgroundColor = .systemBackground

        let button = UIButton(type: .system)
        button.setTitle("Открыть пост", for: .normal)
        button.addTarget(self, action: #selector(openPost), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func openPost() {
        let postViewController = PostViewController()
        postViewController.post = post
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
