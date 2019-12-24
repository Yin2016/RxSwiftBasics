//
// Created by Yin on 2019/12/24.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class SampleViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Sample"

        Sample()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/24 3:35 下午
                             * @Description: Sample操作符除了当前Observable外还可监听另外一个Observable
                             *               每当被监听的Observable发出事件后，源Observable就会从源序列中取一个最新的事件并发送
                             *               而如果被监听的Observable连续两次事件之间源事件都未发出元素，则源事件不会发出新值
                             *               也就是说只有被监听的事件发出元素后才会监听到源事件发出的元素，并且如果源事件未发出新元素时，
                             *               即可被监听事件发出了元素，由于源事件未产生新元素，所以也不会监听到源事件的元素
                             *               一旦被监听事件发送onCompleted/onError事件后将无法在收到源事件发出的元素
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Sample() {

                                 let subject1 = PublishSubject<String>()
                                 let subject2 = PublishSubject<String>()

                                 subject1
                                         .sample(subject2)
                                         .subscribe { s in
                                             print(s)
                                         }
                                         .disposed(by: disposeBag)

                                 subject1.onNext("源事件-->1")
                                 subject2.onNext("被监听事件-->1")
                                 subject2.onNext("被监听事件-->2")
                                 subject1.onNext("源事件-->2")
                                 subject1.onNext("源事件-->3")
                                 subject2.onNext("被监听事件-->3")
                                 subject1.onNext("源事件-->4")
                                 subject2.onCompleted()
                                 subject1.onNext("源事件-->5")
                                 subject1.onNext("源事件-->6")
                                 
                             }
                             """
    }

    /**
    * @Date: 2019/12/24 3:35 下午
    * @Description: Sample操作符除了当前Observable外还可监听另外一个Observable
    *               每当被监听的Observable发出事件后，源Observable就会从源序列中取一个最新的事件并发送
    *               而如果被监听的Observable连续两次事件之间源事件都未发出元素，则源事件不会发出新值
    *               也就是说只有被监听的事件发出元素后才会监听到源事件发出的元素，并且如果源事件未发出新元素时，
    *               即可被监听事件发出了元素，由于源事件未产生新元素，所以也不会监听到源事件的元素
    *               一旦被监听事件发送onCompleted/onError事件后将无法在收到源事件发出的元素
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Sample() {

        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()

        subject1
                .sample(subject2)
                .subscribe { s in
                    print(s)
                }
                .disposed(by: disposeBag)

        subject1.onNext("源事件-->1")
        subject2.onNext("被监听事件-->1")
        subject2.onNext("被监听事件-->2")
        subject1.onNext("源事件-->2")
        subject1.onNext("源事件-->3")
        subject2.onNext("被监听事件-->3")
        subject1.onNext("源事件-->4")
        subject2.onCompleted()
        subject1.onNext("源事件-->5")
        subject1.onNext("源事件-->6")

    }
}
