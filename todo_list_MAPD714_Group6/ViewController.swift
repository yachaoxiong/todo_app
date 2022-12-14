//
//  ViewController.swift
//  todo_list_MAPD714_Group6
//
//  App Name: todo list
//  Course : MAPD714
//  Author : Yachao Xiong 301298033, Mingyuan Xie 301275467
//
//
//  App Revision History
//  V1.0 init app and add basic UI              -  2022-11-13
//  V1.1 added details  page UI                 -  2022-11-13
//
//  About the App
//  This app is to create tasks for the todo list.
//
//  Created by Yachao on 2022-11-13.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var listTable: UITableView!
    let todolist=[
        ["title":"Buy Food","details":"some details...","hasDueDate":true,"isFinished":false ,"dueDate":"2022-11-22"],
        ["title":"Another Task","details2":"some details...2","hasDueDate":true,"isFinished":true,"dueDate":"2022-11-22"]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listTable.dataSource = self
        listTable.delegate = self
    }

    // table rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count
    }
 
    // set data for every row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list =  todolist[indexPath.row]
        let cell =  listTable.dequeueReusableCell(withIdentifier: "cell",for:indexPath) as? todolistViewCell
        
        cell!.title.text = list["title"] as? String
        cell!.status.text = list["dueDate"] as? String
       
        
        cell!.isFinished.setOn(list["isFinished"] as? Bool ?? false, animated: true)
        cell!.isFinished.tag = indexPath.row
        
        if list["isFinished"] as! Bool {
            cell!.title.textColor = UIColor.systemGray5
            cell!.status.text = "Completed"
        }
        
        cell!.editBtn.addTarget(self, action: #selector(detailsScreen), for: .touchUpInside)
        cell!.isFinished.addTarget(self, action: #selector(updateTitle), for: .touchUpInside)
        return cell!
    }
    
    @objc func detailsScreen(){
        print("start new screen")
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(identifier: "detailsScreen") as! DetailsViewController
        self.present(controller, animated: true,completion: nil)
    }
    
     @objc func updateTitle(_ sender:UISwitch!){
            let indexPath = NSIndexPath(row: sender.tag, section: 0)
     
            let cell = listTable.cellForRow(at: indexPath as IndexPath) as! todolistViewCell
            if sender.isOn{
                cell.title.textColor = UIColor.systemGray5
                cell.status.text = "Completed"
            }else{
                cell.title.textColor = UIColor.black
                cell.status.text = todolist[sender.tag]["dueDate"] as! String
            }
    }
    
    
}

