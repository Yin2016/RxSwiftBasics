//
// Created by Yin on 2020/1/10.
// Copyright (c) 2020 Yin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit

class LoginViewController : BaseViewController {
    
    private let leftPadding = 10
    private let rightPadding = -10
    private let textFieldHeight = 40
    
    // 用户名标题
    lazy private var userNameTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "用户名"
        return label
    }()
    
    // 用户名输入框
    lazy private var userNameTextFeild: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "请输入用户名"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    // 用户名验证提示信息
    lazy private var userNameValid: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "请输入6位账号"
        return label
    }()
    
    // 用户密码标题
    lazy private var userPsdTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "密码"
        return label
    }()
    
    // 用户密码输入框
    lazy private var userPsdTextFeild: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "请输入密码"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    // 用户密码验证提示信息
    lazy private var userPsdValid: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "请输入6密码"
        return label
    }()
    
    // 用户确认密码标题
    lazy private var userRepeatedPsdTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "确认密码"
        return label
    }()
    
    // 用户验证密码输入框
    lazy private var userRepeatedPsdTextFeild: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "请输入确认密码"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    // 用户验证密码验证提示信息
    lazy private var userRepeatedPsdValid: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "请输入6确认密码"
        return label
    }()
    
    // 登录按钮
    lazy private var loginBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .green
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.tintColor = .white
        btn.setTitle("登录", for: .normal)
        // 点击事件绑定
        btn.rx.tap.subscribe(onNext: { [weak self] in
            self?.showAlert()
        }).disposed(by: self.disposeBag)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        
        self.view.addSubview(self.userNameTitle)
        self.view.addSubview(self.userNameTextFeild)
        self.view.addSubview(self.userNameValid)
        self.view.addSubview(self.userPsdTitle)
        self.view.addSubview(self.userPsdTextFeild)
        self.view.addSubview(self.userPsdValid)
        self.view.addSubview(self.userRepeatedPsdTitle)
        self.view.addSubview(self.userRepeatedPsdTextFeild)
        self.view.addSubview(self.userRepeatedPsdValid)
        self.view.addSubview(self.loginBtn)
        
        // 用户名标题
        self.userNameTitle.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.top)
            }
        }
        
        // 用户名输入框
        self.userNameTextFeild.snp.makeConstraints { (make) in
            make.top.equalTo(self.userNameTitle.snp.bottom).offset(2)
            make.height.equalTo(textFieldHeight)
        }
        
        // 用户名提示信息
        self.userNameValid.snp.makeConstraints { (make) in
            make.top.equalTo(self.userNameTextFeild.snp.bottom).offset(2)
            make.height.equalTo(20)
        }
        
        // 用户密码标题
        self.userPsdTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.userNameValid.snp.bottom).offset(2)
        }
        
        // 用户密码输入框
        self.userPsdTextFeild.snp.makeConstraints { (make) in
            make.top.equalTo(self.userPsdTitle.snp.bottom).offset(2)
            make.height.equalTo(textFieldHeight)
        }
        
        // 用户密码提示信息
        self.userPsdValid.snp.makeConstraints { (make) in
            make.top.equalTo(self.userPsdTextFeild.snp.bottom).offset(2)
            make.height.equalTo(20)
        }
        
        // 用户确认密码标题
        self.userRepeatedPsdTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.userPsdValid.snp.bottom).offset(2)
        }
        
        // 用户密码输入框
        self.userRepeatedPsdTextFeild.snp.makeConstraints { (make) in
            make.top.equalTo(self.userRepeatedPsdTitle.snp.bottom).offset(2)
            make.height.equalTo(textFieldHeight)
        }
        
        // 用户密码提示信息
        self.userRepeatedPsdValid.snp.makeConstraints { (make) in
            make.top.equalTo(self.userRepeatedPsdTextFeild.snp.bottom).offset(2)
            make.height.equalTo(20)
        }
        
        // 登录按钮
        self.loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.userRepeatedPsdValid.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
        
        // 将View添加到组中统一设置共有信息
        let viewArr: Array<UIView> = [userNameTitle, userNameTextFeild, userNameValid, userPsdTitle, userPsdTextFeild, userPsdValid, userRepeatedPsdTitle, userRepeatedPsdTextFeild, userRepeatedPsdValid, loginBtn]
        _ = viewArr.map {
            $0.snp.makeConstraints { (make) in
                make.left.equalTo(leftPadding)
                make.right.equalTo(rightPadding)
            }
        }
        
    }
    
    func showAlert() {
        //        let alertController = UIAlertController(
        //            title: "RxExample", message: "This is wonderful", preferredStyle: .actionSheet
        //        )
        //
        //
        //        let alterAction = UIAlertAction(
        //        title: "OK", style: .default) { (_) in
        //            print("关闭")
        //        }
        //
        //        alertController.addAction(alterAction)
        //
        //        self.present(alertController, animated: true, completion: nil)
        print("ShowAlert")
    }
}
