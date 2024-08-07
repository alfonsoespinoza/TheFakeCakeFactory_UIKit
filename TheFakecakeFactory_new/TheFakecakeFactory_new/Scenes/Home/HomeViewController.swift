//
//  HomeViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//
import UIKit

class HomeViewController: UIViewController {
    
    private lazy var paginationManager: HorizontalPaginationManager = {
        let manager = HorizontalPaginationManager(scrollView: self.gridView)
        manager.delegate = self
        return manager
    }()
    
    private var isDragging: Bool {
        return self.gridView.isDragging
    }
    
    private let gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //register cells
        collectionView.backgroundColor = .customBgPink
        
        return collectionView
    }()
    
    private var carouselImages: [UIImage] = []
    private var gridImages: [UIImage] = []
    private var gridImagesPagination: [UIImage] = []
    private var secondaryCarouselImages: [UIImage] = []
    
    private let carousel = CarouselView()
    private let secondaryCarousel = CarouselView()
    
    private lazy var visitButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Ven y visítanos"
        if let image = UIImage(named: "mapis") {
            config.image = resizeImage(image: image, targetSize: CGSize(width: 30, height: 30))
        }
        
        config.imagePadding = 20
        config.imagePlacement = .leading
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.customBgPurple, for: .normal)
        button.layer.cornerRadius = 30
        button.layer.borderColor = UIColor.customBgPurple.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .customBtn
        button.tintColor = .customBgPurple
        
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBgPink
        
        gridView.alwaysBounceHorizontal = true
        gridView.dataSource = self
        gridView.delegate = self
        //gridView.register(GridCell.self, forCellWithReuseIdentifier: "GridCell")
        gridView.register(HorizontalCollectionCell.self, forCellWithReuseIdentifier: "HorizontalCollectionCell")
        
        
        carouselImages = [UIImage(named: "bn1")!, UIImage(named: "bn2")!, UIImage(named: "bn3")!, UIImage(named: "bn4")!]
        gridImages = [UIImage(named: "f5")!, UIImage(named: "f6")!, UIImage(named: "f3")!, UIImage(named: "f2")!, UIImage(named: "f1")!, UIImage(named: "f4")!, UIImage(named: "f2")!, UIImage(named: "f1")!, UIImage(named: "f4")!]
        gridImagesPagination = [UIImage(named: "f1")!, UIImage(named: "f2")!, UIImage(named: "f3")!, UIImage(named: "f4")!, UIImage(named: "f5")!, UIImage(named: "f6")!]
        secondaryCarouselImages = [UIImage(named: "sp1")!, UIImage(named: "sp2")!, UIImage(named: "sp3")!]
        
        carousel.setImages(carouselImages)
        secondaryCarousel.setImages(secondaryCarouselImages)
        
        view.addSubview(carousel)
        view.addSubview(gridView)
        view.addSubview(secondaryCarousel)
        view.addSubview(visitButton)
        
        setupConstraints()
        
        visitButton.addTarget(self, action: #selector(visitButtonTapped), for: .touchUpInside)
        
        //self.setupCollectionView()
        setupPagination()
        fetchItems()
    }
    
    private func setupConstraints() {
        carousel.translatesAutoresizingMaskIntoConstraints = false
        gridView.translatesAutoresizingMaskIntoConstraints = false
        secondaryCarousel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            carousel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -50),
            carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carousel.heightAnchor.constraint(equalToConstant: 200),
            
            gridView.topAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 20),
            gridView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            gridView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            gridView.heightAnchor.constraint(equalToConstant: 300),
            
            secondaryCarousel.topAnchor.constraint(equalTo: gridView.bottomAnchor, constant: 20),
            secondaryCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondaryCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondaryCarousel.heightAnchor.constraint(equalToConstant: 130),
            
            visitButton.topAnchor.constraint(equalTo: secondaryCarousel.bottomAnchor, constant: 20),
            visitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            visitButton.widthAnchor.constraint(equalToConstant: 350),
            visitButton.heightAnchor.constraint(equalToConstant: 60),
            visitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func visitButtonTapped() {
        let locationVC = LocationPermissionsViewController()
        locationVC.modalPresentationStyle = .pageSheet
        
        let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in
            return 250
        }
        
        if let sheet = locationVC.sheetPresentationController {
            //sheet.detents = [.medium()]
            sheet.detents = [smallDetent]
            sheet.prefersGrabberVisible = true
        }
        present(locationVC, animated: true, completion: nil)
        
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCell
//        cell.configure(with: gridImages[indexPath.item])
//        return cell
        let cell = collectionView.dequeueReusableCell(
              withReuseIdentifier: "HorizontalCollectionCell",
              for: indexPath
           ) as! HorizontalCollectionCell
           cell.update(with: gridImages[indexPath.item])
           return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController(image: gridImages[indexPath.item])
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let availableWidth = collectionView.frame.width - padding
        let width = availableWidth / 3
        return CGSize(width: width, height: width)
        
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Calcular el nuevo tamaño
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // Redimensionar la imagen
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}


extension HomeViewController: HorizontalPaginationManagerDelegate {
    
    private func setupPagination() {
        self.paginationManager.refreshViewColor = .clear
        self.paginationManager.loaderColor = .white
    }
    
    private func fetchItems() {
        self.paginationManager.initialLoad()
    }
    
    func refreshAll(completion: @escaping (Bool) -> Void) {
        delay(2.0) {
            self.gridImages = [UIImage(named: "f1")!, UIImage(named: "f2")!, UIImage(named: "f3")!, UIImage(named: "f4")!, UIImage(named: "f5")!, UIImage(named: "f6")!]
            self.gridView.reloadData()
            completion(true)
        }
    }
    
    func loadMore(completion: @escaping (Bool) -> Void) {
        print("load more")
        delay(2.0) {
            self.gridImages.append(contentsOf: [UIImage(named: "bn1")!, UIImage(named: "bn2")!, UIImage(named: "bn3")!, UIImage(named: "bn4")!, UIImage(named: "f5")!, UIImage(named: "f6")!, UIImage(named: "bn1")!, UIImage(named: "bn2")!, UIImage(named: "bn3")!, UIImage(named: "bn4")!, UIImage(named: "f5")!, UIImage(named: "f3")!])
            self.gridView.reloadData()
            completion(true)
        }
    }
    
}

public func delay(_ delay: Double, closure: @escaping () -> Void) {
    let deadline = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(
        deadline: deadline,
        execute: closure
    )
}

