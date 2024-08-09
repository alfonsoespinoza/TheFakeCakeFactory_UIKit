//
//  FavoritesViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var carouselImages: [UIImage] = []
    private let carousel = CarouselView()
    
   
    let imagesBanner = ["bn1", "bn2", "bn3", "bn4"]
    let images = ["f1", "f2", "f3"]
   
    let bannerLabel = UILabel()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBgPink

        setupCarouselView()
        setupBannerLabel()
        setupTableView()
        setupLayout()
    }

    func setupCarouselView() {
        carouselImages = [UIImage(named: "bn1")!, UIImage(named: "bn2")!, UIImage(named: "bn3")!, UIImage(named: "bn4")!]
        carousel.setImages(carouselImages)
        view.addSubview(carousel)
        carousel.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupBannerLabel() {
        bannerLabel.text = "Quizás pueda interesarte..."
        bannerLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        bannerLabel.textColor = .white
        bannerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerLabel)
    }
    
    func setupTableView() {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(CustomFavoritesTableViewCell.self, forCellReuseIdentifier: "customFavoritesCell")
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 120
            tableView.separatorStyle = .none
            tableView.backgroundColor = .customBgPink
            view.addSubview(tableView)
        }
    
    func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            carousel.topAnchor.constraint(equalTo: view.topAnchor, constant: -50),
            carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carousel.heightAnchor.constraint(equalToConstant: 200),
            
            bannerLabel.topAnchor.constraint(equalTo: carousel.topAnchor, constant: 10),
            bannerLabel.leadingAnchor.constraint(equalTo: carousel.leadingAnchor, constant: 10),

            tableView.topAnchor.constraint(equalTo: carousel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - UITableView DataSource and Delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return images.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customFavoritesCell", for: indexPath) as! CustomFavoritesTableViewCell
        cell.configure(name: "Lorem Ipsum", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", imageName: images[indexPath.section])
        cell.backgroundColor = .purple
        cell.textLabel?.textColor = .white
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Set a fixed height for each cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .customBgPink
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5 // Set the spacing between cells
    }
}
