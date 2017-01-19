//
//  ViewModel.swift
//  DemoRxSwift
//
//  Created by Chris Hu on 17/1/18.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import Foundation

import RxSwift
import RxDataSources


// 用于将data传递给dataSource
class ViewModel {
    
    func getUsers() -> Observable<[SectionModel<String, User>]> {
        // 一组value的序列
        // 这里是一组SectionModel的数组，包含String和User。
        return Observable.create({ (observer) -> Disposable in
            let users = [
                User(followersCount: 1005, followingCount: 495, screenName: "BalestraPatrick"),
                User(followersCount: 380, followingCount: 5, screenName: "RxSwiftLang"),
                User(followersCount: 36069, followingCount: 0, screenName: "SwiftLang"),
            ]
            let section = [SectionModel(model: "", items: users)] // 这里section标题为空
            observer.onNext(section)
            observer.onCompleted() // 数组已经就绪，
            return Disposables.create()
        })
    }

}
