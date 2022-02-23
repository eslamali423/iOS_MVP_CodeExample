//
//  presenter.swift
//  MVP_codeExample
//
//  Created by Eslam Ali  on 23/02/2022.
//

import Foundation

protocol UserPresenterDelegete : AnyObject {
    func presentUsers(users : [User])
    func presentAlert(title : String, message :  String)
    
}



class Presenter {
    
    var delegete : UserPresenterDelegete?

    func setDelegete(delegete : UserPresenterDelegete)  {
        self.delegete = delegete
    }
 
    public func getUsers (){
        guard let url  =  URL(string: "https://jsonplaceholder.typicode.com/users") else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self ]data, _ , error in
            guard let data =  data , error == nil else {
                return
            }
            do{
                let users =  try JSONDecoder().decode([User].self, from: data )
                self?.delegete?.presentUsers(users: users)
            }catch{
                print (error)
            }
        }
        task.resume()
    }
    
    public func didTapUser(user : User){
        delegete?.presentAlert(title: user.name, message: "\(user.name) has Email : \(user.email) and UserNamr: \(user.username)")
    }
    
}
