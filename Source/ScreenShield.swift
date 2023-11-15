

import UIKit
import SwiftUI


// MARK: UIKit
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



//MARK:  SwiftUI
public struct ProtectScreenshot: ViewModifier {
    public func body(content: Content) -> some View {
        ScreenshotProtectView { content }
    }
}

public extension View {
    func protectScreenshot() -> some View {
        modifier(ProtectScreenshot())
    }
}

struct ScreenshotProtectView<Content: View>: UIViewControllerRepresentable {
    typealias UIViewControllerType = ScreenshotProtectingHostingViewController<Content>
    
    private let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        ScreenshotProtectingHostingViewController(content: content)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

final class ScreenshotProtectingHostingViewController<Content: View>: UIViewController {
    private let content: () -> Content
    private let wrapperView = ScreenshotProtectingView()
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.addSubview(wrapperView)
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wrapperView.topAnchor.constraint(equalTo: view.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let hostVC = UIHostingController(rootView: content())
        hostVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(hostVC)
        wrapperView.setup(contentView: hostVC.view)
        hostVC.didMove(toParent: self)
    }
}


public final class ScreenshotProtectingView: UIView {
    
    private var contentView: UIView?
    private let textField = UITextField()
    private lazy var secureContainer: UIView? = try? getSecureContainer(from: textField)
    
    public init(contentView: UIView? = nil) {
        self.contentView = contentView
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        textField.backgroundColor = .clear
        textField.isUserInteractionEnabled = false
        textField.isSecureTextEntry = true
        
        guard let container = secureContainer else { return }
        
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        guard let contentView = contentView else { return }
        setup(contentView: contentView)
    }
    
    public func setup(contentView: UIView) {
        self.contentView?.removeFromSuperview()
        self.contentView = contentView
        
        guard let container = secureContainer else { return }
        
        container.addSubview(contentView)
        container.isUserInteractionEnabled = isUserInteractionEnabled
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        bottomConstraint.priority = .required - 1
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: container.topAnchor),
            bottomConstraint
        ])
    }
    
    func getSecureContainer(from view: UIView) throws -> UIView {
        let containerName: String
        
        if #available(iOS 15, *) {
            containerName = "_UITextLayoutCanvasView"
        } else if #available(iOS 14, *) {
            containerName = "_UITextFieldCanvasView"
        } else {
            let currentIOSVersion = (UIDevice.current.systemVersion as NSString).floatValue
            throw NSError(domain: "YourDomain", code: -1, userInfo: ["UnsupportedVersion": currentIOSVersion])
        }
        
        let containers = view.subviews.filter { type(of: $0).description() == containerName }
        
        guard let container = containers.first else {
            throw NSError(domain: "YourDomain", code: -1, userInfo: ["ContainerNotFound": containerName])
        }
        
        return container
    }
}

