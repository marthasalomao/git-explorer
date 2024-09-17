
import XCTest

@testable import GitExplorer

final class GitExplorerTests: XCTestCase {
    
    var viewModel: GitHubViewModel!
    var mockService: MockGitHubService!
    
    override func setUpWithError() throws {
        mockService = MockGitHubService()
        viewModel = GitHubViewModel(gitHubService: mockService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
    }

    func testFetchUsersSuccess() throws {
        mockService.shouldReturnError = false
        
        viewModel.fetchUsers()
        
        XCTAssertEqual(viewModel.numberOfUsers(), 2)
        XCTAssertEqual(viewModel.user(at: 0).login, "user1")
        XCTAssertEqual(viewModel.user(at: 1).login, "user2")
    }
    
    func testFetchUsersFailure() throws {
        mockService.shouldReturnError = true
        
        viewModel.fetchUsers()
        
        XCTAssertTrue(viewModel.users.isEmpty)
    }
    
    func testFetchRepositoriesSuccess() throws {
        let user = GitHubUserModel(id: 1, login: "user1", avatar_url: "", html_url: "")
        mockService.shouldReturnError = false
        
        viewModel.fetchRepositories(for: user)
        
        XCTAssertEqual(viewModel.numberOfRepositories(), 1)
        XCTAssertEqual(viewModel.repository(at: 0).name, "repo1")
    }
}
