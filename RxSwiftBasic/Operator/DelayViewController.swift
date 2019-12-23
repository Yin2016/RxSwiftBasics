//
// Created by Yin on 2019/12/23.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class DelayViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Delay"

        Delay()

        DelaySubscription()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/23 3:41 下午
                             * @Description: 该操作会将Observable的所有元素都先延迟一段设定好的事件，然后将他们发送出来
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Delay() {

                                 Observable.of(1, 2, 3)
                                         .delay(3, scheduler: MainScheduler.instance)    // 延迟3秒开始发出元素
                                         .subscribe(onNext: {
                                             print("\\($0)")
                                         })
                                         .disposed(by: disposeBag)

                             }

                             /**
                             * @Date: 2019/12/23 3:52 下午
                             * @Description: 使用DelaySubscription操作符可以进行延迟订阅，即经过所设定的时间后，才对Observable进行订阅操作
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func DelaySubscription() {

                                 Observable.of(1, 2, 3)
                                         .delaySubscription(3, scheduler: MainScheduler.instance)    // 延迟3秒开始订阅
                                         .subscribe { i in
                                             print("\\(i)")
                                         }
                                         .disposed(by: disposeBag)
                                 
                             }
                             """
    }

    /**
    * @Date: 2019/12/23 3:41 下午
    * @Description: 该操作会将Observable的所有元素都先延迟一段设定好的事件，然后将他们发送出来
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Delay() {

        Observable.of(1, 2, 3)
                .delay(3, scheduler: MainScheduler.instance)    // 延迟3秒开始发出元素
                .subscribe(onNext: {
                    print("\($0)")
                })
                .disposed(by: disposeBag)

    }

    /**
    * @Date: 2019/12/23 3:52 下午
    * @Description: 使用DelaySubscription操作符可以进行延迟订阅，即经过所设定的时间后，才对Observable进行订阅操作
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func DelaySubscription() {

        Observable.of(1, 2, 3)
                .delaySubscription(3, scheduler: MainScheduler.instance)    // 延迟3秒开始订阅
                .subscribe { i in
                    print("\(i)")
                }
                .disposed(by: disposeBag)

    }
}
