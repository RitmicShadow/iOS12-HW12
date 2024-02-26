//
//  ViewController.swift
//  iOS12-HW12
//
//  Created by Ден Майшев on 23.02.2024.
//

import UIKit

final class ViewController: UIViewController {
    
//    MARK: - UI

    var timeRemaining: Int = 25
    var timer: Timer!

    var isWorckTime = true
    var isStarted = false

    private lazy var labelTime: UILabel = {
        let labelTime = UILabel()
        labelTime.text = String(self.timeRemaining)
        labelTime.textColor = .red
        labelTime.font = .systemFont(ofSize: 100)
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        return labelTime
    }()

    private lazy var playStopButtom: UIButton = {
        let playStopButtom = UIButton()
        playStopButtom.setImage(UIImage(named: "Play"),
                                for: .normal)
        playStopButtom.imageEdgeInsets = UIEdgeInsets(top: 40,
                                                      left: 40,
                                                      bottom: 40,
                                                      right: 40)
        playStopButtom.addTarget(self, 
                                 action: #selector(starTimer),
                                 for: .touchUpInside)
        playStopButtom.translatesAutoresizingMaskIntoConstraints = false
        return playStopButtom
    }()

    //    MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
//    MARK: - Setups

    private func setupView() {

    }

    private func setupHierarchy() {
        view.addSubview(labelTime)
        view.addSubview(playStopButtom)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            labelTime.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTime.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            playStopButtom.topAnchor.constraint(equalTo: labelTime.bottomAnchor, 
                                                constant: 20),
            playStopButtom.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playStopButtom.heightAnchor.constraint(equalToConstant: 40),
            playStopButtom.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc
    func step() {
        if self.timeRemaining > 0 {
            self.timeRemaining -= 1
        } else {
            isWorckTime = !isWorckTime
            if isWorckTime {
                labelTime.textColor = .red
                timeRemaining = 25
            } else {
                labelTime.textColor = .green
                timeRemaining = 10
            }
        }
        labelTime.text = String(timeRemaining)
    }

    @objc
    func starTimer() {
        isStarted = !isStarted
        if isStarted {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, 
                                              target: self,
                                              selector: #selector(step),
                                              userInfo: nil,
                                              repeats: true)
            playStopButtom.setImage(UIImage(named: "Pause"),
                                    for: .normal)
        } else {
            timer.invalidate()
            playStopButtom.setImage(UIImage(named: "Play"),
                                    for: .normal)
        }
    }
}

