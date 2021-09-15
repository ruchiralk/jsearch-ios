//
//  JobSearchViewModel.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import Foundation
import RxSwift
import RxCocoa

public class JobSearchViewModel {
    
    enum TableViewAction {
        case startOver
        case nextPage
    }
    
    private let bag = DisposeBag()
    
    let login = PublishSubject<Void>()
    let register = PublishSubject<Void>()
    
    let loadMore = PublishSubject<Void>()
    let refresh = PublishSubject<Void>()
    
    var isActive: Observable<Bool> {
        return _isActive
            .asObservable()
            .distinctUntilChanged()
    }
    private let _isActive = PublishSubject<Bool>()
    
    var error: Observable<Error> {
        _error
            .asObservable()
            .observe(on: scheduler)
    }
    private let _error = PublishSubject<Error>()
    
    var results: Observable<[TVSectionViewModel]> {
        data
            .map { [weak self] arr in
                arr.map {
                    let date = self?.dateFormatter.date(from: $0.key)
                    return TVSectionViewModel.from(date, data: $0.data)
                }
            }
    }
    
    private let data = BehaviorRelay<[FlexJobResult]>(value: [])
    
    private let flexJobRepository: FlexJobRepository
    
    private let scheduler: SchedulerType
    
    init(scheduler: SchedulerType = MainScheduler.instance,
         flexJobRepository: FlexJobRepository = FlexJobDefaultRepository()) {
        
        self.flexJobRepository = flexJobRepository
        
        self.scheduler = scheduler
        
        Observable.merge(loadMore.map { TableViewAction.nextPage }
                         ,refresh.map { TableViewAction.startOver })
            .debounce(.milliseconds(100), scheduler: scheduler)
            .do(onNext: { [weak self] _ in
                self?._isActive.onNext(true)
            })
            .map { [weak self] action -> (TableViewAction, String?) in
                switch(action) {
                case .startOver:
                    return (action, self?.startingPagingKey())
                case .nextPage:
                    return (action, self?.nextPagingKey())
                }
            }
            .filter { args in
                let (_, key) = args
                return key != nil
            }
            .flatMapLatest { args -> Observable<(TableViewAction, FlexJobResult?)> in
                let (action, key) = args
                return self.flexJobRepository
                    .fetchJobs(key: key!)
                    .catch({ [weak self] error in
                        self?._error.onNext(error)
                        return Observable.just(nil)
                    })
                    .map { (action, $0) }
            }
            .do(onNext: { [weak self] _ in
                self?._isActive.onNext(false)
            })
            .subscribe { [weak self] args in
                let (action, result) = args
                guard let result = result else {
                    return
                }
                switch action {
                case .startOver:
                    self?.data.accept([result])
                case .nextPage:
                    let arr = (self?.data.value ?? []) + [result]
                    self?.data.accept(arr)
                }
            } onError: { error in
                print("server error: \(error)")
            }
            .disposed(by: bag)
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func nextPagingKey() -> String {
        guard let lastKey = data.value.last?.key else {
            return startingPagingKey()
        }
        let currentPagingDate = dateFormatter.date(from: lastKey)!
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentPagingDate)!
        return dateFormatter.string(from: nextDate)
    }
    
    func startingPagingKey() -> String {
        dateFormatter.string(from: Date())
    }
}
