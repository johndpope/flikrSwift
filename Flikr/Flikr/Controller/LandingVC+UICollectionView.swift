import UIKit
import Foundation
import SnapKit
import CocoaLumberjack
import AVFoundation
import SDWebImage


// MARK: UICollectionViewDataSource /UICollectionViewDelegate
// cells + sectionHeaders  + didSelect

extension LandingVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return DM.featuredPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCollectionViewCell.ID, for: indexPath) as! FeaturedCollectionViewCell
        let photo = DM.featuredPhotos[indexPath.row]
        cell.configureCollectionViewCell(photo: photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("call")
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: currentSize.width, height: featuredHeaderHeight)
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
    

    
}
