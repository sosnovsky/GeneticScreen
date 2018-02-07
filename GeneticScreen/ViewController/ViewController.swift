//
//  ViewController.swift
//  GeneticScreen
//
//  Created by Roma Sosnovsky on 8/1/16.
//  Copyright © 2016 Roma Sosnovsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var topLabelPaddingTop: NSLayoutConstraint!
    @IBOutlet weak var topLabelPaddingBottom: NSLayoutConstraint!
    
    @IBOutlet weak var geneticStackView: UIStackView!
    @IBOutlet weak var geneticTick: UIImageView!
    @IBOutlet weak var geneticTickWidth: NSLayoutConstraint!
    @IBOutlet weak var geneticTickHeight: NSLayoutConstraint!
    
    @IBOutlet weak var microStackView: UIStackView!
    
    @IBOutlet weak var priorityText: UILabel!
    @IBOutlet weak var priorityTextPaddingTop: NSLayoutConstraint!
    @IBOutlet weak var priorityTextPaddingBottom: NSLayoutConstraint!
    @IBOutlet weak var priorityContainer: UIView!
    
    @IBOutlet weak var readyButton: UIButton!
    
    var separatorView: UIView!
    
    var selectedPriorityCount = 0
    var priorityViews: [PriorityView] = []
    let priorityData: [[String:String]] = [
        ["image": "food", "label": "Food"],
        ["image": "sport", "label": "Sport"],
        ["image": "origin", "label": "Origin"],
        ["image": "person", "label": "Personal qualities"]
    ]
    
    let rotationAnimationKey = "backgroundImageRotation"
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        resetViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupPaddings()
        animateAppearance()
        setupPriorityBlocks()
        setupBackgroundImage()
    }
    
    // MARK: - Appearance functions
    
    func resetViews() {
        topLabel.alpha = 0
        geneticStackView.alpha = 0
        microStackView.alpha = 0
        priorityText.alpha = 0
        readyButton.alpha = 0
    }
    
    func setupPaddings() {
        topLabelPaddingTop.constant = view.frame.height * 0.02
        topLabelPaddingBottom.constant = view.frame.height * 0.01
        priorityTextPaddingTop.constant = view.frame.height * 0.055
        priorityTextPaddingBottom.constant = view.frame.height * 0.01
    }
    
    func animateAppearance() {
        animateSeparatorView()
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            self.geneticStackView.alpha = 1
            self.geneticTick.alpha = 1
            self.priorityText.alpha = 1
            self.readyButton.alpha = 1
            self.topLabel.alpha = 0.5
            self.microStackView.alpha = 0.5
            }, completion: { _ in
                self.animateGeneticTick()
        })
    }
    
    func animateSeparatorView() {
        let separatorViewWidth: CGFloat = 0.88
        let separatorViewPadding = (1 - separatorViewWidth) / 2
        let originY = geneticStackView.frame.maxY + view.frame.height * 0.05
        
        separatorView = UIView(frame: CGRect(x: view.frame.width / 2, y: originY, width: 0, height: 1))
        separatorView.backgroundColor = UIColor.white
        separatorView.alpha = 0
        view.addSubview(separatorView)

        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            self.separatorView.alpha = 0.5
            self.separatorView.frame = CGRect(x: self.view.frame.width * separatorViewPadding, y: originY, width: self.view.frame.width * separatorViewWidth, height: 1)
            }, completion: nil)
    }
    
    func animateGeneticTick() {
        UIView.animate(withDuration: 0.45, delay: 0, options: UIViewAnimationOptions(), animations: {
            let tickSide: CGFloat = 40
            let tickCenter = self.geneticTick.frame.getCenterPoint()
            self.geneticTick.frame = CGRect(x: tickCenter.x - tickSide / 2, y: tickCenter.y - tickSide / 2, width: tickSide, height: tickSide)
            self.geneticTickWidth.constant = tickSide
            self.geneticTickHeight.constant = tickSide
            }, completion: { _ in
                self.animatePriorityBlocks()
        })
    }
    
    func setupBackgroundImage() {
        let padding = (view.frame.height - view.frame.width)
        backgroundImageView.frame = CGRect(x: -padding, y: 0, width: view.frame.height, height: view.frame.height)
        rotateView(backgroundImageView, duration: 15)
    }
    
    func rotateView(_ view: UIView, duration: Double) {
        if view.layer.animation(forKey: rotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Double(.pi * 2.0)
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            view.layer.add(rotationAnimation, forKey: rotationAnimationKey)
        }
    }
    
    // MARK: - Priority blocks
        
    func setupPriorityBlocks() {
        let smallerSide = min(priorityContainer.frame.width, priorityContainer.frame.height)
        let priorityBlockProportion: CGFloat = 0.47
        let priorityBlockSize = smallerSide * priorityBlockProportion
        let priorityBlockPadding = smallerSide * (0.5 - priorityBlockProportion) / 2
        let priorityContainerCenter = CGPoint(x: priorityContainer.frame.width / 2, y: priorityContainer.frame.height / 2)
        
        for (index, data) in priorityData.enumerated() {
            let x: CGFloat?
            let y: CGFloat?
            let transform: CGAffineTransform?
            switch index {
            case 0:
                x = priorityContainerCenter.x - priorityBlockSize - priorityBlockPadding
                y = priorityContainerCenter.y - priorityBlockSize - priorityBlockPadding
                transform = CGAffineTransform(translationX: -priorityBlockSize * 0.41, y: -priorityBlockSize * 0.85)
            case 1:
                x = priorityContainerCenter.x + priorityBlockPadding
                y = priorityContainerCenter.y - priorityBlockSize - priorityBlockPadding
                transform = CGAffineTransform(translationX: priorityBlockSize * 0.38, y: -priorityBlockSize * 0.77)
            case 2:
                x = priorityContainerCenter.x - priorityBlockSize - priorityBlockPadding
                y = priorityContainerCenter.y + priorityBlockPadding
                transform = CGAffineTransform(translationX: -priorityBlockSize * 0.4, y: -priorityBlockSize * 0.83)
            case 3:
                x = priorityContainerCenter.x + priorityBlockPadding
                y = priorityContainerCenter.y + priorityBlockPadding
                transform = CGAffineTransform(translationX: priorityBlockSize * 0.37, y: priorityBlockSize * 0.78)
            default:
                return
            }
            
            guard let xPoint = x, let yPoint = y, let initialTransform = transform else { return }
            let originPoint = CGPoint(x: xPoint, y: yPoint)
            let frame = CGRect(origin: originPoint, size: CGSize(width: priorityBlockSize, height: priorityBlockSize))
            
            let priorityView = PriorityView(frame: frame)
            priorityView.setData(data["label"]!, imageName: data["image"]!)
            priorityView.alpha = 0
            priorityView.transform = initialTransform
            priorityContainer.addSubview(priorityView)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(togglePriorityView))
            priorityView.addGestureRecognizer(tapGesture)
            
            priorityViews.append(priorityView)
        }
    }
    
    @objc func togglePriorityView(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let senderView = gestureRecognizer.view as? PriorityView else { return }
        
        let isSelected = senderView.toggleSelected()
        selectedPriorityCount = isSelected ? selectedPriorityCount + 1 : selectedPriorityCount - 1
        
        let readyButtonTitle = selectedPriorityCount > 0 ? "Ready   >" : "Skip  >"
        readyButton.setTitle(readyButtonTitle, for: UIControlState())
    }
    
    func animatePriorityBlocks() {
        for (index, priorityView) in self.priorityViews.enumerated() {
            UIView.animate(withDuration: 0.5, delay: 0.17 * Double(index), options: UIViewAnimationOptions(), animations: {
                priorityView.alpha = 1
                priorityView.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }
}

