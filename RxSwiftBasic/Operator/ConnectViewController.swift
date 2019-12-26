//
// Created by Yin on 2019/12/23.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class ConnectViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Public、Connect、Replay、Multicast"

//        Connect()

//        Replay()

        Multicast()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/23 9:38 上午
                             * @Description: public方法会将一个正常的序列转换成一个可连接序列（ConnectableObservable），同时该序列不会立即发送事件
                             *               只有在调用connect之后才会开始
                             *
                             *               ConnectObservable和普通的Observable相似，但是不会在订阅后立即发送元素，直到connect操作符被调用后才会发出元素
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Connect() {

                                 let intSquence = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()

                                 _ = intSquence.subscribe(onNext:{print("Subscription 1:, Event:\\($0)")})

                                 DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                     _ = intSquence.connect()
                                 }

                                 DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                     _ = intSquence
                                             .subscribe(onNext: { print("Subscription 2:, Event: \\($0)") })
                                 }

                                 DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                     _ = intSquence
                                             .subscribe(onNext: { print("Subscription 3:, Event: \\($0)") })
                                 }

                             }

                             """
    }

    /**
    * @Date: 2019/12/23 9:38 上午
    * @Description: public方法会将一个正常的序列转换成一个可连接序列（ConnectableObservable），同时该序列不会立即发送事件
    *               只有在调用connect之后才会开始
    *
    *               ConnectObservable和普通的Observable相似，但是不会在订阅后立即发送元素，直到connect操作符被调用后才会发出元素
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Connect() {

        let intSquence = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()

        _ = intSquence.subscribe(onNext: { print("Subscription 1:, Event:\($0)") })

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            _ = intSquence.connect()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            _ = intSquence
                    .subscribe(onNext: { print("Subscription 2:, Event: \($0)") })
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            _ = intSquence
                    .subscribe(onNext: { print("Subscription 3:, Event: \($0)") })
        }

    }

    /** 
    * @Date: 2019/12/26 4:08 下午
    * @Description: replay同publish方法相同都是将一个正常的Observable转换成一个可连接的Observable，
    *               同时此Observable不会立即发送事件，只有connect之后才开始
    *               Replay与publish不同之处在于：新的订阅者还能接收到订阅之前的事件消息（可以设置bufferSzie）
    * @Param:  
    * @Author: jie 
    * @return:  
    */
    func Replay() {
        let intSquence = Observable<Int>.interval(1, scheduler: MainScheduler.instance).replay(2)

        _ = intSquence.subscribe(onNext: { print("Subscription 1:, Event:\($0)") })

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            _ = intSquence.connect()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            _ = intSquence
                    .subscribe(onNext: { print("Subscription 2:, Event: \($0)") })
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            _ = intSquence
                    .subscribe(onNext: { print("Subscription 3:, Event: \($0)") })
        }
    }

    /**
    * @Date: 2019/12/26 4:36 下午
    * @Description: Multicast操作符就是将一个Observable转换为一个可连接的Observable，
    *               同时传入Subject，每当序列发送事件都会触发Subject的发送
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Multicast() {
        // 创建一个Subject 后面的Multicast方法中传入
        let subject = PublishSubject<Int>()

        // 订阅这个Subject
        subject
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)

        // 创建每隔1秒发送一个事件的Observable
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).multicast(subject)

        // 第一个订阅者 立即开始订阅）
        _ = interval
                .subscribe(onNext: { print("订阅1: \($0)") })

        //相当于把事件消息推迟了两秒
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            _ = interval.connect()
        }

        //第二个订阅者（延迟5秒开始订阅）
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            _ = interval
                    .subscribe(onNext: { print("订阅2: \($0)") })
        }

        //第三个订阅者（延迟7秒开始订阅）
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            _ = interval
                    .subscribe(onNext: { print("Subscription 3:, Event: \($0)") })
        }
    }

}
