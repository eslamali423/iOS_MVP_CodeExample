//
//  UsersViewController.swift
//  MVP_codeExample
//
//  Created by Eslam Ali  on 23/02/2022.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]()
    
    private var presenter = Presenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Users"
        
        presenter.setDelegete(delegete: self)
        presenter.getUsers()
    }
    
    
    // table view functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let data =  self.users[indexPath.row]
        cell.textLabel?.text = data.name
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapUser(user: users[indexPath.row])
        
    }
}

extension UsersViewController : UserPresenterDelegete {
    func presentUsers(users: [User]) {
        self.users = users
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func presentAlert(title: String, message: String) {
        let alert  =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
}
