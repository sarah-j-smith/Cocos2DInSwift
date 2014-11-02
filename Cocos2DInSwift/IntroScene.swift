//
//  IntroScene.swift
//  Cocos2DInSwift
//
//  Created by Sarah Smith on 2/11/2014.
//  Copyright (c) 2014 Sarah Smith. All rights reserved.
//

import Foundation

class IntroScene : CCScene {
    
    class func scene() -> IntroScene
    {
        return IntroScene()
    }
    
    override func onEnter() {
        super.onEnter()
        
        let background = CCNodeColor(color: CCColor(red: 0.2, green: 0.2, blue: 0.8, alpha: 1.0));
        addChild(background)
        
        let label = CCLabelTTF(string: "Cocos2D Swift", fontName: "Chalkduster", fontSize: 36.0);
        label.positionType = CCPositionTypeMake(CCPositionUnit.Normalized, CCPositionUnit.Normalized, CCPositionReferenceCorner.BottomLeft)
        label.position = CGPoint(x: 0.5, y: 0.5)
        
        addChild(label)
    }
}