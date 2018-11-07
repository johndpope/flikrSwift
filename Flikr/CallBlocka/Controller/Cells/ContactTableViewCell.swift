import Foundation
import UIKit
import SnapKit
import Material
import CocoaLumberjack
import Contacts


class ContactTableViewCell: TableViewCell {
    static let ID = "ContactTableViewCell"

    lazy var alphaView: UIView = {
        let iv = UIView(frame: .zero)
        return iv
    }()

    lazy var heroImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "placeholder")
        return iv
    }()

    let mainLabel = UILabel(frame: .zero)
    let durationLabel = UILabel(frame: .zero)

   override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = UIColor.onyx
    }
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none


        
        // Hero Image
        addSubview(heroImageView)
         heroImageView.contentMode = .scaleAspectFill
        heroImageView.clipsToBounds = true
        heroImageView.removeConstraints((imageView?.constraints)!)
        heroImageView.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(167)
            make.height.equalTo(80)
            make.top.left.equalToSuperview()
        }

        // Duration alpha box
        heroImageView.addSubview(alphaView)
        alphaView.backgroundColor = .black
        alphaView.alpha = 0.3
        alphaView.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(37)
            make.height.equalTo(22)
            make.bottom.equalTo(self.heroImageView).offset(-9)
            make.right.equalTo(self.heroImageView).offset(-7)
        }



        // The default text label
        // This needs to avoid hitting the kebab +
        // and be positioned away from image on left
        addSubview(mainLabel)
        mainLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        mainLabel.text = "blah blah blah"
        mainLabel.textColor = .white
        mainLabel.numberOfLines = 6
        mainLabel.textAlignment = .left
        mainLabel.snp.remakeConstraints { (make) -> Void in
            make.right.equalToSuperview()
            make.left.equalTo(self.heroImageView.snp.right).offset(10)
            make.top.equalTo(self).offset(10)
        }

        backgroundColor = UIColor.onyx
        contentView.backgroundColor = .clear


        // Line seperator
        let lineView = UIView(frame: .zero)
        lineView.backgroundColor = UIColor.darkLine
        addSubview(lineView)
        lineView.snp.remakeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(20)
            make.height.equalTo(1)
            make.bottom.equalToSuperview().offset(-1)
        }
    }

    func configureCell(item: CNContact) {
        
        let familyName = item.familyName
        if familyName.isEmpty{
             let phoneNumbers = item.phoneNumbers
                if phoneNumbers.count > 0 {
                    mainLabel.text = phoneNumbers[0].value.stringValue
                    
                }
        }else{
            mainLabel.text = item.familyName
        }
        if let data = item.imageData{
            heroImageView.image = UIImage(data: data,scale:1.0)
        }else{
            heroImageView.image = nil
        }
        
    }
    


    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
