//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Alexander Hoekje List on 6/9/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1)), animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
