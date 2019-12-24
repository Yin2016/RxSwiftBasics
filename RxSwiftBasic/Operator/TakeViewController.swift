//
// Created by Yin on 2019/12/24.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class TakeViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Take、TakeLast、Skip"

        Take()

        TakeLast()

        Skip()

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
    }
}
