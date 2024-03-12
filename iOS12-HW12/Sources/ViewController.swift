//
//  ViewController.swift
//  iOS12-HW12
//
//  Created by Ден Майшев on 23.02.2024.
//

import UIKit

class ViewController: UIViewController {

    private var isWorkTime = true
    private var isStarted = false

    // MARK: - Timer

    private var timer: Timer?
    private var runCount = 0.0
    private var duration = 25.0
    private var fromValue: CGFloat = 1
    private var toValue: CGFloat = 0
    private var workingTime = 25.0
    private var restTime = 5.0

    // MARK: - UI

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = String(Int(duration))
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 80, weight: .bold)
        label.textColor = .systemRed
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var playStopButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var circularProgress: CircularProgress = {
        let view = CircularProgress()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setups

    private func setupView() {
        view.backgroundColor = .black
    }

    private func setupHierarchy() {
        view.addSubview(circularProgress)
        view.addSubview(timeLabel)
        view.addSubview(playStopButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            circularProgress.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circularProgress.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            timeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            timeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            playStopButton.heightAnchor.constraint(equalToConstant: 34),
            playStopButton.widthAnchor.constraint(equalToConstant: 34),
            playStopButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            playStopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // MARK: - Actions

    @objc private func buttonTapped() {
        isStarted.toggle()

        switch isStarted {
        case true:
            circularProgress.resumeAnimation()
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(step), userInfo: nil, repeats: true)
            playStopButton.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
        default:
            circularProgress.pauseAnimation()
            timer?.invalidate()
            playStopButton.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
        }
    }

    @objc private func step() {
        let formatter = DateFormatter()
        let rounded = runCount.rounded(.up)
        let date = Date(timeIntervalSince1970: TimeInterval(rounded))

        formatter.dateFormat = "ss"
        timeLabel.text = formatter.string(from: date)

        guard rounded == 0 else {
            runCount -= 0.01
            return
        }

        if isWorkTime {
            fromValue = 1
            toValue = 0
            duration = workingTime
            runCount = workingTime
            timeLabel.textColor = .systemRed
        } else {
            fromValue = 0
            toValue = 1
            duration = restTime
            runCount = restTime
            timeLabel.textColor = .systemGreen
        }

        isWorkTime.toggle()
        circularProgress.progressAnimation(duration: duration, from: fromValue, to: toValue)
    }
}
