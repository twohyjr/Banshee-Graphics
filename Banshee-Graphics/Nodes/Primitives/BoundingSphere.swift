import MetalKit

class BoundingSphere: Node {
    
    //distance = sqrt(((p1x – p2x) * (p1x – p2x)) + ((p1y – p2y) * (p1y – p2y)) + ((p1z – p2z) * (p1z – p2z)));
    var modelConstants = ModelConstants()
    var vertices: [Vertex] = []
    var vertexBuffer: MTLBuffer!

    var radius: Float = 0
    var centerPoint = float3(0)
    
    
    init(mins: vector_float3, maxs: vector_float3) {
        super.init()
        radius = getRadius(mins: mins, maxs: maxs)
        centerPoint = getCenterPoint(mins: mins, maxs: maxs)
    }
    
    func buildVisual(){
        let trianglesPerSection: Int = 100
        var lastPos: float2 = float2(0)
        
        for i in (0 ... trianglesPerSection).reversed() {
            let red = Float(CGFloat(Float(arc4random()) / Float(UINT32_MAX)))
            let green = Float(CGFloat(Float(arc4random()) / Float(UINT32_MAX)))
            let blue = Float(CGFloat(Float(arc4random()) / Float(UINT32_MAX)))
            
            let val: Float = i == 0 ? 0 :  Float((360.0 / Double(trianglesPerSection)) * Double(i))
            var pos = float2(cos(Math.toRadians(val)), sin(Math.toRadians(val))) * radius
            
            vertices.append(Vertex(position: float3(0, 0, 0), color: float3(red, green, blue), normal: float3(0,0,1), textureCoordinate: float2(0,1)))
            vertices.append(Vertex(position: float3(pos.x, pos.y, 0), color: float3(red, green, blue), normal: float3(0,0,1), textureCoordinate: float2(0,1)))
            vertices.append(Vertex(position: float3(lastPos.x, lastPos.y, 0), color: float3(red, green, blue), normal: float3(0,0,1), textureCoordinate: float2(0,1)))
            lastPos = pos
        }
        vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
        
    }
    
    func getCenterPoint(mins: vector_float3, maxs: vector_float3)->float3{
        let sum = mins + maxs
        return sum / 2
    }
    
    func getRadius(mins: vector_float3, maxs: vector_float3)->Float{
        var result:Float = simd_max(mins.x, maxs.x)
        result = simd_max(result, mins.y)
        result = simd_max(result, mins.z)
        result = simd_max(result, maxs.y)
        result = simd_max(result, maxs.z)
        return result
    }

}

extension BoundingSphere: Renderable{
    func draw(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride(1), index: 2)
        renderCommandEncoder.setFrontFacing(.counterClockwise)
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset:0, index:0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }
    
    var renderPipelineState: MTLRenderPipelineState! {
        return RenderPipelineStateLibrary.pipelineState(.INSTANCED_BASIC)
    }
    
    func draw(_ renderCommandEncoder: MTLRenderCommandEncoder, modelConstants: ModelConstants) {
        self.modelConstants = modelConstants
        self.draw(renderCommandEncoder)
        
    }
}
