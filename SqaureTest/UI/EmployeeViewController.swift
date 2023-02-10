//
//  EmployeeViewController.swift
//  SqaureTest
//
//  Created by Franco Fantillo on 2023-02-09.
//

import Foundation
import UIKit

private let reuseIdentifier = "Cell"

class EmployeeViewController: UIViewController {
    
    let sizes = CellSizes()
    let collectionView: UICollectionView
    let employeeClient = DataClient(client: HttpClient(session: URLSession.shared), apiKey: "bf718d4dd8b23985d9c3edbcfd440a27")
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Popular"
        view.addSubview(collectionView)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        Task {
//            do {
//                let movies = try await movieClient.popularMovies()
//                self.movies.append(contentsOf: movies)
//                collectionView.reloadData()
//            }
//            catch let error as APIErrors {
//                displayErrorAlert(errorMessage: error.localizedDescription)
//            }
//            catch let error {
//                displayErrorAlert(errorMessage: error.localizedDescription)
//            }
        }
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
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sizes.cellMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
