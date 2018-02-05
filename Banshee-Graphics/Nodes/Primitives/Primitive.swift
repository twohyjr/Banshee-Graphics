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

extension Primitive{
    func doRender(renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.pipelineState(.BASIC))
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }
}
