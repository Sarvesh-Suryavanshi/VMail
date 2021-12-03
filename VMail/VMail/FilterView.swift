//
//  FilterView.swift
//  VMail
//
//  Created by Sarvesh Suryavanshi on 02/12/21.
//

import UIKit


enum Filter: Int, CaseIterable {
    
    case all
    case social
    case promotion
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case .social:
            return "Social"
        case .promotion:
            return "Promotion"
        }
    }
}

protocol FilterViewDelegate: AnyObject {
    func didSelectOption(filter: Filter)
}

class FilterView: UIStackView {

    weak var delegate: FilterViewDelegate?
    private lazy var filterOptions: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.buildUI()
    }
    
    private func buildUI() {
        
        self.axis = .vertical
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let allOption = Button(title: Filter.all.title, tag: Filter.all.rawValue)
        allOption.isSelected = true
        let socialOption = Button(title: Filter.social.title, tag: Filter.social.rawValue)
        let promotionsOption = Button(title: Filter.promotion.title, tag: Filter.promotion.rawValue)
        
        filterOptions = [allOption, socialOption, promotionsOption]
        
        filterOptions.forEach { option in
            option.addTarget(self, action: #selector(self.didSelectOption(sender:)), for: .touchUpInside)
        }
        
        let hStack = UI.HStack(childrens: filterOptions, distribution: .fillProportionally, spacing: 0.0)
        self.addArrangedSubview(hStack)
        self.addArrangedSubview(UI.seperator)
    }
    
    @objc private func didSelectOption(sender: UIButton) {
        if let selectedFilter = Filter(rawValue: sender.tag) {
            self.filterOptions.forEach { option in option.isSelected = (option == sender) }
            self.delegate?.didSelectOption(filter: selectedFilter)
        }
    }
}
