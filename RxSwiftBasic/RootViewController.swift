//
// Created by Yin on 2020/1/10.
// Copyright (c) 2020 Yin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class RootViewController : BaseViewController
{
    
    private let cellId : String = "CellId"
    
    private var tableview : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        
        // 创建表格视图
        tableview = UITableView(frame: self.view.bounds)
        // 创建一个重用的单元格
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.view.addSubview(tableview)
        
        // 初始化数据
        let items = Observable.just([SectionModel(model: "",items: ["RxSwift基础", "MVVM"])])
        
        // 创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell:  { (dataSource, table, index, elment) -> UITableViewCell in
            let cell = table.dequeueReusableCell(withIdentifier: self.cellId)!
            cell.textLabel?.text = "\(elment)"
            return cell
            
        })
        
        // 绑定单元格
        items.bind(to: tableview.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        // 单元格点击事件
        tableview.rx.itemSelected.subscribe(onNext: { (index) in
            
            let cell = self.tableview.cellForRow(at: index)
            cell?.isSelected = false
            
            if index.row == 0 {
                // RxSwift基础
                let rxTestVC = RxTestViewController()
                self.navigationController?.pushViewController(rxTestVC, animated: true)
            } else if index.row == 1 {
                // RxSwift+MVVM
                let loginVC = LoginViewController()
                self.navigationController?.pushViewController(loginVC, animated: true)
                
            }
        }).disposed(by: disposeBag)
        
    }
}
