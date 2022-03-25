//
//  PhotoTableViewCell.swift
//  PrefetchingDataSource
//
//  Created by Ali Hammoud on 25/03/2022.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    private let photo: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(photo)
        addConstraints()
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photo.image = nil
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            photo.heightAnchor.constraint(equalToConstant: 300),
            photo.widthAnchor.constraint(equalToConstant: 300),
            photo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photo.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            photo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        
        ])
    }
    
    func configure(with viewModel: ViewModel){
        viewModel.downloadImage {[weak self] image in
            DispatchQueue.main.async {
                self?.photo.image = image
            }
        }
    }
    
}
