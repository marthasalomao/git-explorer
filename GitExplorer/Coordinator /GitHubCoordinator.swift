
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
}

class GitHubCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = GitHubViewModel()
        let userListViewController = UserListViewController(viewModel: viewModel)
        userListViewController.coordinator = self
        navigationController.pushViewController(userListViewController, animated: true)
    }
}
