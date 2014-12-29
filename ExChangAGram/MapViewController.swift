//
//  MapViewController.swift
//  ExChangAGram
//
//  Created by BenLacroix on 29/12/2014.
//  Copyright (c) 2014 Benobab. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
//        let center = CLLocationCoordinate2D(latitude: 48.845849722424984, longitude: 53.93853534329832)
//        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        let region = MKCoordinateRegionMake( center, span)
//        mapView.setRegion(region, animated: true)
//        let annotation = MKPointAnnotation()
//        annotation.setCoordinate(center)
//        annotation.title = "Actual locaton"
//        annotation.subtitle = "Hyeres city ?"
//        mapView.addAnnotation(annotation)
        let request = NSFetchRequest(entityName: "FeedItem")
        let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext! as NSManagedObjectContext
        var error:NSError?
        let itemArray = context.executeFetchRequest(request, error: &error)
        println(error)
        
        if (itemArray!.count > 0)
        {
            for item in itemArray! {
                let location = CLLocationCoordinate2D(latitude: Double(item.latitude), longitude: Double(item.longitude))
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegionMake(location, span)
                mapView.setRegion(region, animated: true)
                let annotation = MKPointAnnotation()
                annotation.setCoordinate(location)
                annotation.title = item.caption
                mapView.addAnnotation(annotation)
            }
        }
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
