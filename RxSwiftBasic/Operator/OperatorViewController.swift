//
// Created by Yin on 2019/12/19.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class OperatorViewController: UIViewController {

    let disposeBag: DisposeBag = DisposeBag()

    let table: UITableView = {
        let table = UITableView()
        table.estimatedRowHeight = 50
        table.separatorColor = .lightGray
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Operator操作符"

        self.view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }

        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // 创建数据流
        let items = Observable.just([SectionModel(model: "qe",
                items: ["filter、map、zip", "amb、buffer", "CatchError", "CombineLatest",
                        "Concat、ConcatMap", "Connect", "Create", "Throttle", "Deferred",
                        "Delay、DelaySubscription", "Materialize、Dematerialize", "DistincUnitlChanged",
                        "Single", "ElementAt、IgnoreElements", "Take、TakeLast、Skip", "Sample" , 
                        "Do", "Buffer、Window", "Map、FlatMap、FlatLatest、FlatMapFirst"])])

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
                // Filter Map Zip
                self.navigationController?.pushViewController(FilterMapZipViewController(), animated: true)
            case 1:
                // amb、buffer
                self.navigationController?.pushViewController(AmbBufferViewController(), animated: true)
            case 2:
                // CachError
                self.navigationController?.pushViewController(CatchErrorViewController(), animated: true)
            case 3:
                // CombineLatest
                self.navigationController?.pushViewController(CombineLatestViewController(), animated: true)
            case 4:
                // Concat、ConcatMap
                self.navigationController?.pushViewController(ConcatViewController(), animated: true)
            case 5:
                // Connect
                self.navigationController?.pushViewController(ConnectViewController(), animated: true)
            case 6:
                // Create
                self.navigationController?.pushViewController(CreateViewController(), animated: true)
            case 7:
                // Debounce
                self.navigationController?.pushViewController(ThrottleViewController(), animated: true)
            case 8:
                // Deferred
                self.navigationController?.pushViewController(DeferredViewController(), animated: true)
            case 9:
                // Delay、DelaySubscription
                self.navigationController?.pushViewController(DelayViewController(), animated: true)
            case 10:
                // Materialize、Dematerialize
                self.navigationController?.pushViewController(MaterializeViewController(), animated: true)
            case 11:
                // DistincUntilChanged
                self.navigationController?.pushViewController(DistinctUntilChangedViewController(), animated: true)
            case 12:
                // Single
                self.navigationController?.pushViewController(SinglesViewController(), animated: true)
            case 13:
                // ElementAt、IgnoreElements
                self.navigationController?.pushViewController(ElementAtViewController(), animated: true)
            case 14:
                // Take、Takelast、Skip
                self.navigationController?.pushViewController(TakeViewController(), animated: true)
            case 15:
                // Sample
                self.navigationController?.pushViewController(SampleViewController(), animated: true)
            case 16:
                // Do
                self.navigationController?.pushViewController(DoViewController(), animated: true)
            case 17:
                // Buffer、Window
                self.navigationController?.pushViewController(BufferViewController(), animated: true)
            case 18:
                //Map、FlatMap、FlatLatest、FlatMapFirst
                self.navigationController?.pushViewController(MapFlatViewController(), animated: true)
            default:
                print("未知")
            }
        }).disposed(by: disposeBag)

        items.bind(to: table.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }


}
