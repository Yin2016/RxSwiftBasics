//
// Created by Yin on 2019/12/24.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class TakeViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Take、TakeLast、TakeUntil、TakeWhile"

        Take()

        TakeLast()

        TakeUntil()

        TakeWhile()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/24 3:20 下午
                             * @Description: take操作符实现只发送Observable序列中的前N个元素，在满足数量之后会自动发送oncompleted事件
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Take() {

                                 let observable = Observable.of(1, 2, 3, 4, 5)

                                 observable
                                         .take(2)
                                         .subscribe { i in
                                             print("\\(i)")
                                         }
                                         .disposed(by: disposeBag)

                             }

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/24 3:24 下午
                             * @Description: takeLast操作符实现只发送Observable序列中的后N个市价
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func TakeLast() {

                                 let observable = Observable.of(1, 2, 3, 4, 5)

                                 observable
                                         .takeLast(2)
                                         .subscribe { i in
                                             print("\\(i)")
                                         }
                                         .disposed(by: disposeBag)

                             }

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/27 11:03 上午
                             * @Description: TakeUntil会观察一个新的Observable，直到新的Observable发出元素，源Observable就会发出completed事件
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func TakeUntil() {
                                 let sourceSequence = PublishSubject<String>()
                                 let referenceSequence = PublishSubject<String>()

                                 sourceSequence
                                         .takeUntil(referenceSequence)
                                         .subscribe { print($0) }
                                         .disposed(by: disposeBag)

                                 sourceSequence.onNext("🐱")
                                 sourceSequence.onNext("🐰")
                                 sourceSequence.onNext("🐶")

                                 referenceSequence.onNext("🔴")

                                 sourceSequence.onNext("🐸")
                                 sourceSequence.onNext("🐷")
                                 sourceSequence.onNext("🐵")

                                 /*
                                 输出：
                                 next(🐱)
                                 next(🐰)
                                 next(🐶)
                                 completed
                                 */
                             }

                             ----------------------------------------
                             ----------------------------------------

                             /** 
                             * @Date: 2019/12/27 11:06 上午
                             * @Description: TakeWhile操作符将源Observable的元素判断为false时 将停止订阅
                             * @Param:  
                             * @Author: jie 
                             * @return:  
                             */
                             func TakeWhile() {

                                 Observable.of(1, 2, 3, 4, 3, 2, 1)
                                         .takeWhile { $0 < 4 }
                                         .subscribe(onNext: { print($0) })
                                         .disposed(by: disposeBag)
                                 
                                 /*
                                 输出：
                                 1
                                 2
                                 3
                                 */
                             }
                             """

    }

    /**
    * @Date: 2019/12/24 3:20 下午
    * @Description: take操作符实现只发送Observable序列中的前N个元素，在满足数量之后会自动发送oncompleted事件
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Take() {

        let observable = Observable.of(1, 2, 3, 4, 5)

        observable
                .take(2)
                .subscribe { i in
                    print("\(i)")
                }
                .disposed(by: disposeBag)
        
        /*
        输出：
        next(1)
        next(2)
        completed
        */

    }

    /**
    * @Date: 2019/12/24 3:24 下午
    * @Description: takeLast操作符实现只发送Observable序列中的后N个市价
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func TakeLast() {

        let observable = Observable.of(1, 2, 3, 4, 5)

        observable
                .takeLast(2)
                .subscribe { i in
                    print("\(i)")
                }
                .disposed(by: disposeBag)
        
        /*
        输出：
        next(4)
        next(5)
        completed
        */
    }

    /**
    * @Date: 2019/12/27 11:03 上午
    * @Description: TakeUntil会观察一个新的Observable，直到新的Observable发出元素，源Observable就会发出completed事件
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func TakeUntil() {
        let sourceSequence = PublishSubject<String>()
        let referenceSequence = PublishSubject<String>()

        sourceSequence
                .takeUntil(referenceSequence)
                .subscribe { print($0) }
                .disposed(by: disposeBag)

        sourceSequence.onNext("🐱")
        sourceSequence.onNext("🐰")
        sourceSequence.onNext("🐶")

        referenceSequence.onNext("🔴")

        sourceSequence.onNext("🐸")
        sourceSequence.onNext("🐷")
        sourceSequence.onNext("🐵")

        /*
        输出：
        next(🐱)
        next(🐰)
        next(🐶)
        completed
        */
    }

    /** 
    * @Date: 2019/12/27 11:06 上午
    * @Description: TakeWhile操作符将源Observable的元素判断为false时 将停止订阅
    * @Param:  
    * @Author: jie 
    * @return:  
    */
    func TakeWhile() {

        Observable.of(1, 2, 3, 4, 3, 2, 1)
                .takeWhile { $0 < 4 }
                .subscribe(onNext: { print($0) })
                .disposed(by: disposeBag)

        /*
        输出：
        1
        2
        3
        */
    }

}
