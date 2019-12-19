//
// Created by Yin on 2019/12/19.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class FilterMapZipViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Filter、Map、Zip操作符"

        Filters()

        Maps()

        Zips()

        self.codeText.text = """
                             /** 
                             * @Date: 2019/12/19 10:21 上午
                             * @Description: 使用filter创建一个序列 filter中进行过滤操作，仅仅将满足条件的元素发送 
                             * @Param: - 
                             * @Author: jie 
                             * @return: -
                             */
                             func Filters() {

                                 // 温度序列
                                 let rxTemperature: Observable<Double> = Observable.of(30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 40.0)

                                 rxTemperature.filter {
                                     $0 > 33.0
                                 }.subscribe { v in
                                     print("高温：\\(v)")
                                 }.disposed(by: disposeBag)

                                 /*
                                 输出
                                 高温：next(34.0)
                                 高温：next(35.0)
                                 高温：next(36.0)
                                 高温：next(40.0)
                                 高温：completed
                                 */
                             }

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/19 10:25 上午
                             * @Description: 使用map将序列进行转换成需要的类型或一些特殊处理
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Maps() {

                                 // 温度序列
                                 let rxTemperature: Observable<Double> = Observable.of(30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 40.0)

                                 rxTemperature.map { wendu -> String in
                                     if (wendu > 33.0) {
                                         return "高温预警：\\(wendu)"
                                     } else {
                                         return "当前温度为：\\(wendu)"
                                     }
                                 }.subscribe { wendu in
                                     print(wendu)
                                 }.disposed(by: disposeBag)

                                 /*
                                 输出：
                                 next(当前温度为：30.0)
                                 next(当前温度为：31.0)
                                 next(当前温度为：32.0)
                                 next(当前温度为：33.0)
                                 next(高温预警：34.0)
                                 next(高温预警：35.0)
                                 next(高温预警：36.0)
                                 next(高温预警：40.0)
                                 completed
                                 */
                             }

                             ----------------------------------------
                             ----------------------------------------

                             /** 
                             * @Date: 2019/12/19 10:33 上午
                             * @Description: Zip可以将多个Observable合并为一个Observable 订阅此序列时想要获取元素时一定是序列1的一个元素和序列2的一个元素一对对的发送 
                             * @Param: -
                             * @Author: jie 
                             * @return: -
                             */
                             func Zips() {

                                 // 汉堡序列
                                 let rxHanBao: Observable<String> = Observable.of("汉堡1", "汉堡2", "汉堡3")

                                 // 薯条序列
                                 let rxShuTiao: Observable<String> = Observable.of("薯条1", "薯条2", "薯条3", "薯条4")

                                 // Zip操作符
                                 Observable.zip(rxHanBao, rxShuTiao).map {
                                     "组合套餐：\\($0) + \\($1)"
                                 }.subscribe { taocan in
                                     print(taocan)
                                 }.disposed(by: disposeBag)

                                 /*
                                 输出：
                                 next(组合套餐：汉堡1 + 薯条1)
                                 next(组合套餐：汉堡2 + 薯条2)
                                 next(组合套餐：汉堡3 + 薯条3)
                                 completed
                                 */
                             }
                             """
    }

    /** 
    * @Date: 2019/12/19 10:21 上午
    * @Description: 使用filter创建一个序列 filter中进行过滤操作，仅仅将满足条件的元素发送 
    * @Param: - 
    * @Author: jie 
    * @return: -
    */
    func Filters() {

        // 温度序列
        let rxTemperature: Observable<Double> = Observable.of(30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 40.0)

        rxTemperature.filter {
            $0 > 33.0
        }.subscribe { v in
            print("高温：\(v)")
        }.disposed(by: disposeBag)

        /*
        输出
        高温：next(34.0)
        高温：next(35.0)
        高温：next(36.0)
        高温：next(40.0)
        高温：completed
        */
    }

    /**
    * @Date: 2019/12/19 10:25 上午
    * @Description: 使用map将序列进行转换成需要的类型或一些特殊处理
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Maps() {

        // 温度序列
        let rxTemperature: Observable<Double> = Observable.of(30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 40.0)

        rxTemperature.map { wendu -> String in
            if (wendu > 33.0) {
                return "高温预警：\(wendu)"
            } else {
                return "当前温度为：\(wendu)"
            }
        }.subscribe { wendu in
            print(wendu)
        }.disposed(by: disposeBag)

        /*
        输出：
        next(当前温度为：30.0)
        next(当前温度为：31.0)
        next(当前温度为：32.0)
        next(当前温度为：33.0)
        next(高温预警：34.0)
        next(高温预警：35.0)
        next(高温预警：36.0)
        next(高温预警：40.0)
        completed
        */
    }

    /**
    * @Date: 2019/12/19 10:33 上午
    * @Description: Zip可以将多个Observable合并为一个Observable 订阅此序列时想要获取元素时一定是序列1的一个元素和序列2的一个元素一对对的发送
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Zips() {

        // 汉堡序列
        let rxHanBao: Observable<String> = Observable.of("汉堡1", "汉堡2", "汉堡3")

        // 薯条序列
        let rxShuTiao: Observable<String> = Observable.of("薯条1", "薯条2", "薯条3", "薯条4")

        // Zip操作符
        Observable.zip(rxHanBao, rxShuTiao).map {
            "组合套餐：\($0) + \($1)"
        }.subscribe { taocan in
            print(taocan)
        }.disposed(by: disposeBag)

        /*
        输出：
        next(组合套餐：汉堡1 + 薯条1)
        next(组合套餐：汉堡2 + 薯条2)
        next(组合套餐：汉堡3 + 薯条3)
        completed
        */
    }
}
