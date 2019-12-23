//
// Created by Yin on 2019/12/23.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class MaterializeViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Materialize、Dematerialize"

        Materialize()

        DeMaterialize()

        self.codeText.text  = """
                              /**
                              * @Date: 2019/12/23 4:16 下午
                              * @Description: Materialize操作符可以将序列产生的事件转换成元素
                              *               通常一个有限的Observable将产生零个或多个onNext事件，最后产生一个onCompleted或者onError事件，
                              *               而Materialize操作符会将Observable产生的这些事件全部转换成元素，然后发送出来
                              * @Param: -
                              * @Author: jie
                              * @return: -
                              */
                              func Materialize() {

                                  Observable.of(1, 2, 3)
                                          .materialize()
                                          .subscribe (
                                              onNext: {
                                                  print($0)
                                              }
                                          )
                                          .disposed(by: disposeBag)

                              }

                              /**
                              * @Date: 2019/12/23 4:24 下午
                              * @Description: 整好与Materialize相反，将Materialize转换后的元素反转回事件
                              * @Param: -
                              * @Author: jie
                              * @return: -
                              */
                              func DeMaterialize() {

                                  Observable.of(1, 2, 3)
                                          .materialize()
                                          .dematerialize()
                                          .subscribe (
                                                  onNext: {
                                                      print($0)
                                                  }
                                          )
                                          .disposed(by: disposeBag)

                              }
                              """
    }

    /**
    * @Date: 2019/12/23 4:16 下午
    * @Description: Materialize操作符可以将序列产生的事件转换成元素
    *               通常一个有限的Observable将产生零个或多个onNext事件，最后产生一个onCompleted或者onError事件，
    *               而Materialize操作符会将Observable产生的这些事件全部转换成元素，然后发送出来
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Materialize() {

        Observable.of(1, 2, 3)
                .materialize()
                .subscribe (
                    onNext: {
                        print($0)
                    }
                )
                .disposed(by: disposeBag)

    }

    /**
    * @Date: 2019/12/23 4:24 下午
    * @Description: 整好与Materialize相反，将Materialize转换后的元素反转回事件
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func DeMaterialize() {

        Observable.of(1, 2, 3)
                .materialize()
                .dematerialize()
                .subscribe (
                        onNext: {
                            print($0)
                        }
                )
                .disposed(by: disposeBag)

    }
}
