import Foundation
import UIKit
import SnapKit
import Material

import Device


// This handles the TableViewCell for most video use cases.
// Use func configureCell(item:Photo) to modify state


class FeaturedCollectionViewCell: CollectionViewCell {
    static let ID = "FeaturedCollectionViewCell"



    lazy var heroImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = kPlaceholderImage
        return iv
    }()


    let titleLabel = UILabel(frame: .zero)

    let dateLabel = UILabel(frame: .zero)

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImageView.image = kPlaceholderImage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = UIColor.jungleGreen

        // Hero Image
        addSubview(heroImageView)
        heroImageView.contentMode = .scaleAspectFill
        heroImageView.clipsToBounds = true
        heroImageView.snp.remakeConstraints { (make) -> Void in
            make.width.top.left.equalToSuperview()
            make.height.equalTo(160)
        }


        
        addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.medium)
        titleLabel.text = "Loading..."
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.snp.remakeConstraints { (make) -> Void in
            make.width.equalToSuperview().offset(-30) // make it less to avoid overlapping
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
        }


    }
    
    func configureCollectionViewCell(photo: Photo) {
        
        titleLabel.text = photo.title
        heroImageView.image = kPlaceholderImage
        heroImageView.loadImageUsingCacheWithUrlString(urlString: photo.url.absoluteString, noFadeIn:false)

    }
    
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
