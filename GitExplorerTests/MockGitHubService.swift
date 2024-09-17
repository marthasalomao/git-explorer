
import Foundation

@testable import GitExplorer

class MockGitHubService: GitHubServiceProtocol {
    
    var shouldReturnError = false
    
    func fetchUsers(completion: @escaping (Result<[GitHubUserModel], CustomError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.network))
        } else {
            let users = [
                GitHubUserModel(id: 1, login: "user1", avatar_url: "", html_url: ""),
                GitHubUserModel(id: 2, login: "user2", avatar_url: "", html_url: "")
            ]
            completion(.success(users))
        }
    }
    
    func fetchRepositories(for user: String, completion: @escaping (Result<[GitHubUserModel.Repository], CustomError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.api))
        } else {
            let repositories = [
                GitHubUserModel.Repository(id: 1, name: "repo1", description: "description", language: "Swift")
            ]
            completion(.success(repositories))
        }
    }
}

