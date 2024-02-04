//
//  UserInterfaceText.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 15.01.24.
//

import Foundation

struct AppStrings {
    
    struct TabBarController {
        static var profileTabBarTitle: String {
            return NSLocalizedString("Tab.profile", comment: "")
        }
        static var catalogTabBarTitle: String {
            return NSLocalizedString("Tab.catalog", comment: "")
        }
        static var cartTabBarTitle: String {
            return NSLocalizedString("Tab.cart", comment: "")
        }
        static var statisticTabBarTitle: String {
            return NSLocalizedString("Tab.statistics", comment: "")
        }
    }
    
    struct ProfileButtons {
        static var myNFTLabel: String {
            return NSLocalizedString("myNFTLabel", comment: "")
        }
        static var favoritesNFTLabel: String {
            return NSLocalizedString("favoritesNFTLabel", comment: "")
        }
        static var aboutDeveloperLabel: String {
            return NSLocalizedString("aboutDeveloperLabel", comment: "")
        }
    }
    
    struct CatalogVC {
        static var sorting: String {
            return NSLocalizedString("catalogSorting", comment: "")
        }
        static var sortByName: String {
            return NSLocalizedString("catalogSortByName", comment: "")
        }
        static var sortByNFTCount: String {
            return NSLocalizedString("catalogSortByNFTCount", comment: "")
        }
        static var close: String {
            return NSLocalizedString("catalogClose", comment: "")
        }
    }
    
    struct CollectionVC {
        static var authorInfo: String {
            return NSLocalizedString("AboutAuthor", comment: "")
        }
    }
    
    struct MyNftsPrice {
        static var nftPrice: String {
            return NSLocalizedString("priceNamePlaceholder", comment: "")
        }
    }
    
    struct Prepositions {
        static var prepositionFrom: String {
            return NSLocalizedString("from", comment: "")
        }
        
    }
}
