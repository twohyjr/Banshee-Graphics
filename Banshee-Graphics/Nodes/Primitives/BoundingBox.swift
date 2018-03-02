import MetalKit

class BoundingBox: Node {
    var modelConstants = ModelConstants()
    var vertices: [Vertex] = []
    var indices: [UInt32] = []
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
//    var color:
    
    init(mins: vector_float3, maxs: vector_float3, color: float3 = float3(1, 0, 0)) {
        let v1 = Vertex(position: float3(mins.x, maxs.y, mins.z), color: color, normal: float3(0), textureCoordinate: float2(0)) //Top Left Back
        let v2 = Vertex(position: float3(mins.x, maxs.y, maxs.z), color: color, normal: float3(0), textureCoordinate: float2(0)) //Top Left Front
        let v3 = Vertex(position: float3(maxs.x, maxs.y, mins.z), color: color, normal: float3(0), textureCoordinate: float2(0)) //Top Right Back
        let v4 = Vertex(position: float3(maxs.x, maxs.y, maxs.z), color: color, normal: float3(0), textureCoordinate: float2(0)) //Top Right Front
        
        let v5 = Vertex(position: float3(mins.x, mins.y, mins.z), color: color, normal: float3(0), textureCoordinate: float2(0)) //Bottom Left Back
        let v6 = Vertex(position: float3(mins.x, mins.y, maxs.z), color: color, normal: float3(0), textureCoordinate: float2(0)) //Bottom Left Front
        let v7 = Vertex(position: float3(maxs.x, mins.y, mins.z), color: color, normal: float3(0), textureCoordinate: float2(0)) //Bottom Right Back
        let v8 = Vertex(position: float3(maxs.x, mins.y, maxs.z), color: color, normal: float3(0), textureCoordinate: float2(0)) //Bottom Right Front
        
        vertices += [v1, v2, v3, v4, v5, v6, v7, v8]
        indices += [2,0,4,6,2,3,7,6,7,5,4,5,1,0,1,3]
        
        vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
        indexBuffer = Engine.device.makeBuffer(bytes: indices, length: MemoryLayout<UInt32>.stride * indices.count, options: [])
    }
}

extension BoundingBox: Renderable{
    func draw(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride(1), index: 2)
        renderCommandEncoder.setFrontFacing(.counterClockwise)
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset:0, index:0)
        renderCommandEncoder.drawIndexedPrimitives(type: .lineStrip,
                                                   indexCount: indices.count,
                                                   indexType: .uint32,
                                                   indexBuffer: indexBuffer,
                                                   indexBufferOffset: 0)
    }
    
    var renderPipelineState: MTLRenderPipelineState! {
        return RenderPipelineStateLibrary.pipelineState(.INSTANCED_BASIC)
    }
    
    func draw(_ renderCommandEncoder: MTLRenderCommandEncoder, modelConstants: ModelConstants) {
        self.modelConstants = modelConstants
        self.draw(renderCommandEncoder)
        
    }
}
