//
//  DashboradViewController.swift
//  Worklist
//
//  Created by Reetesh Kumar on 10/23/18.
//  Copyright © 2018 Reetesh Kumar. All rights reserved.
//

import UIKit
import JJFloatingActionButton
import iCarousel

extension UILabel {
    func setLabelColor() {
        self.font = UIFont.boldSystemFont(ofSize: 25)
        self.textColor = UIColor.yellow
    }
}

class Task {
    
    let taskId: Int, taskName: String, taskDescription: String, taskDueDate: String, taskPriority: String
    
    init(taskId: Int, taskName: String, taskDescription: String, taskDueDate: String, taskPriority: String) {
        self.taskId = taskId
        self.taskName = taskName
        self.taskDescription = taskDescription
        self.taskDueDate = taskDueDate
        self.taskPriority = taskPriority
    }
}

class Approvals {
    
    let approvalId: Int, approvalName: String, approvalDescription: String, approvalDueDate: String, approvalPriority: String, autoApprovalDate: String
    
    init(approvalId: Int, approvalName: String, approvalDescription: String, approvalDueDate: String, approvalPriority: String, autoApprovalDate: String ) {
        self.approvalId = approvalId
        self.approvalName = approvalName
        self.approvalDescription = approvalDescription
        self.approvalDueDate = approvalDueDate
        self.approvalPriority = approvalPriority
        self.autoApprovalDate = autoApprovalDate
    }
}

class DashboardViewController: UIViewController, iCarouselDataSource, iCarouselDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var lblTaskPending: UILabel?
    @IBOutlet weak var lblApprovalsWaiting: UILabel?
    @IBOutlet var carousel: iCarousel!
    var approvalTableView:UITableView = UITableView()
    
    var actionMenuButton = JJFloatingActionButton()
    
    //var items: [Int] = []
    
    let taskArray = [
        Task(taskId: 101, taskName: "My Goal", taskDescription: "Fill in G&O" , taskDueDate: "Due on 20 June 18", taskPriority: "High" ),
        Task(taskId: 102, taskName: "My Time", taskDescription: "Update Efforts" , taskDueDate: "Due on 23 June 18", taskPriority: "Medium" ),
        Task(taskId: 103, taskName: "My Career", taskDescription: "Submit your Appraisal" , taskDueDate: "Due on 20 June 18", taskPriority: "High" ),
        Task(taskId: 104, taskName: "My Financial", taskDescription: "Financial Declaration" , taskDueDate: "Due on 20 April 18", taskPriority: "Medium" ),
        Task(taskId: 105, taskName: "My Learning", taskDescription: "Plan your Skills" , taskDueDate: "Due on 20 June 18", taskPriority: "Medium" ),
        Task(taskId: 106, taskName: "My Travel", taskDescription: "Create Travel Request" , taskDueDate: "Due on 20 June 18", taskPriority: "Medium" )
    ]
    
    let approvalArray = [
        Approvals(approvalId: 201, approvalName: "My Time - Annual Leave", approvalDescription: "Will be auto approved on", approvalDueDate: "8:30 PM 23 June 2018", approvalPriority: "High", autoApprovalDate: "8:30 PM 23 June 2018"),
        Approvals(approvalId: 202, approvalName: "My Financial - Declaration", approvalDescription: "Due", approvalDueDate: "Due on 7:30 PM 23 June 2018", approvalPriority: "High", autoApprovalDate: "8:30 PM 23 June 2018")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lblTaskPending?.text = String(142)
        lblTaskPending?.setLabelColor()
        lblApprovalsWaiting?.text = String(109)
        lblApprovalsWaiting?.setLabelColor()
        
        approvalTableView.frame = CGRect(x: 5, y: 420, width: view.frame.width-10, height: 150)
        //approvalTableView.layer.borderColor = UIColor.gray.cgColor
        
        approvalTableView.backgroundColor = .white
        approvalTableView.layer.shadowColor = UIColor.lightGray.cgColor
        approvalTableView.layer.shadowOpacity = 0.5
        approvalTableView.layer.shadowOffset = CGSize.zero
        approvalTableView.layer.shadowRadius = 2
        approvalTableView.layer.cornerRadius = 5
        approvalTableView.layer.borderWidth = 0.5
        self.view.addSubview(approvalTableView)
        approvalTableView.dataSource = self
        approvalTableView.delegate = self
        
        carousel.type = .linear
        carousel.delegate = self
        carousel.dataSource = self
        
        self.showActionMenuButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     Helper to Switch the View based on StoryBoard
     @param StoryBoard ID  as String
     */
    func switchToViewController(identifier: String) {
        //let storyboard = UIStoryboard(name: "MyStoryboardName", bundle: nil)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        self.present(viewController!, animated: true, completion: nil)
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
         return taskArray.count
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        print("index=",index)
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var label_name: UILabel
        var label_desc: UILabel
        var label_duedate: UILabel
        var button_priority: UIButton
        
        let screenSize: CGRect = UIScreen.main.bounds
        let tileView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width/3, height: 150))
        tileView.backgroundColor = .white
        
        tileView.layer.shadowColor = UIColor.black.cgColor
        tileView.layer.shadowOpacity = 0.5
        tileView.layer.shadowOffset = CGSize.zero
        tileView.layer.shadowRadius = 2
        tileView.layer.cornerRadius = 5
        tileView.contentMode = .center
        
        let labelFrame = CGRect(x: 0, y: 10, width: screenSize.width/3-10, height: 20.0)
        label_name = UILabel(frame: labelFrame)
        label_name.text = taskArray[index].taskName
        label_name.textColor = .black
        label_name.textAlignment = .center
        tileView.addSubview(label_name)
        
        label_desc = UILabel(frame: CGRect(x: 0, y: 35, width: screenSize.width/3-10, height: 20.0))
        label_desc.text = taskArray[index].taskDescription
        label_desc.textColor = .gray
        label_desc.font = label_desc.font.withSize(12)
        label_desc.textAlignment = .center
        tileView.addSubview(label_desc)
        
        label_duedate = UILabel(frame: CGRect(x: 0, y: 70, width: screenSize.width/3-10, height: 20.0))
        label_duedate.text = taskArray[index].taskDueDate
        label_duedate.textColor = .gray
        label_duedate.font = label_duedate.font.withSize(10)
        label_duedate.textAlignment = .center
        tileView.addSubview(label_duedate)
        
        let separatorView = UIView(frame: CGRect(x: 0, y: 100, width: screenSize.width/3, height: 0.5))
        separatorView.backgroundColor = .gray
        tileView.addSubview(separatorView)
        
        button_priority = UIButton(frame: CGRect(x: 0, y: 110, width: 70, height: 30))
        button_priority.setImage(UIImage(named: "medium-icon"), for: .normal)
        button_priority.center.x = tileView.center.x
        //button_priority.center = true
        //button_priority.imageView = UIImage(named: "medium-icon")
        tileView.addSubview(button_priority)
        
        return tileView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return approvalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        }
        if self.approvalArray.count > 0 {
            cell?.textLabel!.text = self.approvalArray[indexPath.row].approvalName
            cell?.imageView?.image = UIImage(named: "clarification-b-button")
            cell?.accessoryView = UIImageView(image:UIImage(named:"medium-icon")!)
            cell?.detailTextLabel?.text = self.approvalArray[indexPath.row].approvalDueDate
        }
        cell?.textLabel?.numberOfLines = 3
        
        return cell!
    }
    
    func showActionMenuButton() {
        
        //fileprivate let actionMenuButton = JJFloatingActionButton()
        //let actionMenuButton = JJFloatingActionButton()
        
        self.setActionMenuButtonToDeafult()
        
        actionMenuButton.addTarget(self, action: #selector(self.actionMenuButtonTapped(_:)), for:.touchUpInside)
        
        let item1 = actionMenuButton.addItem()
        //item1.titleLabel.text = "Item1"
        item1.imageView.image = UIImage(named: "task-button-icon-s")
        item1.buttonColor = UIColor(red: 28/255, green: 38/255, blue: 99/255, alpha: 1.0)
        item1.action = { item in
                self.setActionMenuButtonToDeafult()
                Helper.showAlert(for: item1)
        }
        //actionMenuButton.addItem(item1)
        
        let item2 = actionMenuButton.addItem()
        //item2.titleLabel.text = "Item2"
        item2.imageView.image = UIImage(named: "approval-button-icon-s")
        item2.buttonColor = UIColor(red: 28/255, green: 38/255, blue: 99/255, alpha: 1.0)
        item2.action = { item in
            self.setActionMenuButtonToDeafult()
            Helper.showAlert(for: item2)
        }
        
        let item3 = actionMenuButton.addItem()
        //item3.titleLabel.text = "Item3"
        item3.imageView.image = UIImage(named: "status-button-icon-s")
        item3.buttonColor = UIColor(red: 28/255, green: 38/255, blue: 99/255, alpha: 1.0)
        item3.action = { item in
            self.setActionMenuButtonToDeafult()
            Helper.showAlert(for: item3)
        }
        
        let item4 = actionMenuButton.addItem()
        //item4.titleLabel.text = "Item4"
        item4.imageView.image = UIImage(named: "profile--button-icon-s")
        item4.buttonColor = UIColor(red: 28/255, green: 38/255, blue: 99/255, alpha: 1.0)
        item4.action = { item in
            self.setActionMenuButtonToDeafult()
            Helper.showAlert(for: item4)
        }
        
        //actionMenuButton.overlayView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        actionMenuButton.itemAnimationConfiguration = .circularSlideIn(withRadius: 120)
        actionMenuButton.buttonAnimationConfiguration = .rotation(toAngle: 180)
        actionMenuButton.buttonAnimationConfiguration.opening.duration = 0.8
        actionMenuButton.buttonAnimationConfiguration.closing.duration = 0.6
        
        self.view.addSubview(actionMenuButton)
        actionMenuButton.translatesAutoresizingMaskIntoConstraints = false
        actionMenuButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -self.view.frame.width/2+20).isActive = true
        actionMenuButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        //actionMenuButton.display(inViewController: self)
    }
    
    func setActionMenuButtonToDeafult() {
        self.actionMenuButton.buttonColor = UIColor(red: 28/255, green: 38/255, blue: 99/255, alpha: 1.0)
        self.actionMenuButton.buttonImage = UIImage(named: "main-button-icon1")
    }
    
    
    @objc func actionMenuButtonTapped(_ sender : UIButton) {
        switch actionMenuButton.buttonState {
        case .open:
            print("Open")
            actionMenuButton.buttonColor = UIColor(red: 252/255, green: 229/255, blue: 0, alpha: 1.0)
            actionMenuButton.buttonImage = UIImage(named: "close-button-s")
        case .closed:
            print("Closed")
            actionMenuButton.buttonColor = UIColor(red: 28/255, green: 38/255, blue: 99/255, alpha: 1.0)
            actionMenuButton.buttonImage = UIImage(named: "main-button-icon1")
        case .opening:
            print("Opening")
            actionMenuButton.buttonColor = UIColor(red: 252/255, green: 229/255, blue: 0, alpha: 1.0)
            actionMenuButton.buttonImage = UIImage(named: "close-button-s")
        case .closing:
            print("Closing")
            actionMenuButton.buttonColor = UIColor(red: 28/255, green: 38/255, blue: 99/255, alpha: 1.0)
            actionMenuButton.buttonImage = UIImage(named: "main-button-icon1")
        }
    }
    
    @IBAction func logout(sender: UIButton) {
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to Logout?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.switchToViewController(identifier: "loginViewController")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancel")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func notification(sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "Notification", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
}
