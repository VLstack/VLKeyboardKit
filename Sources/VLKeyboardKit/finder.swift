import UIKit
import SwiftUI

extension View
{
 public func getTextField(_ customize: @escaping (UITextField) -> ()) -> some View
 {
  self.background(VLKeyboard.FindTextField(customize))
 }
}

extension VLKeyboard
{
 fileprivate struct FindTextField: UIViewRepresentable
 {
  let customize: (UITextField) -> Void
  
  public init(_ customize: @escaping (UITextField) -> Void)
  {
   self.customize = customize
  }
  
  public func makeUIView(context: UIViewRepresentableContext<FindTextField>) -> UIView
  {
   UIView(frame: .zero)
  }
  
  public func updateUIView(_ uiView: UIView,
                           context: UIViewRepresentableContext<FindTextField>)
  {
   DispatchQueue.main.asyncAfter(deadline: .now())
   {
    guard let textfield: UITextField = self.getTarget(uiView)
    else { return }
    self.customize(textfield)
   }
  }
  
  private func getTarget(_ view: UIView) -> UITextField?
  {
   guard let viewHost: UIView = getViewHost(view)
   else { return nil }
   
   return firstSibling(viewHost)
  }
  
  private func getViewHost(_ viewHost: UIView) -> UIView?
  {
   var superview = viewHost.superview
   while let s = superview
   {
    if NSStringFromClass(type(of: s)).contains("ViewHost")
    {
     return s
    }
    
    superview = s.superview
   }
   
   return nil
  }
  
  private func firstSibling(_ viewHost: UIView) -> UITextField?
  {
   guard let superview = viewHost.superview,
         let index = superview.subviews.firstIndex(of: viewHost)
   else { return nil }
   
   for subview in superview.subviews[index..<superview.subviews.endIndex]
   {
    if let typed = findChild(subview)
    {
     return typed
    }
   }
   
   return nil
  }
  
  private func findChild(_ root: UIView) -> UITextField?
  {
   for subview in root.subviews
   {
    if let typed: UITextField = subview as? UITextField
    {
     return typed
    }
    
    if let typed: UITextField = findChild(subview)
    {
     return typed
    }
   }
   
   return nil
  }
 }
}
