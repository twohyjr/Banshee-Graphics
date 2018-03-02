import MetalKit

class Instance: Node {
    
    var meshData: MeshData!
    var nodes: [Node] = []
    var instanceConstants: [ModelConstants] = []
    var instanceBuffer: MTLBuffer!
    var texture: MTLTexture!
    var _boundingBox: BoundingBox!
    var boundingBox: BoundingBox?{
        if(_boundingBox == nil){
            _boundingBox = BoundingBox(mins: meshData.boundingBox.minBounds, maxs: meshData.boundingBox.maxBounds)
        }
        return _boundingBox
    }
    
    init(meshData: MeshData, instanceCount: Int, textureName: String = String.Empty) {
        super.init()
        self.meshData = meshData
        self.setTexture(textureName)
        createInstances(instanceCount)
        makeBuffer()
    }
    
    private func setTexture(_ textureName: String){
        if(textureName != String.Empty){
            texture = generateTexture(textureName: textureName)
        }
    }
    
    private func createInstances(_ instanceCount: Int){
        for _ in 0..<instanceCount{
            let node = Node()
            nodes.append(node)
            instanceConstants.append(ModelConstants())
        }
    }
    
    private func makeBuffer(){
        instanceBuffer = Engine.device.makeBuffer(length: ModelConstants.stride(instanceConstants.count), options: [])
    }
}

extension Instance: Renderable{
    var renderPipelineState: MTLRenderPipelineState! {
        if(texture != nil){
            return RenderPipelineStateLibrary.pipelineState(.INSTANCED_TEXTURED)
        }else{
            return RenderPipelineStateLibrary.pipelineState(.INSTANCED_BASIC)
        }
    }
    
    func draw(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        
        
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
        var pointer = instanceBuffer.contents().bindMemory(to: ModelConstants.self, capacity: nodes.count)
        for node in nodes{
            node.rotation.y += 0.003
            pointer.pointee.model_matrix = node.modelMatrix
            pointer = pointer.advanced(by: 1)
        }
        renderCommandEncoder.setVertexBuffer(instanceBuffer, offset: 0, index: 2)
        if(texture != nil){
            renderCommandEncoder.setFragmentSamplerState(SamplerStateLibrary.samplerState(.BASIC), index: 0)
            renderCommandEncoder.setFragmentTexture(texture, index: 0)
        }
        renderCommandEncoder.setVertexBuffer(meshData.vertexBuffer, offset:0, index:0)
        renderCommandEncoder.drawIndexedPrimitives(type: meshData.primitiveType,
                                                   indexCount: meshData.indexCount,
                                                   indexType: meshData.indexType,
                                                   indexBuffer: meshData.indexBuffer,
                                                   indexBufferOffset: 0,
                                                   instanceCount: nodes.count)
    }
    
    
}

extension Instance: Texturable{ }
