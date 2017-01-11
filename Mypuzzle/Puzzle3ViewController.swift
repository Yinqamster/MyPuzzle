//
//  Puzzle3ViewController.swift
//  Mypuzzle
//
//  Created by 141220138_141220132 on 17/1/10.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class Puzzle3ViewController: UIViewController {

    var puzzle = Puzzle3()
    var imagePick: FZImagePicker!
    public var imageView: UIImageView! = UIImageView()
    
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
    
    @IBAction func bunClick(_ sender: Any) {
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
        for imgView in puzzle.imgViewArr {
            imgView.removeFromSuperview()
        }
        puzzle.imgViewArr.removeAll(keepingCapacity: true)
        puzzle.rotateInfo.removeAll(keepingCapacity: true)
        
        puzzle.kImgWidth = (UIScreen.main.bounds.size.width - 60) / CGFloat(puzzle.kCol)
        
        for i in 0..<(puzzle.kCol * puzzle.kCol) {
            let col = i % puzzle.kCol
            let row = i / puzzle.kCol
            let x = 30 + CGFloat(col) * puzzle.kImgWidth
            let y = 200 + CGFloat(row) * puzzle.kImgWidth
            
            let frame:CGRect = CGRect(x:x , y: y, width: puzzle.kImgWidth, height: puzzle.kImgWidth)
            
            let imgView = UIImageView(frame: frame)
            //            imgView.backgroundColor = UIColor.redColor()
            imgView.image = puzzle.clipImg(imageView.image!, col: puzzle.kCol, row: puzzle.kCol, idx: i)
            imgView.layer.borderWidth = 1
            
            if i == (puzzle.kCol * puzzle.kCol) {
                imgView.image = nil
                imgView.layer.borderWidth = 0
            }
            
            view .addSubview(imgView)
            puzzle.imgViewArr.append(imgView)
            puzzle.rotateInfo.append(0);
            
            //添加手势
            puzzle.addSwipe(View: imgView)
        }
        
        //打乱
        puzzle.disOrderImage();
        
    }
    
    @IBAction func reOrderImage(_ sender: UIBarButtonItem) {
        puzzle.disOrderImage();
       
    }
    
    
    
    
    @IBAction func changedifficult(_ sender: UISlider) {
        if puzzle.kCol != Int(sender.value){
            
            puzzle.kCol = Int(sender.value)
            
            //清除
            for imgView in puzzle.imgViewArr {
                imgView.removeFromSuperview()
            }
            puzzle.imgViewArr.removeAll(keepingCapacity: true)
            puzzle.rotateInfo.removeAll(keepingCapacity: true)
            //更新
            setUpImg()
        }
        print(sender.value,Int(sender.value))
    }

}

//MARK: - FZImagePickerDelegate
extension Puzzle3ViewController: FZImagePickerDelegate{
    
    func imagePickerDidSelectedImage(imagePick: FZImagePicker, didFinishPickingMediaWithInfo info: [String : Any]) {
        //获取图片，根据需要对图片进行压缩处理
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        setUpImg()
    }
}
