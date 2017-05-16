//
//  MenuController.swift
//  HamBurgerMenu
//
//  Created by 林羣珩 on 2017/5/16.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

import UIKit

class MenuController: UINavigationController {

    
    let tableviewSize : CGSize = {
        return CGSize.init(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height)
    }()
    
    var tableview = UITableView()
    
    var menuDidOpen : Bool = false
    
    var datas = ["登入","登出","取得會員列表","新增會員"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
        setupMenuButton(rootViewController: rootViewController)
        self.navigationItem.hidesBackButton = true

    }
    private func setupTableView(){
        tableview.delegate = self as UITableViewDelegate
        tableview.dataSource = self as UITableViewDataSource
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.frame  = CGRect(x: -tableviewSize.width, y: 64, width: tableviewSize.width, height: tableviewSize.height)
        self.view.addSubview(tableview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMenuButton(rootViewController: UIViewController){
        let menubutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(moveTableView))
        rootViewController.navigationItem.leftBarButtonItem = menubutton
        
    }
    
    func moveTableView(){
        menuDidOpen = !menuDidOpen
        UIView.animate(withDuration: 0.5) { 
            self.tableview.frame.origin.x -= self.menuDidOpen ?  -self.tableviewSize.width : self.tableviewSize.width
        }
    }
}
extension MenuController: UITableViewDelegate, UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return datas.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = datas[indexPath.row]
        return cell!
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("selected index \(indexPath.row)")
        let viewcontroller = UIViewController()
        switch indexPath.row {
        case 0:
            viewcontroller.view.backgroundColor = UIColor.black
        case 1:
            viewcontroller.view.backgroundColor = UIColor.blue
        case 2:
            viewcontroller.view.backgroundColor = UIColor.brown
        case 3:
            viewcontroller.view.backgroundColor = UIColor.darkGray
        default:break
        }
        
        
        self.viewControllers = [viewcontroller]
//        self.setViewControllers([viewcontroller], animated: false)
        setupMenuButton(rootViewController: viewcontroller)
        moveTableView()
    }
}

