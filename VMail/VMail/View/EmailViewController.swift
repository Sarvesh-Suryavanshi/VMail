//
//  EmailViewController.swift
//  VMail
//
//  Created by Sarvesh Suryavanshi on 02/12/21.
//

import UIKit

class EmailViewController: UIViewController {
    
    // MARK: - View Properties
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundView?.backgroundColor = .orange
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(EmailCell.self, forCellReuseIdentifier: EmailCell.reuseIdentifier)
        return tableView
    }()
    
    private var filterView: FilterView = {
        let filterView = FilterView()
        return filterView
    }()
    
    private var filter: Filter = .all {
        didSet {
            self.viewModel?.setFilterType(filter: self.filter)
            self.updateContent()
        }
    }
    
    // MARK: - Properties
    
    private var viewModel: EmailViewModelProtocol?
    
    // MARK: - Lifecycle Methods
    
    init(viewModel: EmailViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.configure(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.buildUI()
        self.viewModel?.fetchEmails()
    }
}

// MARK: - Private Methods

private extension EmailViewController {
    
    func buildUI() {
        self.buildNavigationItems()
        self.buildFilterView()
        self.buildTableView()
    }
    
    @objc func didTapOnDrawer() {
        print("didTapOnDrawer")
    }
    
    @objc func didTapOnProfile() {
        print("didTapOnProfile")
    }
    
    func configure(viewModel: EmailViewModelProtocol) {
        let model = EmailModel()
        self.viewModel = viewModel
        self.viewModel?.configure(view: self, model: model)
    }
}

// MARK: - EmailView Protocol Methods

extension EmailViewController: EmailViewProtocol {
    
    func updateContent() {
        self.tableView.reloadData()
    }
}

// MARK: - FilterView Protocol Methods

extension EmailViewController: FilterViewDelegate {
    
    func didSelectOption(filter: Filter) {
        self.filter = filter
    }
}

// MARK: - UI Building Methods

private extension EmailViewController {
    
    func buildTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let listStackView = UI.VStack(childrens: [self.tableView, UI.seperator], distribution: .fill, spacing: 0.0)
        self.view.addSubview(listStackView)
        // Adding Constraints to listStackView
        listStackView.topAnchor.constraint(equalTo: self.filterView.bottomAnchor).isActive = true
        listStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        listStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        listStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    func buildFilterView() {
        self.filterView.delegate = self
        self.view.addSubview(self.filterView)
        // Adding Constraints to FilterView
        self.filterView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.filterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.filterView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.filterView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    func buildNavigationItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "hamburgerMenu"), style: .plain, target: self, action: #selector(didTapOnDrawer))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "profilePlaceholder"), style: .plain, target: self, action: #selector(didTapOnProfile))
    }
}

// MARK: - UITableView DataSource Methods

extension EmailViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.emailCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmailCell.reuseIdentifier, for: indexPath) as? EmailCell else { return UITableViewCell() }
        if let email = self.viewModel?.emails()[indexPath.row] {
            cell.configure(email: email)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel?.deleteEmail(indexPath: indexPath)
            self.updateContent()
        }
    }
}

// MARK: - UITableView Delegate Methods

extension EmailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let view = ViewBuilder.emailDetailView(),
           let email = self.viewModel?.emails()[indexPath.row] {
            view.configureForEmail(email: email)
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
}
