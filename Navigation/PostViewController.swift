import UIKit

class PostViewController: UIViewController {

    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        title = post?.title

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Инфо",
            style: .plain,
            target: self,
            action: #selector(openInfo)
        )
    }

    @objc private func openInfo() {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .pageSheet
        present(infoViewController, animated: true)
    }
}
