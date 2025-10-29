//
//  MetalTestShaderView.swift
//  SwiftyUI
//
//  Created by SylenthWave on 2025/10/29.
//

import SwiftUI

struct MetalTestShaderView: View {
  
  @State var startDate = Date()
  
  var body: some View {
    TimelineView(.animation) { context in
      let time = startDate.distance(to: context.date)
      Image(systemName: "figure.cooldown.circle")
        .font(.system(size: 300))
        .foregroundStyle(Color.red)
        .colorEffect(ShaderLibrary.rainbow(.float(time)))
    }
  }
  
}

#Preview {
  MetalTestShaderView()
}
