//
// Created by Yin on 2019/12/20.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class CombineLatestViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "CombineLatest"

        CombineLatest()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.WithLatestFrom()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.SwitchLatest()
        }

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/20 1:13 下午
                             * @Description: combineLatest操作等将多个Observable中最新的元素通过一个函数组合起来，然后将这个组合的结果发出来
                             *               这些源Observable中任何一个元素，他都会发出一个元素（前提是，这些Observable曾经发出过元素）
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func CombineLatest() {

                                 let first = PublishSubject<String>()
                                 let second = PublishSubject<String>()

                                 Observable.combineLatest(first, second) {
                                     $0 + $1
                                 }.subscribe(onNext: {
                                     print($0)
                                 }).disposed(by: disposeBag)

                                 first.onNext("1")
                                 second.onNext("A")
                                 first.onNext("2")
                                 second.onNext("B")
                                 second.onNext("C")
                                 second.onNext("D")
                                 first.onNext("3")
                                 first.onNext("4")

                             输出：
                             1A
                             2A
                             2B
                             2C
                             2D
                             3D
                             4D

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/26 11:36 上午
                             * @Description: withLatestFrom操作符将两个Observable序列合并为一个。没当self序列发射一个元素，便从第二个序列中取出最新的一个值
                             * @Param:  -
                             * @Author: jie
                             * @return:  -
                             */
                             func WithLatestFrom() {
                                 let first = PublishSubject<String>()
                                 let second = PublishSubject<String>()

                                 first
                                         .withLatestFrom(second) {
                                             $0 + $1
                                         }
                                         .subscribe(onNext: {
                                             print($0)
                                         })
                                         .disposed(by: disposeBag)

                                 first.onNext("1")
                                 second.onNext("A")
                                 first.onNext("2")
                                 second.onNext("B")
                                 second.onNext("C")
                                 second.onNext("D")
                                 first.onNext("3")
                                 first.onNext("4")
                             }
                             输出：
                             2A
                             3D
                             4D

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/26 11:42 上午
                             * @Description: switchLatest类似switch，可以对事件流进行转换
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func SwitchLatest() {
                                 let disposeBag = DisposeBag()

                                 let subject1 = BehaviorSubject(value: "A")
                                 let subject2 = BehaviorSubject(value: "1")

                                 let variable = Variable(subject1)

                                 variable.asObservable()
                                         .switchLatest()
                                         .subscribe(onNext: { print($0) })
                                         .disposed(by: disposeBag)

                                 subject1.onNext("B")
                                 subject1.onNext("C")

                                 //改变事件源
                                 variable.value = subject2
                                 subject1.onNext("D")
                                 subject2.onNext("2")

                                 //改变事件源
                                 variable.value = subject1
                                 subject2.onNext("3")
                                 subject1.onNext("E")
                             }

                             输出：
                             A
                             B
                             C
                             1
                             2
                             D
                             E
                             """
    }

    /**
    * @Date: 2019/12/20 1:13 下午
    * @Description: combineLatest操作等将多个Observable中最新的元素通过一个函数组合起来，然后将这个组合的结果发出来
    *               这些源Observable中任何一个元素，他都会发出一个元素（前提是，这些Observable曾经发出过元素）
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func CombineLatest() {

        let first = PublishSubject<String>()
        let second = PublishSubject<String>()

        Observable.combineLatest(first, second) {
            $0 + $1
        }.subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)

        first.onNext("1")
        second.onNext("A")
        first.onNext("2")
        second.onNext("B")
        second.onNext("C")
        second.onNext("D")
        first.onNext("3")
        first.onNext("4")

    }

    /**
    * @Date: 2019/12/26 11:36 上午
    * @Description: withLatestFrom操作符将两个Observable序列合并为一个。没当self序列发射一个元素，便从第二个序列中取出最新的一个值
    * @Param:  -
    * @Author: jie
    * @return:  -
    */
    func WithLatestFrom() {
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()

        first
                .withLatestFrom(second) {
                    $0 + $1
                }
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)

        first.onNext("1")
        second.onNext("A")
        first.onNext("2")
        second.onNext("B")
        second.onNext("C")
        second.onNext("D")
        first.onNext("3")
        first.onNext("4")
    }

    /**
    * @Date: 2019/12/26 11:42 上午
    * @Description: switchLatest类似switch，可以对事件流进行转换
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func SwitchLatest() {
        let disposeBag = DisposeBag()

        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")

        let variable = Variable(subject1)

        variable.asObservable()
                .switchLatest()
                .subscribe(onNext: { print($0) })
                .disposed(by: disposeBag)

        subject1.onNext("B")
        subject1.onNext("C")

        //改变事件源
        variable.value = subject2
        subject1.onNext("D")
        subject2.onNext("2")

        //改变事件源
        variable.value = subject1
        subject2.onNext("3")
        subject1.onNext("E")
    }
}
