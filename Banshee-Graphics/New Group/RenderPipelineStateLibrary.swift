import MetalKit

enum RenderPipelineStateType{
    case BASIC
}

class RenderPipelineStateLibrary{
    
    private static var renderPipelineStates: [RenderPipelineStateType: RenderPipelineState] = [:]
    
    public static func initialize(){
        setupAllRenderPipelineStates()
    }
    
    private static func setupAllRenderPipelineStates(){

        renderPipelineStates.updateValue(Basic_RenderPipelineState(), forKey: .BASIC)
        
    }
    
    public static func pipelineState(_ renderPipelineStateType: RenderPipelineStateType)->MTLRenderPipelineState{
        return (renderPipelineStates[renderPipelineStateType]?.renderPipelineState)!
    }
}

protocol RenderPipelineState{
    var name: String { get }
    var renderPipelineState: MTLRenderPipelineState! { get }
}

extension RenderPipelineState{
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

class Basic_RenderPipelineState: RenderPipelineState{
    var name: String = "Basic Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    var vertexDescriptor: MTLVertexDescriptor{
        let vertexDescriptor = MTLVertexDescriptor()
        
        //Position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        
        //Color
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = MemoryLayout<float3>.size
        
        vertexDescriptor.layouts[0].stride = Vertex.stride(1)
        
        return vertexDescriptor
    }
    
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor{
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.vertexFunction = Engine.library.makeFunction(name: "basic_vertex_shader")
        renderPipelineDescriptor.fragmentFunction = Engine.library.makeFunction(name: "basic_fragment_shader")
        renderPipelineDescriptor.vertexDescriptor = vertexDescriptor
        return renderPipelineDescriptor
    }
    
    init() {
        renderPipelineState = buildRenderPipelineState(renderPipelineDescriptor)
    }
}

