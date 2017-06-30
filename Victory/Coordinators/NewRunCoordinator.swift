import UIKit

protocol NewRunCoordinatorDelegate: class {
    
    func newRunCoordinatorDidRequestCancel(newRunCoordinator: NewRunCoordinator)
    func newRunCoordinator(newRunCoordinator: NewRunCoordinator, didAddRun runPayload: NewRunCoordinatorPayload)
    
}

final class NewRunCoordinatorPayload {
    var run: Run?
}

final class NewRunCoordinator: RootViewCoordinator {
    
    // MARK: - Properties
    
    let services: Services
    var childCoordinators: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    weak var delegate: RunCoordinatorDelegate?
    
    var payload: RunCoordinatorPayload?
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    // MARK: - Init
    
    init(with services: Services) {
        self.services = services
    }
    
    // MARK: - Functions
    
    func start() {
        let viewController = ViewController(services: self.services)
        viewController.delegate = self
        self.navigationController.viewControllers = [viewController]
    }
    
    func showViewController() {
        let viewController = ViewController(services: self.services)
        viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - ViewControllerDelegate

extension NewRunCoordinator: ViewControllerDelegate {
    
    func viewControllerDidLoad(viewController: ViewController) {
        print("View Controller Did Load")
    }
    
}
