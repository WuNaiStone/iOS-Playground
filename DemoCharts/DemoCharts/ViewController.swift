//
//  ViewController.swift
//  DemoCharts
//
//  Created by Chris Hu on 16/5/7.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    var pieChartView    : PieChartView!
    
    var lineChartView   : LineChartView!
    
    var barChartView    : BarChartView!
    
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
                  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    ]
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0,
                     20.0, 4.0, 6.0, 3.0, 12.0, 16.0,
                     20.0, 4.0, 6.0, 3.0, 12.0, 16.0,
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.lineChartView = LineChartView(frame: CGRectMake(20, 10, 300, 200))
        self.lineChartView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.lineChartView)
        self.drawLineChart(months, values: unitsSold)
        
        
        
        self.pieChartView = PieChartView(frame: CGRectMake(20, 220, 300, 200))
        self.pieChartView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.pieChartView)
        self.drawPieChart(months, values: unitsSold)
        
        
        
        self.barChartView = BarChartView(frame: CGRectMake(20, 440, 300, 200))
        self.barChartView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.barChartView)
        self.drawBarChart(months, values: unitsSold)
    }
    
    func drawLineChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        // Line Chart
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        self.lineChartView.data = lineChartData
    }

    func drawPieChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        // Pie Chart
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Units Sold")
        
        var colors: [UIColor] = []
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        self.pieChartView.data = pieChartData
    }
    
    func drawBarChart(dataPoints: [String], values: [Double]) {
        var barDataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            barDataEntries.append(dataEntry)
        }
        
        // Bar Chart
        let barChartDataSet = BarChartDataSet(yVals: barDataEntries, label: "Units Sold")
        let barChartData = BarChartData(xVals: dataPoints, dataSet: barChartDataSet)
        self.barChartView.data = barChartData
    }

}

