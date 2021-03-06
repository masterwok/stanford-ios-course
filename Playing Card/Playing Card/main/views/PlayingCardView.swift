//
//  PlayingCardView.swift
//  Playing Card
//
//  Created by Jonathan Trowbridge on 1/11/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import UIKit

@IBDesignable
class PlayingCardView: UIView {

    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.35
    }
    
    @IBInspectable
    var rank: Int = 12 { didSet { requestDisplayUpdate() } }
    @IBInspectable
    var suit: String = "♥️" { didSet { requestDisplayUpdate() } }
    @IBInspectable
    var isFaceUp: Bool = false { didSet { requestDisplayUpdate() } }
    
    var faceCardScale: CGFloat = SizeRatio.faceCardImageSizeToBoundsSize {
        didSet {
            requestDisplayUpdate()
        }
    }
    
    @objc func adjustFaceCardScale(byHandlingGestureRecognizedBy recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .changed, .ended:
            faceCardScale *= recognizer.scale
            recognizer.scale = 1
        default:break
        }
    }
    
    private lazy var upperLeftCornerLabel = createCornerLabel()
    private lazy var lowerRightCornerLabel = createCornerLabel()
    private lazy var cardImageView = createCardImageView()
    
    private func createCardImageView() -> UIImageView {
        // This UIImage syntax is required to render image in storyboard
        let faceCardImage = UIImage(
            named: "CoStarIcon"
            , in: Bundle(for: self.classForCoder)
            , compatibleWith: traitCollection
        )
        
        let imageView = UIImageView(image: faceCardImage)
        
        imageView.contentMode = .scaleToFill

        addSubview(imageView)
        
        return imageView
    }
    
    private func createCornerLabel() -> UILabel {
        let label = UILabel()
        
        label.numberOfLines = 2
        
        addSubview(label)

        return label
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    
    private var rankString: String {
        switch rank {
        case 1: return "A"
        case 2...10: return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
        }
    }
    
    private func configureCornerLabel(_ label: UILabel) {
        label.attributedText = cornerString

        // Clear size so sizeToFit works correctly
        label.frame.size = CGSize.zero
        
        // Size label to fit contents
        label.sizeToFit()
        
        // Hide label if card isn't face up
        label.isHidden = !isFaceUp
    }
    
    private func configureCardImageView(_ imageView: UIImageView) {
        let cardWidth = bounds.size.width *  faceCardScale
        let size = CGSize(width: cardWidth, height: cardWidth)
        
        // Center the card
        imageView.center.x = bounds.midX
        imageView.center.y = bounds.midY

        // Set the size of the card
        imageView.frame.size = size
        
        // Add rounded corners
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        
        // Hide card image if card isn't face up
        imageView.isHidden = isFaceUp
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        requestDisplayUpdate()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureCardImageView(cardImageView)

        configureCornerLabel(upperLeftCornerLabel)
        
        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(
            dx: cornerOffset
            , dy: cornerOffset
        )

        configureCornerLabel(lowerRightCornerLabel)
        
        lowerRightCornerLabel.transform = CGAffineTransform
            .identity
            .translatedBy(x: lowerRightCornerLabel.frame.size.width, y: lowerRightCornerLabel.frame.size.height)
            .rotated(by: CGFloat.pi)
        
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
            .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
    }

    private func requestDisplayUpdate() {
        setNeedsDisplay()
        setNeedsLayout()
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        drawCardBackground()
    }

    private var cornerString: NSAttributedString {
        return createCenteredAttributedString(
            "\(rankString)\n\(suit)"
            , fontSize: cornerFontSize
        )
    }

    private func createCenteredAttributedString(
        _ string: String
        , fontSize: CGFloat
    ) -> NSAttributedString {
        var font = UIFont
            .preferredFont(forTextStyle: .body)
            .withSize(fontSize)
        
        // Don't forget this line of code so text scales when increased in settings
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        
        // Center text
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        return NSAttributedString(string: string, attributes: [
            .paragraphStyle: paragraphStyle,
            .font: font
        ])
    }
    
    private func drawCardBackground() {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        // Clip subviews from rendering outside of view
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }
    
    private func drawCircleUsingUIBezierPath() {
        let path = UIBezierPath()
        
        path.addArc(
            withCenter: CGPoint(x: bounds.midX, y: bounds.midY)
            , radius: 100
            , startAngle: 0
            , endAngle: 2 * CGFloat.pi
            , clockwise: true
        )
        
        path.lineWidth = 5
        UIColor.cyan.setFill()
        UIColor.black.setStroke()
        path.stroke()
        path.fill()
    }
    
    private func drawCircleUsingUIGraphics() {
        if let context = UIGraphicsGetCurrentContext() {
            context.addArc(
                center: CGPoint(x: bounds.midX, y: bounds.midY)
                , radius: 100
                , startAngle: 0
                , endAngle: 2 * CGFloat.pi
                , clockwise: true
            )

            context.setLineWidth(5)
            UIColor.cyan.setFill()
            UIColor.black.setStroke()
            context.strokePath()
            context.fillPath()
        }
    }

}
