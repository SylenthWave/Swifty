//
//  File.swift
//  SwiftyUI
//
//  Created by SylenthWave on 2025/10/18.
//

import SwiftUI

struct OutlineText: View {
  
  var body: some View {
    Text("Hello Outline Text")
      .font(.system(size: 30, weight: .bold, design: .rounded))
      .foregroundStyle(.white)
      .padding(.horizontal, 5)
      .background {
        Canvas { context, size in
          context.addFilter(.alphaThreshold(min: 0.050))
          context.addFilter(.blur(radius: 4))
          if let symbol = context.resolveSymbol(id: 1) {
            context.draw(symbol, in: CGRect(origin: .zero, size: size))
          }
        } symbols: {
          Text("Hello Outline Text")
            .font(.system(size: 30, weight: .bold, design: .rounded))
            .padding(.horizontal, 5)
            .tag(1)
        }
      }
    
  }
}

#Preview {
  OutlineText()
}
