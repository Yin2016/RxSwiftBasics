//
// Created by Yin on 2019/12/23.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class DeferredViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Deferred"

        Deferred()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/23 3:27 下午
                             * @Description: deferred相当于创建一个Observable工厂，通过传入block来执行延迟Observable序列创建的行为，而这个block里就是真整的实例化序列的地方
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Deferred() {
                                 
                                 // 用于标记是奇数还是偶数
                                 var isOdd = true
                                 
                                 // 使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回
                                 let factory : Observable<Int> = Observable.deferred{
                                     
                                     // 让每个执行这个block时候都会让奇、偶数进行交替
                                     isOdd = !isOdd
                                     
                                     // 根据isOdd的参数，决定创建并返回奇数Observable、还是偶数Observable
                                     if isOdd {
                                         return Observable.of(1, 3, 5, 7)
                                     } else  {
                                         return Observable.of(2, 4, 6, 8)
                                     }
                                 }
                                 
                                 // 第一次订阅
                                 factory.subscribe{ event in 
                                     print("\\(isOdd)", event)
                                 }
                                 
                                 // 第二次订阅
                                 factory.subscribe { event in
                                     print("\\(isOdd)", event)
                                 }
                             }
                             """
    }

    /**
    * @Date: 2019/12/23 3:27 下午
    * @Description: deferred相当于创建一个Observable工厂，通过传入block来执行延迟Observable序列创建的行为，而这个block里就是真整的实例化序列的地方
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Deferred() {

        // 用于标记是奇数还是偶数
        var isOdd = true

        // 使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回
        let factory : Observable<Int> = Observable.deferred{

            // 让每个执行这个block时候都会让奇、偶数进行交替
            isOdd = !isOdd

            // 根据isOdd的参数，决定创建并返回奇数Observable、还是偶数Observable
            if isOdd {
                return Observable.of(1, 3, 5, 7)
            } else  {
                return Observable.of(2, 4, 6, 8)
            }
        }

        // 第一次订阅
        factory.subscribe{ event in
            print("\(isOdd)", event)
        }

        // 第二次订阅
        factory.subscribe { event in
            print("\(isOdd)", event)
        }
    }
}
