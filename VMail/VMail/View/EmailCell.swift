//
//  EmailCell.swift
//  VMail
//
//  Created by Sarvesh Suryavanshi on 03/12/21.
//

import UIKit

class EmailCell: UITableViewCell {
    
    static let reuseIdentifier = "EmailCell"
    
    // MARK: - Life Cycle Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.buildUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Methods
    
    private func buildUI() {
        
        let profileStackView = UI.VStack(childrens: [self.profileImageView, UI.spacer], distribution: .fill, spacing: 5.0)
        profileStackView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        let name_time_stackView = UI.HStack(childrens: [self.senderLbl, self.timeLbl], distribution: .fill, spacing: 5.0)
        let subject_statusIcon_stackView = UI.HStack(childrens: [self.subjectLbl, self.statusIcon], distribution: .fill, spacing: 5.0)
        
        self.attachmentStackView.addArrangedSubview(self.attachment)
        self.attachmentStackView.addArrangedSubview(UI.spacer)
        
        let detailsStack = UI.VStack(childrens: [name_time_stackView, subject_statusIcon_stackView, self.bodyLabel, self.attachmentStackView], distribution: .fill, spacing: 5.0)
        
        let containerStack = UI.HStack(childrens: [profileStackView, detailsStack], distribution: .fillProportionally, spacing: 5.0)
        self.contentView.addSubview(containerStack)
        containerStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        containerStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        containerStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        containerStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15).isActive = true
    }
    
    // MARK: - Configuration Method
    
    func configure(email: Email) {
        
        self.senderLbl.text = email.senderName
        self.timeLbl.text = email.time
        self.subjectLbl.text = email.subject
        self.bodyLabel.text = email.body
        
        if let profileImage = UIImage(named: email.profileImage) {
            self.profileImageView.image = profileImage
        } else {
            self.profileImageView.image = UIImage(named: "profilePlaceholder")
        }
        
        if let statusImage = UIImage(named: email.isFavourite ? "star_filled" : (email.isMarked ? "marker" : "")) {
            self.statusIcon.image = statusImage
        }
        
        if email.hasAttachment {
            self.attachment.setTitle("\(email.attachmentName)", for: .normal)
            self.attachment.setImage(UIImage(named: "fileAttachment"), for: .normal)
            self.attachmentStackView.isHidden = false
        }
    }
    
    // MARK: - Private UI Builder Extension
    
    var senderLbl: UILabel = {
        let senderNameLabel = UILabel()
        senderNameLabel.textColor = .black
        senderNameLabel.numberOfLines = 1
        return senderNameLabel
    }()
    
    var subjectLbl: UILabel = {
        let subjectLbl = UILabel()
        subjectLbl.textColor = .black
        subjectLbl.font = UIFont.boldSystemFont(ofSize: 18)
        subjectLbl.numberOfLines = 1
        return subjectLbl
    }()
    
    var timeLbl: UILabel = {
        let timeLbl = UILabel()
        timeLbl.textColor = .lightGray
        timeLbl.textAlignment = .center
        timeLbl.font = UIFont.systemFont(ofSize: 12, weight: .light)
        timeLbl.widthAnchor.constraint(equalToConstant: 80).isActive = true
        timeLbl.numberOfLines = 1
        return timeLbl
    }()
    
    var bodyLabel: UILabel = {
        let bodyLabel = UILabel()
        bodyLabel.textColor = .lightGray
        bodyLabel.textAlignment = .left
        bodyLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        bodyLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        bodyLabel.numberOfLines = 2
        return bodyLabel
    }()
    
    var attachment: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.buttonSize = .small
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .label
        config.imagePlacement = .leading
        config.imagePadding = 5.0
        let attachment = UIButton(configuration: config, primaryAction: nil)
        return attachment
    }()
    
    var attachmentStackView: UIStackView = {
        let attachmentStackView = UI.HStack(distribution: .equalSpacing, spacing: 5.0)
        attachmentStackView.isHidden = true
        return attachmentStackView
    }()
    
    var statusIcon: UIImageView = {
        let statusIconView = UIImageView()
        statusIconView.contentMode = .center
        statusIconView.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        return statusIconView
    }()
    
    var profileImageView: UIImageView = {
        let profileImageView = UIImageView(image: UIImage(named: "profilePlaceholder"))
        profileImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return profileImageView
    }()
}
