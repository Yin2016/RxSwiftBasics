//
// Created by Yin on 2019/12/19.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class ErrorHandlingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Error Handling"

        Retrys()

        self.codeText.text = """
                             /*
                             Error Handling 错误处理
                             一旦序列里面出了一个error事件，整个序列将被终止。RxSwift主要有两种错误处理机制：
                             retry - 重试
                             catch - 恢复
                             */

                             ----------------------------------------
                             ----------------------------------------

                             /** 
                             * @Date: 2019/12/19 1:56 下午
                             * @Description: retry可以让序列在发生错误后重试
                             *               通过.retry(3)来设置重试次数，3代表重试次数可以自行配置，当达到重试次数仍然失败将抛出错误
                             *
                             *               通过.retryWhen { (rxError: Observable<Error>) -> Observable<Int> in return Observable.timer(5, scheduler: MainScheduler.instance)}
                             *               来控制重试的时机 以上例子：失败之后延迟5秒执行下一次
                             *               当出现error或者completed事件时，就不会重试，并且将这个事件传递给后边的Observer
                             *               如果需要设置重试最大次数，需要使用 flateMapWithIndex 操作符，它可以提供错误的索引个数，通过索引设置次数条件，当达到最大次数时抛出错误
                             * @Param: - 
                             * @Author: jie 
                             * @return: - 
                             */
                             func Retrys() {
                                 let rxJson: Observable<String> = Observable.of("123")

                                 rxJson
                                         .retry(3)
                                         .subscribe(
                                                 onNext: { str in print(str) },
                                                 onError: { error in
                                                     print("异常")
                                                 }).disposed(by: disposeBag)

                                 rxJson
                                         .retryWhen { (rxError: Observable<Error>) -> Observable<Int> in
                                             return Observable.timer(5, scheduler: MainScheduler.instance)
                                         }
                                         .subscribe { s in
                                             print(s)
                                         }.disposed(by: disposeBag)

                                 rxJson
                                         .retryWhen { (rxError: Observable<Error>) -> Observable<Int> in
                                             return rxError.flatMapWithIndex { (error, index) -> Observable<Int> in
                                                 guard index < 3 else {
                                                     return  Observable.error(error)
                                                 }

                                                 return Observable.timer(5, scheduler: MainScheduler.instance)
                                             }
                                         }
                                         .subscribe { s in
                                             print(s)
                                         }.disposed(by: disposeBag)
                             }

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/19 3:46 下午
                             * @Description: CatchError - 恢复
                             *               catchError可以在产生错误时，用一个备用元素或一组备用元素将错误替换掉
                             *               使用.catchErrorJustReturn(备用元素)在出现错误时将备用元素返回
                             *               例如：
                             *               searchGitHub(query).catchErrorJustReturn([])
                             *               当searchGitHub(query)异常时返回一个空数组
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func CatchErrors() {
                                 /*
                                 searchBar.rx.text.orEmpty
                                         ...
                                         .flatMapLatest { query -> Observable<[Repository]> in
                                             ...
                                             return searchGitHub(query)
                                                     .catchErrorJustReturn([])
                                         }
                                 ...
                                 .bind(to: ...)
                                         .disposed(by: disposeBag)
                                 */
                             }

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/19 3:50 下午
                             * @Description: 如果只是想给用户提示错误信息则使用Result
                             *               通过 .flateMapLatest将将返回值用 Result<Void, Error>包裹
                             *               请求结果将会返回一个Restult枚举
                             *               在订阅结果时需要在onNext事件中判断Result类型
                             *               根据实际返回类型 .success处理成功结果 .failure来处理异常信息
                             *               因为error是通过Result包裹后传递回来的，所以不会触发onError和onCompleted事件，
                             *               因此不会终止订阅，当用户再次请求时仍可以继续进行验证
                             *               
                             *               例如：
                             *               // 转换
                             *               .flatMapLatest { userInfo -> Observable<Result<Void, Error>> in
                             *               return update(userInfo)
                             *                       .map(Result.success)  // 转换成 Result
                             *                       .catchError { error in Observable.just(Result.failure(error)) }
                             *               
                             *               // 订阅
                             *               .subscribe(onNext: { result in
                             *               switch result {           // 处理 Result
                             *               case .success:
                             *                   print("用户信息更新成功")
                             *               case .failure(let error):
                             *                   print("用户信息更新失败： \\(error.localizedDescription)")
                             *               }
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Results() {

                                 /*
                                     系统提供两个错误枚举
                                     public enum Result<Success, Failure> where Failure : Error {
                                         case success(Success)
                                         case failure(Failure)
                                     }
                                 */

                                 /*
                                 updateUserInfoButton.rx.tap
                                         .withLatestFrom(rxUserInfo)
                                         .flatMapLatest { userInfo -> Observable<Result<Void, Error>> in
                                             return update(userInfo)
                                                     .map(Result.success)  // 转换成 Result
                                                     .catchError { error in Observable.just(Result.failure(error)) }
                                         }
                                         .observeOn(MainScheduler.instance)
                                         .subscribe(onNext: { result in
                                             switch result {           // 处理 Result
                                             case .success:
                                                 print("用户信息更新成功")
                                             case .failure(let error):
                                                 print("用户信息更新失败： \\(error.localizedDescription)")
                                             }
                                         })
                                         .disposed(by: disposeBag)
                                   */
                             }
                             """
    }


    /*
        Error Handling 错误处理
        一旦序列里面出了一个error事件，整个序列将被终止。RxSwift主要有两种错误处理机制：
        retry - 重试
        catch - 恢复
    */

    /** 
    * @Date: 2019/12/19 1:56 下午
    * @Description: retry可以让序列在发生错误后重试
    *               通过.retry(3)来设置重试次数，3代表重试次数可以自行配置，当达到重试次数仍然失败将抛出错误
    *
    *               通过.retryWhen { (rxError: Observable<Error>) -> Observable<Int> in return Observable.timer(5, scheduler: MainScheduler.instance)}
    *               来控制重试的时机 以上例子：失败之后延迟5秒执行下一次
    *               当出现error或者completed事件时，就不会重试，并且将这个事件传递给后边的Observer
    *               如果需要设置重试最大次数，需要使用 flateMapWithIndex 操作符，它可以提供错误的索引个数，通过索引设置次数条件，当达到最大次数时抛出错误
    * @Param: - 
    * @Author: jie 
    * @return: - 
    */
    func Retrys() {
        let rxJson: Observable<String> = Observable.of("123")

        rxJson
                .retry(3)
                .subscribe(
                        onNext: { str in print(str) },
                        onError: { error in
                            print("异常")
                        }).disposed(by: disposeBag)

        rxJson
                .retryWhen { (rxError: Observable<Error>) -> Observable<Int> in
                    return Observable.timer(5, scheduler: MainScheduler.instance)
                }
                .subscribe { s in
                    print(s)
                }.disposed(by: disposeBag)

        rxJson
                .retryWhen { (rxError: Observable<Error>) -> Observable<Int> in
                    return rxError.flatMapWithIndex { (error, index) -> Observable<Int> in
                        guard index < 3 else {
                            return  Observable.error(error)
                        }

                        return Observable.timer(5, scheduler: MainScheduler.instance)
                    }
                }
                .subscribe { s in
                    print(s)
                }.disposed(by: disposeBag)
    }

    /**
    * @Date: 2019/12/19 3:46 下午
    * @Description: CatchError - 恢复
    *               catchError可以在产生错误时，用一个备用元素或一组备用元素将错误替换掉
    *               使用.catchErrorJustReturn(备用元素)在出现错误时将备用元素返回
    *               例如：
    *               searchGitHub(query).catchErrorJustReturn([])
    *               当searchGitHub(query)异常时返回一个空数组
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func CatchErrors() {
        /*
        searchBar.rx.text.orEmpty
                ...
                .flatMapLatest { query -> Observable<[Repository]> in
                    ...
                    return searchGitHub(query)
                            .catchErrorJustReturn([])
                }
        ...
        .bind(to: ...)
                .disposed(by: disposeBag)
        */
    }

    /**
    * @Date: 2019/12/19 3:50 下午
    * @Description: 如果只是想给用户提示错误信息则使用Result
    *               通过 .flateMapLatest将将返回值用 Result<Void, Error>包裹
    *               请求结果将会返回一个Restult枚举
    *               在订阅结果时需要在onNext事件中判断Result类型
    *               根据实际返回类型 .success处理成功结果 .failure来处理异常信息
    *               因为error是通过Result包裹后传递回来的，所以不会触发onError和onCompleted事件，
    *               因此不会终止订阅，当用户再次请求时仍可以继续进行验证
    *
    *               例如：
    *               // 转换
    *               .flatMapLatest { userInfo -> Observable<Result<Void, Error>> in
    *               return update(userInfo)
    *                       .map(Result.success)  // 转换成 Result
    *                       .catchError { error in Observable.just(Result.failure(error)) }
    *
    *               // 订阅
    *               .subscribe(onNext: { result in
    *               switch result {           // 处理 Result
    *               case .success:
    *                   print("用户信息更新成功")
    *               case .failure(let error):
    *                   print("用户信息更新失败： \(error.localizedDescription)")
    *               }
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Results() {

        /*
            系统提供两个错误枚举
            public enum Result<Success, Failure> where Failure : Error {
                case success(Success)
                case failure(Failure)
            }
        */

        /*
        updateUserInfoButton.rx.tap
                .withLatestFrom(rxUserInfo)
                .flatMapLatest { userInfo -> Observable<Result<Void, Error>> in
                    return update(userInfo)
                            .map(Result.success)  // 转换成 Result
                            .catchError { error in Observable.just(Result.failure(error)) }
                }
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { result in
                    switch result {           // 处理 Result
                    case .success:
                        print("用户信息更新成功")
                    case .failure(let error):
                        print("用户信息更新失败： \(error.localizedDescription)")
                    }
                })
                .disposed(by: disposeBag)
          */
    }

}
