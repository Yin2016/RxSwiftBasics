//
// Created by Yin on 2019/12/24.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class DoViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Do"

        Do()

        self.codeText.text = """
                             /** 
                             * @Date: 2019/12/24 3:54 下午
                             * @Description: do操作符类似subscribe操作符 但是优先于subscribe
                             * @Param: - 
                             * @Author: jie 
                             * @return: - 
                             */
                             func Do() {

                                 let observable = Observable.of(1, 2, 3, 4, 5)

                                 observable
                                         .do(
                                             onNext: {
                                                 print("Do \\($0)")
                                             }
                                         )
                                         .subscribe { i in
                                             print(i)
                                         }
                                         .disposed(by: disposeBag)
                             } 
                             """
    }

    /**
    * @Date: 2019/12/24 3:54 下午
    * @Description: do操作符类似subscribe操作符 但是优先于subscribe
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Do() {

        let observable = Observable.of(1, 2, 3, 4, 5)

        observable
                .do(
                    onNext: {
                        print("Do \($0)")
                    }
                )
                .subscribe { i in
                    print(i)
                }
                .disposed(by: disposeBag)

        let emptyObservable = Observable<String>.empty()

        emptyObservable
                .subscribe { i in
                    print(i)
                }
                .disposed(by: disposeBag)


    }
}
