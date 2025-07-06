//
//  ContentsViewController.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 05/07/2025.
//

import UIKit
import SwiftUI
import Combine

class ContentsViewController: UIViewController {
    
    private var hostingController: UIHostingController<AnyView>?
    private weak var coordinator: ContentsCoordinator?
    private var cancellables = Set<AnyCancellable>()
    private var scrollState: ScrollState
    private let viewModel: ContentsViewModel

    init(coordinator: ContentsCoordinator, scrollState: ScrollState, viewModel: ContentsViewModel) {
        self.scrollState = scrollState
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        Task {
            do {
                try await viewModel.fetchData()
            } catch {
                DispatchQueue.main.async {
                    self.coordinator?.showToaster()
                }
            }
        }
        
        bindViewModel()

    }

    private func bindViewModel() {
        viewModel.$contents
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.hostingController?.rootView = AnyView(ContentsRootView(action: { [weak self] tappedId in
                    self?.scrollState.scrollToId = tappedId
                    if let tabBar = self?.tabBarController {
                        tabBar.selectedIndex = 0
                    }
                }, scrollItem: items)                .environmentObject(self?.scrollState ?? ScrollState())) 
            }
            .store(in: &cancellables)
    }

    private func setupLayout() {
        view.backgroundColor = .white

        let hostingVC = UIHostingController(
            rootView: AnyView(
                ContentsRootView(action: { [weak self] tappedId in
                    self?.scrollState.scrollToId = tappedId
                    if let tabBar = self?.tabBarController {
                        tabBar.selectedIndex = 0
                    }
                }, scrollItem: viewModel.contents)
                    .environmentObject(self.scrollState)
            )
        )

        self.hostingController = hostingVC

        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hostingVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        hostingVC.didMove(toParent: self)
    }
}
