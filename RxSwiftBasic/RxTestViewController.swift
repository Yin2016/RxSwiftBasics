//
//  RxTestViewController.swift
//  RxSwiftBasic
//
//  Created by Yin on 2019/12/13.
//  Copyright © 2019 Yin. All rights reserved.
//

import UIKit

class RxTestViewController: UIViewController {

    let table : UITableView = {
        let table = UITableView()
        table.estimatedRowHeight = 50
        table.separatorColor = .lightGray
        return table
    }()
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        self.view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // 创建数据流
        let items = Observable.just([SectionModel(model: "qe", items: ["Single", "Completable", "Maybe", "Driver", "Signal", "ControEvent"])])
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: {dataSource, tv, indexPath, element in
                let cell = tv.dequeueReusableCell(withIdentifier: "cell")
                cell?.textLabel?.text = element
                return cell!
            }
        )
        
        
        // 点击事件处理
        table.rx.itemSelected.subscribe(onNext:{
            let cell = self.table.cellForRow(at: $0)
            cell?.isSelected = false
            
            switch $0.row {
            case 0:
                // Single
                self.navigationController?.pushViewController(SingleViewController(), animated: true)
            case 1:
                // Completable
                self.navigationController?.pushViewController(CompletableViewController(), animated: true)
            case 2:
                // Maybe
                self.navigationController?.pushViewController(MaybeViewController(), animated: true)
            case 3:
                // Driver
                self.navigationController?.pushViewController(DriverController(), animated: true)
            case 4:
                // Signal
                self.navigationController?.pushViewController(SignalViewController(), animated: true)
            default:
                print("未知")
            }
        }).disposed(by: disposeBag)
        
        items.bind(to: table.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
    }

}
