//
//  JobSearchViewModelTests.swift
//  jsearch-iosTests
//
//  Created by Ruchira on 2021-09-15.
//

import XCTest
import RxTest
import RxSwift
@testable import jsearch_ios

class JobSearchViewModelTests: XCTestCase {
    
    var sut: JobSearchViewModel!
    var repository: FlexJobRepository!
    var scheduler: TestScheduler!
    var bag: DisposeBag!
    
    override func setUpWithError() throws {
        // mock current date in-order to make unit tests reliable
        Date.overrideCurrentDate(Date.mockDate)
        
        bag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        repository = FakeFlexJobRepository()
        sut = JobSearchViewModel(scheduler: scheduler,
                                 flexJobRepository: repository)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        repository = nil
        scheduler = nil
        Date.overrideCurrentDate(Date())
    }
    
    func testStartingPagingKey_returnsCurrentDate() {
        XCTAssertEqual(sut.startingPagingKey(), "2001-01-01")
    }
    
    func testNextPagingKey_ifNoData_returnsCurrentDate() {
        XCTAssertEqual(sut.nextPagingKey(), "2001-01-01")
    }
    
    func testNextPageKey_withData_returnsCorrectDate() {
        // call load more
        scheduler.createColdObservable([.next(100, ())])
            .bind(to: sut.loadMore)
            .disposed(by: bag)
        
        scheduler.start()
        
        XCTAssertEqual(sut.nextPagingKey(), "2001-01-02")
    }
    
    func testLoadMore_emitCorrectData() {
        // results observer
        let resultsObserver = scheduler.createObserver([TVSectionViewModel].self)
        
        // bind the reulsts
        sut.results
            .drive(resultsObserver)
            .disposed(by: bag)
        
        // smilulate paging
        scheduler.createColdObservable(
            [.next(100, ()),
             .next(200, ()),
             .next(300, ())]
        )
        .bind(to: sut.loadMore)
        .disposed(by: bag)
        
        scheduler.start()
        
        let results = resultsObserver.events.compactMap {
            $0.value.element
        }
        
        let expected = [
            [FakeFlexJobRepository.Result_2001_01_01.model()],
            //
            [FakeFlexJobRepository.Result_2001_01_01.model(),
             FakeFlexJobRepository.Result_2001_01_02.model()],
            //
            [FakeFlexJobRepository.Result_2001_01_01.model(),
             FakeFlexJobRepository.Result_2001_01_02.model(),
             FakeFlexJobRepository.Result_2001_01_03.model()]
        ]
        XCTAssertEqual(results, expected)
    }
    
    func testPullToRefresh_emitFirstPage() {
        // results observer
        let resultsObserver = scheduler.createObserver([TVSectionViewModel].self)
        
        // bind the reulsts
        sut.results
            .drive(resultsObserver)
            .disposed(by: bag)
        
        // smilulate paging
        scheduler.createColdObservable(
            [.next(100, ()),
             .next(200, ()),
             .next(300, ())]
        )
        .bind(to: sut.loadMore)
        .disposed(by: bag)
        
        // call refresh after loading few pages
        scheduler.createColdObservable([.next(400, ())])
            .bind(to: sut.refresh)
            .disposed(by: bag)
        
        scheduler.start()
        
        // The last emitted event should have first page only
        let results = resultsObserver.events.last?.value.element
        
        let expected = [FakeFlexJobRepository.Result_2001_01_01.model()]
        XCTAssertEqual(results, expected)
    }
    
    func testLoadMore_activateIsActive() {
        // isActive observer
        let isActiveObserver = scheduler.createObserver(Bool.self)
        
        // bind isActive
        sut.isActive
            .drive(isActiveObserver)
            .disposed(by: bag)
        
        // call load more
        scheduler.createColdObservable([.next(100, ())])
            .bind(to: sut.loadMore)
            .disposed(by: bag)
        
        scheduler.start()
        
        let results = isActiveObserver.events.compactMap { $0.value.element }
        let expected = [true, false]
        
        XCTAssertEqual(results, expected)
    }
    
    func testOnError_emitCorrectError() {
        let expected = APIError.responseError(code: 500, description: "server error")
        
        // error observer
        let errorObserver = scheduler.createObserver(Error?.self)
        // bind error
        sut.error
            .drive(errorObserver)
            .disposed(by: bag)
        
        // smilulate paging
        scheduler.createColdObservable(
            [.next(100, ()),
             .next(200, ()),
             .next(300, ())]
        )
        .bind(to: sut.loadMore)
        .disposed(by: bag)
        
        // schedule error prior to last paging call
        scheduler.scheduleAt(250) {
            (self.repository as! FakeFlexJobRepository).error = expected
        }
        
        scheduler.start()
        
        let results = errorObserver.events.compactMap { $0.value.element }
        
        XCTAssert(results.count == 1)
        XCTAssertEqual(results.last!!.localizedDescription, expected.localizedDescription)
    }
}


