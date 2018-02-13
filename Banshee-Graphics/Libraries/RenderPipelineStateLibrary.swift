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

    var renderPipelineDescriptor: MTLRenderPipelineDescriptor{
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.vertexFunction = ShaderFunctionLibrary.shaderFunction(.Basic_Vertex)
        renderPipelineDescriptor.fragmentFunction = ShaderFunctionLibrary.shaderFunction(.Basic_Fragment)
        renderPipelineDescriptor.vertexDescriptor = VertexDescriptorLibrary.vertexDescriptor(.BASE)
        return renderPipelineDescriptor
    }
    
    init() {
        renderPipelineState = buildRenderPipelineState(renderPipelineDescriptor)
    }
}

