//
// Created by Yin on 2019/12/19.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class AmbBufferViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "amb、flutter"

        Amb()
        Buffer()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/19 4:34 下午
                             * @Description: amb 在多个源Observable中，取第一个发出元素或产生事件的Observable，然后只发出它的元素
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Amb() {

                                 // 汉堡序列
                                 let rxHanBao: Observable<String> = Observable.of("汉堡1", "汉堡2", "汉堡3").delay(3, scheduler: MainScheduler.instance)

                                 // 薯条序列
                                 let rxShuTiao: Observable<String> = Observable.of("薯条1", "薯条2", "薯条3", "薯条4").delay(5, scheduler: MainScheduler.instance)

                                 Observable<String>.amb([rxHanBao, rxShuTiao]).subscribe { event in
                                     switch  event {
                                     case .next(let element):
                                         print("element", element)
                                     case .error(let error) :
                                         print("error", error)
                                     case .completed:
                                         print("completed")
                                     }
                                 }.disposed(by: disposeBag)
                             }

                             输出：
                             element 汉堡1
                             element 汉堡2
                             element 汉堡3
                             completed

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/19 4:43 下午
                             * @Description: buffer缓存元素，然后将缓存的元素集合，周期性的发送出来
                             *               Observable.buffer((timeSpan: 周期时长, count: 周期内元素个数, scheduler: 线程))
                             *               当周期内发出的元素不足是也会发出
                             * @Param:
                             * @Author: jie
                             * @return:
                             */
                             func Buffer() {

                                 // 汉堡序列
                                 let rxHanBao: Observable<String> = Observable.of("汉堡1", "汉堡2", "汉堡3").delay(4, scheduler: MainScheduler.instance)

                                 rxHanBao.buffer(timeSpan: 2, count: 2, scheduler: MainScheduler.instance).subscribe { event in
                                     switch event {
                                     case .next(let element):
                                         print("element2", element)
                                     case .error(let error):
                                         print("error2", error)
                                     case .completed:
                                         print("completed2")
                                     }
                                 }.disposed(by: disposeBag)
                             }

                             输出：
                             element2 []
                             element2 ["汉堡1"]
                             element2 ["汉堡2", "汉堡3"]
                             element2 []
                             completed2
                             """
    }

    /**
    * @Date: 2019/12/19 4:34 下午
    * @Description: amb 在多个源Observable中，取第一个发出元素或产生事件的Observable，然后只发出它的元素
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Amb() {

        // 汉堡序列
        let rxHanBao: Observable<String> = Observable.of("汉堡1", "汉堡2", "汉堡3").delay(3, scheduler: MainScheduler.instance)

        // 薯条序列
        let rxShuTiao: Observable<String> = Observable.of("薯条1", "薯条2", "薯条3", "薯条4").delay(5, scheduler: MainScheduler.instance)

        Observable<String>.amb([rxHanBao, rxShuTiao]).subscribe { event in
            switch event {
            case .next(let element):
                print("element1", element)
            case .error(let error):
                print("error1", error)
            case .completed:
                print("completed1")
            }
        }.disposed(by: disposeBag)
    }

    /**
    * @Date: 2019/12/19 4:43 下午
    * @Description: buffer缓存元素，然后将缓存的元素集合，周期性的发送出来
    *               Observable.buffer((timeSpan: 周期时长, count: 周期内元素个数, scheduler: 线程))
    *               当周期内发出的元素不足是也会发出
    * @Param:
    * @Author: jie
    * @return:
    */
    func Buffer() {

        // 汉堡序列
        let rxHanBao: Observable<String> = Observable.of("汉堡1", "汉堡2", "汉堡3").delay(4, scheduler: MainScheduler.instance)

        rxHanBao.buffer(timeSpan: 2, count: 2, scheduler: MainScheduler.instance).subscribe { event in
            switch event {
            case .next(let element):
                print("element2", element)
            case .error(let error):
                print("error2", error)
            case .completed:
                print("completed2")
            }
        }.disposed(by: disposeBag)
    }
}
