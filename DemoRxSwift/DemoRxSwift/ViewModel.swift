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
    
    // 返回的Observable，其Element是[SectionModel<String, User>]对象，即多个sectionModel
    func getUsers() -> Observable<[SectionModel<String, User>]> {
        // 一组value的序列
        // 这里是一组SectionModel的数组，包含String和User。
        return Observable.create({ (observer) -> Disposable in
            let users = [
                User(followersCount: 1005,      followingCount: 495,    screenName: "Chris"),
                User(followersCount: 380,       followingCount: 5,      screenName: "RxSwiftLang"),
                User(followersCount: 36069,     followingCount: 0,      screenName: "SwiftLang"),
                User(followersCount: 231005,    followingCount: 5,      screenName: "iOS"),
                User(followersCount: 431005,    followingCount: 5,      screenName: "AI"),
            ]
            let section = [SectionModel(model: "section", items: users)] // 这里section标题为空
            observer.onNext(section)
            observer.onCompleted() // 数组已经就绪，
            return Disposables.create()
        })
    }

}
