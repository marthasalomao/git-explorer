
import UIKit

final class RepositoriesViewController: UIViewController {
    
    private let user: GitHubUserModel
    private var viewModel: GitHubViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(user: GitHubUserModel, viewModel: GitHubViewModel) {
        self.user = user
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(user.login)'s repositories"
        view.backgroundColor = .white
        
        viewModel.delegate = self
        setupTableView()
        setupConstraints()
        
        viewModel.fetchRepositories(for: user)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier)
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
}

extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRepositories()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.reuseIdentifier, for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        let repository = viewModel.repository(at: indexPath.row)
        cell.configure(with: repository)
        cell.selectionStyle = .none
        return cell
    }
}

extension RepositoriesViewController: GitHubViewModelDelegate {
    func didFetchRepositoriesSuccessfully(_ repositories: [GitHubUserModel.Repository]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailToFetchRepositories(with error: CustomError) {
        print("Error fetching repositories: \(error)")
        // Show Alert
    }
    
    func didFetchUsersSuccessfully(_ users: [GitHubUserModel]) {
        // Fetch success
    }
    
    func didFailToFetchUsers(with error: CustomError) {
        // Fetch error
    }
}

