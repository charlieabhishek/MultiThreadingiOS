//
//  ViewController.swift
//  MultiThreading
//
//  Created by Abhishek Kumar on 18/04/19.
//  Copyright © 2019 CharlieAbhishek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        syncExample()
//        asyncExample()
//        deadLockExample1()
//        queuesWitQOS()
//        concurrentQueues()
//        queueWithDelay()
//        workItemExample()
//        deadLock2()
//        deadLock3()
//        dispatchGrpExample()
          semaphoreExample()
    }
    
    func semaphoreExample(){
        
        let semaphore = DispatchSemaphore(value: 1)
        
        let highPriority = DispatchQueue.global(qos: .userInitiated)
        let lowerPriority = DispatchQueue.global(qos: .userInteractive)
        func asyncPrint(queue:DispatchQueue, symbol:String){
            queue.async {
                print("\(symbol) waiting")
                semaphore.wait() // Requesting the resource
                
                for i in 0...100{
                    print(symbol,i)
                }
                
                print("\(symbol) signal")
                semaphore.signal() // Releasing the resource
            }
        }
        
        asyncPrint(queue: highPriority, symbol: "🍏")
        asyncPrint(queue: lowerPriority, symbol: "🍎")
    }
    
    func task1(dispatchGroup:DispatchGroup){
        DispatchQueue.global().async {
            print("Task 1 executed")
            dispatchGroup.leave()
        }
    }
    
    func task2(dispatchGroup:DispatchGroup){
        DispatchQueue.global().async {
            print("Task 2 executed")
            dispatchGroup.leave()
        }
    }
    
    func task3(dispatchGroup:DispatchGroup){
        DispatchQueue.main.async {
            print("Task 3 executed")
            dispatchGroup.leave()
        }
    }
    
    func dispatchGrpExample(){
        let dispatchGroup = DispatchGroup()
         dispatchGroup.enter()
        task1(dispatchGroup: dispatchGroup)
         dispatchGroup.enter()
        task2(dispatchGroup: dispatchGroup)
         dispatchGroup.enter()
        task3(dispatchGroup: dispatchGroup)
        
        dispatchGroup.notify(queue: .main) {
            print("All Tasks Completed..😎")
        }
    }
    
    func deadLock2(){
        DispatchQueue.main.sync {
            print("Main Queue Sync")
        }
    }
    
    func deadLock3(){
        DispatchQueue.global().sync {
            DispatchQueue.main.sync {
                print("Main Queue Sync")
            }
        }
        
        //Below code work, as main sync stop global queue and then execute task in main queue synchronously..
//        DispatchQueue.global().async {
//            DispatchQueue.main.sync {
//                print("Main Queue Sync")
//            }
//        }
    }
    
    func workItemExample(){
        var value = 10
        
        let workItem = DispatchWorkItem {
            value += 5
        }
        
        workItem.perform()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async(execute: workItem)
        workItem.notify(queue: DispatchQueue.main) {
            print("value = \(value)")
        }
    }
    
    func queueWithDelay(){
        let delayQueue = DispatchQueue(label: "delayQueueExmp",qos: .userInitiated)
        print(Date())
        let additionalTime:DispatchTimeInterval = .seconds(2)
        
        delayQueue.asyncAfter(deadline: .now()+additionalTime) {
            print(Date())
        }
    }
    
    func concurrentQueues(){
        let anotherQueue = DispatchQueue(label: "com.multithreading.concurr", qos: .utility, attributes: .concurrent)
        anotherQueue.async {
            for i in 0..<30{
                print("🏓",i)
            }
        }
        anotherQueue.async {
            for i in 100..<120{
                print("⚽️",i)
            }
        }
        anotherQueue.async {
            for i in 1000..<1020{
                print("📘",i)
            }
        }
    }
    
    func queuesWitQOS(){
        let queue1 = DispatchQueue(label: "com.multithreading.queue1",qos: .userInitiated)
        let queue2 = DispatchQueue(label: "com.multithreading.queue2",qos: .utility)
        queue1.async {
            for i in 0..<10{
                print("💔",i)
            }
        }
        queue2.async {
            for i in 100..<110{
                print("💙",i)
            }
        }
        for i in 1000..<1010{
            print("🎾",i)
        }
    }
    
    func deadLockExample1(){
        let queueAsync = DispatchQueue(label: "com.multithreading.queueAsync")
        
        queueAsync.async {
            for i in 1...1130{
                print("📟 \(i)")
            }
        }
        for i in 1...200{
            print("☪️ \(i)")
        }
        queueAsync.sync {
            for i in 1...100{
                print("💛 \(i)")
            }
        }
        
    }
    
    func asyncExample(){
        let queue = DispatchQueue(label: "com.multithreading.queue1")
        queue.async {
            for i in 0..<10{
                print("🚒 \(i)")
            }
        }
        
        for i in 100..<110{
            print("🚐 \(i)")
        }
    }
    
    func syncExample(){
        let queue = DispatchQueue(label: "com.multithreading.queue")
        queue.sync {
            for i in 0..<10{
                print("🚒 \(i)")
            }
        }
        
        for i in 100..<110{
            print("🚐 \(i)")
        }
    }

}

