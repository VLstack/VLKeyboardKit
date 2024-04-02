import UIKit
import SwiftUI

public struct VLKeyboardFinderView<ViewType: UIView>: UIViewRepresentable
{
//    let selector: (UIView) -> ViewType?
    let customize: (ViewType) -> Void
    
    public init(
//        selector: @escaping (UIView) -> ViewType?,
        customize: @escaping (ViewType) -> Void
    ) {
//        self.selector = selector
        self.customize = customize
    }
    
    public func makeUIView(context: UIViewRepresentableContext<VLKeyboardFinderView>) -> UIView {
        let view = UIView(frame: .zero)
        view.accessibilityLabel = "IntrospectionUIView<\(ViewType.self)>"
        return view
    }

    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VLKeyboardFinderView>) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            guard let targetView = self.selector(uiView) else {
                return
            }
            self.customize(targetView)
        }
    }
 
 // TODO: rename to "getTarget"
 // TODO: should return UITextField?
 private func selector(_ view: UIView) -> ViewType?
 {
  guard let viewHost = findViewHost(from: view)
  else { return nil }

  return firstSibling(containing: UITextField.self, from: viewHost) as? ViewType
 }
 
 private func findViewHost(from entry: UIView) -> UIView?
 {
  var superview = entry.superview
  while let s = superview
  {
   if NSStringFromClass(type(of: s)).contains("ViewHost") { return s }
   superview = s.superview
  }
  
  return nil
 }
 
 private func firstSibling<AnyViewType: UIView>(containing type: AnyViewType.Type,
                                                from entry: UIView) -> AnyViewType?
 {
  guard let superview = entry.superview,
      let entryIndex = superview.subviews.firstIndex(of: entry)
  else { return nil }
        
  for subview in superview.subviews[entryIndex..<superview.subviews.endIndex]
  {
   if let typed = findChild(ofType: type, in: subview)
   {
    return typed
   }
  }
        
  return nil
 }

 private func findChild<AnyViewType: UIView>(ofType type: AnyViewType.Type,
                                             in root: UIView) -> AnyViewType?
 {
  for subview in root.subviews
  {
   if let typed = subview as? AnyViewType
   {
    return typed
   }
   
   if let typed = findChild(ofType: type, in: subview)
   {
    return typed
   }
  }
  
  return nil
 }
}

extension View
{
 @ViewBuilder
 public func findTextField(customize: @escaping (UITextField) -> ()) -> some View
 {
         return self.background(VLKeyboardFinderView(
//             selector: { introspectionView in
//                 guard let viewHost = INTROSPECT.findViewHost(from: introspectionView) else {
//                     return nil
//                 }
//                 return INTROSPECT.firstSibling(containing: UITextField.self, from: viewHost)
//             },
             customize: customize
         ))
     }
 
 
}
