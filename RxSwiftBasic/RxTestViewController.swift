//
//  RxTestViewController.swift
//  RxSwiftBasic
//
//  Created by Yin on 2019/12/13.
//  Copyright © 2019 Yin. All rights reserved.
//

import UIKit

class RxTestViewController: UIViewController {

    let table: UITableView = {
        let table = UITableView()
        table.estimatedRowHeight = 50
        table.separatorColor = .lightGray
        return table
    }()

    let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.navigationItem.title = "RxSwift笔记"

        self.view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }

        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // 创建数据流
        let items = Observable.just([SectionModel(model: "qe",
                items: ["Single", "Completable", "Maybe", "Driver", "Signal",
                        "AnyObserver", "Binder", "AsyncSubject", "PublishSubject",
                        "ReplaySubject", "BehaviorSubject", "Operator", "Disposable", "Schedulers", "Error Handling"])])

        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { dataSource, tv, indexPath, element in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = element
            return cell!
        }
        )


        // 点击事件处理
        table.rx.itemSelected.subscribe(onNext: {
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
            case 5:
                // AnyObserver
                self.navigationController?.pushViewController(AnyObserverViewController(), animated: true)
            case 6:
                // Binder
                self.navigationController?.pushViewController(BinderViewController(), animated: true)
            case 7:
                // AsyncSubject
                self.navigationController?.pushViewController(AsyncSubjectViewController(), animated: true)
            case 8:
                // PublishSubject
                self.navigationController?.pushViewController(PublishSubjectViewController(), animated: true)
            case 9:
                // ReplaySubject
                self.navigationController?.pushViewController(ReplaySubjectViewController(), animated: true)
            case 10:
                // BehaviorSubject
                self.navigationController?.pushViewController(BehaviorSubjectViewController(), animated: true)
            case 11:
                // Operator
                self.navigationController?.pushViewController(OperatorViewController(), animated: true)
            case 12:
                // Operator
                self.navigationController?.pushViewController(DisposableViewController(), animated: true)
            case 13:
                // Schedulers
                self.navigationController?.pushViewController(SchedulersViewController(), animated: true)
            case 14:
                // Error Handling
                self.navigationController?.pushViewController(ErrorHandlingViewController(), animated: true)
            default:
                print("未知")
            }
        }).disposed(by: disposeBag)

        items.bind(to: table.rx.items(dataSource: dataSource)).disposed(by: disposeBag)

    }

}
