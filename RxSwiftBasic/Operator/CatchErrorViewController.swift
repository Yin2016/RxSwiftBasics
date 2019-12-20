//
// Created by Yin on 2019/12/20.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class CatchErrorViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "CatchError"

        CatchError()

        // 延迟3秒执行
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.catchErrorJustReturn()
        }

        self.codeText.text = """
                             /*
                             CatchError
                             从一个错误事件中恢复，将错误事件替换成一个备选序列
                             */

                             /**
                             * @Date: 2019/12/20 10:57 上午
                             * @Description: catchError操作符会拦截一个error事件，将它替换成其他的元素或一组元素，然后传递给Observer
                             *               这样可以使得Observable正常结束或根本不需要结束
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func CatchError() {

                                 let sequenceThatFails = PublishSubject<String>()
                                 let recoverySequence = PublishSubject<String>()

                                 sequenceThatFails
                                         .catchError {
                                             print("Error:", $0)
                                             return recoverySequence
                                         }
                                         .subscribe {
                                             print($0)
                                         }
                                         .disposed(by: disposeBag)

                                 sequenceThatFails.onNext("😬")
                                 sequenceThatFails.onNext("😨")
                                 sequenceThatFails.onNext("😡")
                                 sequenceThatFails.onNext("🔴")
                                 sequenceThatFails.onError(TestError.test)

                                 recoverySequence.onNext("😊")
                                 sequenceThatFails.onNext("🔴")
                                 recoverySequence.onNext("😡")
                             }

                             打印：
                             next(😬)
                             next(😨)
                             next(😡)
                             next(🔴)
                             Error: test
                             next(😊)
                             next(😡)

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/20 11:16 上午
                             * @Description: catchErrorJustReturn操作符会将error事件替换成其他的一个元素，然后终止该序列
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func catchErrorJustReturn() {
                                 let sequenceThatFails = PublishSubject<String>()

                                 sequenceThatFails
                                         .catchErrorJustReturn("❎")
                                         .subscribe {
                                             print($0)
                                         }
                                         .disposed(by: disposeBag)

                                 sequenceThatFails.onNext("😬")
                                 sequenceThatFails.onNext("😨")
                                 sequenceThatFails.onNext("😡")
                                 sequenceThatFails.onNext("🔴")
                                 sequenceThatFails.onError(TestError.test)
                             }

                             打印：
                             next(😬)
                             next(😨)
                             next(😡)
                             next(🔴)
                             next(❎)
                             completed
                             """

    }

    /*
        CatchError
        从一个错误事件中恢复，将错误事件替换成一个备选序列
    */

    /**
    * @Date: 2019/12/20 10:57 上午
    * @Description: catchError操作符会拦截一个error事件，将它替换成其他的元素或一组元素，然后传递给Observer
    *               这样可以使得Observable正常结束或根本不需要结束
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func CatchError() {

        let sequenceThatFails = PublishSubject<String>()
        let recoverySequence = PublishSubject<String>()

        sequenceThatFails
                .catchError {
                    print("Error:", $0)
                    return recoverySequence
                }
                .subscribe {
                    print($0)
                }
                .disposed(by: disposeBag)

        sequenceThatFails.onNext("😬")
        sequenceThatFails.onNext("😨")
        sequenceThatFails.onNext("😡")
        sequenceThatFails.onNext("🔴")
        sequenceThatFails.onError(TestError.test)

        recoverySequence.onNext("😊")
        sequenceThatFails.onNext("🔴")
        recoverySequence.onNext("😡")
    }

    /**
    * @Date: 2019/12/20 11:16 上午
    * @Description: catchErrorJustReturn操作符会将error事件替换成其他的一个元素，然后终止该序列
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func catchErrorJustReturn() {
        let sequenceThatFails = PublishSubject<String>()

        sequenceThatFails
                .catchErrorJustReturn("❎")
                .subscribe {
                    print($0)
                }
                .disposed(by: disposeBag)

        sequenceThatFails.onNext("😬")
        sequenceThatFails.onNext("😨")
        sequenceThatFails.onNext("😡")
        sequenceThatFails.onNext("🔴")
        sequenceThatFails.onError(TestError.test)
    }
}

enum TestError: Error {
    case test
}
