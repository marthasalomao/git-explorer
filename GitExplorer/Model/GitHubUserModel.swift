
import Foundation

struct GitHubUserModel: Codable {
    let id: Int
    let login: String
    let avatar_url: String
    let html_url: String
    
    struct Repository: Codable {
        let id: Int
        let name: String
        let description: String?
        let language: String?
    }
}
