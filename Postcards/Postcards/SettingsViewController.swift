/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The view controller that displays options for presenting sheets.
*/

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var largestUndimmedDetentIdentifierControl: UISegmentedControl!
    @IBOutlet weak var prefersScrollingExpandsWhenScrolledToEdgeSwitch: UISwitch!
    @IBOutlet weak var prefersEdgeAttachedInCompactHeightSwitch: UISwitch!
    @IBOutlet weak var widthFollowsPreferredContentSizeWhenEdgeAttachedSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectedSegmentIndex: Int
        switch PresentationHelper.sharedInstance.largestUndimmedDetentIdentifier {
        case .small:
            selectedSegmentIndex = 0
        case .medium:
            selectedSegmentIndex = 1
        default:
            selectedSegmentIndex = 2
        }
    
        prefersScrollingExpandsWhenScrolledToEdgeSwitch.isOn =
        PresentationHelper.sharedInstance.prefersScrollingExpandsWhenScrolledToEdge
        
        prefersEdgeAttachedInCompactHeightSwitch.isOn =
        PresentationHelper.sharedInstance.prefersEdgeAttachedInCompactHeight
        
        widthFollowsPreferredContentSizeWhenEdgeAttachedSwitch.isOn =
        PresentationHelper.sharedInstance.widthFollowsPreferredContentSizeWhenEdgeAttached
        
        // Set the delegate and datasource to the view controller
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44 // or any other value that you prefer
        // Register a cell for the table view
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 100
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         
         // Set the text of the cell
         cell.textLabel?.text = "Row \(indexPath.row + 1)"
         
         return cell
     }
     
     // MARK: - UITableViewDelegate
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         print("Selected row \(indexPath.row + 1)")
     }
    
    @IBAction func largestUndimmedDetentChanged(_ sender: UISegmentedControl) {
        let largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier
        switch sender.selectedSegmentIndex {
        case 0:
            largestUndimmedDetentIdentifier = .small
        case 1:
            largestUndimmedDetentIdentifier = .medium
        default:
            largestUndimmedDetentIdentifier = .large
        }
        
        PresentationHelper.sharedInstance.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        updateSheet()
    }
    
    @IBAction func prefersScrollingExpandsWhenScrolledToEdgeSwitchChanged(_ sender: UISwitch) {
        PresentationHelper.sharedInstance.prefersScrollingExpandsWhenScrolledToEdge = sender.isOn
        updateSheet()
    }
    
    @IBAction func prefersEdgeAttachedInCompactHeightSwitchChanged(_ sender: UISwitch) {
        PresentationHelper.sharedInstance.prefersEdgeAttachedInCompactHeight = sender.isOn
        updateSheet()
    }
    
    @IBAction func widthFollowsPreferredContentSizeWhenEdgeAttachedChanged(_ sender: UISwitch) {
        PresentationHelper.sharedInstance.widthFollowsPreferredContentSizeWhenEdgeAttached = sender.isOn
        updateSheet()
    }
    
    func updateSheet() {
        guard let sheet = popoverPresentationController?.adaptiveSheetPresentationController else {
            return
        }
        sheet.largestUndimmedDetentIdentifier =
        PresentationHelper.sharedInstance.largestUndimmedDetentIdentifier
        sheet.prefersScrollingExpandsWhenScrolledToEdge =
        PresentationHelper.sharedInstance.prefersScrollingExpandsWhenScrolledToEdge
        sheet.prefersEdgeAttachedInCompactHeight =
        PresentationHelper.sharedInstance.prefersEdgeAttachedInCompactHeight
        sheet.widthFollowsPreferredContentSizeWhenEdgeAttached =
        PresentationHelper.sharedInstance.widthFollowsPreferredContentSizeWhenEdgeAttached
    }
}
