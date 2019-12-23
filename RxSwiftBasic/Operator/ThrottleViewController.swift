//
// Created by Yin on 2019/12/23.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class ThrottleViewController: BaseViewController {

    lazy private var textField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        tf.placeholder = "请输入内容"
        return tf
    }()

    lazy private var btn: UIButton = {
        let b = UIButton(type: .contactAdd)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Throttle"

        self.view.addSubview(textField)
        self.view.addSubview(btn)
        self.textField.snp.makeConstraints { make in
            make.top.equalTo(90)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }

        self.btn.snp.makeConstraints { make in
            make.top.equalTo(self.textField.snp.bottom).offset(20)
            make.trailing.equalTo(-10)
            make.width.height.equalTo(30)
        }

        self.codeText.snp.updateConstraints { make in
            make.height.equalToSuperview().offset(-100)
            make.centerY.equalToSuperview().offset(80)
        }

        Debounce()

        self.codeText.text = """

                             """
    }

    /**
    * @Date: 2019/12/23 10:39 上午
    * @Description: debounce操作符 会忽略掉指定时间间隔内人元素
    *               例子：当监听输入框内容时无需关注用户输入的每个字符时，可以使用该操作符控制每间隔一段时间发出一个事件
    *                   .throttle(0.5, scheduler: Mainscheduler.instance) 每0.5秒间隔发送一次元素给Observer
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Debounce() {
        self.textField.rx.text
                .throttle(0.5, scheduler: MainScheduler.instance)
                .debug("Debug")
                .subscribe { s in
                    print(s)
                }.disposed(by: disposeBag)

        self.btn.rx.tap
                .throttle(1.0, scheduler: MainScheduler.instance)
                .subscribe(
                        onNext: {
                            print("adad")
                        })
                .disposed(by: disposeBag)
    }

}
