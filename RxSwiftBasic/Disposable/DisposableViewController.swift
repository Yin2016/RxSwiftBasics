//
// Created by Yin on 2019/12/19.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class DisposableViewController: BaseViewController {

    var disposable: Disposable?

    lazy private var textField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        tf.placeholder = "请输入内容"
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Disposable"

        self.view.addSubview(textField)
        self.textField.snp.makeConstraints { make in
            make.top.equalTo(90)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }

        self.codeText.snp.updateConstraints { make in
            make.height.equalToSuperview().offset(-100)
            make.centerY.equalToSuperview().offset(80)
        }

        Disposables()

        self.codeText.text = """
                             /*
                             Disposable

                             通常来说 一个序列如果发出了error或者completed事件，那么所有内部资源都会被释放
                             如果你需要提前释放这些资源或取消订阅的话，那么你可以对返回的 可被清楚的资源（Disposable）调用dispose方法

                             调用dispose方法后，订阅将被取消，并且内部资源都会被释放。通常情况下，你是需要手动调用dispose方法的
                             RxSwift推荐使用DisposeBag或者takeUntil操作符来管理订阅的生命周期
                             */

                             /**
                             * @Date: 2019/12/19 11:38 上午
                             * @Description: Disposable的使用
                             * @Param:
                             * @Author: jie
                             * @return:
                             */
                             func Disposables() {

                                 // 获取序列的Disposable
                                 self.disposable = textField.rx.text.orEmpty.subscribe { text in
                                     print(text)
                                 }

                             }

                             ----------------------------------------
                             ----------------------------------------

                             /*
                                 DisposeBag

                                 系统默认推进使用ARC管理内容
                                 但是订阅的生命周期无法通过ARC来管理
                                 需要使用DisposeBag来实现这种订阅管理机制（清除包）

                                 当DisposeBag被释放的时候，清除包内部所有可被清除的资源都将被清除

                                 例如：
                                 // 用户名是否有效 -> 密码输入库是否可用
                                 userNameValidRx.bind(to: userPsdTextFeild.rx.isEnabled).disposed(by: disposeBag)
                                 // 密码是否有效 -> 密码提示语是否隐藏
                                 userPsdValidRx.bind(to: userPsdValid.rx.isHidden).disposed(by: disposeBag)
                             */

                             ----------------------------------------
                             ----------------------------------------

                             /*
                                 takeUntil

                                 使用Observable.takeUntil(self.rx.deallocated)

                                 例如:
                                 _ = usernameValid
                                 .takeUntil(self.rx.deallocated)
                                 .bind(to: passwordOutlet.rx.isEnabled)

                                 _ = usernameValid
                                 .takeUntil(self.rx.deallocated)
                                 .bind(to: usernameValidOutlet.rx.isHidden)
                             */


                             // 页面销毁时处理订阅对象
                             override func viewDidDisappear(_ animated: Bool) {
                                 super.viewDidDisappear(animated)

                                 // 页面关闭是调用dispose销毁Disposable
                                 self.disposable?.dispose()
                             }
                             """
    }

    /*
        Disposable

        通常来说 一个序列如果发出了error或者completed事件，那么所有内部资源都会被释放
        如果你需要提前释放这些资源或取消订阅的话，那么你可以对返回的 可被清楚的资源（Disposable）调用dispose方法

        调用dispose方法后，订阅将被取消，并且内部资源都会被释放。通常情况下，你是需要手动调用dispose方法的
        RxSwift推荐使用DisposeBag或者takeUntil操作符来管理订阅的生命周期
    */

    /**
    * @Date: 2019/12/19 11:38 上午
    * @Description: Disposable的使用
    * @Param:
    * @Author: jie
    * @return:
    */
    func Disposables() {

        // 获取序列的Disposable
        self.disposable = textField.rx.text.orEmpty.subscribe { text in
            print(text)
        }

    }


    /*
        DisposeBag

        系统默认推进使用ARC管理内容
        但是订阅的生命周期无法通过ARC来管理
        需要使用DisposeBag来实现这种订阅管理机制（清除包）

        当DisposeBag被释放的时候，清除包内部所有可被清除的资源都将被清除

        例如：
        // 用户名是否有效 -> 密码输入库是否可用
        userNameValidRx.bind(to: userPsdTextFeild.rx.isEnabled).disposed(by: disposeBag)
        // 密码是否有效 -> 密码提示语是否隐藏
        userPsdValidRx.bind(to: userPsdValid.rx.isHidden).disposed(by: disposeBag)
    */


    /*
        takeUntil

        使用Observable.takeUntil(self.rx.deallocated)

        例如:
        _ = usernameValid
        .takeUntil(self.rx.deallocated)
        .bind(to: passwordOutlet.rx.isEnabled)

        _ = usernameValid
        .takeUntil(self.rx.deallocated)
        .bind(to: usernameValidOutlet.rx.isHidden)
    */


    // 页面销毁时处理订阅对象
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // 页面关闭是调用dispose销毁Disposable
        self.disposable?.dispose()
    }
}
