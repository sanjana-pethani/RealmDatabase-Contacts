//
//  ViewController.swift
//  RealmDatabase Contacts
//
//  Created by sanjana pethani on 03/08/23.
//

import UIKit
import RealmSwift


class ViewController: UIViewController {

    
    @IBOutlet weak var ContactTabelView: UITableView!
    
    var  contactArray = [contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
    
    }


    @IBAction func AddButoon(_ sender: UIBarButtonItem) {
        
        contactConfiguration(isAdd: true, index: 0)

    }
}

extension ViewController {
    func configuration() {
        ContactTabelView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        contactArray = DataBase.shared.getAllcontacts()
    }
    
    func contactConfiguration(isAdd: Bool, index: Int) {
        let aleratcontroller = UIAlertController(title: isAdd ? "Add Contact" : "update Contact", message: isAdd ? "Enter youre contact": "please update your contact deteils", preferredStyle: .alert)
        let save = UIAlertAction(title: isAdd ? "save": "upadate", style: .default) { _ in
            
            if let firstName = aleratcontroller.textFields?.first?.text,
               let lastName = aleratcontroller.textFields?[1].text {
               let contact = contact(firstName: firstName, lastName: lastName)
                
                if isAdd {
                    self.contactArray.append(contact)
                    DataBase.shared.saveContact(contact: contact)
                } else {
                    self.contactArray[index] = contact
                }
               
                self.ContactTabelView.reloadData()
            }
        }
        let cancel = UIAlertAction(title: "cancel ", style: .cancel,handler: nil)
        
        aleratcontroller.addTextField { firstnameField in
            firstnameField.placeholder = isAdd ? "Enter your fistName" : self.contactArray[index].firstName
        }
        
        aleratcontroller.addTextField { lastnameField in
           lastnameField.placeholder = isAdd ? "Enter your lastName" : self.contactArray[index].lastName
            
        }
        
        aleratcontroller.addAction(save)
        aleratcontroller.addAction(cancel)
        
        present(aleratcontroller,animated: true)
        
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = contactArray[indexPath.row].firstName
        cell.detailTextLabel?.text = contactArray[indexPath.row].lastName
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let Update = UIContextualAction(style: .normal, title: "Update") { _, _, _ in
            
            self.contactConfiguration(isAdd: true, index: indexPath.row)
        }
        Update.backgroundColor = .systemCyan
        let delet = UIContextualAction(style: .destructive, title: "delet") {  _, _, _ in
            DataBase.shared.deletContact(contact: self.contactArray[indexPath.row])
            self.contactArray.remove(at: indexPath.row)
            self.ContactTabelView.reloadData()
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [Update , delet])
        return swipeConfiguration
    }
}

