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
    
    private func updateModel(){
        scale = float3(0.5)
    }
    
    private func setModelConstants(_ renderCommandEncoder: MTLRenderCommandEncoder){
        modelConstants.model_matrix = modelMatrix
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride(1), index: 1)
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

        updateModel()
        
        setModelConstants(renderCommandEncoder)
        
        if(texture != nil){
            renderCommandEncoder.setFragmentSamplerState(SamplerStateLibrary.samplerState(.BASIC), index: 0)
            renderCommandEncoder.setFragmentTexture(texture, index: 0)
        }
        
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }
}

extension Primitive: Texturable{ }

