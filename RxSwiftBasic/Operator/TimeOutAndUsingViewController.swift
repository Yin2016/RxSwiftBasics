//
// Created by Yin on 2019/12/26.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class TimeOutAndUsingViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "TimeOut、Using"

        TimeOut()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/26 11:12 上午
                             * @Description: timeout操作符可以设置一个超时时间 如果源Observable在超时时间内未发出任何元素将发出error事件
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func TimeOut() {

                                 // 定义好每个事件的值和发送的时间
                                 let times = [
                                     ["value": 1, "time": 0],
                                     ["value": 2, "time": 0.5],
                                     ["value": 3, "time": 1.5],
                                     ["value": 4, "time": 3],
                                     ["value": 5, "time": 6],
                                 ]

                                 // 生成对应的Observable序列订阅
                                 Observable
                                         .from(times)
                                         .flatMap{ item in
                                             return Observable.of(Int(item["value"]!)).delaySubscription(Double(item["time"]!), scheduler: MainScheduler.instance)                    
                                         }
                                         .timeout(2, scheduler: MainScheduler.instance)
                                         .subscribe(onNext: {
                                             print($0)
                                         }, onError: { error in
                                             print(error)
                                         })
                                         .disposed(by: disposeBag)

                             }

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/26 11:20 上午
                             * @Description: using操作符在创建Observable时，同时会创建一个可被清除的资源，一旦Observable终止了，那么这个资源就会被清除掉
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Using() {
                                 /*
                                 import UIKit
                                 import RxSwift
                                 import RxCocoa
                                  
                                 class ViewController: UIViewController {
                                      
                                     override func viewDidLoad() {
                                          
                                         //一个无限序列（每隔0.1秒创建一个序列数 ）
                                         let infiniteInterval$ = Observable<Int>
                                             .interval(0.1, scheduler: MainScheduler.instance)
                                             .do(
                                                 onNext: { print("infinite$: \\($0)") },
                                                 onSubscribe: { print("开始订阅 infinite$")},
                                                 onDispose: { print("销毁 infinite$")}
                                         )
                                          
                                         //一个有限序列（每隔0.5秒创建一个序列数，共创建三个 ）
                                         let limited$ = Observable<Int>
                                             .interval(0.5, scheduler: MainScheduler.instance)
                                             .take(2)
                                             .do(
                                                 onNext: { print("limited$: \\($0)") },
                                                 onSubscribe: { print("开始订阅 limited$")},
                                                 onDispose: { print("销毁 limited$")}
                                         )
                                          
                                         //使用using操作符创建序列
                                         let o: Observable<Int> = Observable.using({ () -> AnyDisposable in
                                             return AnyDisposable(infiniteInterval$.subscribe())
                                         }, observableFactory: { _ in return limited$ }
                                         )
                                         o.subscribe()
                                     }
                                 }
                                  
                                 class AnyDisposable: Disposable {
                                     let _dispose: () -> Void
                                      
                                     init(_ disposable: Disposable) {
                                         _dispose = disposable.dispose
                                     }
                                      
                                     func dispose() {
                                         _dispose()
                                     }
                                 }
                                 */
                             }
                             """
    }

    /**
    * @Date: 2019/12/26 11:12 上午
    * @Description: timeout操作符可以设置一个超时时间 如果源Observable在超时时间内未发出任何元素将发出error事件
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func TimeOut() {

        // 定义好每个事件的值和发送的时间
        let times = [
            ["value": 1, "time": 0],
            ["value": 2, "time": 0.5],
            ["value": 3, "time": 1.5],
            ["value": 4, "time": 3],
            ["value": 5, "time": 6],
        ]

        // 生成对应的Observable序列订阅
        Observable
                .from(times)
                .flatMap{ item in
                    return Observable.of(Int(item["value"]!)).delaySubscription(Double(item["time"]!), scheduler: MainScheduler.instance)                    
                }
                .timeout(2, scheduler: MainScheduler.instance)
                .subscribe(onNext: {
                    print($0)
                }, onError: { error in
                    print(error)
                })
                .disposed(by: disposeBag)

    }

    /**
    * @Date: 2019/12/26 11:20 上午
    * @Description: using操作符在创建Observable时，同时会创建一个可被清除的资源，一旦Observable终止了，那么这个资源就会被清除掉
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Using() {
        /*
        import UIKit
        import RxSwift
        import RxCocoa

        class ViewController: UIViewController {

            override func viewDidLoad() {

                //一个无限序列（每隔0.1秒创建一个序列数 ）
                let infiniteInterval$ = Observable<Int>
                    .interval(0.1, scheduler: MainScheduler.instance)
                    .do(
                        onNext: { print("infinite$: \($0)") },
                        onSubscribe: { print("开始订阅 infinite$")},
                        onDispose: { print("销毁 infinite$")}
                )

                //一个有限序列（每隔0.5秒创建一个序列数，共创建三个 ）
                let limited$ = Observable<Int>
                    .interval(0.5, scheduler: MainScheduler.instance)
                    .take(2)
                    .do(
                        onNext: { print("limited$: \($0)") },
                        onSubscribe: { print("开始订阅 limited$")},
                        onDispose: { print("销毁 limited$")}
                )

                //使用using操作符创建序列
                let o: Observable<Int> = Observable.using({ () -> AnyDisposable in
                    return AnyDisposable(infiniteInterval$.subscribe())
                }, observableFactory: { _ in return limited$ }
                )
                o.subscribe()
            }
        }

        class AnyDisposable: Disposable {
            let _dispose: () -> Void

            init(_ disposable: Disposable) {
                _dispose = disposable.dispose
            }

            func dispose() {
                _dispose()
            }
        }
        */
    }
}
