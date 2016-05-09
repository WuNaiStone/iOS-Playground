//
//  ViewController.swift
//  DemoPNChartSwift
//
//  Created by Chris Hu on 16/5/7.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit
import PNChartSwift

class ViewController: UIViewController, PNChartDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLineChart()
        
        self.addBarChart()
    }
    
    func addLineChart() {
        let lineChart:PNLineChart = PNLineChart(frame: CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 200))
        lineChart.yLabelFormat = "%1.1f"
        lineChart.showLabel = true
        lineChart.backgroundColor = UIColor.clearColor()
        lineChart.xLabels = ["SEP 1","SEP 2","SEP 3","SEP 4","SEP 5","SEP 6","SEP 7",
        ]
        lineChart.showCoordinateAxis = true
        lineChart.delegate = self
        
        // Line Chart Nr.1
        var data01Array: [CGFloat] = [60.1, 160.1, 126.4, 262.2, 186.2, 127.2, 176.2,
        ]
        let data01:PNLineChartData = PNLineChartData()
        data01.color = PNGreenColor
        data01.itemCount = data01Array.count
        data01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
        data01.getData = ({(index: Int) -> PNLineChartDataItem in
            let yValue:CGFloat = data01Array[index]
            let item = PNLineChartDataItem(y: yValue)
            return item
        })
        
        lineChart.chartData = [data01]
        lineChart.strokeChart()
        
        self.view.addSubview(lineChart)
    }
    
    func addBarChart() {
        let barChart = PNBarChart(frame: CGRectMake(0, 400, CGRectGetWidth(self.view.frame), 200.0))
        barChart.backgroundColor = UIColor.clearColor()
        //            barChart.yLabelFormatter = ({(yValue: CGFloat) -> NSString in
        //                var yValueParsed:CGFloat = yValue
        //                var labelText:NSString = NSString(format:"%1.f",yValueParsed)
        //                return labelText;
        //            })
        
        
        // remove for default animation (all bars animate at once)
        barChart.animationType = .Waterfall
        
        
        barChart.labelMarginTop = 5.0
        barChart.xLabels = ["SEP 1","SEP 2","SEP 3","SEP 4","SEP 5","SEP 6","SEP 7",
        ]
        barChart.yValues = [1,24,12,18,30,10,21,
        ]
        barChart.strokeChart()
        
        barChart.delegate = self
    
        self.view.addSubview(barChart)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - PNChartDelegate
    
    func userClickedOnLineKeyPoint(point: CGPoint, lineIndex: Int, keyPointIndex: Int)
    {
        print("Click Key on line \(point.x), \(point.y) line index is \(lineIndex) and point index is \(keyPointIndex)")
    }
    
    func userClickedOnLinePoint(point: CGPoint, lineIndex: Int)
    {
        print("Click Key on line \(point.x), \(point.y) line index is \(lineIndex)")
    }
    
    func userClickedOnBarChartIndex(barIndex: Int)
    {
        print("Click  on bar \(barIndex)")
    }
    

}

