//
//  ViewController.swift
//  ToDoApp
//
//  Created by 하다현 on 5/31/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    let toDoManager = CoreDataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupTableView()
        
    }
    // 네비게이션바 우측에 Plus버튼 생성
    func setupNaviBar() {
        self.title = "Memo"
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                         action: #selector(plusButtonTapped))
        plusButton.tintColor = .black
        navigationItem.rightBarButtonItem = plusButton
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    @objc func plusButtonTapped() {
        performSegue(withIdentifier: "ToDoCell", sender: nil)
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        return UITableViewCell()
    }
}
