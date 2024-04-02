import Foundation
import UIKit
import SwiftUI

public extension View
{
 func keyboard(_ type: VLKeyboard) -> some View
 {
  self.modifier(VLKeyboard.Modifier(type))
 }
 
 func keyboard(delegate: UITextFieldDelegate? = nil,
               @ViewBuilder view: @escaping ((UITextDocumentProxy, VLKeyboard.FeedbackHandler?, UITextFieldDelegate?) -> some View)) -> some View
 {
  self.keyboard(VLKeyboard.Factory(delegate, view))
 }
}

extension VLKeyboard
{
 fileprivate struct Modifier: ViewModifier
 {
  @State var type: VLKeyboard
  
  internal init(_ type: VLKeyboard)
  {
   self._type = State(wrappedValue: type)
  }
  
  internal func body(content: Content) -> some View
  {
   content
    .getTextField
    {
     textfield in
     textfield.inputView = type.keyboardInputView
     textfield.delegate = type.delegate
    }
   //  .onAppear { keyboardType.onSubmit = onCustomSubmit }
   //  .introspect(.textEditor, on: .iOS(.v15...)) { uiTextView in uiTextView.inputView = keyboardType.keyboardInputView }
   //  .introspect(.textField, on: .iOS(.v15...)) { uiTextField in uiTextField.inputView = keyboardType.keyboardInputView }
  }
 }
}
