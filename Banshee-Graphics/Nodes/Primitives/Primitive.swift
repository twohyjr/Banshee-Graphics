import MetalKit

class Primitive : Node{
    
    var vertices: [Vertex]!
    var indices: [UInt32] = []
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
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

    public func buildVertices(){
        let modelData = ModelDataLibrary.modelData(.TRIANGLE)
        vertices = modelData.vertices
        indices = modelData.indices
    }
    
    public func buildIndices(){ }

    private func updateModel(){
        if(Keyboard.isKeyPressed(key: KEY_CODES.Key_Arrow_Left)){
            rotation.y += 0.05
        }
        
        if(Keyboard.isKeyPressed(key: KEY_CODES.Key_Arrow_Right)){
            rotation.y -= 0.05
        }
        
        if(Keyboard.isKeyPressed(key: KEY_CODES.Key_Arrow_Up)){
            rotation.x += 0.05
        }
        
        if(Keyboard.isKeyPressed(key: KEY_CODES.Key_Arrow_Down)){
            rotation.x -= 0.05
        }
    }
    
    private func buildBuffers(){
        vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
        if(indices.count > 0){
            indexBuffer = Engine.device.makeBuffer(bytes: indices, length: MemoryLayout<UInt32>.stride * indices.count, options: [])
        }
    }
    
    private func setModelConstants(_ renderCommandEncoder: MTLRenderCommandEncoder){
        modelConstants.model_matrix = modelMatrix
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride(1), index: 2)
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

    func draw(_ renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)

        updateModel()
        
        setModelConstants(renderCommandEncoder)
            
        if(texture != nil){
            renderCommandEncoder.setFragmentSamplerState(SamplerStateLibrary.samplerState(.BASIC), index: 0)
            renderCommandEncoder.setFragmentTexture(texture, index: 0)
        }
        
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        if(indices.count > 0){
            renderCommandEncoder.drawIndexedPrimitives(type: .triangle,
                                                       indexCount: indices.count,
                                                       indexType: .uint32,
                                                       indexBuffer: indexBuffer,
                                                       indexBufferOffset: 0)
        }else{
            renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
        }
    }
}

extension Primitive: Texturable{ }

