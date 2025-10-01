//
//  CustomMenuView.swift
//  SwiftyUI
//
//  Created by sylenthwave on 2025/10/1.
//

import SwiftUI

//MARK: - CustomMenuView
struct CustomMenuView: View {
  
  enum CornerAlignment: Hashable {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
    
    var title: String {
      switch self {
      case .topLeading:
        return "TopL"
      case .topTrailing:
        return "TopR"
      case .bottomLeading:
        return "BottomL"
      case .bottomTrailing:
        return "BottomR"
      }
    }
  }
  
  @State private var progress: CGFloat = 0
  private var allCornerAlignments: [CornerAlignment] = [.topLeading, .topTrailing, .bottomLeading, .bottomTrailing]
  @State private var selectedCornerAlignment: CornerAlignment = .topLeading
  @State private var alignment: Alignment = .topLeading
  
  var body: some View {
    List {
      
      Section("Preview") {
        Rectangle()
          .foregroundStyle(.clear)
          .background {
            Image("custommenu_preview_bg")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .onTapGesture {
                withAnimation(.bouncy(duration: 0.55, extraBounce: 0.02)) {
                  progress = 0
                }
              }
          }
          .overlay(content: {
            ExpandableGlassMenu(alignment: alignment, progress: progress) {
              VStack(alignment: .leading, spacing: 12) {
                rowView("paperplane", "Send")
                rowView("arrow.trianglehead.2.counterclockwise", "Swap")
                rowView("arrow.down", "Receive")
              }
              .padding(10)
            } label: {
              Image(systemName: "square.and.arrow.up.fill")
                .font(.title3)
                .frame(width: 55, height: 55)
                .contentShape(.rect)
                .onTapGesture {
                  withAnimation(.bouncy(duration: 0.55, extraBounce: 0.02)) {
                    progress = 1
                  }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .padding(10)
          })
          .frame(height: 350)
      }
      .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
      
      Section("Alignment") {
        Picker("Picker", selection: $selectedCornerAlignment) {
          ForEach(allCornerAlignments, id: \.self) { item in
            Text(item.title)
              .tag(item)
          }
        }
        .pickerStyle(.palette)
        .onChange(of: selectedCornerAlignment) { oldValue, newValue in
          withAnimation(.smooth) {
            switch newValue {
            case .topLeading:
              alignment = .topLeading
            case .topTrailing:
              alignment = .topTrailing
            case .bottomLeading:
              alignment = .bottomLeading
            case .bottomTrailing:
              alignment = .bottomTrailing
            }
          }
        }
      }
      
      Section("Properties") {
        Slider(value: $progress, in: 0...1)
      }
    }
  }
  
  func rowView(_ image: String, _ title: String) -> some View {
    HStack(spacing: 10) {
      Image(systemName: image)
        .font(.title3)
        .symbolVariant(.fill)
        .frame(width: 45, height: 45)
        .background(.background, in: .circle)
      VStack(alignment: .leading, spacing: 6) {
        Text(title)
          .fontWeight(.semibold)
        Text("This is a smaple text description")
          .font(.caption)
          .foregroundStyle(.gray)
          .lineLimit(2)
      }
    }
    .padding(10)
    .contentShape(.rect)
  }
  
}

//MARK: - ExpandableGlassMenu
struct ExpandableGlassMenu<Content: View, Label: View>: View, Animatable {
  
  var alignment: Alignment
  var progress: CGFloat
  var cornerRadius: CGFloat = 30
  var labelSize: CGSize = .init(width: 55, height: 55)
  @ViewBuilder var content: Content
  @ViewBuilder var label: Label
  @State private var contentSize: CGSize = .zero
  var animatableData: CGFloat {
    get { progress }
    set { progress = newValue }
  }
  
  var labelOpacity: CGFloat {
    min(progress/0.35, 1)
  }
  
  var contentOpcity: CGFloat {
    max(progress - 0.35, 0)/0.65
  }
  
  var contentScale: CGFloat {
    let minAspectScale = min(labelSize.width/contentSize.width, labelSize.height/contentSize.height)
    return minAspectScale + (1 - minAspectScale) * progress
  }
  
  var blurProgress: CGFloat {
    return progress > 0.5 ? (1 - progress)/0.5 : progress/0.5
  }
  
  var offset: CGFloat {
    switch alignment {
    case .bottom, .bottomLeading, .bottomTrailing: return -75
    case .top, .topTrailing, .topLeading: return 75
    default: return 0
    }
  }
  
  var scaleAnchor: UnitPoint {
    switch alignment {
    case .bottomTrailing: .bottomTrailing
    case .bottom: .bottom
    case .bottomTrailing: .bottomTrailing
    case .topLeading: .topLeading
    case .top: .top
    case .topLeading: .topLeading
    case .leading: .leading
    case .trailing: .trailing
    default: .center
    }
  }
  
  var body: some View {
    GlassEffectContainer {
      let widthDiff = contentSize.width - labelSize.width
      let heightDiff = contentSize.height - labelSize.height
      let rWidth = widthDiff * contentOpcity
      let rHeight = heightDiff * contentOpcity
      
      ZStack(alignment: alignment) {
        content
          .compositingGroup()
          .scaleEffect(contentScale)
          .blur(radius: 14 * blurProgress)
          .opacity(contentOpcity)
          .onGeometryChange(for: CGSize.self, of: { $0.size }) { newValue in
            contentSize = newValue
          }
          .fixedSize()
          .frame(width: labelSize.width + rWidth, height: labelSize.height + rHeight)
        
        label
          .blur(radius: 14 * blurProgress)
          .opacity(1 - labelOpacity)
          .frame(width: labelSize.width, height: labelSize.height)
      }
      .compositingGroup()
      .clipShape(.rect(cornerRadius: cornerRadius))
      .glassEffect(.regular.interactive(), in: .rect(cornerRadius: cornerRadius))
    }
    .scaleEffect(x: 1 - (blurProgress * 0.35), y: 1 + (blurProgress * 0.45), anchor: scaleAnchor)
    .offset(y: offset * blurProgress)
  }
  
}

//MARK: - Previews
#Preview {
  CustomMenuView()
}
