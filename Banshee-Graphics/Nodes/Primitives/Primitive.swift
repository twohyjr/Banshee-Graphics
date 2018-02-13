import MetalKit

class Primitive : Node{
    
    var vertices: [Vertex]!
    var vertexBuffer: MTLBuffer!
    
    override init(){
        super.init()
        buildVertices()
        buildBuffers()
    }
    
    public func buildVertices(){ }
    
    private func buildBuffers(){
        vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: Vertex.size(vertices.count), options: [])
    }
}

extension Primitive: Renderable{
    var renderPipelineState: MTLRenderPipelineState! {
        return RenderPipelineStateLibrary.pipelineState(.BASIC)
    }

    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }
}
