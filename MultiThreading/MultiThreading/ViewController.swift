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
        queuesWitQOS()
    }
    
    func queuesWitQOS(){
        let queue1 = DispatchQueue(label: "com.multithreading.queue1",qos: .userInteractive)
        let queue2 = DispatchQueue(label: "com.multithreading.queue2",qos: .userInitiated)
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

