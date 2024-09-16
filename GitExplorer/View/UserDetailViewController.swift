import UIKit

protocol UserDetailViewControllerDelegate: AnyObject {
    func showRepositories(for user: GitHubUserModel)
}

final class UserDetailViewController: UIViewController {
    
    private let user: GitHubUserModel
    weak var delegate: UserDetailViewControllerDelegate?
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let repositoriesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View Repositories", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    init(user: GitHubUserModel) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = user.login
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        configureUserDetails()
    }
    
    private func setupViews() {
        view.addSubview(avatarImageView)
        view.addSubview(loginLabel)
        view.addSubview(repositoriesButton)
        repositoriesButton.addTarget(self, action: #selector(didTapRepositories), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            loginLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            repositoriesButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            repositoriesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureUserDetails() {
        loginLabel.text = user.login
        
        // Load the avatar image
        if let avatarUrl = URL(string: user.avatar_url) {
            URLSession.shared.dataTask(with: avatarUrl) { [weak self] data, response, error in
                guard let self = self, let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.avatarImageView.image = image
                }
            }.resume()
        }
    }
    
    @objc func didTapRepositories() {
        delegate?.showRepositories(for: user)  // Navigate to the repositories screen
    }
}
