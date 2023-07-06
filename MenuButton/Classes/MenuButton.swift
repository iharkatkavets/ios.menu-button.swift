//
//  MenuButton.swift
//  MenuButton
//
//  Created by Ihar Katkavets on 06/07/2023.
//

import UIKit

fileprivate enum TouchState {
    case idle
    case down
    case up
    case cancelled
}

public final class MenuButton: UIControl {
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let highlightOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        view.alpha = 0
        return view
    }()
    
    private var touchState: TouchState = .idle {
        didSet {
            guard touchState != oldValue else { return }
            switch touchState {
            case .down:
                performTouchDownAnimations()
            case .up:
                performTouchUpAnimations()
            case .cancelled:
                performTouchUpAnimations()
            case .idle:
                break
            }
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func setupLayout() {
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        highlightOverlayView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(highlightOverlayView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            highlightOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            highlightOverlayView.topAnchor.constraint(equalTo: topAnchor),
            highlightOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            highlightOverlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        touchState = .down
        return true
    }

    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let point = touch.location(in: self)
        if bounds.contains(point) {
            touchState = .down
        } else {
            touchState = .cancelled
        }
        return true
    }

    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        if let point = touch?.location(in: self), bounds.contains(point) {
            touchState = .up
            sendActions(for: .primaryActionTriggered)
        } else {
            touchState = .cancelled
        }
    }

    public override func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        touchState = .cancelled
    }
    
    private func performTouchDownAnimations() {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState, .curveEaseOut]) {
            self.highlightOverlayView.alpha = 1
        }
    }
    
    private func performTouchUpAnimations() {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState, .curveEaseOut]) {
            self.highlightOverlayView.alpha = 0
        }
    }
}
