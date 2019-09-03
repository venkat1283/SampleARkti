//
//  Drone.swift
//  SampleARKit
//
//  Created by Venkata Naresh Katari on 8/14/19.
//  Copyright © 2019 IMI. All rights reserved.
//

import Foundation
import ARKit
class Drone: SCNNode {
    func loadModel() {
        guard let virtualObjectScene = SCNScene(named: "Drone_daes.scn") else { return }
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes {
            wrapperNode.addChildNode(child)
        }
        addChildNode(wrapperNode)
    }
    func loadScene(name:String)  {
        guard let virtualObjectScene = SCNScene(named:String.init(format: "%@.scn", name)) else { return }
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes {
            wrapperNode.addChildNode(child)
        }
        addChildNode(wrapperNode)
    }
}
