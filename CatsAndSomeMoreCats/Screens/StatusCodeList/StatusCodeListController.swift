//
//  StatusCodeListController.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import UIKit

final class StatusCodeListController: UIViewController {
    private enum Constants {
        static let twoLabelsCellReuseIdentifier = "twoLabelsCellReuseIdentifier"
        static let cellHeight = 70.0
    }

    // MARK: – Properties –

    private let tableView: UITableView = UITableView()

    private let viewModel: StatusCodeListViewModel

    // MARK: – Init –

    private init(viewModel: StatusCodeListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Lifecycle methods –

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        setUpTableView()
    }
    
    // MARK: – Bind view model –

    private func bindViewModel() {
        viewModel.showCatDetails = { [unowned self] statusCode in
            let catDetailsController = CatDetailsController.make(statusCode: statusCode)
            present(catDetailsController, animated: true)
        }
    }
    
    // MARK: – Set up views –
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TwoLabelsCell.self, forCellReuseIdentifier: Constants.twoLabelsCellReuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
    }
}


// MARK: – UITableViewDataSource & UITableViewDelegate –

extension StatusCodeListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.twoLabelsCellReuseIdentifier, for: indexPath)
        guard let cell = (cell as? TwoLabelsCell) else {
            fatalError("TwoLabelsCell expected")
        }

        let statusCodeModel = viewModel.sections[indexPath.section]
        cell.apply(statusCodeModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(section: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
}

// MARK: – Make –

extension StatusCodeListController {
    static func make() -> UIViewController {
        StatusCodeListController(viewModel: .init())
    }
}
