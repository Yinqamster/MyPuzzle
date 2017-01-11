//
//  Puzzle2.swift
//  Mypuzzle
//
//  Created by 141220138_141220132 on 2017/1/8.
//  Copyright © 2017年 nju. All rights reserved.
//

import Foundation
import UIKit

class Puzzle2: UIViewController{
    
    public var kCol = 2
    public var kImgWidth:CGFloat = 0
    public var screenwidth:CGFloat=0;
    public var screenheight:CGFloat=0;
    
    public var imgViewArr: [UIImageView] = []
    public var pointInfo: [CGPoint] = []
    
    
    public var netTranslation : CGPoint = CGPoint(x: 0, y: 0)//平移
    
    
    //添加手势
    func addSwipe(View imgView : UIImageView){
       // netTranslation.x=0;
       // netTranslation.y=0;
        
        let swipe = UIPanGestureRecognizer(target: self, action: #selector(swipe(_:)))
        imgView.addGestureRecognizer(swipe)
        imgView.isUserInteractionEnabled = true
        
    }
    
    
    //处理手势
     func swipe(_ sender: UIPanGestureRecognizer){
        let imgView:UIImageView = sender.view as! UIImageView
        let idx = imgViewArr.index(of: imgView)!

        let x1=imgView.frame.minX;
        let x2=pointInfo[idx].x;
        let y1=imgView.frame.minY;
        let y2=pointInfo[idx].y;
        
        if(kCol==3){
            if(abs(x1-x2)<kImgWidth/10&&abs(y1-y2)<kImgWidth/10){
                imgView.frame=CGRect(x:x2 , y: y2, width: imgView.frame.width, height: imgView.frame.height)
                sender.setTranslation(CGPoint.zero, in: imgView)
                return
            }
        }
        
        if(kCol==2){
            if(abs(x1-x2)<kImgWidth/20&&abs(y1-y2)<kImgWidth/20){
                imgView.frame=CGRect(x:x2 , y: y2, width: imgView.frame.width, height: imgView.frame.height)
                sender.setTranslation(CGPoint.zero, in: imgView)
                return
            }
        }
        
        if(kCol==4){
            if(abs(x1-x2)<kImgWidth/7&&abs(y1-y2)<kImgWidth/7){
                imgView.frame=CGRect(x:x2 , y: y2, width: imgView.frame.width, height: imgView.frame.height)
                sender.setTranslation(CGPoint.zero, in: imgView)
                return
            }
        }
        
        if(kCol==5){
            if(abs(x1-x2)<kImgWidth/5&&abs(y1-y2)<kImgWidth/5){
                imgView.frame=CGRect(x:x2 , y: y2, width: imgView.frame.width, height: imgView.frame.height)
                sender.setTranslation(CGPoint.zero, in: imgView)
                return
            }
        }
        
        let translation = sender.translation(in: imgView)
        imgView.center = CGPoint(x:imgView.center.x + translation.x, y:imgView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: imgView)
         /*
        let _transX = sender.translation(in: imgView).x
        let _transY = sender.translation(in: imgView).y
        
        imgView.transform = CGAffineTransform(translationX: _transX, y: _transY)
        */
        
     /*   //得到拖的过程中的xy坐标
        let translation : CGPoint = sender.translation(in: imgView)
        //平移图片CGAffineTransformMakeTranslation
        
        imgView.transform = CGAffineTransform(translationX: netTranslation.x+translation.x, y: netTranslation.y+translation.y)
        if sender.state == UIGestureRecognizerState.ended{
            netTranslation.x += translation.x
            netTranslation.y += translation.y
        }*/
    }

    
    //打乱图片
    func disOrderImage(){
        
        for _ in 0..<20{
            
            var idx1 = Int( arc4random() % UInt32(kCol * kCol) )
            
            if(idx1==0){
                idx1=1;
            }
            
            var idx2 = Int( arc4random() % UInt32(kCol * kCol) )
            
            if(idx2==0){
                idx2=1;
            }
            
            let imgView = imgViewArr[idx1]
            let imgV = imgViewArr[idx2]
            
            let frame1:CGRect = CGRect(x:imgV.frame.minX+10, y:screenwidth+20, width:imgV.frame.width, height:imgV.frame.height);
            let frame2:CGRect = CGRect(x:imgView.frame.minX-10, y:screenwidth+25, width:imgView.frame.width, height:imgView.frame.height);
            
            UIView.animate(withDuration: 1, animations: { () -> Void in
                imgV.frame = frame2
                imgView.frame = frame1
            })
            
         //   imgViewArr.exchangeObj(idx: idx1, toIdx: idx2)
            
        }
        
    }
    
    //剪裁图片
    func clipImg(_ img: UIImage, col: Int, row: Int, idx: Int) -> UIImage{
        
        let cgImgH = CGFloat( (img.cgImage?.height)! )
        let cgImgW = CGFloat( (img.cgImage?.width)! )
        
        
        let eleH = cgImgH / CGFloat(row)
        let eleW = cgImgW / CGFloat(col)
        
        let space = eleH < eleW ? eleH : eleW
        let topX = (cgImgW - space * CGFloat(col)) * 0.5
        let topY = (cgImgH - space * CGFloat(row)) * 0.5
        let X = topX + space * CGFloat(idx % col)
        let Y = topY + space * CGFloat(idx / col)
        
        let rect = CGRect(x: X, y: Y, width: space, height: space)
        
        let cgImg = img.cgImage?.cropping(to: rect)
        
        return UIImage(cgImage: cgImg!)
    }


}
