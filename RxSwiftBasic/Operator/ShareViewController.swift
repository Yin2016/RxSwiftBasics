//
// Created by Yin on 2019/12/27.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class ShareViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Share、Reduce"

        Share()

        Reduce()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/27 9:34 上午
                             * @Description: share操作符可使观察者共享源Observable，并缓存最新的n个元素，将这些元素直接发送给新的观察者
                             *
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Share() {

                                 let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).share(replay: 5)

                                 interval.subscribe(onNext: {
                                     print("订阅1：\\($0)")
                                 }).disposed(by: disposeBag)

                                 delay(5) { [weak self] in
                                     interval.subscribe(onNext: {
                                         print("订阅2：\\($0)")
                                     }).disposed(by: self!.disposeBag)
                                 }
                             }

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/27 9:56 上午
                             * @Description: Reduce操作符可以将数组合计为一个值，并且会接受一个初始值，这个值的类型可以与数组元素的类型不同
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Reduce() {
                                 let prices = [20, 30, 40]

                                 let sum = prices.reduce(10) { (result: Int, i: Int) -> Int in
                                     return result + i
                                 }

                                 print("总数为\\(sum)")

                                 let array = ["Apple", "Orange", "Grape"]

                                 let str = array.reduce("") { (result: String, s: String) -> String in
                                     return result.isEmpty ? s : result + "、" + s
                                 }

                                 print("返回字符串", str)
                             }
                             """
    }

    /**
    * @Date: 2019/12/27 9:34 上午
    * @Description: share操作符可使观察者共享源Observable，并缓存最新的n个元素，将这些元素直接发送给新的观察者
    *
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Share() {

        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).share(replay: 5)

        interval.subscribe(onNext: {
            print("订阅1：\($0)")
        }).disposed(by: disposeBag)

        delay(5) { [weak self] in
            interval.subscribe(onNext: {
                print("订阅2：\($0)")
            }).disposed(by: self!.disposeBag)
        }
    }

    /**
    * @Date: 2019/12/27 9:56 上午
    * @Description: Reduce操作符可以将数组合计为一个值，并且会接受一个初始值，这个值的类型可以与数组元素的类型不同
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Reduce() {
        let prices = [20, 30, 40]

        let sum = prices.reduce(10) { (result: Int, i: Int) -> Int in
            return result + i
        }

        print("总数为\(sum)")

        let array = ["Apple", "Orange", "Grape"]

        let str = array.reduce("") { (result: String, s: String) -> String in
            return result.isEmpty ? s : result + "、" + s
        }

        print("返回字符串", str)
    }
}
///
/// 延迟执行
/// - Parameters:
///   - delay: 延迟时间 s
///   - closure: 延迟执行的闭包
public func delay(_ delay : Double, closure : @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}
