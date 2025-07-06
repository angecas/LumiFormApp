//
//  ContentsFactory.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 05/07/2025.
//

import UIKit

enum ContentsFactory {
    static func makeContentsScreen(scrollState: ScrollState,
        coordinator: ContentsCoordinator
    ) -> UIViewController {
        let dataService = DataService()
        let fetchDataDataSource = FetchDataDataSource(fetchService: dataService)
        let viewModel = ContentsViewModel(fetchDataDataSource: fetchDataDataSource)
        let viewController = ContentsViewController(coordinator: coordinator, scrollState: scrollState, viewModel: viewModel)
        return viewController
    }
}
