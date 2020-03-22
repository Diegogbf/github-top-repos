//
//  ViewController.swift
//  base-ios
//
//  Created by Diego Gomes on 20/01/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var topReposFilterSegmented: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Stars","Followers"])
        segmentControl.addTarget(self, action: #selector(selectionChanged), for: .valueChanged)
        return segmentControl
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        navigationItem.titleView = topReposFilterSegmented
        view.backgroundColor = .white
        view.addSubview(label)
        label.snp.makeConstraints{ $0.center.equalToSuperview() }
    }
    
    @objc func selectionChanged() {
        switch topReposFilterSegmented.selectedSegmentIndex {
        case 0:
            label.text = "Stars"
        case 1:
            label.text = "Followers"
        default:
            break
        }
    }
    
    
}

