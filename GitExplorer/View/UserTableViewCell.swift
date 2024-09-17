
import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "UserTableViewCell"
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupViews() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(loginLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            
            loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 15),
            loginLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            loginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
        
    func configure(with user: GitHubUserModel) {
        loginLabel.text = user.login
        loadImage(from: user.avatar_url)
    }
        
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.avatarImageView.image = image
                }
            }
        }.resume()
    }
}
