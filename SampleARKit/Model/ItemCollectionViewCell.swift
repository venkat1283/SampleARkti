//
//  ItemCollectionViewCell.swift
//  SampleARKit
//
//  Created by Venkata Naresh Katari on 8/20/19.
//  Copyright © 2019 IMI. All rights reserved.
//

import UIKit
import ARKit
class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var sceneImg: SCNView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
