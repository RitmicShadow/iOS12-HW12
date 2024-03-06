//
//  CircularProgress.swift
//  iOS12-HW12
//
//  Created by Ден Майшев on 28.02.2024.
//

import UIKit

class CircularProgress: UIView {

    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)

    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }

    private func createCircularPath() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0,
                                                           y: frame.size.height / 2.0),
                                        radius: 150,
                                        startAngle: startPoint,
                                        endAngle: endPoint,
                                        clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 8.0
        circleLayer.strokeEnd = 1
        circleLayer.strokeColor = UIColor.systemGray6.cgColor
        circleLayer.opacity = 0.5
        layer.addSublayer(circleLayer)

        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 8.0
        progressLayer.strokeColor = UIColor.green.cgColor
        layer.addSublayer(progressLayer)
    }

    func pauseAnimation() {
        let pausedTime: CFTimeInterval = progressLayer.convertTime(CACurrentMediaTime(), from: nil)
        progressLayer.speed = 0.0
        progressLayer.timeOffset = pausedTime
    }

    func resumeAnimation() {
        let pausedTime: CFTimeInterval = progressLayer.timeOffset
        progressLayer.speed = 1.0
        progressLayer.timeOffset = 0.0
        progressLayer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = progressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        progressLayer.beginTime = timeSincePause
    }

    func progressAnimation(duration: TimeInterval, from: CGFloat, to: CGFloat) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        progressLayer.strokeEnd = from
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = to
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
