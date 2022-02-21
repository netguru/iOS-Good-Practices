//
//  ViewController.swift
//  Biometrics how-to
//
//  Created by Jolanta Zakrzewska on 21/02/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var faceIdButton: UIImageView!
    @IBOutlet weak var touchIdButton: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!

    private let biometricsAuthManager: BiometricsAuthManager = DefaultBiometricsAuthManager(with: .deviceOwnerAuthenticationWithBiometrics)

    override func viewDidLoad() {
        super.viewDidLoad()

        switch biometricsAuthManager.availableBiometrics {
        case .none:
            disableFaceId()
            disableTouchId()
        case .faceID:
            enableFaceId()
            disableTouchId()
        case .touchID:
            enableTouchId()
            disableFaceId()
        }

        faceIdButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapFaceIdButton(_:))))
        touchIdButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapTouchIdButton(_:))))
    }

    @IBAction func didTapFaceIdButton(_ sender: UITapGestureRecognizer) {
        authenticateUser()
    }

    @IBAction func didTapTouchIdButton(_ sender: UITapGestureRecognizer) {
        authenticateUser()
    }
}

private extension ViewController {
    func authenticateUser() {
        if biometricsAuthManager.canEvaluatePolicy {
            biometricsAuthManager.authenticateUser { result in
                DispatchQueue.main.async {
                    self.resultLabel.text = result.rawValue
                }
            }
        } else {
            self.resultLabel.text = "Unable to evaluate policy"
        }
    }

    func enableFaceId() {
        faceIdButton.tintColor = .blue
        faceIdButton.isUserInteractionEnabled = true
    }

    func enableTouchId() {
        touchIdButton.tintColor = .blue
        touchIdButton.isUserInteractionEnabled = true
    }

    func disableFaceId() {
        faceIdButton.tintColor = .gray
        faceIdButton.isUserInteractionEnabled = false
    }

    func disableTouchId() {
        touchIdButton.tintColor = .gray
        touchIdButton.isUserInteractionEnabled = false
    }
}
