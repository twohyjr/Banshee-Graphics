import MetalKit

class Primitive : Node{
    
    var id: UInt32 = 0
    var meshData: MeshData!
    var texture: MTLTexture!
    var modelConstants = ModelConstants()
    var _boundingSphere: BoundingSphere!
    var boundingSphere: BoundingSphere?{
        if(_boundingSphere == nil){
            _boundingSphere = BoundingSphere(mins: meshData.boundingBox.minBounds, maxs: meshData.boundingBox.maxBounds)
        }
        return  _boundingSphere
    }
    
    var _boundingBox: BoundingBox!
    var boundingBox: BoundingBox?{
        if(_boundingBox == nil){
            _boundingBox = BoundingBox(mins: meshData.boundingBox.minBounds, maxs: meshData.boundingBox.maxBounds)
        }
        return _boundingBox
    }
    
    init(baseMeshType: MeshDataTypes, position: float3 = float3(0), textureName: String = String.Empty){
        super.init()
        self.position = position
        id = arc4random_uniform(1000000000)
        setTexture(textureName)
        meshData = MeshLibrary.mesh(baseMeshType)
    }
    
    private func setTexture(_ textureName: String){
        if(textureName != String.Empty){
            texture = generateTexture(textureName: textureName)
        }
    }

    private func setModelConstants(_ renderCommandEncoder: MTLRenderCommandEncoder){
        modelConstants.model_matrix = modelMatrix
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride(1), index: 2)
    }
    
    override func tick() {
        if(Preferences.drawBoundingBox){
            boundingBox?.recalculateBoundingBox(modelConstants.model_matrix)
        }
        
        super.tick()
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
        renderCommandEncoder.setVertexBuffer(meshData.vertexBuffer, offset:0, index:0)
        
        if(Preferences.drawObjects){
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

        if(Preferences.drawBoundingBox){
            boundingBox?.draw(renderCommandEncoder)
        }
        if(Preferences.drawBoundingSphere){
            boundingSphere?.draw(renderCommandEncoder, modelConstants: modelConstants)
        }
    }
}

extension Primitive: Texturable{ }

