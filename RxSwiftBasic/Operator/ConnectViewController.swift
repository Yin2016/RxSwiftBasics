//
// Created by Yin on 2019/12/23.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class ConnectViewController : BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Connect"

        Connect()
    }

    /**
    * @Date: 2019/12/23 9:38 上午
    * @Description: public方法会将一个正常的序列转换成一个可连接序列（ConnectableObservable），同时该序列不会立即发送事件
    *               只有在调用connect之后才会开始
    *
    *               ConnectObservable和普通的Observable相似，但是不会在订阅后立即发送元素，直到connect操作符被调用后才会发出元素
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Connect() {

        let intSquence = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()

        _ = intSquence.subscribe(onNext:{print("Subscription 1:, Event:\($0)")})

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            _ = intSquence.connect()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            _ = intSquence
                    .subscribe(onNext: { print("Subscription 2:, Event: \($0)") })
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            _ = intSquence
                    .subscribe(onNext: { print("Subscription 3:, Event: \($0)") })
        }

    }

}
