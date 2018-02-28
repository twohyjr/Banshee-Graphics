import MetalKit

class Primitive : Node{
    
    var meshData: MeshData!
    var texture: MTLTexture!
    var modelConstants = ModelConstants()
    
    init(textureName: String = String.Empty){
        super.init()
        setTexture(textureName)
        meshData = MeshLoader.LoadMeshDataFromWavefront(modelName: "stall")
    }
    
    private func setTexture(_ textureName: String){
        if(textureName != String.Empty){
            texture = generateTexture(textureName: textureName)
        }
    }

    public func buildVertices(){ }
    
    public func buildIndices(){ }

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
        setModelConstants(renderCommandEncoder)
        if(texture != nil){
            renderCommandEncoder.setFragmentSamplerState(SamplerStateLibrary.samplerState(.BASIC), index: 0)
            renderCommandEncoder.setFragmentTexture(texture, index: 0)
        }
        
        renderCommandEncoder.setFrontFacing(.counterClockwise)
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder.setVertexBuffer(meshData.vertexBuffer, offset:0, index:0)
        
        if(meshData.indexCount > 0){
            renderCommandEncoder.drawIndexedPrimitives(type: meshData.primitiveType,
                                                       indexCount: meshData.indexCount,
                                                       indexType: meshData.indexType,
                                                       indexBuffer: meshData.indexBuffer,
                                                       indexBufferOffset: 0)
        }else{
            renderCommandEncoder.drawPrimitives(type: meshData.primitiveType, vertexStart: 0, vertexCount: meshData.vertexCount)
        }

    }
}

extension Primitive: Texturable{ }

