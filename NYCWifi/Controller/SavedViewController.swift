//
//  SavedViewController.swift
//  NYCWifi
//
//  Created by Pritesh Nadiadhara on 3/1/21.
//

import UIKit

class SavedViewController: UIViewController {
    
    let savedView = SavedView()
    
    private var savedHotspots = [Hotspot]() {
        didSet {
            self.savedView.savedTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(savedView)
        setUpTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedHotspots = HotspotDataManager.getHotspots()
    }
    
    private func setUpTableView() {
        title = "Saved Hotspots"
        savedView.savedTableView.dataSource = self
        savedView.savedTableView.delegate = self
        
        savedHotspots = HotspotDataManager.getHotspots()
    }
}

extension SavedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SavedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedHotspots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell") else {
                return UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "SavedCell")
            }
            return cell
        }()
        let savedHotspot = savedHotspots[indexPath.row]
        cell.textLabel?.text = savedHotspot.locationName
        cell.detailTextLabel?.text = "SSID: " + savedHotspot.ssid
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.textLabel?.shadowOffset = CGSize(width: 0, height: 2)
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        cell.textLabel?.textColor = .black
        cell.textLabel?.shadowColor = #colorLiteral(red: 0.5019607843, green: 0.9294117647, blue: 0.6, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.hotspot = savedHotspots[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        savedHotspots.remove(at: indexPath.row)
        HotspotDataManager.deleteHotspot(atIndex: indexPath.row)
    }
}
