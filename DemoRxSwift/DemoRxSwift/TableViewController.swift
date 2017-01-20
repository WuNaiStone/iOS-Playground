//
//  TableViewController.swift
//  DemoRxSwift
//
//  Created by Chris Hu on 17/1/18.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources


class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    // 指定tableView的dataSource中包含的对象
    // 包含SectionModel，以String作为section name，User作为item类型。
    // String作为section的名字，User作为item的类型
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, User>>()
    
    let viewModel = ViewModel()
    
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dataSource对象需要设置configureCell，原型如下
        // typealias CellFactory = (TableViewSectionedDataSource<S>, UITableView, IndexPath, I) -> UITableViewCell
        dataSource.configureCell = { (_, table, indexPath, user) in
            
            let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let string = "\(user.screenName) is following \(user.followingCount) users and is followed by \(user.followersCount) users."
            cell.textLabel?.text = string
            cell.textLabel?.numberOfLines = 0
            cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.white : UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
            return cell
            
        }
        
        // ViewModel中负责生成数据相关的Observable，然后跟Observer（items）绑定
        viewModel.getUsers()
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
        
        tableView.rx
            .modelSelected(User.self)
            .subscribe(onNext: { user in
                print(user)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                self.present(loginVC, animated: true, completion: nil)
            })
            .addDisposableTo(disposeBag)
        
        
        
        
        /*
        // 构建一个Observable
        let dataSource = Observable.just(
            (0..<10).map({
                "\($0)"
            })
        )
        
        // bindTo类似于dataSource的作用。而register cell则在storyboard中实现
        dataSource.bindTo(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) {
            (row, element, cell) in
            cell.textLabel?.text = "\(element) - \(row)"
        }.addDisposableTo(disposeBag)
        
        // 点击cell
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                print(value)
            })
            .addDisposableTo(disposeBag)
        
        // 点击AccessoryButton
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                print(indexPath)
            })
            .addDisposableTo(disposeBag)
        
        // 监听contentOffset
        tableView.rx.contentOffset
            .map { $0.y }
            .subscribe(onNext: { (offset) in
                print(offset)
            })
            .addDisposableTo(disposeBag)
        */
        
    }
    
}

