//
//  ViewController.swift
//  DataMapper
//
//  Created by Mark Pleskac on 12/15/14.
//  Copyright (c) 2014 Mark Pleskac. All rights reserved.
//

import Cocoa
import Foundation
import MapKit

class ViewController: NSViewController {

    @IBOutlet var mapView: MKMapView!

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var points = getJsonCoordinates()
        for point in points{
            var annotation = MKPointAnnotation()
            var l = CLLocationCoordinate2D(latitude: point["Latitude"] as Double, longitude: point["Longitude"] as Double)
            annotation.setCoordinate(l)
            annotation.title = point["Title"] as String
            mapView.addAnnotation(annotation)
        }
        
        mapView.showAnnotations(mapView.annotations, animated: true)

    }
    
    func getJsonCoordinates() -> NSArray {
        var url: NSURL = NSURL(string: "http://pleskac.org:8080/api/trip/id/11")!
        
        var request1: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var error: NSErrorPointer = nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request1, returningResponse: response, error:nil)!
        var err: NSError
        println(response)
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        return jsonResult["Coordinates"] as NSArray;

    }


}

