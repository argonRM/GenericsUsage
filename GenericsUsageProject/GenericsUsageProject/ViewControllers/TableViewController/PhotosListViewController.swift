//
//  TableViewController.swift
//  ReviewGenericsTest
//
//  Created by user on 11/5/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit

class PhotosListViewController: UIViewController, Storyboardable {
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    static var flow: Flow = .Table
    
    private var model: PhotosListModel?
    private var photos: [PhotoInfo] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = PhotosListModel(delegate: self)
        setupTableView()
        fetchPhotos()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(of: PictureTableViewCell.self)
    }
    
    private func fetchPhotos() {
        model?.fetchPhotos()
        loaderView.isHidden = false
        startIndicatorAnimating()
    }
    
    private func startIndicatorAnimating() {
        DispatchQueue.main.async { [weak self] in
            self?.loaderView.isHidden = false
            self?.indicator.startAnimating()
        }
    }
    
    private func stopIndicatorAnimating() {
        DispatchQueue.main.async { [weak self] in
            self?.loaderView.isHidden = true
            self?.indicator.stopAnimating()
        }
    }
}

extension PhotosListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.tableViewCell(of: PictureTableViewCell.self, path: indexPath)
        cell.configureWith(info: photos[indexPath.row])
        return cell
    }
}

extension PhotosListViewController: PhotosListModelDelegate {
    func handleGetEventsResponse(photosInfoList: [PhotoInfo]) {
        stopIndicatorAnimating()
        photos = photosInfoList
    }
    
    func handleErrorResponse(error: Error) {
        stopIndicatorAnimating()
        print(error.localizedDescription)
    }
}

