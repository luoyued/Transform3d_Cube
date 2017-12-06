//
//  CubeViewController.swift
//  03core  Anmiation mask
//
//  Created by wang dan on 2017/12/6.
//  Copyright © 2017年 luoyue. All rights reserved.
//

import UIKit
import GLKit
class LYCubeViewController: UIViewController {

    var viewArrar:[LYCubeFaceView] = []
    var containerView:UIView?
    
    var sliderX:UISlider?
    var sliderY:UISlider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.addContainerView()
        self.addControlSlider()
        self.createFaceView()
        self.updateCubeFaceViews()
        // Do any additional setup after loading the view.
    }
    /**添加容器view*/
    func addContainerView() {
        containerView = UIView(frame: view.bounds)
        containerView?.backgroundColor = UIColor.black
        view.addSubview(containerView!)
        containerView!.center = view.center
        var superTransform = CATransform3DIdentity
        superTransform.m34 = -1.0/500
        superTransform = CATransform3DRotate(superTransform, CGFloat(-Double.pi/4), 1, 0, 0)
        superTransform = CATransform3DRotate(superTransform, CGFloat(-Double.pi/4), 0, 1, 0)
        containerView!.layer.sublayerTransform = superTransform
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panAction(_:)))
        containerView?.addGestureRecognizer(pan)
    }

    func addControlSlider() {
        sliderX = self.createSlider(origin: CGPoint(x: 20, y: view.bounds.size.height-80))
        view.addSubview(sliderX!)
        sliderY = self.createSlider(origin: CGPoint(x: 20, y: view.bounds.size.height-40))
        view.addSubview(sliderY!)
    }
    /**创建控制选择的silder*/
    func createSlider(origin:CGPoint) ->UISlider {
        let slider = UISlider(frame: CGRect(x: origin.x, y: origin.y, width: view.frame.size.width-40, height: 30))
        slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }
    /**创建正方体每一个面*/
    func createFaceView() {
        for index in 0...5 {
            let faceView = LYCubeFaceView(frame: CGRect(x: 0, y: 0, width: 150, height: 150), text: "\(index)")
            faceView.tag = index+1
            containerView!.addSubview(faceView)
            viewArrar.append(faceView)
            faceView.center = CGPoint(x: containerView!.bounds.size.width/2, y: containerView!.bounds.size.height/2)
        }
    }
    /**更新每一个面位置*/
    func updateCubeFaceViews(){
        for index in 0...viewArrar.count-1 {
            let faceView = viewArrar[index]
            let transform = self.getTransform(faceView: faceView, index: index);
            faceView.layer.transform = transform
//            self.applyLightToFace(faceLayer: faceView.layer)
        }
    }
    
    /**通过index 配置每一个view的位置*/
    func getTransform(faceView:UIView,index:Int) -> CATransform3D {
        var transform = CATransform3DIdentity
        switch index {
        case 0:
            print("front")
            transform = CATransform3DTranslate(transform, 0, 0,-faceView.bounds.size.height/2)
        //后
        case 1:
            print("back")
            transform = CATransform3DTranslate(transform, 0, 0,faceView.bounds.size.height/2)
        //前
        case 2:
            print("left")
            transform = CATransform3DTranslate(transform, -faceView.bounds.size.width/2,0, 0)
            transform = CATransform3DRotate(transform, CGFloat(-Double.pi/2), 0, 1, 0)
        //左
        case 3:
            print("right")
            transform = CATransform3DTranslate(transform, faceView.bounds.size.width/2, 0, 0)
            transform = CATransform3DRotate(transform, CGFloat(Double.pi/2), 0, 1, 0)
        //右
        case 4:
            print("up")
            transform = CATransform3DTranslate(transform, 0, -faceView.bounds.size.height/2, 0)
            transform = CATransform3DRotate(transform, CGFloat(Double.pi/2), 1, 0, 0)
        //上
        default:
            print("down")
            transform = CATransform3DTranslate(transform, 0, faceView.bounds.size.height/2, 0)
            transform = CATransform3DRotate(transform, CGFloat(-Double.pi/2), 1, 0, 0)
            //下
        }
        return transform
    }
    
    
    //通过slider旋转正方体
    var valueX:Float = 0
    var valueY:Float = 0
    @objc func sliderValueDidChange(_ slider:UISlider){
        var superTransform = containerView!.layer.sublayerTransform
        var value:Float
        if slider == sliderY{
            value = valueY
        }else{
            value = valueX
        }
        let angle =  CGFloat(Double.pi*2) * CGFloat(slider.value-value)
        if slider == sliderY{
            valueY = slider.value
            superTransform = CATransform3DRotate(superTransform, angle, 0, 1, 0)
        }else{
            valueX = slider.value
            superTransform = CATransform3DRotate(superTransform, angle, 1, 0, 0)
        }
        print(slider.value)
        containerView?.layer.sublayerTransform = superTransform
    }
    
    
    /**手势选择*/
    @objc func panAction(_ gesture:UIPanGestureRecognizer) {
        let point = gesture.translation(in: containerView)
        print(point)
        let angelY: CGFloat =  point.x/containerView!.bounds.size.width * CGFloat(Double.pi*2)
        let angelX: CGFloat =  point.y/containerView!.bounds.size.width * CGFloat(-Double.pi*2)
        var superTransform = containerView!.layer.sublayerTransform
        superTransform = CATransform3DRotate(superTransform, angelY, 0, 1, 0)
        superTransform = CATransform3DRotate(superTransform, angelX, 1, 0, 0)
        containerView?.layer.sublayerTransform = superTransform
        gesture.setTranslation(.zero, in: containerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
