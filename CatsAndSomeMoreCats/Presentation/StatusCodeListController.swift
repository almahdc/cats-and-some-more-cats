//
//  StatusCodeListController.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import UIKit

class StatusCodeListController: UIViewController {
    // MARK: – Properties –

    private let tableView: UITableView = UITableView()
    private let twoLabelsCellReuseIdentifier = "twoLabelsCellReuseIdentifier"
    private let cellHeight = 70.0

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

        setUpTableView()
        bindViewModel()
    }
    
    // MARK: – Bind view model –

    private func bindViewModel() {
        viewModel.showCatDetails = { [unowned self] statusCode in
            let catDetailsController = CatDetailsController.make()
            present(catDetailsController, animated: true)
        }
    }
    
    
    // MARK: – Set up views –
    
    private func setUpTableView() {
        tableView.register(TwoLabelsCell.self, forCellReuseIdentifier: twoLabelsCellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "twoLabelsCellReuseIdentifier", for: indexPath)

        guard let cell = (cell as? TwoLabelsCell) else {
            fatalError("TwoLabelsCell expected")
        }

        cell.leftLabel.text = "200"
        cell.rightLabel.text = "Tap me!"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
}

// MARK: – Make –

extension StatusCodeListController {
    static func make() -> UIViewController {
        StatusCodeListController(viewModel: .init())
    }
}
