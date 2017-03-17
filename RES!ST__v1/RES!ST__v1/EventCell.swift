//
//  EventCell.swift
//  RES!ST__v1
//
//  Created by soniclouds on 3/16/17.
//  Copyright © 2017 soniclouds. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class EventCell: UITableViewCell {
    
    var showsDetails = false {
        didSet {
            secondViewHeight.priority = showsDetails ? 250 : 999
        }
    }
    
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeDescription: UILabel!
    @IBOutlet weak var locationDescription: UILabel!
    
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    // insert image view here --- *** nvrmnd ***
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var secondViewHeight: NSLayoutConstraint!
    
    
    
    
    @IBAction func interestedButtonPressed(_ sender: UIButton) {
    }
    
    
    
    
    
    
}
