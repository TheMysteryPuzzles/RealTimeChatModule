
//  RealTimeChatModule

//  Copyright © 2019 TheMysteryPuzzles. All rights Given.


import UIKit
import Firebase

class ChatModuleViewController: UIViewController {
    
    var tableView: UITableView!
    var items = [Conversation]()
    var selectedUser: User?
    override func viewDidLoad() {
       super.viewDidLoad()
       self.title = "Chats"
       self.tableView = UITableView()
       self.tableView.translatesAutoresizingMaskIntoConstraints = false
       
       self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
             self.tableView.topAnchor.constraint(equalTo: self.view.safeTopAnchor),
             self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
             self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
             self.tableView.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor)
        ])
        
       tableView.delegate = self
       tableView.dataSource = self
         navigationItem.setRightBarButton(UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(handleNewConversation)), animated: false)
        self.fetchData()
    
    }
    
    func addNewContactsForLoggedInUser(contacts: [User]){
        let currentUserUid = UserDefaults.standard.string(forKey: "currentUser")
        var newContacts = [String:Any]()
        for contact in contacts {
            newContacts[contact.id] = true
        }
        Database.database().reference(fromURL: realTimeDataBaseReference).child("users/\(currentUserUid!)").child("Contacts").updateChildValues(newContacts)
    }
    
    
    @objc private func handleNewConversation(){
      print("Hello")
    }
    //Downloading conversations
    func fetchData() {
        Conversation.showConversations { (conversations) in
            self.items = conversations
            self.items.sort{ $0.lastMessage.timestamp > $1.lastMessage.timestamp }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                for conversation in self.items {
                    if conversation.lastMessage.isRead == false {
                        break
                    }
                }
            }
        }
    }//Downloading conversations
   
    
}
extension ChatModuleViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as? ConversationCell else{
            return UITableViewCell()
        }
        cell.profilePIc.image = self.items[indexPath.row].user.profilePic
        cell.Username.text = self.items[indexPath.row].user.name
        let messageDate = Date.init(timeIntervalSince1970: TimeInterval(self.items[indexPath.row].lastMessage.timestamp))
        let dataformatter = DateFormatter.init()
        dataformatter.timeStyle = .short
        let date = dataformatter.string(from: messageDate)
        cell.timeStamp.text = date
        switch self.items[indexPath.row].lastMessage.type {
        case .text:
            let message = self.items[indexPath.row].lastMessage.content as! String
            cell.lastMessage.text = message
        
        default:
            cell.lastMessage.text = "Media"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVc = Chat()
        chatVc.currentUser = self.items[indexPath.row].user
        DispatchQueue.main.async {
             self.navigationController?.pushViewController(chatVc, animated: true)
        }
      
    }
    
    
}
