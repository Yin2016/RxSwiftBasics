//
// Created by Yin on 2019/12/27.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class SkipViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Skip、SkipUntil、SkipWhile"

        Skip()
        SkipUntil()
        SkipWhile()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/24 3:27 下午
                             * @Description: skip操作符用于跳过Observable序列发出的前N个元素
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Skip() {
                                 let observable = Observable.of(1, 2, 3, 4, 5)

                                 observable
                                         .skip(2)
                                         .subscribe { i in
                                             print("\\(i)")
                                         }
                                         .disposed(by: disposeBag)
                                /*
                                 输出：
                                 next(3)
                                 next(4)
                                 next(5)
                                 completed
                                 */
                             }

                             /**
                             * @Date: 2019/12/27 10:52 上午
                             * @Description: SkipUntil操作符会关联一个新的Observable，当关联的Observable发出元素时，才会对源Observable开始订阅
                             *               也就是说只要新的Observable发出元素开始才可以收到源Observable发出的元素，以前的都会被忽略掉
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func SkipUntil() {
                                 let sourceSequence = PublishSubject<String>()
                                 let referenceSequence = PublishSubject<String>()

                                 sourceSequence
                                         .skipUntil(referenceSequence)
                                         .subscribe(onNext: { print($0) })
                                         .disposed(by: disposeBag)

                                 sourceSequence.onNext("🐱")
                                 sourceSequence.onNext("🐰")
                                 sourceSequence.onNext("🐶")

                                 referenceSequence.onNext("🔴")

                                 sourceSequence.onNext("🐸")
                                 sourceSequence.onNext("🐷")
                                 sourceSequence.onNext("🐵")

                                 /*
                                 输出
                                 🐸
                                 🐷
                                 🐵
                                 */
                             }

                             /**
                             * @Date: 2019/12/27 10:56 上午
                             * @Description: SkipWhile操作符会忽略源Observable中的满足条件之前的元素，直到不满足条件后才开始接收
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func SkipWhile() {
                                 Observable.of(1, 2, 3, 4, 3, 2, 1)
                                         .skipWhile { $0 < 4 }
                                         .subscribe(onNext: { print($0) })
                                         .disposed(by: disposeBag)

                                 /*
                                 输出：
                                 4
                                 3
                                 2
                                 1
                                 */
                             }
                             """
    }


    /**
    * @Date: 2019/12/24 3:27 下午
    * @Description: skip操作符用于跳过Observable序列发出的前N个元素
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Skip() {
        let observable = Observable.of(1, 2, 3, 4, 5)

        observable
                .skip(2)
                .subscribe { i in
                    print("\(i)")
                }
                .disposed(by: disposeBag)

        /*
        输出：
        next(3)
        next(4)
        next(5)
        completed
        */
    }

    /**
    * @Date: 2019/12/27 10:52 上午
    * @Description: SkipUntil操作符会关联一个新的Observable，当关联的Observable发出元素时，才会对源Observable开始订阅
    *               也就是说只要新的Observable发出元素开始才可以收到源Observable发出的元素，以前的都会被忽略掉
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func SkipUntil() {
        let sourceSequence = PublishSubject<String>()
        let referenceSequence = PublishSubject<String>()

        sourceSequence
                .skipUntil(referenceSequence)
                .subscribe(onNext: { print($0) })
                .disposed(by: disposeBag)

        sourceSequence.onNext("🐱")
        sourceSequence.onNext("🐰")
        sourceSequence.onNext("🐶")

        referenceSequence.onNext("🔴")

        sourceSequence.onNext("🐸")
        sourceSequence.onNext("🐷")
        sourceSequence.onNext("🐵")

        /*
        输出
        🐸
        🐷
        🐵
        */
    }

    /**
    * @Date: 2019/12/27 10:56 上午
    * @Description: SkipWhile操作符会忽略源Observable中的满足条件之前的元素，直到不满足条件后才开始接收
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func SkipWhile() {
        Observable.of(1, 2, 3, 4, 3, 2, 1)
                .skipWhile { $0 < 4 }
                .subscribe(onNext: { print($0) })
                .disposed(by: disposeBag)

        /*
        输出：
        4
        3
        2
        1
        */
    }
}
