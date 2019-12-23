//
// Created by Yin on 2019/12/23.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class SinglesViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Single"

        Single()
    }

    /**
    * @Date: 2019/12/23 4:53 下午
    * @Description: Single限制只发送一个事件，或者满足条件的第一个事件
    *               如果存在多个事件或者没有事件都会发货一个error
    *               如果只有一个事件则不会发出error事件
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Single() {

        let observable = Observable.of(1, 2, 3, 4)

        observable
                .single { i in
                    i > 3
                }
                .subscribe { i in
                    print("\(i)")
                }
                .disposed(by: disposeBag)

    }
}
