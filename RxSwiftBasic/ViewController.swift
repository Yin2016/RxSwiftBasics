//
//  ViewController.swift
//  RxSwiftBasic
//
//  Created by Yin on 2019/12/10.
//  Copyright © 2019 Yin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    private let leftPadding = 10
    private let rightPadding = -10
    private let textFieldHeight = 40
    
    // 用户名标题
    lazy private var userNameTitle : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "用户名"
        return label
    }()
    
    // 用户名输入框
    lazy private var userNameTextFeild : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "请输入用户名"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    // 用户名验证提示信息
    lazy private var userNameValid : UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "请输入6位账号"
        return label
    }()
    
    // 用户密码标题
    lazy private var userPsdTitle : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "密码"
        return label
    }()
    
    // 用户密码输入框
    lazy private var userPsdTextFeild : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "请输入密码"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    // 用户密码验证提示信息
    lazy private var userPsdValid : UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "请输入6密码"
        return label
    }()
    
    // 登录按钮
    lazy private var loginBtn : UIButton = {
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
    
    // 跳转按钮
    lazy private var jumpBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("跳转RxSwift", for: .normal)
        btn.backgroundColor = .green
        btn.rx.tap.subscribe(onNext:{ [weak self] in
            let rxVC = RxTestViewController()
            self?.navigationController?.pushViewController(rxVC, animated: true)
        }).disposed(by: self.disposeBag)
        return btn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDefultInfo()
        setUI()
        setRx()
    }

    func setDefultInfo() {
        self.navigationItem.title = "RxSwift基础"
    }
    
    func setUI() {
        
        self.view.addSubview(self.userNameTitle)
        self.view.addSubview(self.userNameTextFeild)
        self.view.addSubview(self.userNameValid)
        self.view.addSubview(self.userPsdTitle)
        self.view.addSubview(self.userPsdTextFeild)
        self.view.addSubview(self.userPsdValid)
        self.view.addSubview(self.loginBtn)
        self.view.addSubview(self.jumpBtn)
        
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
        
        // 登录按钮
        self.loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.userPsdValid.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
        
        // 将View添加到组中统一设置共有信息
        let viewArr : Array<UIView> = [userNameTitle, userNameTextFeild, userNameValid, userPsdTitle, userPsdTextFeild, userPsdValid, loginBtn]
        _ = viewArr.map {
            $0.snp.makeConstraints { (make) in
                make.left.equalTo(leftPadding)
                make.right.equalTo(rightPadding)
            }
        }
        
        // 跳转按钮
        self.jumpBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.equalTo(self.leftPadding)
            make.trailing.equalTo(self.rightPadding)
            make.height.equalTo(50)
        }
    }
    
    func setRx() {
        
        // 用户名是否有效
        let userNameValidRx = userNameTextFeild.rx.text.orEmpty.map{$0.count >= 6}.share(replay: 1)
        
        // 用户名是否有效 -> 密码输入库是否可用
        userNameValidRx.bind(to: userPsdTextFeild.rx.isEnabled).disposed(by: disposeBag)
        
        // 用户名是否有效 -> 用户名提示信息是否隐藏
        //userNameValidRx.bind(to: userNameValid.rx.isHidden).disposed(by: disposeBag)
        
        // 用户密码是否有效
        let userPsdValidRx = userPsdTextFeild.rx.text.orEmpty.map{$0.count >= 6}.share(replay: 1)
        
        // 密码是否有效 -> 密码提示语是否隐藏
        userPsdValidRx.bind(to: userPsdValid.rx.isHidden).disposed(by: disposeBag)
        
        // 所有输入是否有效
        let everythingValidRx = Observable.combineLatest(userNameValidRx, userPsdValidRx){
            $0 && $1
        }.share(replay: 1)
        
        // 所有输入是否有效 -> 绿色按钮是否可点击
        everythingValidRx.bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
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
        
        checkInfo().subscribe(onSuccess: { ss in
            print(ss)
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)
        
        binder()
    }
    
    // Single
    func checkInfo() -> Single<String> {
        return Single<String>.create { single in
            
            if (self.userNameTextFeild.text?.count ?? 0 < 6) {
                single(.error(CheckErro.UserNameNo(code: 1001, message: "用户名不合法")))
            }
            if (self.userPsdTextFeild.text?.count ?? 0 < 8) {
                single(.error(CheckErro.UserPsdNo(code: 1002, message: "用户密码不合法")))
            }
            
            single(.success("通过"))
            
            return Disposables.create {
                
            }
        }
    }
    
    // Binder
    func binder() {
        let observer : Binder<Bool> = Binder(userNameValid) {
         (view, hidden) in
            view.isHidden = hidden
        }
        
        let userNmaeRx = userNameTextFeild.rx.text.orEmpty.map{$0.count > 6}
        userNmaeRx.bind(to: observer).disposed(by: disposeBag)
    }
}

enum CheckErro : Error {
    case UserNameNo(code: Int, message: String)
    case UserPsdNo(code: Int, message: String)
}

extension Reactive where Base : UIView {
    public var isHiddens : Binder<Bool> {
        return Binder(self.base) {
            (view, hidden) in
            view.isHidden = hidden
        }
    }
}
