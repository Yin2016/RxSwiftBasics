//
// Created by Yin on 2019/12/19.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class SchedulersViewController: BaseViewController {

    var data: Data?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Schedulers"

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/19 1:31 下午
                             * @Description: 我们用subscribeOn来决定数据序列的构建函数在哪个Scheduler上运行
                             *               使用observeOn来决定在那个Scheduler上监听数据
                             *
                             *               MainScheduler代表主线程 如果你需要执行一些和UI相关任务，你需要切换到该Scheduler上运行
                             *               SerialDispatchQueueScheduler抽象了串行队列，如果需要执行一些串行任务，可切换到这个Scheduler上
                             *               ConcurrentDispatchQueueScheduler抽象了并行，如果你需要执行一些并发任务，可切换到这个Scheduler上
                             *               OperationQueueScheduler抽象了NSOperationQueue，他具备了NSOperation的一些特点，
                             *               例如，maxConcurrentOperationCount，来控制同时执行并发任务的最大数量
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Schedulers() {

                                 // 后台取得数据 主线程处理结果
                                 let rxData: Observable<Data> = Observable.of(Data())

                                 rxData
                                         .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
                                         .observeOn(MainScheduler.instance)
                                         .subscribe(onNext: { [weak self] data in
                                             self?.data = data
                                         }
                                         ).disposed(by: disposeBag)


                             }
                             """
    }

    /**
    * @Date: 2019/12/19 1:31 下午
    * @Description: 我们用subscribeOn来决定数据序列的构建函数在哪个Scheduler上运行
    *               使用observeOn来决定在那个Scheduler上监听数据
    *
    *               MainScheduler代表主线程 如果你需要执行一些和UI相关任务，你需要切换到该Scheduler上运行
    *               SerialDispatchQueueScheduler抽象了串行队列，如果需要执行一些串行任务，可切换到这个Scheduler上
    *               ConcurrentDispatchQueueScheduler抽象了并行，如果你需要执行一些并发任务，可切换到这个Scheduler上
    *               OperationQueueScheduler抽象了NSOperationQueue，他具备了NSOperation的一些特点，
    *               例如，maxConcurrentOperationCount，来控制同时执行并发任务的最大数量
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Schedulers() {

        // 后台取得数据 主线程处理结果
        let rxData: Observable<Data> = Observable.of(Data())

        rxData
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] data in
                    self?.data = data
                }
                ).disposed(by: disposeBag)


    }
}
