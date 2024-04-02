import Foundation
import UIKit
import SwiftUI

extension VLKeyboard
{
 public class Factory: VLKeyboard
 {
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
  
  required init?(coder: NSCoder) { fatalError("VLKeyboard.Factory.init(coder:) not implemented") }
 }
}
