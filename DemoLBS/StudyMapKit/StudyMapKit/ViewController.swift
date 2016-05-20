//
//  ViewController.swift
//  StudyMapKit
//
//  Created by Chris Hu on 15/4/24.
//  Copyright (c) 2015年 edu.self. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.delegate = self
        // MKMapView中有一个delegate属性, ViewController继承MKMapViewDelegate协议,就必须实现该协议中的必需的方法
        
        let location = CLLocationCoordinate2D(latitude: 22.284681, longitude: 114.158177)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        // region可以视为以location为中心, 方圆多少范围
        let region = MKCoordinateRegion(center: location, span: span)
        // mapView会显示该region的map
        // mapView.mapType = MKMapType.Standard
        mapView.setRegion(region, animated: true)
        
        // 在地图上添加一个位置标注
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Hong Kong"
        annotation.subtitle = "Someplace"
        mapView.addAnnotation(annotation)

        // 在地图上添加另一个位置标注
        let location2 = CLLocationCoordinate2D(latitude: 22.294681, longitude: 114.170177)
        let annotation2: MKPointAnnotation = MKPointAnnotation()
        annotation2.coordinate = location2
        annotation2.title = "Hong Kong"
        annotation2.subtitle = "Someplace2"
        mapView.addAnnotation(annotation2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 点击该annotation的时候, 调用
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        print("didAddAnnotationViews")
        let annotationView: MKAnnotationView = views[0] 
        let annotation = annotationView.annotation
        let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(annotation!.coordinate, 500, 500)
        self.mapView.centerCoordinate = region.center
        self.mapView.setRegion(region, animated: true)
        self.mapView.selectAnnotation(annotation!, animated: true)
    }
}

