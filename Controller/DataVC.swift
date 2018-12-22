//
//  DataVC.swift
//  FitTrack
//
//  Created by Connor Buckley on 12/5/18.
//  Copyright © 2018 Connor Buckley. All rights reserved.
//

import UIKit
import Charts

class DataVC: UIViewController {
    
    
    //eventually replace this with my model class
    //Currently hard coded for testing
    
    private let model = dataModel.sharedInstance
    
    var numbers : [Double] = []
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //barChartView.noDataText = "You need to provide data for the chart."
        
        //here we should load our data into the numbers array
        //we should also load a second array with dates
        numbers = model.getNumbers()
        
        
       updateGraph()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        numbers = model.getNumbers()
        updateGraph()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var chtChart: LineChartView!
    
    
    func updateGraph() {
        
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        let backGround = UIColor.init(red: 194.0/255.0, green: 216.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        chtChart.backgroundColor = backGround
        
        //looping to set the data entries
        for i in 0..<numbers.count {
            let value = ChartDataEntry(x: Double(i), y: numbers[i]) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Current Weight") //Here we convert lineChartEntry to a LineChartDataSet
        
        let lineColor = UIColor.purple
        
        line1.colors = [lineColor] //Sets the colour to blue
        //style the line
        line1.setCircleColor(lineColor)
        line1.circleHoleColor = (lineColor)
        line1.circleRadius = 4.0
        line1.mode = .cubicBezier
        line1.cubicIntensity = 0.2
        line1.valueFont = .systemFont(ofSize: 0)
        
        //add a gradient
        
        
        let gradientColors = [lineColor.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0,0.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else {
            print("Gradient Error")
            return
        }
        line1.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        line1.drawFilledEnabled = true
        
        //add target line
        let ll = ChartLimitLine(limit: model.targetWeight, label: "Target Weight")
        chtChart.leftAxis.removeAllLimitLines()
        chtChart.leftAxis.addLimitLine(ll)
        
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        
        //style the chart
        chtChart.xAxis.drawGridLinesEnabled = false
        chtChart.xAxis.drawLabelsEnabled = false
        chtChart.rightAxis.enabled = false
        chtChart.xAxis.labelPosition = .bottom
        
        chtChart.legend.enabled = false
        
        //replace this with values based on target weight and minimum weight recorded
        
        var minY = model.getMin() - 30
        var maxY = model.getMax() + 30
        
        if (model.targetWeight > model.getMax()) {
            maxY = model.targetWeight + 30
        } else if (model.targetWeight < model.getMin()) {
            minY = model.targetWeight - 30
        }
        
        chtChart.leftAxis.axisMaximum = maxY
        chtChart.leftAxis.axisMinimum = minY
        
        chtChart.data = data //finally - it adds the chart data to the chart and causes an update
        
        chtChart.chartDescription?.text = "Progress Towards Weight Goal" // Here we set the description for the graph
        
        chtChart.chartDescription?.font = UIFont(name: "Didot", size: 16.0)!
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
