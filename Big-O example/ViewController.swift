//
//  ViewController.swift
//  Big-O example
//
//  Created by Chad Wiedemann on 10/24/16.
//  Copyright © 2016 Chad Wiedemann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createFileButton(_ sender: AnyObject) {
        self.findTime()
   
    }
    
    func findTime() -> Void {
        var CSVStringTotal: String = ""
        let unsortedArray: NSMutableArray = NSMutableArray(array: [])
        let title1: String = String("elements, n, nsquared\n")
        CSVStringTotal.append(title1)
        for i in 1...7{
            var elements: Int = 0
            
            if i == 1{
                elements = 2
            }else if i == 2{
                elements = 10
            }else if i==3{
                elements = 50
            }else if i==4{
                elements = 100
            }else if i==5{
                elements = 150
            }else if i == 6{
                elements = 300
            }else if i == 7{
                elements = 1000
            }
            
            unsortedArray.removeAllObjects()
            let methodStart1 = NSDate()
            for _ in 1...elements{
                let random: Int = Int(arc4random_uniform(9)+1)
                unsortedArray.add(random)
            }
            let methodFinished1 = NSDate()
            let executionTime1 = methodFinished1.timeIntervalSince(methodStart1 as Date)
            let s1 = String("\(unsortedArray.count),")
            let s2 = String("\(executionTime1),")
            
            let methodStart = NSDate()
            for j in 1...unsortedArray.count-1{
                let valueSorting: Int = unsortedArray[j] as! Int
                var i = 0
                i = j - 1
                while i >= 0 && unsortedArray[i] as! Int > valueSorting  {
                    unsortedArray[i + 1] = unsortedArray[i]
                    i = i - 1
                }
                unsortedArray[i + 1] = valueSorting
            }
            let methodFinished = NSDate()
            let executionTime = methodFinished.timeIntervalSince(methodStart as Date)
            let s3 = String("\(executionTime)")
            let CSVString = String("\(s1!)\(s2!)\(s3!)\n")
            CSVStringTotal.append(CSVString!)
        }
        print(CSVStringTotal)
        let fileName = "Test"
        let docDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        if let fileURL = docDirectory?.appendingPathComponent(fileName).appendingPathExtension("txt") {
            
            // Write to a file on disk
            let outString = CSVStringTotal
            do {
                try outString.write(to: fileURL, atomically: true, encoding: .utf8)
                print("success")
            } catch let error as NSError {
                print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
            }
            var inString = ""
            do {
                inString = try String(contentsOf: fileURL)
            } catch let error as NSError {
                print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
            }
            print("Read from file: \(inString)")
    
        }
   
    }

}
