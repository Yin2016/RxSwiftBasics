//
// Created by Yin on 2019/12/18.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class PublishSubjectViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        PublishSubjects()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/18 4:36 下午
                             * @Description: PublishSubject将对观察者发送订阅后产生的元素，而在订阅前发出的元素将不会发送给观察者。
                             *               如果你希望观察者受到所有的元素，你可以通过Observable的create方法创建爱你Observable，或者使用ReplaySubject
                             *               如果Observable因为产生一个error时间而终止，PublishSubject就不会发出任何元素，而是将这个error时间发送出来
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func PublishSubjects() {
                                 let subject = PublishSubject<String>()

                                 subject.onNext("🐷")
                                 subject.onNext("🐎")

                                 subject.subscribe(
                                         onNext: { str in print(str) },
                                         onError: {
                                             error in

                                         }, onCompleted: {
                                     print("onCompleted")
                                 }).disposed(by: disposeBag)

                                 subject.onNext("🧧")
                                 subject.onNext("👍")
                             }

                             打印内容：
                             🧧
                             👍
                             """
    }

    /**
    * @Date: 2019/12/18 4:36 下午
    * @Description: PublishSubject将对观察者发送订阅后产生的元素，而在订阅前发出的元素将不会发送给观察者。
    *               如果你希望观察者受到所有的元素，你可以通过Observable的create方法创建爱你Observable，或者使用ReplaySubject
    *               如果Observable因为产生一个error时间而终止，PublishSubject就不会发出任何元素，而是将这个error时间发送出来
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func PublishSubjects() {
        let subject = PublishSubject<String>()

        subject.onNext("🐷")
        subject.onNext("🐎")

        subject.subscribe(
                onNext: { str in print(str) },
                onError: {
                    error in

                }, onCompleted: {
            print("onCompleted")
        }).disposed(by: disposeBag)

        subject.onNext("🧧")
        subject.onNext("👍")
    }

}
