//
// Created by Yin on 2019/12/23.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class CreateViewController : BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Create"

        Create()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/23 10:34 上午
                             * @Description: crete操作符将创建一个Observable，你需要提供一个构件函数，在构件函数里面描述事件（next error onCompleted）的产生过程
                             *               通常情况下一个有限序列值会调用一次观察者的onCompleted或者onError事件，并且调用他们之后将不会在去调用观察者的其他方法
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Create() {

                                 let id = Observable<Int>.create { observer in
                                     observer.onNext(0)
                                     observer.onNext(1)
                                     observer.onNext(2)
                                     observer.onNext(3)
                                     observer.onNext(4)
                                     observer.onNext(5)
                                     observer.onNext(6)
                                     observer.onNext(7)
                                     observer.onNext(8)
                                     observer.onNext(9)
                                     observer.onCompleted()
                                     return Disposables.create()
                                 }

                             }
                             """
    }

    /**
    * @Date: 2019/12/23 10:34 上午
    * @Description: crete操作符将创建一个Observable，你需要提供一个构件函数，在构件函数里面描述事件（next error onCompleted）的产生过程
    *               通常情况下一个有限序列值会调用一次观察者的onCompleted或者onError事件，并且调用他们之后将不会在去调用观察者的其他方法
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Create() {

        let id = Observable<Int>.create { observer in
            observer.onNext(0)
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onNext(4)
            observer.onNext(5)
            observer.onNext(6)
            observer.onNext(7)
            observer.onNext(8)
            observer.onNext(9)
            observer.onCompleted()
            return Disposables.create()
        }

    }
}
