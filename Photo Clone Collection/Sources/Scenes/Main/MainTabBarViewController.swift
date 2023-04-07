//
//  MainTabBarViewContoller.swift
//  Photo Clone Collection
//
//  Created by Victor Garitskyu on 30.01.2023.
//

import UIKit
import SnapKit

import SnapKit
import UIKit


final class MainTabBarViewController: UITabBarController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupTabBarControllers()
        loadAlbumsData()
    }
    
    // MARK: - Setups
    
    private func setupAppearance() {
        tabBar.backgroundColor = .white
    }
    
    private func setupTabBarControllers() {
        viewControllers = [controllerWithTabBarItem(AllPhotosViewController(),
                                                    title: "All Photos",
                                                    image: "photo.fill.on.rectangle.fill"),
                           controllerWithTabBarItem(ForYouViewController(),
                                                    title: "For You",
                                                    image: "heart.text.square.fill"),
                           controllerWithTabBarItem(AlbumsViewController(),
                                                    title: "Albums",
                                                    image: "rectangle.stack.fill"),
                           controllerWithTabBarItem(SearchViewController(),
                                                    title: "Search",
                                                    image: "magnifyingglass")]
        
        selectedViewController = viewControllers?[2]
    }
    
    private func loadAlbumsData() {
        PhotosDataManager.fetchImages()
    }
    
    private func controllerWithTabBarItem(_ controller: UIViewController, title: String, image: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.backgroundColor = .white
        controller.view.backgroundColor = .white
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: image)
        return navigationController
    }
}
