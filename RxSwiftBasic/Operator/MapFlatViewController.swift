//
// Created by Yin on 2019/12/24.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class MapFlatViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Map、FlatMap、FlatLatest、FlatMapFirst"

        Map()
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
}
