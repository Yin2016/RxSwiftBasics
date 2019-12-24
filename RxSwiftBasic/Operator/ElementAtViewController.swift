//
// Created by Yin on 2019/12/24.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class ElementAtViewController : BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "ElementAt、ignoreElments"

        ElementAt()

        IgnoreElements()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/24 2:02 下午
                             * @Description: elementAt只处理指定位置的事件
                             * @Param: -
                             * @Author: jie
                             * @return: =
                             */
                             func ElementAt() {

                                 let observable = Observable.of(1, 2, 3, 4, 5)

                                 observable
                                         .elementAt(3)
                                         .subscribe { i in
                                             print("\\(i)")
                                         }
                                         .disposed(by: disposeBag)

                             }

                             /**
                             * @Date: 2019/12/24 2:52 下午
                             * @Description: IgnoreElements操作符可以忽略掉所有元素，只发出error或completed事件
                             *               如果我们不关心Observable的任何元素，只想知道Observable什么时候终止，那么就可以使用ignoreElements操作符
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func IgnoreElements() {

                                 let observable = Observable.of(1, 2, 3, 4, 5)

                                 observable
                                         .ignoreElements()
                                         .subscribe{
                                             print($0)
                                         }
                                         .disposed(by: disposeBag)

                             }
                             """
    }

    /**
    * @Date: 2019/12/24 2:02 下午
    * @Description: elementAt只处理指定位置的事件
    * @Param: -
    * @Author: jie
    * @return: =
    */
    func ElementAt() {

        let observable = Observable.of(1, 2, 3, 4, 5)

        observable
                .elementAt(3)
                .subscribe { i in
                    print("\(i)")
                }
                .disposed(by: disposeBag)

    }

    /**
    * @Date: 2019/12/24 2:52 下午
    * @Description: IgnoreElements操作符可以忽略掉所有元素，只发出error或completed事件
    *               如果我们不关心Observable的任何元素，只想知道Observable什么时候终止，那么就可以使用ignoreElements操作符
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func IgnoreElements() {

        let observable = Observable.of(1, 2, 3, 4, 5)

        observable
                .ignoreElements()
                .subscribe{
                    print($0)
                }
                .disposed(by: disposeBag)

    }

}
