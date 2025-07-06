//
//  SearchFactory.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 05/07/2025.
//

import UIKit

enum MainViewControllerFactory {
    static func makeMainViewScreen(scrollState: ScrollState, coordinator: MainPageCoordinator) -> UIViewController {
        let dataService = DataService()
        let fetchDataDataSource = FetchDataDataSource(fetchService: dataService)
        let viewModel = MainPageViewModel(fetchDataDataSource: fetchDataDataSource)
        let viewController = MainPageViewController(viewModel: viewModel, coordinator: coordinator, scrollState: scrollState)
        return viewController
    }
}
