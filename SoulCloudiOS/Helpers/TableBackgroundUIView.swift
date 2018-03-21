//
//  TableBackgroundUIView.swift
//  SoulCloudiOS
//
//  Created by BLVCK on 22/03/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

protocol ButtonTappedDelegate {
    func didTapButton()
}

class TableBackgroundUIView: UIView {

    var parentController: UIViewController = UIViewController()
    var delegate: ButtonTappedDelegate!
    func configure(with controller: ForYouViewController){
        parentController = controller
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate.didTapButton()
//        let popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpViewController") as! SelectGenresViewController
//        parentController.addChildViewController(popVC)
//        popVC.view.frame = parentController.view.frame
//        parentController.view.addSubview(popVC.view)
//        popVC.didMove(toParentViewController: parentController)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
