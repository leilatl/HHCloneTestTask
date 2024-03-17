//
//  AppCoordinator.swift
//  Epitome
//
//  Created by Leila Serebrova on 08.12.2023.
//

import SwiftUI
import UIKit

enum AppTab {
    case search
    case favorites
    case responds
    case messages
    case profile

    var title: String {
        switch self {
        case .search:
            "Поиск"
        case .favorites:
            "Избранное"
        case .responds:
            "Отклики"
        case .messages:
            "Сообщения"
        case .profile:
            "Профиль"
        }
    }

    var icon: UIImage? {
        switch self {
        case .search:
            UIImage(systemName: "magnifyingglass")
        case .favorites:
            UIImage(systemName: "heart")
        case .responds:
            UIImage(systemName: "envelope")
        case .messages:
            UIImage(systemName: "message")
        case .profile:
            UIImage(systemName: "person")
        }
    }
}

class AppCoordinator {
    private var tabBarController: UITabBarController
    let sharedVacancyProvider = VacancyProvider()
    let context = CoreDataManager.shared.mainContext
    lazy var sharedFavoriteVacanciesService = FavoriteVacanciesService(context: context)
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
        tabBarController = UITabBarController()
    }

    func start() {
        let tabs: [(AppTab, UIViewController)] = [
            (.search, entryScreen()),
            (.favorites, entryScreen()),
            (.responds, entryScreen()),
            (.messages, entryScreen()),
            (.profile, entryScreen()),
        ]

        setupTabs(tabs: tabs)

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    private func setupTabs(tabs: [(tab: AppTab, viewController: UIViewController)]) {
        let viewControllers = tabs.map { tuple -> UIViewController in
            let navController = UINavigationController(rootViewController: tuple.viewController)
            navController.tabBarItem = UITabBarItem(title: tuple.tab.title, image: tuple.tab.icon, selectedImage: nil)
            return navController
        }

        tabBarController.setViewControllers(viewControllers, animated: false)
    }

    private func entryScreen() -> UIViewController {
        let viewModel = EntryViewModel()
        let entryController = UIHostingController(rootView: EntryView(viewModel: viewModel))

        viewModel.onAction = { [weak entryController, weak self] action in
            guard let self else { return }
            switch action {
            case let .next(email):
                entryController?.navigationController?.pushViewController(
                    self.securityCodeScreen(email: email),
                    animated: true
                )
            }
        }

        return entryController
    }

    private func securityCodeScreen(email: String) -> UIViewController {
        let viewModel = SecurityCodeViewModel(email: email)
        let securityCodeController = UIHostingController(rootView: SecurityCodeView(viewModel: viewModel))

        viewModel.onAction = { [weak securityCodeController, weak self] action in
            guard let self else { return }
            switch action {
            case .next:
                let tabs: [(AppTab, UIViewController)] = [
                    (.search, self.searchScreen()),
                    (.favorites, self.favoritesScreen()),
                    (.responds, self.emptyScreen()),
                    (.messages, self.emptyScreen()),
                    (.profile, self.emptyScreen()),
                ]

                setupTabs(tabs: tabs)
            }
        }
        return securityCodeController
    }

    private func emptyScreen() -> UIViewController {
        let emptyController = UIHostingController(rootView: EmptyView())

        return emptyController
    }

    private func searchScreen() -> UIViewController {
        let viewModel = SearchViewModel(
            vacancyProvider: sharedVacancyProvider,
            favoriteVacanciesService: sharedFavoriteVacanciesService)
        let searchController = UIHostingController(rootView: SearchView(viewModel: viewModel))
        
        viewModel.onAction = { [weak searchController, weak self] (action: SearchViewModel.Event) in
            guard let self else { return }
            switch action {
            case .didChooseVacancy(let vacancy):
                searchController?.navigationController?.pushViewController(
                    self.vacancyDetailScreen(vacancy: vacancy),
                    animated: true
                )
            }
        }

        return searchController
    }
    
    private func vacancyDetailScreen(vacancy: VacancyModel) -> UIViewController {
        let viewModel = VacancyDetailViewModel(vacancy: vacancy, favoriteVacanciesService: sharedFavoriteVacanciesService)
        let vacancyDetailController = UIHostingController(rootView: VacancyDetailView(viewModel: viewModel))
        
        viewModel.onAction = { [weak vacancyDetailController, weak self] (action: VacancyDetailViewModel.Event) in
            guard let self else { return }
            switch action {
            case .goBack:
                vacancyDetailController?.navigationController?.popViewController(animated: true)
            }
        }

        return vacancyDetailController
    }

    private func favoritesScreen() -> UIViewController {
        let viewModel = FavoritesViewModel(favoriteVacanciesService: sharedFavoriteVacanciesService)
        let favoritesController = UIHostingController(rootView: FavoritesView(viewModel: viewModel))

        return favoritesController
    }
}
