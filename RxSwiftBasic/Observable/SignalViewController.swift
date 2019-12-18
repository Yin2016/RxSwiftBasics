//
// Created by Yin on 2019/12/17.
// Copyright (c) 2019 Yin. All rights reserved.
//

import UIKit
import Foundation

class SignalViewController: BaseViewController {

    lazy private var btn: UIButton = {
        let b = UIButton(type: .contactAdd)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(btn)

        self.btn.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(30)
        }

        self.codeText.snp.updateConstraints { make in
            make.height.equalToSuperview().offset(-100)
            make.centerY.equalToSuperview().offset(100)
        }

        SignalObservables()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/17 3:54 下午
                             * @Description:  Signal和Driver相似 唯一区别就是Driver会对新观察者回放上一个元素
                             *                而Signal不会对新观察者回放上一个元素
                             *                使用.asSignal()将Observable转换为Signal
                             *
                             *                一般情况下状态序列选用Driver类型
                             *                事件序列选用Signal序列
                             * @Param:  -
                             * @Author: jie
                             * @return:  -
                             */
                             func SignalObservables() {
                                 let observable : Signal<Void> = self.btn.rx.tap.asSignal()

                                 let observer : () -> Void = { [weak self] in
                                     DispatchQueue.main.async {
                                         self?.showAlert(sss: "qwe")
                                     }
                                 }

                                 observable.emit(onNext: observer)

                                 // 由于当按钮点击时observe2并没有对点击事件进行监听，所以不会收到第一次的事件
                                 self.btn.rx.tap.subscribe(onNext: { [weak self] in
                                     self?.btn.isEnabled = false
                                     let observe2 : () -> Void = { [weak self] in
                                         self?.showAlert(sss: "123")
                                     }
                                     observable.emit(onNext: observe2)
                                 }).disposed(by: disposeBag)
                             }
                             """
    }

    /**
    * @Date: 2019/12/18 11:30 上午
    * @Description:
    * @Param:
    * @Author: jie
    * @return:
    */
    public func showAlert(sss ss: String) {
        let alertController = UIAlertController(
                title: "提示", message: ss, preferredStyle: .alert
        )

        let alterAction = UIAlertAction(
                title: "OK", style: .default) { (_) in
            print("关闭")
        }

        alertController.addAction(alterAction)

        self.present(alertController, animated: true)
    }

    /**
    * @Date: 2019/12/17 3:54 下午
    * @Description:  Signal和Driver相似 唯一区别就是Driver会对新观察者回放上一个元素
    *                而Signal不会对新观察者回放上一个元素
    *                使用.asSignal()将Observable转换为Signal
    *
    *                一般情况下状态序列选用Driver类型
    *                事件序列选用Signal序列
    * @Param:  -
    * @Author: jie
    * @return:  -
    */
    func SignalObservables() {
        let observable : Signal<Void> = self.btn.rx.tap.asSignal()

        let observer : () -> Void = { [weak self] in
            DispatchQueue.main.async {
                self?.showAlert(sss: "qwe")
            }
        }

        observable.emit(onNext: observer)

        // 由于当按钮点击时observe2并没有对点击事件进行监听，所以不会收到第一次的事件
        self.btn.rx.tap.subscribe(onNext: { [weak self] in
            self?.btn.isEnabled = false
            let observe2 : () -> Void = { [weak self] in
                self?.showAlert(sss: "123")
            }
            observable.emit(onNext: observe2)
        }).disposed(by: disposeBag)
    }
}