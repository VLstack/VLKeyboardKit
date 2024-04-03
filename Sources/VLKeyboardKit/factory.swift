import SwiftUI

extension VLKeyboard
{
 public class Factory: VLKeyboard
 {
  /// Initializes a factory instance with the specified delegate and SwiftUI input view builder closure
  ///
  /// - Parameters:
  ///   - delegate: The delegate for text field interactions
  ///   - keyboardInputView: A closure that returns a SwiftUI view representing the custom keyboard
  public init(_ delegate: UITextFieldDelegate? = nil,
              @ViewBuilder _ keyboardInputView: @escaping ((UITextDocumentProxy, FeedbackHandler?, UITextFieldDelegate?) -> some View))
  {
   super.init(nibName: nil, bundle: nil)
   let rootView = keyboardInputView(self.textDocumentProxy,
                                    self.feedback,
                                    delegate)
   let hostingController = UIHostingController.init(rootView: rootView)
   self.keyboardView = hostingController.view
   self.delegate = delegate
  }
  
  /// :nodoc:
  required init?(coder: NSCoder) { fatalError("VLKeyboard.Factory.init(coder:) not implemented") }
 }
}
