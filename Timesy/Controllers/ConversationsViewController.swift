//
//  ConversationsViewController.swift
//  Timesy
//
//  Created by Tomas D. De Andrade Gomes on 6/21/23.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(<#T##UINib?#>, forCellReuseIdentifier: <#T##String#>)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        validateAuth()
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}


