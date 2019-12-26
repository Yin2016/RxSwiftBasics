//
// Created by Yin on 2019/12/26.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class StartWithAndMergeViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "StartWith、Merge"

        StartWith()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.Merge()
        }

        self.codeText.text = """
                                 /**
                             * @Date: 2019/12/26 11:51 上午
                             * @Description: StartWith操作符会在Observable序列开始前插入一些事件元素，会先发出这些预先插入的事件消息
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func StartWith() {
                                 let observable = Observable<Int>.of(1, 2, 3, 4, 5)

                                 observable
                                         .startWith(-1, 0)
                                         .subscribe(onNext: {
                                             print($0)
                                         })
                                         .disposed(by: disposeBag)
                             }

                             输出：
                             -1
                             0
                             1
                             2
                             3
                             4
                             5

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/26 11:53 上午
                             * @Description: Merge操作符可将两个或两个以上的Observable序列合并成一个Observable序列
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Merge() {
                                 let disposeBag = DisposeBag()

                                 let subject1 = PublishSubject<Int>()
                                 let subject2 = PublishSubject<Int>()

                                 Observable.of(subject1, subject2)
                                         .merge()
                                         .subscribe(onNext: { print($0) })
                                         .disposed(by: disposeBag)

                                 subject1.onNext(20)
                                 subject1.onNext(40)
                                 subject1.onNext(60)
                                 subject2.onNext(1)
                                 subject1.onNext(80)
                                 subject1.onNext(100)
                                 subject2.onNext(1)
                             }

                             输出：
                             20
                             40
                             60
                             1
                             80
                             100
                             1
                             """
    }

    /**
    * @Date: 2019/12/26 11:51 上午
    * @Description: StartWith操作符会在Observable序列开始前插入一些事件元素，会先发出这些预先插入的事件消息
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func StartWith() {
        let observable = Observable<Int>.of(1, 2, 3, 4, 5)

        observable
                .startWith(-1, 0)
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
    }

    /**
    * @Date: 2019/12/26 11:53 上午
    * @Description: Merge操作符可将两个或两个以上的Observable序列合并成一个Observable序列
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Merge() {
        let disposeBag = DisposeBag()

        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()

        Observable.of(subject1, subject2)
                .merge()
                .subscribe(onNext: { print($0) })
                .disposed(by: disposeBag)

        subject1.onNext(20)
        subject1.onNext(40)
        subject1.onNext(60)
        subject2.onNext(1)
        subject1.onNext(80)
        subject1.onNext(100)
        subject2.onNext(1)
    }
}
