import MetalKit

class BoundingSphere: Node {
    var modelConstants = ModelConstants()
    var vertices: [Vertex] = []
    var indices: [UInt32] = []
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    var radius: Float = 0
    var mins: float3!
    var maxs: float3!
    var centerPoint: float3{
        var center = getCenterPoint(mins: mins, maxs: maxs)
        var center4 = matrix_multiply(Camera.viewMatrix, modelConstants.model_matrix) * float4(center.x, center.y, center.z, 1)
        return float3(center4.x, center4.y, center4.z)
    }
    //    var color:
    
    init(mins: vector_float3, maxs: vector_float3, color: float3 = float3(1, 0, 0)) {
        super.init()
        self.mins = mins
        self.maxs = maxs
        let trianglesPerSection: Int = 100
        radius = getRadius(mins: mins, maxs: maxs)
        for i in (0 ... trianglesPerSection) {
            let val: Float = i == 0 ? 0 :  Float((360.0 / Double(trianglesPerSection)) * Double(i))
            var pos = float2(cos(Math.toRadians(val)), sin(Math.toRadians(val))) * radius
            vertices.append(Vertex(position: float3(pos.x, pos.y, 0), color: color, normal: float3(0,0,1), textureCoordinate: float2(0,1)))
        }
        
        for i in (0 ... trianglesPerSection) {
            let val: Float = i == 0 ? 0 :  Float((360.0 / Double(trianglesPerSection)) * Double(i))
            var pos = float2(cos(Math.toRadians(val)), sin(Math.toRadians(val))) * radius
            vertices.append(Vertex(position: float3(pos.x, 0, pos.y), color: color, normal: float3(0,0,1), textureCoordinate: float2(0,1)))
        }
        
        vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
    }
    
    
    public func getCenterPoint(mins: vector_float3, maxs: vector_float3)->float3{
        let sum = mins + maxs
        return sum / 2
    }
    
    public func getRadius(mins: vector_float3, maxs: vector_float3)->Float{
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
        if(indices.count > 0){
            renderCommandEncoder.drawIndexedPrimitives(type: .lineStrip,
                                                       indexCount: indices.count,
                                                       indexType: .uint32,
                                                       indexBuffer: indexBuffer,
                                                       indexBufferOffset: 0)
        }else{
            renderCommandEncoder.drawPrimitives(type: .lineStrip, vertexStart: 0, vertexCount: vertices.count)
        }

    }
    
    var renderPipelineState: MTLRenderPipelineState! {
        return RenderPipelineStateLibrary.pipelineState(.BOUNDING)
    }
    
    func draw(_ renderCommandEncoder: MTLRenderCommandEncoder, modelConstants: ModelConstants) {
        self.modelConstants = modelConstants
        self.draw(renderCommandEncoder)
    }
}











