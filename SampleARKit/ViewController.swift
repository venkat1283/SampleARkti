//
//  ViewController.swift
//  SampleARKit
//
//  Created by Venkata Naresh Katari on 8/14/19.
//  Copyright © 2019 IMI. All rights reserved.
//

import UIKit
import ARKit

let kStartingPosition = SCNVector3(0, 0, -0.6)
let kAnimationDurationMoving: TimeInterval = 0.2
let kMovingLengthPerLoop: CGFloat = 0.05
let kRotationRadianPerLoop: CGFloat = 0.2
let itemCollectionCell = "itemCollectionViewCell"

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var scenesArray : NSMutableArray = NSMutableArray()
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var itemsCollectionsView: UICollectionView!
    var drone = Drone()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //itemsCollectionsView .register(ItemCollectionViewCell.self, forCellWithReuseIdentifier:itemCollectionCell)
       // itemsCollectionsView.register([UINib (nibName:"ItemCollectionViewCell", bundle: nil)], forCellWithReuseIdentifier: itemCollectionCell)
        
        scenesArray = NSMutableArray.init(objects: "Drone_daes","Plane","FlareHunShort","MaxPro","Car","Doraemon","table");
        itemsCollectionsView.showsHorizontalScrollIndicator = true;
        itemsCollectionsView.register(UINib.init(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: itemCollectionCell)
        self.sceneSctup(view: sceneView)
        self.setUpConfiguration();
        self.addDrone();
    }
    func sceneSctup(view:ARSCNView)
{
    let scene = SCNScene();
    view.scene = scene;
}
func setUpConfiguration()
{
    let configuration = ARWorldTrackingConfiguration();
    sceneView.session.run(configuration);
    }
func addDrone() {
    drone.loadScene(name: scenesArray.object(at: 0) as! String)
    sceneView.scene.rootNode.addChildNode(drone)
}
    @IBAction func upLongPressed(_ sender: UILongPressGestureRecognizer) {
        let action = SCNAction.moveBy(x: 0, y: kMovingLengthPerLoop, z: 0, duration: kAnimationDurationMoving)
        execute(action: action, sender: sender)
    }
    
    @IBAction func downLongPressed(_ sender: UILongPressGestureRecognizer) {
        let action = SCNAction.moveBy(x: 0, y: -kMovingLengthPerLoop, z: 0, duration: kAnimationDurationMoving)
        execute(action: action, sender: sender)
    }
    
    @IBAction func moveLeftLongPressed(_ sender: UILongPressGestureRecognizer) {
        let x = -deltas().cos
        let z = deltas().sin
        moveDrone(x: x, z: z, sender: sender)
    }
    
    @IBAction func moveRightLongPressed(_ sender: UILongPressGestureRecognizer) {
        let x = deltas().cos
        let z = -deltas().sin
        moveDrone(x: x, z: z, sender: sender)
    }
    
    @IBAction func moveForwardLongPressed(_ sender: UILongPressGestureRecognizer) {
        let x = -deltas().sin
        let z = -deltas().cos
        moveDrone(x: x, z: z, sender: sender)
    }
    
    @IBAction func moveBackLongPressed(_ sender: UILongPressGestureRecognizer) {
        let x = deltas().sin
        let z = deltas().cos
        moveDrone(x: x, z: z, sender: sender)
    }
    
    @IBAction func rotateLeftLongPressed(_ sender: UILongPressGestureRecognizer) {
        rotateDrone(yRadian: kRotationRadianPerLoop, sender: sender)
    }
    
    @IBAction func rotateRightLongPressed(_ sender: UILongPressGestureRecognizer) {
        rotateDrone(yRadian: -kRotationRadianPerLoop, sender: sender)
    }
    private func execute(action: SCNAction, sender: UILongPressGestureRecognizer) {
        let loopAction = SCNAction.repeatForever(action)
        if sender.state == .began {
            drone.runAction(loopAction)
        } else if sender.state == .ended {
            drone.removeAllActions()
        }
    }
    private func deltas() -> (sin: CGFloat, cos: CGFloat) {
        return (sin: kMovingLengthPerLoop * CGFloat(sin(drone.eulerAngles.y)), cos: kMovingLengthPerLoop * CGFloat(cos(drone.eulerAngles.y)))
    }
    private func moveDrone(x: CGFloat, z: CGFloat, sender: UILongPressGestureRecognizer) {
        let action = SCNAction.moveBy(x: x, y: 0, z: z, duration: kAnimationDurationMoving)
        execute(action: action, sender: sender)
    }
    private func rotateDrone(yRadian: CGFloat, sender: UILongPressGestureRecognizer) {
        let action = SCNAction.rotateBy(x: 0, y: yRadian, z: 0, duration: kAnimationDurationMoving)
        execute(action: action, sender: sender)
    }
    
   func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1;
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
     {
        return scenesArray.count;
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCollectionCell, for: indexPath) as! ItemCollectionViewCell
        self.sceneSctup(view: cell.sceneImg as! ARSCNView)
        drone.loadScene(name:scenesArray.object(at: indexPath.row) as! String)
        cell.sceneImg.scene!.rootNode.addChildNode(drone)
        return cell;
    }
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        drone.loadScene(name:scenesArray.object(at: indexPath.row) as! String)
        sceneView.scene.rootNode.addChildNode(drone)
    }
    
}
