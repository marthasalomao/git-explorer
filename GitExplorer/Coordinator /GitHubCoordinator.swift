
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
}

final class GitHubCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = GitHubViewModel()
        let userListViewController = UserListViewController(viewModel: viewModel)
        userListViewController.delegate = self
        navigationController.pushViewController(userListViewController, animated: true)
    }
}

extension GitHubCoordinator: UserListViewControllerDelegate {
    func showUserDetails(for user: GitHubUserModel) {
        let userDetailViewController = UserDetailViewController(user: user)
        userDetailViewController.delegate = self
        navigationController.pushViewController(userDetailViewController, animated: true)
    }
}

extension GitHubCoordinator: UserDetailViewControllerDelegate {
    func showRepositories(for user: GitHubUserModel) {
        let viewModel = GitHubViewModel()
        let repositoriesViewController = RepositoriesViewController(user: user, viewModel: viewModel)
        navigationController.pushViewController(repositoriesViewController, animated: true)
    }
}
