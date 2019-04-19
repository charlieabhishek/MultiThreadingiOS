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
          workItemExample()
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
        let queueSync  = DispatchQueue(label: "com.multithreading.queueSync")
        
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

