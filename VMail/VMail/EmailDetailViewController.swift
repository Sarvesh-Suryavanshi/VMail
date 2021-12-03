//
//  EmailDetailViewController.swift
//  VMail
//
//  Created by Sarvesh Suryavanshi on 03/12/21.
//

import UIKit

class EmailDetailViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet weak var emailSubjectLbl: UILabel!
    @IBOutlet weak var senderNameLbl: UILabel!
    @IBOutlet weak var senderEmailLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var emailBody: UITextView!
    
    // MARK: - Properties

    private var email: Email?

    // MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Configuration Methods

    func configureForEmail(email: Email) {
        self.email = email
    }
    
    // MARK: - Private Methods

    private func setupUI() {
        if let email = email {
            self.emailSubjectLbl.text = email.subject
            self.senderNameLbl.text = email.senderName
            self.senderEmailLbl.text = email.senderEmailID
            self.emailBody.text = email.body
            if let profileImage = UIImage(named: email.profileImage) {
                self.profileImage.image = profileImage
            } else {
                self.profileImage.image = UIImage(named: "profilePlaceholder")
            }
            
            if let statusImage = UIImage(named: email.isFavourite ? "star_filled" : (email.isMarked ? "marker" : "")) {
                self.statusImageView.image  = statusImage
            }
        }
    }
}
