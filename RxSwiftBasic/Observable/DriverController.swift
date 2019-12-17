//
// Created by Yin on 2019/12/17.
// Copyright (c) 2019 Yin. All rights reserved.
//

import UIKit

class DriverController: BaseViewController {

    lazy private var textField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        tf.placeholder = "请输入内容"
        return tf
    }()

    lazy private var textView: UITextView = {
        let tv = UITextView()
        tv.textColor = .black
        tv.backgroundColor = .lightGray
        return tv
    }()

    lazy private var textView2: UITextView = {
        let tv = UITextView()
        tv.textColor = .black
        tv.backgroundColor = .lightGray
        return tv
    }()

    lazy private var btn: UIButton = {
        let b = UIButton(type: .contactAdd)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(textField)
        self.view.addSubview(textView)
        self.view.addSubview(textView2)
        self.view.addSubview(btn)
        self.textField.snp.makeConstraints { make in
            make.top.equalTo(90)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }

        self.textView.snp.makeConstraints { make in
            make.top.equalTo(self.textField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }

        self.textView2.snp.makeConstraints { make in
            make.top.equalTo(self.textView.snp.bottom).offset(20)
            make.leading.equalTo(10)
            make.width.equalToSuperview().offset(-80)
            make.height.equalTo(30)
        }

        self.btn.snp.makeConstraints { make in
            make.top.equalTo(self.textView.snp.bottom).offset(20)
            make.trailing.equalTo(-10)
            make.width.height.equalTo(30)
        }

        self.codeText.snp.updateConstraints { make in
            make.height.equalToSuperview().offset(-200)
            make.centerY.equalToSuperview().offset(200)
        }

        self.codeText.text = """
                             /** 
                             * @Date: 2019/12/17 11:06 上午
                             * @Description:  Driver主要是用于简化UI层的代码 不会产生error事件并且一定在MainScheduler监听（主线程）
                             *                使用asDriver(onErrorJustReturn: "")方法转回Driver Observable
                             *                Driver会回放上一个元素
                             * @Param: - 
                             * @Author: jie 
                             * @return: - 
                             */
                             func DriverObservables() {
                                 let results = textField.rx.text.throttle(0.3, scheduler: MainScheduler.instance).asDriver(onErrorJustReturn: "")
                                 results.map {
                                     "已经输入字符数\\($0?.count ?? 0)"
                                 }.drive(textView.rx.text).disposed(by: disposeBag)

                                 btn.rx.tap.subscribe(
                                     onNext:{ [unowned self] in
                                         results.map {
                                             "已经输入字符数\\($0?.count ?? 0)"
                                         }.drive(self.textView2.rx.text).disposed(by: self.disposeBag)
                                     }
                                 ).disposed(by: disposeBag)
                             }
                             """

        DriverObservables()
    }

    /** 
    * @Date: 2019/12/17 11:06 上午
    * @Description:  Driver主要是用于简化UI层的代码 不会产生error事件并且一定在MainScheduler监听（主线程）
    *                使用asDriver(onErrorJustReturn: "")方法转回Driver Observable
    *                Driver会回放上一个元素
    * @Param: - 
    * @Author: jie 
    * @return: - 
    */
    func DriverObservables() {
        let results = textField.rx.text.throttle(0.3, scheduler: MainScheduler.instance).asDriver(onErrorJustReturn: "")
        results.map {
            "已经输入字符数\($0?.count ?? 0)"
        }.drive(textView.rx.text).disposed(by: disposeBag)

        btn.rx.tap.subscribe(
            onNext:{ [unowned self] in
                results.map {
                    "已经输入字符数\($0?.count ?? 0)"
                }.drive(self.textView2.rx.text).disposed(by: self.disposeBag)
            }
        ).disposed(by: disposeBag)
    }
}
