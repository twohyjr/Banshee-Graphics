import MetalKit

class Scene {
    
    var vertices: [Vertex]!
    var vertexBuffer: MTLBuffer!
    
    init(){
        buildVertices()
        buildBuffers()
    }
    
    private func buildVertices(){
        vertices = [
            Vertex(position: float3(0,1,0), color: float4(1,0,0,1)),
            Vertex(position: float3(-1,-1,0), color: float4(0,1,0,1)),
            Vertex(position: float3(1,-1,0), color: float4(0,0,1,1))
        ]
    }
    
    private func buildBuffers(){
        vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: Vertex.size(vertices.count), options: [])
    }

    public func render(_ renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.pipelineState(.BASIC))
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }
    
}
