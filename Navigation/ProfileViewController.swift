import UIKit

class ProfileViewController: UIViewController {

    private let profileHeaderView: ProfileHeaderView = {
        let headerView = ProfileHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    private let newButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Новая кнопка", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let overlayView: UIView = {
        let overlay = UIView()
        overlay.backgroundColor = .black
        overlay.alpha = 0
        overlay.translatesAutoresizingMaskIntoConstraints = false
        return overlay
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var avatarExpandedConstraints: [NSLayoutConstraint] = []
    private var isAvatarExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        view.backgroundColor = .systemBackground

        // Что добавлено позже, то лежит выше
        view.addSubview(newButton)
        view.addSubview(profileHeaderView)
        view.addSubview(closeButton)

        // Затемнение кладем поверх элементов шапки, а аватар поднимаем над затемнением
        profileHeaderView.addSubview(overlayView)
        profileHeaderView.bringSubviewToFront(profileHeaderView.avatarImageView)

        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        profileHeaderView.avatarImageView.addGestureRecognizer(tap)

        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        setupConstraints()
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let avatar = profileHeaderView.avatarImageView

        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),

            newButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            closeButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44)
        ])

        // Положение увеличенного аватара: по центру экрана, на всю ширину, квадрат.
        // Пока не включаем
        avatarExpandedConstraints = [
            avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            avatar.widthAnchor.constraint(equalTo: view.widthAnchor),
            avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor)
        ]
    }

    @objc private func avatarTapped() {
        guard !isAvatarExpanded else { return }
        isAvatarExpanded = true
        view.endEditing(true)

        NSLayoutConstraint.deactivate(profileHeaderView.avatarSmallConstraints)
        NSLayoutConstraint.activate(avatarExpandedConstraints)

        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.overlayView.alpha = 0.7
            self.profileHeaderView.avatarImageView.layer.cornerRadius = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 1
            }
        }
    }

    @objc private func closeButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.closeButton.alpha = 0
        } completion: { _ in
            NSLayoutConstraint.deactivate(self.avatarExpandedConstraints)
            NSLayoutConstraint.activate(self.profileHeaderView.avatarSmallConstraints)

            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
                self.overlayView.alpha = 0
                self.profileHeaderView.avatarImageView.layer.cornerRadius = ProfileHeaderView.avatarSize / 2
            } completion: { _ in
                self.isAvatarExpanded = false
            }
        }
    }
}
