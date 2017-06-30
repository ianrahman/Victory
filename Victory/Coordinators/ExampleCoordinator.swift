import UIKit

protocol NewRunCoordinatorDelegate: class {
    
    func newRunCoordinatorDidRequestCancel(newOrderCoordinator: NewRunCoordinator)
    func newRunCoordinator(newRunCoordinator: NewRunCoordinator, didAddOrder orderPayload: NewRunCoordinatorPayload)
    
}

final class NewRunCoordinatorPayload {
    var property: String?
}

final class NewRunCoordinator: RootViewCoordinator {
    
    // MARK: - Properties
    let services: Services
    var childCoordinators: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    weak var delegate: ExampleCoordinatorDelegate?
    
    var examplePayload: ExampleCoordinatorPayload?
    
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
