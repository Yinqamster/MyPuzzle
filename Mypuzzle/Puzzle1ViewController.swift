//
//  Puzzle1ViewController.swift
//  Mypuzzle
//
//  Created by 141220138_141220132 on 17/1/10.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class Puzzle1ViewController: UIViewController {

    var puzzle1 = Puzzle1()
    var imagePick: FZImagePicker!
    
    public var imageView: UIImageView! = UIImageView()
 //   imageView.image = UIImage(named: "138448104748")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: "138448104748")
        setUpImg()
        imagePick = FZImagePicker()
        //设置代理对象
        imagePick.delegate = self
        imagePick.viewController = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClick(_ sender: Any) {
        imagePick.showImagePick()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setUpImg(){
        
        //清除
        for imgView in puzzle1.imgViewArr {
            imgView.removeFromSuperview()
        }
        puzzle1.imgViewArr.removeAll(keepingCapacity: true)
        
        puzzle1.kImgWidth = (UIScreen.main.bounds.size.width - 60) / CGFloat(puzzle1.kCol)
        
        for i in 0..<(puzzle1.kCol * puzzle1.kCol) {
            let col = i % puzzle1.kCol
            let row = i / puzzle1.kCol
            let x = 30 + CGFloat(col) * puzzle1.kImgWidth
            let y = 200 + CGFloat(row) * puzzle1.kImgWidth
            
            let frame:CGRect = CGRect(x:x , y: y, width: puzzle1.kImgWidth, height: puzzle1.kImgWidth)
            
            let imgView = UIImageView(frame: frame)
            //            imgView.backgroundColor = UIColor.redColor()
            imgView.image = puzzle1.clipImg(imageView.image!, col: puzzle1.kCol, row: puzzle1.kCol, idx: i)
            imgView.layer.borderWidth = 1
            
            if i == (puzzle1.kCol * puzzle1.kCol - 1) {
                imgView.image = nil
                imgView.layer.borderWidth = 0
            }
            
            view .addSubview(imgView)
            puzzle1.imgViewArr.append(imgView)
            let P : CGPoint = CGPoint(x:imgView.frame.midX,y:imgView.frame.midY)
            puzzle1.pointInfo.append(P)
            
            //添加手势
            puzzle1.addSwipe(View: imgView, direction: .right)
            puzzle1.addSwipe(View: imgView, direction: .left)
            puzzle1.addSwipe(View: imgView, direction: .up)
            puzzle1.addSwipe(View: imgView, direction: .down)
        }
        
        //打乱
        puzzle1.disOrderImage()
        
    }
    
    @IBAction func reOrderImage(_ sender: UIBarButtonItem) {
        puzzle1.disOrderImage()
    }
    
    
    
    
    @IBAction func changedifficult(_ sender: UISlider) {
        if puzzle1.kCol != Int(sender.value){
            
            puzzle1.kCol = Int(sender.value)
            
            //清除
            for imgView in puzzle1.imgViewArr {
                imgView.removeFromSuperview()
            }
            puzzle1.imgViewArr.removeAll(keepingCapacity: true)
            
            //更新
            setUpImg()
        }
        print(sender.value,Int(sender.value))
    }

}

//MARK: - FZImagePickerDelegate
extension Puzzle1ViewController: FZImagePickerDelegate{
    
    func imagePickerDidSelectedImage(imagePick: FZImagePicker, didFinishPickingMediaWithInfo info: [String : Any]) {
        //获取图片，根据需要对图片进行压缩处理
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        setUpImg()
    }
}
