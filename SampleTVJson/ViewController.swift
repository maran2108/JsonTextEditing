//
//  ViewController.swift
//  SampleTVJson
//
//  Created by Rifluxyss on 20/02/23.
//

import UIKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var x = [AllData]()
    
    @IBOutlet weak var myEditBtn: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        JSDownload {
            print("finished")
            self.myTableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return x.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "t1") as! TVC
       
        cell.id_Lbl.text = String(x[indexPath.row].id)
        
        cell.name_text.text = x[indexPath.row].name
        cell.name_text.isEnabled = myTableView.isEditing
        
        cell.phone_text.text = x[indexPath.row].phone
        cell.phone_text.isEnabled = myTableView.isEditing
        
        cell.email_text.text = x[indexPath.row].email
        cell.email_text.isEnabled = myTableView.isEditing
        print("-------------------->",myTableView.visibleCells.count,"<-----------------------")
        return cell
    }
    @IBAction func editAndSave(_ sender: UIButton) {
        myTableView.isEditing = !myTableView.isEditing
        
        switch myTableView.isEditing{
        case true:
            print("---------------->",myTableView.isEditing)
            myEditBtn.setTitle("save", for: .normal)
            
        case false:
            print("---------------->",myTableView.isEditing)
            myEditBtn.setTitle("edit", for: .normal)
        }
        myEditBtn.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
    }
    @objc func buttonTapped(sender: UIButton){
        
        myTableView.visibleCells.forEach { cell  in
            guard let cell = cell as? TVC else {
                return
            }
            cell.name_text.isEnabled = myTableView.isEditing
            cell.phone_text.isEnabled = myTableView.isEditing
            cell.email_text.isEnabled = myTableView.isEditing
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let z = AllData(id: indexPath.row + 2, name: "", email: "", phone: "")
        let addRow = UIContextualAction(style: .normal, title: "+ add-Row") { _, _, _ in
            self.x.insert(z, at: indexPath.row)
            self.myTableView.insertRows(at: [indexPath], with: .fade)
            print("---->Row Added<------")
        }
        addRow.backgroundColor = .green
        let swipe = UISwipeActionsConfiguration(actions: [addRow])
        return swipe
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteRow = UIContextualAction(style: .destructive, title: "- delete") { _, _, _ in
            self.x.remove(at: indexPath.row)
            self.myTableView.deleteRows(at: [indexPath], with: .fade)
            print("---->deleted<------")
        }
        let swipe = UISwipeActionsConfiguration(actions: [deleteRow])
        return swipe
    }
    // re-order
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let i = x[sourceIndexPath.row]
        x.remove(at: sourceIndexPath.row)
        x.insert(i, at: destinationIndexPath.row)
    }
    func JSDownload(completed: @escaping () -> ()){
        let url = URL(string: "https://jsonplaceholder.typicode.com/users#")
        URLSession.shared.dataTask(with: url!) { data, _, error in
            if let data = data {
                do{
                    self.x = try JSONDecoder().decode([AllData].self, from: data)
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch {
                    print("json error")
                }
            }
        }.resume()
    }
}





