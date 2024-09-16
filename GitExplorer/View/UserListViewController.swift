
import UIKit

class UserListViewController: UIViewController {
        
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
        
    private var viewModel: GitHubViewModel
        
    init(viewModel: GitHubViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "GitHub Users"
        view.backgroundColor = .white
        
        viewModel.delegate = self
        
        setupViews()
        setupConstraints()
        configureTableView()
        viewModel.fetchUsers()
    }
        
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let user = viewModel.user(at: indexPath.row)
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.user(at: indexPath.row)
        // Add detail view controller
    }
}

// MARK: - GitHubViewModelDelegate

extension UserListViewController: GitHubViewModelDelegate {
    func didFetchUsersSuccessfully(_ users: [GitHubUserModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailToFetchUsers(with error: CustomError) {
        // Add alert error
        print("Erro ao buscar usuários: \(error)")
    }
    
    func didFetchRepositoriesSuccessfully(_ repositories: [GitHubUserModel.Repository]) {
        // Add repositories
    }
    
    func didFailToFetchRepositories(with error: CustomError) {
        // Error repositories
    }
}
