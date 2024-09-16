
import Foundation

protocol GitHubViewModelDelegate: AnyObject {
    func didFetchUsersSuccessfully(_ users: [GitHubUserModel])
    func didFailToFetchUsers(with error: CustomError)
    func didFetchRepositoriesSuccessfully(_ repositories: [GitHubUserModel.Repository])
    func didFailToFetchRepositories(with error: CustomError)
}

class GitHubViewModel {
    private let gitHubService: GitHubServiceProtocol
    weak var delegate: GitHubViewModelDelegate?
    
    var users: [GitHubUserModel] = []
    var repositories: [GitHubUserModel.Repository] = []
    
    init(gitHubService: GitHubServiceProtocol = GitHubService()) {
        self.gitHubService = gitHubService
    }
    
    func fetchUsers() {
        gitHubService.fetchUsers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.users = users
                self.delegate?.didFetchUsersSuccessfully(users)
            case .failure(let error):
                self.delegate?.didFailToFetchUsers(with: error)
            }
        }
    }
    
    func fetchRepositories(for user: GitHubUserModel) {
        gitHubService.fetchRepositories(for: user.login) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let repositories):
                self.repositories = repositories
                self.delegate?.didFetchRepositoriesSuccessfully(repositories)
            case .failure(let error):
                self.delegate?.didFailToFetchRepositories(with: error)
            }
        }
    }
    
    func numberOfUsers() -> Int {
        return users.count
    }
    
    func user(at index: Int) -> GitHubUserModel {
        return users[index]
    }
    
    func numberOfRepositories() -> Int {
        return repositories.count
    }
    
    func repository(at index: Int) -> GitHubUserModel.Repository {
        return repositories[index]
    }
}
