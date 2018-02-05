import MetalKit


class BGRenderPipelineStateLibrary{
    
    public static var renderPipelineStates: [String: BGRenderPipelineState] = [:]
    
    public static func initialize(){
        
    }
    
}

protocol BGRenderPipelineState{
    var name: String { get }
    var renderPipelineState: MTLRenderPipelineState! { get }
}

extension BGRenderPipelineState{
    func buildRenderPipelineState(_ renderPipelineDescriptor: MTLRenderPipelineDescriptor)->MTLRenderPipelineState{
        var renderPipelineState: MTLRenderPipelineState!
        do{
            renderPipelineState = try Engine.device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        }catch let error as NSError{
            print("RENDER_PIPELINE_STATE::BUILD::\(name)::\(error)")
        }
        return renderPipelineState
    }
}

class Basic_RenderPipelineState: BGRenderPipelineState{
    var name: String = "Basic Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    var vertexDescriptor: MTLVertexDescriptor{
        let vertexDescriptor = MTLVertexDescriptor()
        
        return vertexDescriptor
    }
    
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor{
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = BGPreferences.MainPixelFormat
        
        return renderPipelineDescriptor
    }
    
    init() {
        renderPipelineState = buildRenderPipelineState(renderPipelineDescriptor)
    }
}
