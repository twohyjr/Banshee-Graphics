import MetalKit

class Primitive : Node{
    
    var vertices: [Vertex]!
    var vertexBuffer: MTLBuffer!
    var texture: MTLTexture!
    
    var modelConstants = ModelConstants()
    
    convenience init(textureName: String){
        self.init()
        texture = generateTexture(textureName: textureName)
    }
    
    override init(){
        super.init()
        buildVertices()
        buildBuffers()
    }
    
    public func buildVertices(){ }
    
    private func buildBuffers(){
        vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
    }
}

extension Primitive: Renderable{
    var renderPipelineState: MTLRenderPipelineState! {
        if(texture != nil){
            return RenderPipelineStateLibrary.pipelineState(.TEXTURED)
        }else{
            return RenderPipelineStateLibrary.pipelineState(.BASIC)
        }
    }

    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }
}

extension Primitive: Texturable{ }

