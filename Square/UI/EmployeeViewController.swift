//
//  EmployeeViewController.swift
//  Square
//
//  Created by Franco Fantillo on 2023-02-09.
//

import Foundation
import UIKit

private let reuseIdentifier = "Cell"

class EmployeeViewController: UICollectionViewController {
    
    let sizes = CellSizes()
    let employeeClient = DataClient(client: HttpClient(session: URLSession.shared))
    private let refreshControl = UIRefreshControl()
    
    var employees = [Employee]()
    var loadingContainer: UIView!
    var emptyLabel: UILabel!
    
    init() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EmployeeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.refreshControl = refreshControl
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Employees"
        view.backgroundColor = .white
        
        // Configure Refresh Control and begin intial load
        refreshControl.addTarget(self, action: #selector(refreshEmployeeData(_:)), for: .valueChanged)
        
        showActivityIndicator()
        retrieveData()
    }
    
    private func showActivityIndicator() {
        loadingContainer = UIView()
        loadingContainer.frame = CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: 80, height: 80) // Set X and Y whatever you want
        loadingContainer.backgroundColor = .clear
        
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        
        loadingContainer.addSubview(activityView)
        self.view.addSubview(loadingContainer)
        activityView.startAnimating()
    }
    
    private func hideActivityIndicator(){
        if let container = loadingContainer {
            container.removeFromSuperview()
            self.loadingContainer = nil
        }
    }

    private func addEmptyLabel(){
        
        emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 42))
        emptyLabel.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        emptyLabel.textAlignment = .center
        emptyLabel.text = "The employee list is empty."
        emptyLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.view.addSubview(emptyLabel)
    }
    
    private func retrieveData(){
        
        Task {
            do {
                let employees = try await employeeClient.getEmployees()
                self.employees = employees.sorted()
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
                hideActivityIndicator()
                if employees.isEmpty {
                    addEmptyLabel()
                } else {
                    if let label = emptyLabel {
                        label.removeFromSuperview()
                        self.emptyLabel = nil
                    }
                }
            }
            catch let error as APIErrors {
                displayErrorAlert(errorMessage: error.localizedDescription)
            }
            catch let error {
                displayErrorAlert(errorMessage: error.localizedDescription)
            }
        }
    }
    
    @objc private func refreshEmployeeData(_ sender: Any) {
        retrieveData()
    }
    
    private func displayErrorAlert(errorMessage: String){
        let refreshAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    //UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return employees.count
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    //UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EmployeeCell
        cell.employee = employees[indexPath.row]
        return cell
    }
}

extension EmployeeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sizes.width, height: sizes.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sizes.cellMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sizes.cellMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: sizes.cellMargin, left: sizes.cellMargin, bottom: 0, right: sizes.cellMargin)
    }
}
