//
//  FurgoperfectoMapAccessoryView.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 21/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import UIKit

protocol FurgoperfectoMapAccessoryViewDelegate {
    func moreInfoButtonPushed(state: FurgoperfectoViewModel)
}

final class FurgoperfectoMapAccessoryView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var servicesLabel: UILabel!
    @IBOutlet weak var servicesSatckView: UIStackView!
    @IBOutlet weak var moreInfoButon: UIButton!
    var delegate: FurgoperfectoMapAccessoryViewDelegate?
    var viewModel: FurgoperfectoViewModel? = nil
    
    func apply(state: FurgoperfectoViewModel){
        self.viewModel = state
    }

    @IBAction func moreInfoButtonPushed(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        delegate?.moreInfoButtonPushed(state: viewModel)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
