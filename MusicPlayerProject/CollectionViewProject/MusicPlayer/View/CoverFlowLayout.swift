//
//  CoverFlowLayout.swift
//  CollectionViewProject
//
//  Created by Kimkeeyun on 28/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class CoverFlowLayout: UICollectionViewFlowLayout {
    
    var cacheAttributes = [UICollectionViewLayoutAttributes]()
    var halfOfCollectionWidth: CGFloat {
        if let collectionView = self.collectionView {
            return collectionView.bounds.width/2.0
        }
        return 0
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superLayoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        for attribute in superLayoutAttributes {
            change(attribute: attribute)
            cacheAttributes.append(attribute)
        }
        return cacheAttributes
    }

    func change(attribute: UICollectionViewLayoutAttributes) {
        let distance = distanceFromOffset(toOffset: attribute.center.x)
        var ratio:CGFloat = 0.0
        if distance < halfOfCollectionWidth {
            ratio = (halfOfCollectionWidth-distance)/halfOfCollectionWidth + 0.2
        }else if distance >= halfOfCollectionWidth {
            ratio = 0
        }
        attribute.transform3D = CATransform3DScale(CATransform3DIdentity, ratio, ratio, 1)
        attribute.alpha = ratio
        //attribute.zIndex = NSInteger(ratio+0.5)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else { return proposedContentOffset }
        guard let attributeList = self.layoutAttributesForElements(in: collectionView.bounds) else { return proposedContentOffset }
        let sortedAttributes = attributeList.sorted { (attribute1, attribute2) -> Bool in
            distanceFromOffset(toOffset: attribute1.center.x) < distanceFromOffset(toOffset: attribute2.center.x) }
        let targetOffsetOfMinimumAttributesCenter = sortedAttributes.first?.center.x
        let targetOffset = CGPoint(x: targetOffsetOfMinimumAttributesCenter!-halfOfCollectionWidth, y: proposedContentOffset.y)
        return targetOffset
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    private func distanceFromOffset(toOffset: CGFloat) -> CGFloat {
        guard let collectionView = self.collectionView else { return 0 }
        let centerOffset = collectionView.contentOffset.x + halfOfCollectionWidth
        return fabs(toOffset - centerOffset)
    }
    
}

