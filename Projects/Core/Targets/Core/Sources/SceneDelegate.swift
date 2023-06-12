import RxFlow
import RxSwift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	let disposeBag = DisposeBag()
	var window: UIWindow?
	var coordinator = FlowCoordinator()
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		coordinator.rx.willNavigate
			.subscribe { flow, step in
				print("will navigate flow ~> \(flow), with step ~> \(step)")
			}.disposed(by: self.disposeBag)
		
		window = UIWindow(windowScene: windowScene)
		
		let loginFlow = LoginFlow()
		
		self.coordinator.coordinate(
			flow: loginFlow,
			with: AppStepper()
		)
		
		Flows.use(loginFlow, when: .created) { root in
			self.window?.rootViewController = root
			self.window?.makeKeyAndVisible()
		}
	}
	
	func sceneDidDisconnect(_ scene: UIScene) { }
	func sceneDidBecomeActive(_ scene: UIScene) { }
	func sceneWillResignActive(_ scene: UIScene) { }
	func sceneWillEnterForeground(_ scene: UIScene) { }
	func sceneDidEnterBackground(_ scene: UIScene) { }
	
	
}