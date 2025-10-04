//
//  LiqudeGlassView.swift
//  SwiftyUI
//
//  Created by sylenthwave on 2025/10/4.
//

import SwiftUI

//MARK: - LiqudeGlassView
struct LiqudeGlassView: View {
  
  @State var selectedTab: Int = 0
  @State var showAllButtons: Bool = false
  @Namespace var namespace
  
  var body: some View {
    TabView {
      Tab("", systemImage: "1.square") {
        ZStack {
          Image("liqudeglass_bg")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
          ScrollView {
            glassButtonContentView
          }
        }
      }
      Tab("", systemImage: "2.square") {
        ZStack {
          Image("liqudeglass_bg")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
          ScrollView {
            glassBackgroundContentView
          }
        }
      }
    }
    .tint(.white)
  }
  
}

//MARK: - 视图Glass背景
extension LiqudeGlassView {
  
  /// - 为内容添加Glass背景
  var glassBackgroundContentView: some View {
    VStack(alignment: .leading, spacing: 20) {
      VStack(alignment: .leading) {
        Text("Shape")
          .foregroundStyle(.white)
          .fontWeight(.bold)
        glassShape
      }
      
      VStack(alignment: .leading) {
        Text("Text")
          .foregroundStyle(.white)
          .fontWeight(.bold)
        glassText
      }
      
      VStack(alignment: .leading) {
        Text("Stack")
          .foregroundStyle(.white)
          .fontWeight(.bold)
        stackGlass
          .padding(.top, 10)
      }
    }
    .padding(.top, 100)
    .padding(.horizontal, 30)
  }
  
  /// - 普通视图上增加LiqudeGlass效果
  var glassShape: some View {
    RoundedRectangle(cornerRadius: 20, style: .continuous)
      .frame(width: 300, height: 60, alignment: .center)
       /// - 必须增加颜色，否则不是纯白色
      .foregroundStyle(.white.opacity(0.1))
      .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 20, style: .continuous))
  }
  
  /// - 文字Label添加Glass效果
  var glassText: some View {
    Text("Welcome to Glass World!!!")
      //.foregroundStyle(.red) 不设置文字颜色会随背景颜色变为黑色或者白色
      .font(.title3)
      .fontDesign(.serif)
      .fontWeight(.bold)
      .padding(.horizontal, 20)
      .padding()
      .glassEffect()
  }
  
  /// - VStack / HStack 添加Glass背景
  /// - 应该直接对Stack使用Glass效果，而不是先设置Background
  var stackGlass: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        Image(systemName: "bookmark.circle.fill")
          .font(.system(size: 20))
        Text("bookmark.circle.fill")
          .font(.system(size: 20))
        Spacer()
      }
      HStack {
        Image(systemName: "moon.zzz.fill")
          .font(.system(size: 20))
        Text("moon.zzz.fill")
          .font(.system(size: 20))
        Spacer()
      }
      HStack {
        Image(systemName: "cloud.bolt.rain")
          .font(.system(size: 20))
        Text("cloud.bolt.rain")
          .font(.system(size: 20))
        Spacer()
      }
    }
    .padding()
    .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 20, style: .continuous))
  }
}

//MARK: - 按钮Glass
extension LiqudeGlassView {
  
  var glassButtonContentView: some View {
    
    VStack(alignment: .leading, spacing: 20) {
      
      VStack {
        Text("Normal Button")
          .foregroundStyle(.white)
          .fontWeight(.bold)
        normalButton
      }
      
      VStack {
        Text("Image Button")
          .foregroundStyle(.white)
          .fontWeight(.bold)
        imageButton
      }
      
      VStack {
        Text("Container Button")
          .foregroundStyle(.white)
          .fontWeight(.bold)
        containerButtons
      }
    }
    .padding(.top, 100)
    .padding(.horizontal, 30)
  }
  
  var normalButton: some View {
    Button {
    
    } label: {
      Text("Tap Me!")
        .font(.system(size: 18, weight: .semibold))
        .foregroundStyle(.black)
        .padding()
    }
    .buttonStyle(.glass)
  }
  
  var imageButton: some View {
    Button {
      
    } label: {
      Image(systemName: "checkmark")
        .font(.system(size: 20, weight: .regular))
        .foregroundStyle(.black)
        .frame(width: 40, height: 50)
    }
    .buttonStyle(.glass)

  }
  
  var containerButtons: some View {
    GlassEffectContainer(spacing: 10) {
      HStack(spacing: 10) {
        Button {
          withAnimation(.smooth) {
            showAllButtons.toggle()
          }
        } label: {
          Image(systemName: "checkmark")
            .foregroundStyle(.black)
            .font(.system(size: 20))
            .frame(width: 40, height: 50)
        }
        .buttonStyle(.glass)
        .glassEffectID("check", in: namespace)
        if showAllButtons {
          Button {
            withAnimation(.smooth) {
              showAllButtons.toggle()
            }
          } label: {
            Image(systemName: "xmark")
              .font(.system(size: 20))
              .frame(width: 40, height: 50)
          }
          .tint(.blue)
          .buttonStyle(.glassProminent)
          .glassEffectID("xmark", in: namespace)
          .glassEffectTransition(.matchedGeometry)
        }
      }
    }
  }
}

//MARK: - Previews
#Preview {
  LiqudeGlassView()
}
