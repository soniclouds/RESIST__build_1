//
//  MainViewController.swift
//  RES!ST__v1
//
//  Created by soniclouds on 3/7/17.
//  Copyright © 2017 soniclouds. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate, WebViewDelegate {
    
    //MARK................................VAR...................
    var events = [Event]()
    var filteredEvents = [Event]()
    
    var selectedEvent: Event?
    
    var selectedIndex = -1
    
    var searchController = UISearchController(searchResultsController: nil)
    
    var hide = true
    var state = 0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //MARK................................FUNC.................
    
    // search bar
    func filterSearchResults(searchText: String, scope: String = "All") {
        filteredEvents = events.filter {event in
            // query by name, country, state, city, or neighborhood
            return ((event.name?.lowercased().contains(searchText.lowercased()))!) || ((event.neighborhood?.lowercased().contains(searchText.lowercased()))!) || ((event.country?.lowercased().contains(searchText.lowercased()))!) || ((event.state?.lowercased().contains(searchText.lowercased()))!) || ((event.city?.lowercased().contains(searchText.lowercased()))!)
        }
        tableView.reloadData()
    }
    func updateSearchResults(for searchController: UISearchController) {
        filterSearchResults(searchText: searchController.searchBar.text!)
    }
    
    
    func getTimeDate(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM dd yyyy - hh:m a"
        return dateFormatter.string(from: date as Date)
    }
    
    //MARK................................TABLE VIEW METHODS...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredEvents.count
        }
        return events.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventCell
        let event: Event
        
        // set event for each cell based on search bar
        if searchController.isActive && searchController.searchBar.text != "" {
            event = filteredEvents[indexPath.row]
        } else {
            event = events[indexPath.row]
        }
        //        // format and set the date
        let date = event.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        // extract the date elements
        let dateComponents = (Calendar.current).dateComponents([.year, .month, .day], from: date as! Date)
        let months = dateFormatter.shortMonthSymbols
        
        let monthSymbol = months![dateComponents.month! - 1]
        let day = dateComponents.day! + 1
        print("==========================", day)
        let daySymbol = "\(day)"
        
        
        cell.monthLabel.text = monthSymbol
        cell.dateLabel.text = daySymbol
        cell.nameLabel.text = event.name
        
        if event.neighborhood != nil {
            cell.locationDescription.text = event.neighborhood
        } else {
            cell.locationDescription.text = ""
        }
        
        cell.addressLabel.text = event.address
        cell.detailsLabel.text = event.details
        
        
        if event.neighborhood == nil {
            cell.mapView.isHidden = true
        } else {
            cell.mapView.isHidden = false
            // set map display to address (neighborhood + city)
            let geocoder: CLGeocoder = CLGeocoder()
            var locationManager: CLLocationManager!
            func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
                if status == .authorizedAlways {
                    if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                        if CLLocationManager.isRangingAvailable() {
                            // do stuff
                        }
                    }
                }
            }
            func locationManager(_ manager: CLLocationManager,
                                 didUpdateLocations locations: [CLLocation])
            {
                // Handle location updates here
            }
            
            func locationManager(_ manager: CLLocationManager,
                                 didFailWithError error: Error)
            {
                // Handle errors here
            }
            
            
            //            let locale: String?
            //            if event.neighborhood != nil {
            //                if event.city != nil {
            //                    locale = event.neighborhood! + " " + event.city!
            //                } else if event.state != nil {
            //                    locale = event.neighborhood! + " " + event.state!
            //                } else {
            //                    locale = event.country
            //                }
            //            } else if event.address != nil {
            //                locale = event.address! + " " + event.city!
            //            } else {
            //                if event.city != nil {
            //                    locale = event.city!
            //                } else if event.state != nil {
            //                    locale = event.state!
            //                } else {
            //                    locale = event.country
            //                }
            //            }
            
            //============================= GEO-CODER ======== LAST ATTEMPT ========
            //            if event.neighborhood != nil {
            //                if event.city != nil {
            //                    let locale = event.neighborhood! + " " + event.city!
            //                    geocoder.geocodeAddressString(locale, completionHandler: {(placemarks, error) -> Void in
            //                        if let placemark = placemarks![0] as? CLPlacemark {
            //                            cell.mapView.addAnnotation(MKPlacemark(placemark: placemark))
            //                            let dest = placemark.location
            //
            //                            let span = MKCoordinateSpanMake(0.075, 0.075)
            //                            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (dest?.coordinate.latitude)!, longitude: (dest?.coordinate.longitude)!), span: span)
            //                            cell.mapView.setRegion(region, animated: true)
            //                        }
            //                    })
            //                }
            //            }
            
            
            //            else if event.address != nil {
            //                let locale = event.address!
            //                geocoder.geocodeAddressString(locale, completionHandler: {(placemarks, error) -> Void in
            //                    if let placemark = placemarks![0] as? CLPlacemark {
            //                        cell.mapView.addAnnotation(MKPlacemark(placemark: placemark))
            //                        let dest = placemark.location
            //
            //                        let span = MKCoordinateSpanMake(0.075, 0.075)
            //                        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (dest?.coordinate.latitude)!, longitude: (dest?.coordinate.longitude)!), span: span)
            //                        cell.mapView.setRegion(region, animated: true)
            //                    }
            //                })
            //            }
            
            
            
            
            
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (selectedIndex == indexPath.row) {
            return 225
        } else {
            return 81
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        selectedEvent = events[indexPath.row]
        print(selectedEvent)
        // if I click the same row again
        if (selectedIndex == indexPath.row) {
            selectedIndex = -1
            // if I click a different row
        } else {
            selectedIndex = indexPath.row
            state = 1
            if hide == true {
                hide = false
            }
        }
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
        
    }
    
    //MARK................................OUT........................
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK................................ACT........................
    
    // this is the 'swipe' icon
    @IBAction func showButtonPressed(_ sender: UIButton) {
        
    }
    
    
    //MARK................................DELEGATE METHODS...........
    //    func backButtonPressed(by controller: ShowEventViewController) {
    //        print("Back button pressed")
    //        dismiss(animated: true, completion: nil)
    //    }
    func showButtonPressed(by controller: MainViewController) {
        //        let webViewController = WebViewController()
        //        webViewController.webViewDelegate = self
        //        webViewController.event = selectedEvent
        //        print("in dispatch q ", self.selectedEvent!)
        //        DispatchQueue.main.async {
        //
        //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "webVC") as! WebViewController
        //            print("in dispatch queue!")
        //            vc.webViewDelegate = self
        //            vc.event = self.selectedEvent!
        //            print("in main vc, event: ", self.selectedEvent!)
        //            self.present(vc, animated: true, completion: nil)
        //        }
    }
    
    
    //MARK................................SEGUES...........
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showWeb" {
            
            let vc = segue.destination as! WebViewController
            vc.webViewDelegate = self
            vc.event = self.selectedEvent!
            
            
        }
        
        
        
        
        
    }
    
    
    //        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //            print (sender!)
    //            // unwrap sender
    //            if let send = sender {
    //                // if we clicked on a table item
    //                if send is UIButton {
    //                    // set the destination view controller
    //                    let nC = segue.destination as! UINavigationController
    //                    // tell the destination to communicate back
    //                    let webViewController = nC.topViewController as! WebViewController
    //                    webViewController.webViewDelegate = self
    //                    // if an indexPath is sent, get it
    //    //                let indexPath = sender as! NSIndexPath
    //                    // get item from items array where the index matches the index of the row
    //    //                let event = events[indexPath.row]
    //                    // assign the item for the next view
    //                    webViewController.event = selectedEvent
    //                    // if indexPath is passed, assign the indexPath as well
    //    //                showEventViewController.indexPath = indexPath
    //                    print("showing item")
    //
    //                } else {
    //                    print ("something went wrong")
    //                }
    //            }
    //        }
    
    
    
    //MARK................................UI LIFECYCLE...............
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        searchController.searchBar.placeholder = "filter by location"
        tableView.tableHeaderView = searchController.searchBar
        
        EventModel.getAllEvents() {
            data, response, error in
            do {
                if let events = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Array<NSMutableDictionary> { // an array of dictionary entries
                    print(events)
                    events.forEach {
                        event in
                        let newEvent = Event(entity: Event.entity(), insertInto: self.context)
                        
                        newEvent.address = event.value(forKey: "address") as! String!
                        newEvent.city = event.value(forKey: "city") as! String!
                        newEvent.country = event.value(forKey: "country") as! String!
                        
                        _ = event.value(forKey: "date")! as! String
                        
                        let createdAt = event.value(forKey: "date")
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        
                        if let parsedDate = dateFormatter.date(from: createdAt as! String) {
                            
                            let dateFormatter2 = DateFormatter()
                            dateFormatter2.dateFormat = "EEE, MMM dd yyyy - h:mm a"
                            
                            let date = parsedDate as NSDate as Date
                            
                            print(date)
                            newEvent.date = date as NSDate?
                            
                        }
                        
                        newEvent.details = event.value(forKey: "details") as! String!
                        newEvent.link = event.value(forKey: "link") as! String!
                        newEvent.name = event.value(forKey: "name") as! String!
                        newEvent.neighborhood = event.value(forKey: "neighborhood") as! String!
                        newEvent.state = event.value(forKey: "state") as! String!
                        newEvent.zip = event.value(forKey: "zip") as! String!
                        self.events.append(newEvent)
                        print("event : ", event)
                        if let testingEvent = newEvent.date {
                            print("newEvent date: ", testingEvent)
                        }
                        
                        print("newEvent : ", newEvent)
                    }
                    print ("events again: ", events)
                    print("attempting to call TaskModel.getAllTasks()")
                    print(self.events)
                }
                // sort the array here (by date)
                
                print(self.events)
                self.events.sort(by: { $0.date?.compare($1.date as! Date) == .orderedAscending })
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Something went wrong")
            }
        }
        
        
        
        super.viewDidLoad()
        print ("superview did load!")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

extension String {
    func toDateTime() -> NSDate {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        //Parse into NSDate
        let dateFromString: NSDate = dateFormatter.date(from: "2017-03-02T22:06:46.000Z")! as NSDate
        
        //Return Parsed Date
        return dateFromString
    }
}


