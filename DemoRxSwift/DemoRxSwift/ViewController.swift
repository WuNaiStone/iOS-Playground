//
//  ViewController.swift
//  DemoRxSwift
//
//  Created by Chris Hu on 17/1/18.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    // 指定tableView的dataSource中包含的对象
    // 包含SectionModel，以String作为section name，User作为item类型。
    // String作为section的名字，User作为item的类型
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, User>>()
    
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        dataSource.configureCell = { dataSource, table, indexPath, user in
            let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let string = "\(user.screenName) is following \(user.followingCount) users and is followed by \(user.followersCount) users."
            cell.textLabel?.text = string
            cell.textLabel?.numberOfLines = 0
            cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.white : UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
            return cell
        }
        
        viewModel.getUsers()
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
    }
    
}

