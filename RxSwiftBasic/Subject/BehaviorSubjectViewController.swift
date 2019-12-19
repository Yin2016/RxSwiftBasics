//
// Created by Yin on 2019/12/19.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class BehaviorSubjectViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        BehaviorSubjects()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/19 8:35 上午
                             * @Description: 当Observer对BehaviorSubject进行订阅时，他会将源Observable中最新的元素发送出来
                             *               如果不存在最新的元素，就会发出默认元素。然后将随后产生的元素发送出来
                             *               如果源Observable产生一个error而终止，BehaviorSubject就不会发出任何元素，而是发送error事件
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func BehaviorSubjects() {

                                 let subject = BehaviorSubject(value: "")

                                 subject.subscribe(
                                         onNext: { str in print(str) },
                                         onError: { error in
                                         }, onCompleted: {
                                     print("onCompleted")
                                 }).disposed(by: disposeBag)

                                 subject.onNext("🐶")
                                 subject.onNext("🐱")

                                 subject.subscribe(
                                         onNext: { str in print(str) },
                                         onError: { error in
                                         }, onCompleted: {
                                     print("onCompleted")
                                 }).disposed(by: disposeBag)

                                 subject.onNext("🅰️")
                                 subject.onNext("🅱️")

                                 subject.subscribe(
                                         onNext: { str in print(str) },
                                         onError: { error in
                                         }, onCompleted: {
                                     print("onCompleted")
                                 }).disposed(by: disposeBag)

                                 subject.onNext("🍐")
                                 subject.onNext("🍊")
                             }

                             输出：
                             
                             🐶
                             🐱
                             🐱
                             🅰️
                             🅰️
                             🅱️
                             🅱️
                             🅱️
                             🍐
                             🍐
                             🍐
                             🍊
                             🍊
                             🍊
                             """
    }

    /**
    * @Date: 2019/12/19 8:35 上午
    * @Description: 当Observer对BehaviorSubject进行订阅时，他会将源Observable中最新的元素发送出来
    *               如果不存在最新的元素，就会发出默认元素。然后将随后产生的元素发送出来
    *               如果源Observable产生一个error而终止，BehaviorSubject就不会发出任何元素，而是发送error事件
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func BehaviorSubjects() {

        let subject = BehaviorSubject(value: "")

        subject.subscribe(
                onNext: { str in print(str) },
                onError: { error in
                }, onCompleted: {
            print("onCompleted")
        }).disposed(by: disposeBag)

        subject.onNext("🐶")
        subject.onNext("🐱")

        subject.subscribe(
                onNext: { str in print(str) },
                onError: { error in
                }, onCompleted: {
            print("onCompleted")
        }).disposed(by: disposeBag)

        subject.onNext("🅰️")
        subject.onNext("🅱️")

        subject.subscribe(
                onNext: { str in print(str) },
                onError: { error in
                }, onCompleted: {
            print("onCompleted")
        }).disposed(by: disposeBag)

        subject.onNext("🍐")
        subject.onNext("🍊")
    }
}
