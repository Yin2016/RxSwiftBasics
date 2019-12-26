//
// Created by Yin on 2019/12/24.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class MapFlatViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Map、FlatMap、FlatLatest、FlatMapFirst"

        Map()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.FlatMap()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.FlatMapLatest()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.FlatMapFirst()
        }

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/24 4:46 下午
                             * @Description: Map操作符通过一个函数闭包将原来的Observable序列转换成一个新的Observable序列
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Map() {
                                 let observable = Observable.of(1, 2, 3, 4, 5)

                                 observable
                                         .map { i in
                                             "00\\(i)"
                                         }
                                         .subscribe { s in
                                             print(s)
                                         }
                                         .disposed(by: disposeBag)
                             }

                             /**
                             * @Date: 2019/12/25 8:13 上午
                             * @Description: flatMap操作符对源Observable的每个元素应用一个转换方法，将它们转换成Observables
                             *               然后将这些Observables的元素合并之后在发送出来
                             *
                             *               map在做转换时容易出现升维的情况，转换之后变成了序列的序列，这样使用flatMap可以保证转换以后仍是一个序列
                             *               比如当Observable的元素本身拥有其他的Observable时，我们可以将所有子Observables的元素发出来
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func FlatMap() {
                                 let observable = Observable<Observable<String>>.of(Observable<String>.of("1", "2", "3"), Observable<String>.of("4", "5", "6"))

                                 observable
                                         .flatMap {
                                             $0
                                         }
                                         .subscribe(onNext: {
                                             print($0)
                                         })
                                         .disposed(by: disposeBag)

                                 /*
                                 打印：
                                 1
                                 2
                                 4
                                 3
                                 5
                                 6
                                 */
                             }

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/25 8:46 上午
                             * @Description: FlatMapLatest与FlatMap相比 它只会接收最新的事件
                             *               也就是降维后Observables中只存取最新的Observable中的元素
                             *               如果源Observable中是多个Observable时，只有最后一个Observable的元素会被全部接收，其余Observable只会接收到第一个元素
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func FlatMapLatest() {

                                 let disposeBag = DisposeBag()

                                 let subject1 = BehaviorSubject(value: "A")
                                 let subject2 = BehaviorSubject(value: "1")

                                 let variable = Variable(subject1)

                                 variable.asObservable()
                                         .flatMapLatest { $0 }
                                         .subscribe(onNext: { print($0) })
                                         .disposed(by: disposeBag)

                                 subject1.onNext("B")
                                 subject1.onNext("D")
                                 subject1.onNext("D")
                                 variable.value = subject2
                                 subject2.onNext("2")
                                 subject1.onNext("C")

                                 /*
                                 输出：
                                 A
                                 B
                                 D
                                 D
                                 1
                                 2
                                 */

                                 let observable = Observable<Observable<String>>.of(
                                         Observable<String>.of("1", "2", "3", "1", "2", "3"),
                                         Observable<String>.of("4", "5", "6"),
                                         Observable<String>.of("7", "8", "9"))

                                 observable
                                         .flatMapLatest {
                                             $0
                                         }
                                         .subscribe(onNext: {
                                             print($0)
                                         })
                                         .disposed(by: disposeBag)

                                 /*
                                 输出:
                                 1   Observable1的新元素
                                 4   Observable2的新元素
                                 7   Observable3的全部元素
                                 8
                                 9
                                 */
                             }

                             /**
                             * @Date: 2019/12/25 9:00 上午
                             * @Description: FlatMapFirst与FlatMapLatest想反 只取最初的元素 其余Observable中的元素不会被发送
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func FlatMapFirst() {

                                 let disposeBag = DisposeBag()

                                 let subject1 = BehaviorSubject(value: "A")
                                 let subject2 = BehaviorSubject(value: "1")

                                 let variable = Variable(subject1)

                                 variable.asObservable()
                                         .flatMapFirst { $0 }
                                         .subscribe(onNext: { print($0) })
                                         .disposed(by: disposeBag)

                                 subject1.onNext("B")
                                 subject1.onNext("D")
                                 subject1.onNext("D")
                                 variable.value = subject2
                                 subject2.onNext("2")
                                 subject1.onNext("C")

                                 /*
                                 输出：
                                 A
                                 B
                                 D
                                 D
                                 C
                                 */

                                 let observable = Observable<Observable<String>>.of(
                                         Observable<String>.of("1", "2", "3", "1", "2", "3"),
                                         Observable<String>.of("4", "5", "6"),
                                         Observable<String>.of("7", "8", "9"))

                                 observable
                                         .flatMapFirst {
                                             $0
                                         }
                                         .subscribe(onNext: {
                                             print($0)
                                         })
                                         .disposed(by: disposeBag)

                                 /*
                                 输出:
                                 1
                                 2
                                 3
                                 1
                                 2
                                 3
                                 */
                             }
                             """
    }

    /**
    * @Date: 2019/12/24 4:46 下午
    * @Description: Map操作符通过一个函数闭包将原来的Observable序列转换成一个新的Observable序列
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Map() {
        let observable = Observable.of(1, 2, 3, 4, 5)

        observable
                .map { i in
                    "00\(i)"
                }
                .subscribe { s in
                    print(s)
                }
                .disposed(by: disposeBag)
    }

    /**
    * @Date: 2019/12/25 8:13 上午
    * @Description: flatMap操作符对源Observable的每个元素应用一个转换方法，将它们转换成Observables
    *               然后将这些Observables的元素合并之后在发送出来
    *
    *               map在做转换时容易出现升维的情况，转换之后变成了序列的序列，这样使用flatMap可以保证转换以后仍是一个序列
    *               比如当Observable的元素本身拥有其他的Observable时，我们可以将所有子Observables的元素发出来
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func FlatMap() {
        let observable = Observable<Observable<String>>.of(Observable<String>.of("1", "2", "3"), Observable<String>.of("4", "5", "6"))

        observable
                .flatMap {
                    $0
                }
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)

        /*
        打印：
        1
        2
        4
        3
        5
        6
        */
    }

    /**
    * @Date: 2019/12/25 8:46 上午
    * @Description: FlatMapLatest与FlatMap相比 它只会接收最新的事件
    *               也就是降维后Observables中只存取最新的Observable中的元素
    *               如果源Observable中是多个Observable时，只有最后一个Observable的元素会被全部接收，其余Observable只会接收到第一个元素
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func FlatMapLatest() {

        let disposeBag = DisposeBag()

        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")

        let variable = Variable(subject1)

        variable.asObservable()
                .flatMapLatest { $0 }
                .subscribe(onNext: { print($0) })
                .disposed(by: disposeBag)

        subject1.onNext("B")
        subject1.onNext("D")
        subject1.onNext("D")
        variable.value = subject2
        subject2.onNext("2")
        subject1.onNext("C")

        /*
        输出：
        A
        B
        D
        D
        1
        2
        */

        let observable = Observable<Observable<String>>.of(
                Observable<String>.of("1", "2", "3", "1", "2", "3"),
                Observable<String>.of("4", "5", "6"),
                Observable<String>.of("7", "8", "9"))

        observable
                .flatMapLatest {
                    $0
                }
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)

        /*
        输出:
        1   Observable1的新元素
        4   Observable2的新元素
        7   Observable3的全部元素
        8
        9
        */
    }

    /**
    * @Date: 2019/12/25 9:00 上午
    * @Description: FlatMapFirst与FlatMapLatest想反 只取最初的元素 其余Observable中的元素不会被发送
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func FlatMapFirst() {

        let disposeBag = DisposeBag()

        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")

        let variable = Variable(subject1)

        variable.asObservable()
                .flatMapFirst { $0 }
                .subscribe(onNext: { print($0) })
                .disposed(by: disposeBag)

        subject1.onNext("B")
        subject1.onNext("D")
        subject1.onNext("D")
        variable.value = subject2
        subject2.onNext("2")
        subject1.onNext("C")

        /*
        输出：
        A
        B
        D
        D
        C
        */

        let observable = Observable<Observable<String>>.of(
                Observable<String>.of("1", "2", "3", "1", "2", "3"),
                Observable<String>.of("4", "5", "6"),
                Observable<String>.of("7", "8", "9"))

        observable
                .flatMapFirst {
                    $0
                }
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)

        /*
        输出:
        1
        2
        3
        1
        2
        3
        */
    }
}
