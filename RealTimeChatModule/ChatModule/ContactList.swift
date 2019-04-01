
//  RealTimeChatModule

//  Copyright © 2019 TheMysteryPuzzles. All rights Given.


import UIKit
import Firebase

class ContactList: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView: UITableView!
    var UsersArr = [User]()
    var selectedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeTopAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor)
            ])
        
        self.addBackButton()
        self.fetchUsers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.view.endEditing(true)
       
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Users"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    //Downloads users list for Contacts View
    func fetchUsers()  {
        UsersArr.removeAll()
        if (Auth.auth().currentUser?.uid) != nil {
            User.downloadAllUsers(completion: {(user) in
                DispatchQueue.main.async {
                    self.UsersArr.append(user)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
           
        }
       
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UsersArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TotalUserCell", for: indexPath) as? TotalUserCell else {
            return UITableViewCell()
        }
        cell.profilePic.image = UsersArr[indexPath.row].profilePic
        cell.username.text = UsersArr[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let Chat = storyBoard.instantiateViewController(withIdentifier: "Chat") as! Chat
        Chat.currentUser = self.UsersArr[indexPath.row]
        self.navigationController?.pushViewController(Chat, animated: true)
    }
    
    
}
