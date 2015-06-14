//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Alexander Hoekje List on 6/9/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var nextPhoto: UIImage!
    var annotations: [PhotoAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1)), animated: false)
        mapView.delegate = self
    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let reuseID = "myAnnotationView"
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
        if (annotationView == nil) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            annotationView.canShowCallout = true
            annotationView.leftCalloutAccessoryView = UIImageView(frame: CGRect(x:0, y:0, width: 30, height:30))

            var detailsButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIButton
            annotationView.rightCalloutAccessoryView = detailsButton
        }
        
        var resizeRenderImageView = UIImageView(frame: CGRectMake(0, 0, 45, 45))
        resizeRenderImageView.layer.borderColor = UIColor.whiteColor().CGColor
        resizeRenderImageView.layer.borderWidth = 3.0
        resizeRenderImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeRenderImageView.image = (annotation as? PhotoAnnotation)?.photo

        UIGraphicsBeginImageContext(resizeRenderImageView.frame.size)
        resizeRenderImageView.layer.renderInContext(UIGraphicsGetCurrentContext())
        var thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let accessoryImageView = annotationView.leftCalloutAccessoryView as! UIImageView
        accessoryImageView.image = thumbnail
        annotationView.image = thumbnail
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        performSegueWithIdentifier("fullImageSegue", sender: (view.annotation as? PhotoAnnotation)?.photo)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        var vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
             vc.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            var originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            var editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            dismissViewControllerAnimated(true, completion: nil)
            performSegueWithIdentifier("tagSegue", sender: editedImage)
    }
    
    func locationsPickedLocation(controller: LocationsViewController, latitude: NSNumber,longitude: NSNumber) {
        var coordinate = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue)
        var image = controller.userInfo as! UIImage
        
        navigationController?.popToViewController(self, animated: true)
        
        var annotation = PhotoAnnotation()
        annotation.coordinate = coordinate
        annotation.photo = image
        
        annotations.append(annotation)
        mapView.addAnnotation(annotation)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if var locations = segue.destinationViewController as? LocationsViewController {
            locations.delegate = self
            locations.userInfo = sender
        }else if var fullImageVC = segue.destinationViewController as? FullImageViewController {
            fullImageVC.image = sender as! UIImage
        }
    }
}
