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
    
    static let serverDateFormat = "yyyy-MM-dd"
    
    private enum TableViewAction {
        case startOver
        case nextPage
    }
    
    private let bag = DisposeBag()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = JobSearchViewModel.serverDateFormat
        return formatter
    }()
    
    // input
    
    // launch login screen
    let login = PublishSubject<Void>()
    // launch register screen
    let register = PublishSubject<Void>()
    
    let loadMore = PublishSubject<Void>()
    let refresh = PublishSubject<Void>()
    
    // output
    var isActive: Driver<Bool> {
        return _isActive
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
    }
    private let _isActive = PublishSubject<Bool>()
    
    var error: Driver<Error?> {
        _error
            .asDriver(onErrorJustReturn: nil)
    }
    private let _error = PublishSubject<Error?>()
    
    var results: Driver<[TVSectionViewModel]> {
        data
            .skip(1)
            .map { arr in
                arr.map {
                    return TVSectionViewModel.from($0.key, data: $0.data)
                }
            }
            .asDriver(onErrorJustReturn: [])
    }
    
    
    private let data = BehaviorRelay<[FlexJobResult]>(value: [])
    
    private let flexJobRepository: FlexJobRepository
    
    private let scheduler: SchedulerType
    
    init(scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .userInteractive),
         flexJobRepository: FlexJobRepository = FlexJobDefaultRepository()) {
        
        self.flexJobRepository = flexJobRepository
        
        self.scheduler = scheduler
        
        Observable.merge(loadMore.map { TableViewAction.nextPage }
                         ,refresh.map { TableViewAction.startOver })
            .observe(on: scheduler)
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
                    // stop observable chain from disposing on server errors
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
            } onError: { [weak self] error in
                self?._error.onNext(error)
            }
            .disposed(by: bag)
    }
    
    // return next paging key based on last page in datasource
    func nextPagingKey() -> String {
        guard let lastKey = data.value.last?.key else {
            return startingPagingKey()
        }
        let currentPagingDate = dateFormatter.date(from: lastKey)!
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentPagingDate)!
        return dateFormatter.string(from: nextDate)
    }
    
    // return paging key for current date
    func startingPagingKey() -> String {
        dateFormatter.string(from: Date.current)
    }
}
