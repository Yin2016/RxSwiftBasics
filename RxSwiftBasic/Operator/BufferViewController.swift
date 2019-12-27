//
// Created by Yin on 2019/12/24.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class BufferViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Buffer、Window"

        Buffer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self!.Window()
        }

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/24 4:14 下午
                             * @Description: buffer操作符的作用是缓冲组合，当缓冲的元素达到某个数量或者达到缓冲时间时，会将元素集合发送出来
                             *               .buffer(缓冲时间， 缓冲个数， 线程)
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Buffer() {

                                 let subject = PublishSubject<String>()

                                 // 没缓冲3个元素则组合起来一起发出
                                 // 如果1秒内不够3个也会发出，有几个发几个，一个都没有发出一个空集合[]
                                 subject
                                         .buffer(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
                                         .subscribe { s in
                                             print(s)
                                         }
                                         .disposed(by: disposeBag)

                                 subject.onNext("a")
                                 subject.onNext("b")
                                 subject.onNext("c")

                                 subject.onNext("1")
                                 subject.onNext("2")
                                 subject.onNext("3")

                                 subject.onNext("A")

                                 DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                     subject.onCompleted()
                                 }

                                /*
                                 输出：
                                 next(["a", "b", "c"])
                                 next(["1", "2", "3"])
                                 next(["A"])
                                 next([])
                                 next([])
                                 completed
                                 */
                             }

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/24 4:21 下午
                             * @Description: window操作符与buffer相似，buffer是周期性的将元素集合发出来
                             *               window是周期性的将元素集合以Observable的形态发出来
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Window() {
                                 let subject = PublishSubject<String>()

                                 // 没缓冲3个元素则组合起来一起发出
                                 // 如果1秒内不够3个也会发出，有几个发几个，一个都没有发出一个空集合[]
                                 subject
                                         .window(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
                                         .subscribe(
                                                 onNext: { [weak self] in
                                                     print("subscribe: \\($0)")
                                                     $0.asObservable()
                                                             .subscribe(onNext: {
                                                                 print($0)
                                                             }).disposed(by: self!.disposeBag)
                                                 }
                                         )
                                         .disposed(by: disposeBag)

                                 subject.onNext("a")
                                 subject.onNext("b")
                                 subject.onNext("c")

                                 subject.onNext("1")
                                 subject.onNext("2")
                                 subject.onNext("3")

                                 subject.onNext("A")

                                 DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                     subject.onCompleted()
                                 }

                                /*
                                 输出：
                                 ubscribe: RxSwift.AddRef<Swift.String>
                                 a
                                 b
                                 c
                                 subscribe: RxSwift.AddRef<Swift.String>
                                 1
                                 2
                                 3
                                 subscribe: RxSwift.AddRef<Swift.String>
                                 A
                                 subscribe: RxSwift.AddRef<Swift.String>
                                 subscribe: RxSwift.AddRef<Swift.String>
                                 subscribe: RxSwift.AddRef<Swift.String>
                                 */
                             }
                             """
    }

    /**
    * @Date: 2019/12/24 4:14 下午
    * @Description: buffer操作符的作用是缓冲组合，当缓冲的元素达到某个数量或者达到缓冲时间时，会将元素集合发送出来
    *               .buffer(缓冲时间， 缓冲个数， 线程)
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Buffer() {

        let subject = PublishSubject<String>()

        // 没缓冲3个元素则组合起来一起发出
        // 如果1秒内不够3个也会发出，有几个发几个，一个都没有发出一个空集合[]
        subject
                .buffer(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
                .subscribe { s in
                    print(s)
                }
                .disposed(by: disposeBag)

        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")

        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")

        subject.onNext("A")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            subject.onCompleted()
        }

        /*
        输出：
        next(["a", "b", "c"])
        next(["1", "2", "3"])
        next(["A"])
        next([])
        next([])
        completed
        */
    }

    /**
    * @Date: 2019/12/24 4:21 下午
    * @Description: window操作符与buffer相似，buffer是周期性的将元素集合发出来
    *               window是周期性的将元素集合以Observable的形态发出来
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Window() {
        let subject = PublishSubject<String>()

        // 没缓冲3个元素则组合起来一起发出
        // 如果1秒内不够3个也会发出，有几个发几个，一个都没有发出一个空集合[]
        subject
                .window(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
                .subscribe(
                        onNext: { [weak self] in
                            print("subscribe: \($0)")
                            $0.asObservable()
                                    .subscribe(onNext: {
                                        print($0)
                                    }).disposed(by: self!.disposeBag)
                        }
                )
                .disposed(by: disposeBag)

        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")

        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")

        subject.onNext("A")

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            subject.onCompleted()
        }

        /*
        输出：
        ubscribe: RxSwift.AddRef<Swift.String>
        a
        b
        c
        subscribe: RxSwift.AddRef<Swift.String>
        1
        2
        3
        subscribe: RxSwift.AddRef<Swift.String>
        A
        subscribe: RxSwift.AddRef<Swift.String>
        subscribe: RxSwift.AddRef<Swift.String>
        subscribe: RxSwift.AddRef<Swift.String>
        */
    }
}
