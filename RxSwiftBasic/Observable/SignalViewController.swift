//
// Created by Yin on 2019/12/17.
// Copyright (c) 2019 Yin. All rights reserved.
//

import UIKit

class SignalViewController : BaseViewController {

    let showAlert : (String) -> Void = { ss in
        let alertController = UIAlertController(
            title: "提示", message: ss, preferredStyle: .actionSheet
        )

        let alterAction = UIAlertAction(
        title: "OK", style: .default) { (_) in
            print("关闭")
        }

        alertController.addAction(alterAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /**
    * @Date: 2019/12/17 3:54 下午
    * @Description:  Signal和Driver相似 唯一区别就是Driver会对新观察者回放上一个元素
    *                而Signal不会对新观察者回放上一个元素
    *                使用
    * @Param:  -
    * @Author: jie
    * @return:  -
    */
    func SignalObservables() {

    }
}
