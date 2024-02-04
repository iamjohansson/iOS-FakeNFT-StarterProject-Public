import UIKit

final class TabBarController: UITabBarController {
    
    let appConfiguration: AppConfiguration
    
    init(appConfiguration: AppConfiguration) {
        self.appConfiguration = appConfiguration
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.appConfiguration = AppConfiguration()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let profileNC = UINavigationController(
            rootViewController: appConfiguration.profileViewControlle)
        profileNC.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Tab.profile", comment: ""),
            image: UIImage(named: "profileBar"),
            selectedImage: nil
        )

        let catalogNC = UINavigationController(
            rootViewController: appConfiguration.catalogViewController)
        catalogNC.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Tab.catalog", comment: ""),
            image: UIImage(named:"catalogBar"),
            tag: 0
        )
        
        viewControllers = [profileNC, catalogNC]
        
        tabBar.isTranslucent = false
        view.tintColor = .ypBlueUn
        tabBar.backgroundColor = .ypWhite
        tabBar.unselectedItemTintColor = .ypBlack
        tabBar.tintColor = .ypBlack
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .ypWhite
            appearance.shadowColor = nil
            appearance.stackedLayoutAppearance.normal.iconColor = .ypBlack
            appearance.stackedLayoutAppearance.selected.iconColor = .ypBlueUn
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
