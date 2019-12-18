//
// Created by Yin on 2019/12/18.
// Copyright (c) 2019 Yin. All rights reserved.
//

import UIKit

class AnyObserverViewController : BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.codeText.text = """
                             AnyObserver 可以用来描叙任意一种观察者。

                             例如：
                             打印网络请求结果：

                             URLSession.shared.rx.data(request: URLRequest(url: url))
                                 .subscribe(onNext: { data in
                                     print("Data Task Success with count: \\(data.count)")
                                 }, onError: { error in
                                     print("Data Task Error: \\(error)")
                                 })
                                 .disposed(by: disposeBag)
                             可以看作是：

                             let observer: AnyObserver<Data> = AnyObserver { (event) in
                                 switch event {
                                 case .next(let data):
                                     print("Data Task Success with count: \\(data.count)")
                                 case .error(let error):
                                     print("Data Task Error: \\(error)")
                                 default:
                                     break
                                 }
                             }

                             URLSession.shared.rx.data(request: URLRequest(url: url))
                                 .subscribe(observer)
                                 .disposed(by: disposeBag)
                             用户名提示语是否隐藏：

                             usernameValid
                                 .bind(to: usernameValidOutlet.rx.isHidden)
                                 .disposed(by: disposeBag)
                             可以看作是：

                             let observer: AnyObserver<Bool> = AnyObserver { [weak self] (event) in
                                 switch event {
                                 case .next(let isHidden):
                                     self?.usernameValidOutlet.isHidden = isHidden
                                 default:
                                     break
                                 }
                             }

                             usernameValid
                                 .bind(to: observer)
                                 .disposed(by: disposeBag)
                             """
    }


}
