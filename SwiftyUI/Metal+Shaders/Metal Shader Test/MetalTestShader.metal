//
//  MetalTestShader.metal
//  SwiftyUI
//
//  Created by SylenthWave on 2025/10/29.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 changeColor(float2 position, half4 color) {
  return half4(position.x/position.y, 0, position.y/position.x, color.a);
}

[[ stitchable ]] half4 rainbow(float2 position, half4 color, float time) {
  float angle = atan(position.y/position.x) + time;
  return half4(sin(angle), sin(angle + 2), sin(angle + 4), color.a);
}

