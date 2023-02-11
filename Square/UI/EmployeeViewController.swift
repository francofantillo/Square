//
//  EmployeeViewController.swift
//  Square
//
//  Created by Franco Fantillo on 2023-02-09.
//

import Foundation
import UIKit

private let reuseIdentifier = "Cell"

class EmployeeViewController: UIViewController {
    
    let sizes = CellSizes()
    let collectionView: UICollectionView
    let employeeClient = DataClient(client: HttpClient(session: URLSession.shared))
    private let refreshControl = UIRefreshControl()
    
    var employees = [Employee]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(EmployeeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        super.init(nibName: nil, bundle: nil)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Employees"
        view.addSubview(collectionView)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshEmployeeData(_:)), for: .valueChanged)
        
        retrieveData()
    }
    
    private func retrieveData(){
        
        Task {
            do {
                let employees = try await employeeClient.getEmployees()
                self.employees = employees.sorted()
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
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
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmployeeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return employees.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
}

extension EmployeeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
