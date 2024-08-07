//
//  HorizontalCollectionCell.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 07/08/24.
//
import UIKit

class HorizontalCollectionCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        //imageView.layer.cornerRadius = (UIScreen.main.bounds.width - 40) / 6
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = UIColor.systemPurple.cgColor
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with image: UIImage) {
        imageView.image = image
    }
    
//    func update(index: Int) {
//       self.titleLabel.text = "\(index) Value"
//       self.backgroundColor = index % 2 == 0 ? .lightGray : .lightText
//    }

}
