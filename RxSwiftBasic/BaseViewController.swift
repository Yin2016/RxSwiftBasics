//
//  BaseViewController.swift
//  RxSwiftBasic
//
//  Created by Yin on 2019/12/16.
//  Copyright © 2019 Yin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BaseViewController: UIViewController {
    
    public let disposeBag = DisposeBag()
    
    lazy public var codeText : UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = true

        self.view.backgroundColor = .white

        // Do any additional setup after loading the view.
        self.view.addSubview(codeText)
        codeText.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            make.height.equalToSuperview().offset(-20)
        }

        self.codeText.scrollsToTop = true;
    }
    
    deinit {
        print("销毁了 -- 无内存占用")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
