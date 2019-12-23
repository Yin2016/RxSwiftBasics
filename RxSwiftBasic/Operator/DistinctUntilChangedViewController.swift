//
// Created by Yin on 2019/12/23.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class DistinctUntilChangedViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "DistincUntilChanged"

        DistincUntilChanged()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/23 4:28 下午
                             * @Description: DistincUntilChanged操作符作用是组织Observable发出重复元素，如果出现重复元素将不会被发出
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func DistincUntilChanged() {

                                 let observable = Observable.of(1, 1, 2, 3, 3, 4, 5, 6, 6, 7)

                                 observable
                                     .distinctUntilChanged()
                                     .subscribe { i in
                                         print("\\(i)")
                                     }
                                     .disposed(by: disposeBag)
                             }
                             """

    }

    /**
    * @Date: 2019/12/23 4:28 下午
    * @Description: DistincUntilChanged操作符作用是组织Observable发出重复元素，如果出现重复元素将不会被发出
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func DistincUntilChanged() {

        let observable = Observable.of(1, 1, 2, 3, 3, 4, 5, 6, 6, 7)

        observable
            .distinctUntilChanged()
            .subscribe { i in
                print("\(i)")
            }
            .disposed(by: disposeBag)
    }
}
