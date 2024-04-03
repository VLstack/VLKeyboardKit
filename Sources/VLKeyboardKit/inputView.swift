import UIKit

extension VLKeyboard
{
 /// Serves as the input view for the custom keyboard provided by `VLKeyboard`.
 public class InputView: UIView, UIInputViewAudioFeedback
 {
  /// Underlying UIView used as the input view
  private var uiView: UIView
  
  /// Indicates whether the input view plays input clicks
  public var enableInputClicksWhenVisible: Bool { true }
  
  /// Initializes the input view with the specified view
  /// 
  /// - Parameters:
  ///   - view: The view to be used as the input view
  init(_ view: UIView)
  {
   self.uiView = view
   uiView.backgroundColor = .clear
   uiView.translatesAutoresizingMaskIntoConstraints = false
   
   super.init(frame: .zero)
   translatesAutoresizingMaskIntoConstraints = false
   addSubview(uiView)
   let constraints = [
                      leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
                      trailingAnchor.constraint(equalTo: uiView.trailingAnchor),
                      topAnchor.constraint(equalTo: uiView.topAnchor),
                      bottomAnchor.constraint(equalTo: uiView.bottomAnchor),
                     ]
   NSLayoutConstraint.activate(constraints)
   backgroundColor = .clear
  }
  
  /// :nodoc:
  required init?(coder: NSCoder) { fatalError("VLKeyboard.InputView.init(coder:) not implemented") }

  /// :nodoc:
  public override var intrinsicContentSize: CGSize { uiView.intrinsicContentSize }
 }
}
