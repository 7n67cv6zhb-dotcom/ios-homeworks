import UIKit

class LogInViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let emailTextField = LogInViewController.makeTextField(placeholder: "Email or phone", isSecure: false)
    private let passwordTextField = LogInViewController.makeTextField(placeholder: "Password", isSecure: true)

    private let logInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        let pixel = UIImage(named: "blue_pixel")
        button.setBackgroundImage(pixel, for: .normal)
        button.setBackgroundImage(pixel?.alpha(0.8), for: .selected)
        button.setBackgroundImage(pixel?.alpha(0.8), for: .highlighted)
        button.setBackgroundImage(pixel?.alpha(0.8), for: .disabled)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(fieldsStackView)
        contentView.addSubview(logInButton)

        fieldsStackView.addArrangedSubview(emailTextField)
        fieldsStackView.addArrangedSubview(passwordTextField)
        fieldsStackView.addSubview(separatorView)

        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)

        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),

            fieldsStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            fieldsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            fieldsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            fieldsStackView.heightAnchor.constraint(equalToConstant: 100),

            separatorView.centerYAnchor.constraint(equalTo: fieldsStackView.centerYAnchor),
            separatorView.leadingAnchor.constraint(equalTo: fieldsStackView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: fieldsStackView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),

            logInButton.topAnchor.constraint(equalTo: fieldsStackView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollView.contentInset.bottom = keyboardFrame.height
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.height
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    @objc private func logInButtonTapped() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }

    private static func makeTextField(placeholder: String, isSecure: Bool) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = isSecure
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        return textField
    }
}

private extension UIImage {
    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { _ in
            draw(at: .zero, blendMode: .normal, alpha: value)
        }
    }
}
