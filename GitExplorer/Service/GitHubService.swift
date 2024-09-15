
import Foundation

protocol GitHubServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[GitHubUserModel], CustomError>) -> Void)
    func fetchRepositories(for user: String, completion: @escaping (Result<[GitHubUserModel.Repository], CustomError>) -> Void)
}

class GitHubService: GitHubServiceProtocol {
    
    func fetchUsers(completion: @escaping (Result<[GitHubUserModel], CustomError>) -> Void) {
        request(route: .users) { (result: Result<[GitHubUserModel], CustomError>) in
            completion(result)
        }
    }
    
    func fetchRepositories(for user: String, completion: @escaping (Result<[GitHubUserModel.Repository], CustomError>) -> Void) {
        request(route: .repositories(user)) { (result: Result<[GitHubUserModel.Repository], CustomError>) in
            completion(result)
        }
    }
    
    private func request<T: Codable>(route: Route, completion: @escaping (Result<T, CustomError>) -> Void) {
        var components = URLComponents()
        components.scheme = route.scheme
        components.host = route.host
        components.path = route.path
        components.queryItems = route.queryItems
        
        guard let url = components.url else {
            completion(.failure(.network))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = route.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.network))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(.failure(.api))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(.parse))
            }
        }
        
        dataTask.resume()
    }
}

extension GitHubService {
    enum Route {
        case users
        case repositories(String)
        
        var scheme: String {
            return "https"
        }
        
        var host: String {
            return "api.github.com"
        }
        
        var path: String {
            switch self {
            case .users:
                return "/users"
            case .repositories(let user):
                return "/users/\(user)/repos"
            }
        }
        
        var queryItems: [URLQueryItem]? {
            return nil
        }
        
        var method: String {
            return "GET"
        }
    }
}
