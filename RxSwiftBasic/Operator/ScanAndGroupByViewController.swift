//
// Created by Yin on 2019/12/26.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class ScanAndGroupByViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Scan、GroupBy"

        Scan()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.GroupBy()
        }

        self.codeText.text = """
                                 /**
                             * @Date: 2019/12/26 9:01 上午
                             * @Description: Scan操作符就是先给一个初始化参数，然后不断的拿前一个结果和最新的值进行操作
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Scan() {
                                 let observable = Observable<Int>.of(1, 2, 3, 4, 5)

                                 observable
                                         .scan(10) { (a: Int, i: Int) -> Int in
                                             a + i
                                         }
                                         .subscribe(onNext: {
                                             print($0)
                                         })
                                         .disposed(by: disposeBag)
                             }

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/26 9:06 上午
                             * @Description: groupBy操作符将源Observable分解为多个子Observable，然后将这些子Observable发出来
                             *               使用groupBy可以按指定条件将Observable拆分成多个子Observable
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func GroupBy() {
                                 let observable = Observable<Int>.of(1, 2, 3, 4, 5, 6, 7, 8, 9)

                                 observable
                                         .groupBy { i -> String in
                                             return i % 2 != 0 ? "基数：\\(i)" : "偶数：\\(i)"
                                         }
                                         .subscribe(onNext: {
                                             print($0)
                                         })
                                         .disposed(by: disposeBag)
                             }
                             """
    }

    /**
    * @Date: 2019/12/26 9:01 上午
    * @Description: Scan操作符就是先给一个初始化参数，然后不断的拿前一个结果和最新的值进行操作
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Scan() {
        let observable = Observable<Int>.of(1, 2, 3, 4, 5)

        observable
                .scan(10) { (a: Int, i: Int) -> Int in
                    a + i
                }
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
    }

    /**
    * @Date: 2019/12/26 9:06 上午
    * @Description: groupBy操作符将源Observable分解为多个子Observable，然后将这些子Observable发出来
    *               使用groupBy可以按指定条件将Observable拆分成多个子Observable
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func GroupBy() {
        let observable = Observable<Int>.of(1, 2, 3, 4, 5, 6, 7, 8, 9)

        observable
                .groupBy { i -> String in
                    return i % 2 != 0 ? "基数：\(i)" : "偶数：\(i)"
                }
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
    }
}
