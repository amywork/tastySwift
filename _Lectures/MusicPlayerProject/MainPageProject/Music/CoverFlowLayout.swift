//
//  CoverFlowLayout.swift
//  MusicPlayer
//
//  Created by youngmin joo on 2017. 7. 3..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//


import UIKit

let itemScale:CGFloat = 0.5
let itemAlpha:CGFloat = 0.5

class CoverFlowLayout : UICollectionViewFlowLayout {
    
    override func awakeFromNib() {
        self.minimumLineSpacing = 25.0
    }

    //준비단계
    override func prepare() {
        
    }
    
    //속성 변경
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard  let attributes = super.layoutAttributesForElements(in: rect) else {return nil}
        
        var layoutAttribute:[UICollectionViewLayoutAttributes] = []
        for attribute in attributes
        {
            //change
            changeLayoutAttribute(attribute: attribute)
            //add
            layoutAttribute.append(attribute)
        }
        
        return layoutAttribute
    }
    

    //스크롤을 멈췄을때 실행
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        guard let collectionView = self.collectionView  else {
            return proposedContentOffset
        }
        //현재 컬렉션 뷰의 [UICollectionViewLayoutAttributes] 가져오기
        guard let attributeList =  self.layoutAttributesForElements(in: collectionView.bounds) else {
            return proposedContentOffset
        }

        //거리가 가장 가까운 순으로 정렬
        let sortedAttributeList = attributeList.sorted {
            (attribute1, attribute2) -> Bool in
            distance(ofCenter: attribute1.center.x) < distance(ofCenter: attribute2.center.x)
        }
        //가장 가까은 아이템의 센터 위치
        let nearItemCenter = sortedAttributeList.first?.center.x

        //중앙으로 이동
        let screenXCenter = collectionView.frame.size.width / 2
        let targetContentOffset = CGPoint(x:nearItemCenter! - screenXCenter,
                                          y: proposedContentOffset.y)

        return targetContentOffset
    }
    
    //레이아웃 정보듣 다시 불러오도록 허락함
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    //실제 연산내용
    func changeLayoutAttribute(attribute:UICollectionViewLayoutAttributes)
    {
        //변경가능한 최대 거리(조정가능)
        let maxDistance = self.itemSize.width
        
        //실제 거리과 최대거리중 작은거리를 선택!
        let choiceDistance = min(distance(ofCenter: attribute.center.x), maxDistance)
        
        //비율
        let ratio = (maxDistance - choiceDistance) / maxDistance
        //0-1
        //비율에 따라 스케일과 투명도 변경
        //min 1.0 - 1.5 max
        let scale = ratio * (1 - itemScale) + 1.0
        //min 0.5 - 1.0 max
        let alpha = ratio * (1 - itemAlpha) + itemAlpha;
        attribute.alpha = alpha;
        attribute.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1);
        //alpha값에 따른 z 좌표 변경
        attribute.zIndex = NSInteger(alpha * 10.0)
    }
    
    func distance(ofCenter centerx:CGFloat) -> CGFloat
    {
        guard let collectionView = self.collectionView else {
            return 0
        }
        //현재 아이템의 offsetX + 센터
        let offSet = collectionView.contentOffset.x + (collectionView.bounds.size.width/2)
        return  fabs(offSet - centerx)
    }
    
}




