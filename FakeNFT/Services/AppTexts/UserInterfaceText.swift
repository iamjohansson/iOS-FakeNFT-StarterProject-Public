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
    
    struct ProfileEditVC {
        static var avatarLabel: String {
            return NSLocalizedString("avatarLabel", comment: "")
        }
        static var nameEdit: String {
            return NSLocalizedString("nameEdit", comment: "")
        }
        static var descriptionEdit: String {
            return NSLocalizedString("descriptionEdit", comment: "")
        }
        static var websiteEdit: String {
            return NSLocalizedString("websiteEdit", comment: "")
        }
        static var profileUpdatedSuccessfully: String {
            return NSLocalizedString("profileUpdatedSuccessfully", comment: "")
        }
        static var error: String {
            return NSLocalizedString("error", comment: "")
        }
    }
    
    struct ProfileSortNfts {
        static var filter: String {
            return NSLocalizedString("filter", comment: "")
        }
        static var filterByPrice: String {
            return NSLocalizedString("filterByPrice", comment: "")
        }
        static var filterByRating: String {
            return NSLocalizedString("filterByRating", comment: "")
        }
        static var filterByName: String {
            return NSLocalizedString("filterByName", comment: "")
        }
        static var closeLabel: String {
            return NSLocalizedString("closeLabel", comment: "")
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
    
    struct AboutDevelopers {
        static var catalogCreator: String {
            return NSLocalizedString("catalogCreator", comment: "")
        }
        static var profileCreator: String {
            return NSLocalizedString("profileCreator", comment: "")
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
