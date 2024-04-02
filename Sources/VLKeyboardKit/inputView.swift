import UIKit

extension VLKeyboard
{
 public class InputView: UIView, UIInputViewAudioFeedback
 {
  private var uiView: UIView
  
  public var enableInputClicksWhenVisible: Bool { true }
  
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
  
  required init?(coder: NSCoder) { fatalError("VLKeyboard.InputView.init(coder:) not implemented") }
  
  public override var intrinsicContentSize: CGSize { uiView.intrinsicContentSize }
 }
}
