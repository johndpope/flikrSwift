import Foundation
import UIKit
import SnapKit
import Material
import CocoaLumberjack
import Contacts


class ScamPhoneNumberCell: TableViewCell {
    static let ID = "ScamPhoneNumberCell"



    let mainLabel = UILabel(frame: .zero)


   override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = UIColor.onyx
    }
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none



        addSubview(mainLabel)
        mainLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        mainLabel.text = "blah blah blah"
        mainLabel.textColor = .white
        mainLabel.numberOfLines = 1
        mainLabel.textAlignment = .left
        mainLabel.snp.remakeConstraints { (make) -> Void in
            make.width.height.top.equalToSuperview()
            make.left.equalTo(self).offset(10)
        }


    }

    func configureCell(number: String) {
        
      mainLabel.text = number
        
    }
    


    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
