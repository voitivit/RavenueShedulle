//
//  SceneDelegate.swift
//  ExampleGraphic
//
//  Created by sot on 19.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: windowScene)
		self.window = window
		let vc1 = IncomeReports()
		let vc2 = ConsuptionReports()
		vc1.tabBarItem = UITabBarItem(title: "ДОХОД", image: UIImage(systemName: "dollarsign.circle"), tag: 0)
		vc2.tabBarItem = UITabBarItem(title: "РАСХОД", image: UIImage(systemName: "cart.fill"), tag: 1)
				// Создаем UITabBarController и связываем с ним три UIViewController
				let tabBarController = UITabBarController()
				tabBarController.viewControllers = [vc1, vc2]
	
		
		
		let rootVC = tabBarController
		window.rootViewController = rootVC
		window.makeKeyAndVisible()
	}

	func sceneDidDisconnect(_ scene: UIScene) {

	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}


}

