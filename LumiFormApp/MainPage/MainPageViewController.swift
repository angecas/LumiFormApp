//
//  MainPageViewController.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 04/07/2025.
//

import UIKit
import SwiftUI
import Combine

class MainPageViewController: UIViewController {
    
    private var hostingController: UIHostingController<AnyView>?
    private let viewModel: MainPageViewModel
    private weak var coordinator: MainPageCoordinator?
    private var cancellables = Set<AnyCancellable>()
    private let scrollState: ScrollState

    init(viewModel: MainPageViewModel, coordinator: MainPageCoordinator, scrollState: ScrollState) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.scrollState = scrollState
        
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
        viewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.hostingController?.rootView = AnyView(MainPageRootView(
                    item: self?.viewModel.items,
                    action: { [weak self] item in
                        self?.coordinator?.showQuestionImage(item: item)
                    }
                )
                .environmentObject(self?.scrollState ?? ScrollState()))
            }
            .store(in: &cancellables)
    }


    private func setupLayout() {
        view.backgroundColor = .white

        let hostingVC = UIHostingController(
            rootView: AnyView(MainPageRootView(
                item: viewModel.items,
                action: { [weak self] item in
                    self?.coordinator?.showQuestionImage(item: item)
                }
            )
            .environmentObject(self.scrollState)
        ))

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
