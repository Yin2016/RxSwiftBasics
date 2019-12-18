//
// Created by Yin on 2019/12/18.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class AsyncSubjectViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        AsyncSubjects()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/18 4:25 下午
                             * @Description: AsyncSubject将在源Observable产生完成事件后，发出最后一个元素（仅仅只有最后一个元素）
                             *               如果源Observable没有发出任何元素，只有一个完成事件。那AsyncSubject也只有一个完成事件
                             *               如果源Observable产生一个error事件而终止，那AsyncSubject就不会发出任何元素，而是将这个error发送出来
                             * @Param:
                             * @Author: jie
                             * @return: -
                             */
                             func AsyncSubjects() {

                                 let subject = AsyncSubject<String>()

                                 subject.subscribe(
                                         onNext: { str in print(str) },
                                         onError: { error in

                                         },
                                         onCompleted: {
                                             print("onCompleted")
                                         }
                                 ).disposed(by: disposeBag)

                                 subject.onNext("🐱")
                                 subject.onNext("🐔")
                                 subject.onNext("🐅")
                                 subject.onCompleted()
                             }
                             """
    }

    /**
    * @Date: 2019/12/18 4:25 下午
    * @Description: AsyncSubject将在源Observable产生完成事件后，发出最后一个元素（仅仅只有最后一个元素）
    *               如果源Observable没有发出任何元素，只有一个完成事件。那AsyncSubject也只有一个完成事件
    *               如果源Observable产生一个error事件而终止，那AsyncSubject就不会发出任何元素，而是将这个error发送出来
    * @Param:
    * @Author: jie
    * @return: -
    */
    func AsyncSubjects() {

        let subject = AsyncSubject<String>()

        subject.subscribe(
                onNext: { str in print(str) },
                onError: { error in

                },
                onCompleted: {
                    print("onCompleted")
                }
        ).disposed(by: disposeBag)

        subject.onNext("🐱")
        subject.onNext("🐔")
        subject.onNext("🐅")
        subject.onCompleted()
    }

}
