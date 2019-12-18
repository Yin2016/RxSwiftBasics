//
// Created by Yin on 2019/12/18.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class ReplaySubjectViewController : BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /**
    * @Date: 2019/12/18 4:54 下午
    * @Description: ReplaySubject将对观察者发送全部的元素，无论观察者是何时进行订阅的
    *               这里存在多个版本的ReplaySubject，有的只会将最新的n个元素发送给观察者，
    *               有的只会将限制时间段内最新的元素发送给观察者
    *
    *               如果把ReplaySubject当做观察者来使用，注意不要在多线程调用onNext，onError或onCompleted
    *               这样会导致无序调用，将造成意向不到的结果
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func ReplaySubjects() {

        let subject = ReplaySubject<String>()

        subject.subscribe(
                        onNext:{
                            print("Subject1\($0)")
                        },
                        onError: { error in

                        },
                        onCompleted: {
                            print("onComplated")
                        }
                )
                .disposed(by: disposeBag)

        subject.onNext("🐶")
        subject.onNext("🐱")

        subject.subscribe(
                        onNext:{
                            print("Subject2\($0)")
                        },
                        onError: { error in

                        },
                        onCompleted: {
                            print("onComplated")
                        }
                )
                .disposed(by: disposeBag)

        subject.onNext("🅰️")
        subject.onNext("🅱️")
    }
}
