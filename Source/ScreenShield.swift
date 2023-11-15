import UIKit
import SwiftUI

public extension View {
    func protectScreenshot() -> some View {
        let guardView = ProtectView()
        return self.background(guardView)
    }
}

private struct ProtectView: UIViewRepresentable {
    #if os(iOS)
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.setScreenCaptureProtection()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
    #else
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        view.setScreenCaptureProtection()
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) { }
    #endif
}

public class ScreenShield {
    public static let shared = ScreenShield()
    
    private var blurView: UIVisualEffectView?
    private var recordingObservation: NSKeyValueObservation?
    
    public func protect(window: UIWindow) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            window.setScreenCaptureProtection()
        })
    }
    
    public func protect(view: UIView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            view.setScreenCaptureProtection()
        })
    }
    
    public func protectFromScreenRecording() {
        recordingObservation =  UIScreen.main.observe(\UIScreen.isCaptured, options: [.new]) { [weak self] screen, change in
            let isRecording = change.newValue ?? false
            
            if isRecording {
                self?.addBlurView()
            } else {
                self?.removeBlurView()
            }
        }
    }
    
    private func addBlurView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = UIScreen.main.bounds
        
        // Add a label to the blur view
        let label = UILabel()
        label.text = "Screen recording not allowed"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        blurView.contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: blurView.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor)
        ])
        
        self.blurView = blurView
        UIApplication.shared.windows.first { $0.isKeyWindow }?.addSubview(blurView)
    }
    
    private func removeBlurView() {
        blurView?.removeFromSuperview()
        blurView = nil
    }
}


extension UIView {
    
    private struct Constants {
        static var secureTextFieldTag: Int { 54321 }
    }
    
    func setScreenCaptureProtection() {
        if viewWithTag(Constants.secureTextFieldTag) is UITextField {
            return
        }
        
        guard superview != nil else {
            for subview in subviews {
                subview.setScreenCaptureProtection()
            }
            return
        }
        
        let secureTextField = UITextField()
        secureTextField.backgroundColor = .clear
        secureTextField.translatesAutoresizingMaskIntoConstraints = false
        secureTextField.tag = Constants.secureTextFieldTag
        secureTextField.isSecureTextEntry = true
        
        insertSubview(secureTextField, at: 0)
        secureTextField.isUserInteractionEnabled = false
        
        #if os(iOS)
        layer.superlayer?.addSublayer(secureTextField.layer)
        secureTextField.layer.sublayers?.last?.addSublayer(layer)
        
        secureTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        secureTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        secureTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        secureTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        #else
        secureTextField.frame = bounds
        secureTextField.wantsLayer = true
        secureTextField.layer?.addSublayer(layer!)
        addSubview(secureTextField)
        #endif
    }
}

