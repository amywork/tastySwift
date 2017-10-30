//
//  CoverFlowLayout.swift
//  CollectionViewProject
//
//  Created by Kimkeeyun on 28/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class CoverFlowLayout: UICollectionViewFlowLayout {
    
    override func awakeFromNib() {
        minimumLineSpacing = 0
    }
    
    func distanceFromOffset(toOffset: CGFloat) -> CGFloat {
        guard let collectionView = self.collectionView else { return 0 }
        let center = collectionView.bounds.width/2.0
        let centerOffset = collectionView.contentOffset.x + center
        return fabs(toOffset - centerOffset)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let superLayoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        var layoutAttributes:[UICollectionViewLayoutAttributes] = []
        for attribute in superLayoutAttributes {
            change(attribute: attribute)
            layoutAttributes.append(attribute)
        }
        return layoutAttributes
    }
    
    func change(attribute: UICollectionViewLayoutAttributes) {
        guard let collectionView = self.collectionView else { return }
        let centerWidth = collectionView.bounds.width/2.0
        let distance = distanceFromOffset(toOffset: attribute.center.x)
        
        var ratio:CGFloat = 0.0
        if distance < centerWidth {
            ratio = (centerWidth-distance)/centerWidth
        }else if distance >= centerWidth {
            ratio = 0
        }
        
        attribute.transform3D = CATransform3DScale(CATransform3DIdentity, ratio, ratio, 1)
        // attribute.zIndex = NSInteger(ratio)
        attribute.alpha = ratio
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else { return proposedContentOffset }
        guard let attributeList = self.layoutAttributesForElements(in: collectionView.bounds) else { return proposedContentOffset }
        
        let sortedAttributes = attributeList.sorted { (attribute1, attribute2) -> Bool in
            distanceFromOffset(toOffset: attribute1.center.x) < distanceFromOffset(toOffset: attribute2.center.x) }
        
        let centerXofMinimumAttributes = sortedAttributes.first?.center.x
        let centerXofScreen = collectionView.bounds.width/2.0
        
        let targetOffset = CGPoint(x: centerXofMinimumAttributes!-centerXofScreen, y: proposedContentOffset.y)
        return targetOffset
        
        }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
}
