import MetalKit

enum RenderPipelineStateType{
    case BASIC
    case TEXTURED
    case INSTANCED_TEXTURED
    case INSTANCED_BASIC
}

class RenderPipelineStateLibrary{
    
    private static var renderPipelineStates: [RenderPipelineStateType: RenderPipelineState] = [:]
    
    public static func initialize(){
        setupAllRenderPipelineStates()
    }
    
    private static func setupAllRenderPipelineStates(){
        renderPipelineStates.updateValue(Basic_RenderPipelineState(), forKey: .BASIC)
        renderPipelineStates.updateValue(Textured_RenderPipelineState(), forKey: .TEXTURED)
        renderPipelineStates.updateValue(InstancedBasic_RenderPipelineState(), forKey: .INSTANCED_BASIC)
        renderPipelineStates.updateValue(InstancedTextured_RenderPipelineState(), forKey: .INSTANCED_TEXTURED)
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
        renderPipelineDescriptor.sampleCount = Engine.mtkView.sampleCount
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preferences.MainDepthStencilFormat
        renderPipelineDescriptor.vertexFunction = ShaderFunctionLibrary.shaderFunction(.Basic_Vertex)
        renderPipelineDescriptor.fragmentFunction = ShaderFunctionLibrary.shaderFunction(.Basic_Fragment)
        renderPipelineDescriptor.vertexDescriptor = BaseVertexDescriptorLibrary.vertexDescriptor(.BASIC)
        return renderPipelineDescriptor
    }
    
    init() {
        renderPipelineState = buildRenderPipelineState(renderPipelineDescriptor)
    }
}

class Textured_RenderPipelineState: RenderPipelineState{
    var name: String = "Textured Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor{
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preferences.MainDepthStencilFormat
        renderPipelineDescriptor.vertexFunction = ShaderFunctionLibrary.shaderFunction(.Textured_Vertex)
        renderPipelineDescriptor.fragmentFunction = ShaderFunctionLibrary.shaderFunction(.Textured_Fragment)
        renderPipelineDescriptor.vertexDescriptor = BaseVertexDescriptorLibrary.vertexDescriptor(.BASIC)

        return renderPipelineDescriptor
    }
    
    init() {
        renderPipelineState = buildRenderPipelineState(renderPipelineDescriptor)
    }
}

class InstancedBasic_RenderPipelineState: RenderPipelineState{
    var name: String = "Instance Basic Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor{
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preferences.MainDepthStencilFormat
        renderPipelineDescriptor.vertexFunction = ShaderFunctionLibrary.shaderFunction(.Instanced_Vertex)
        renderPipelineDescriptor.fragmentFunction = ShaderFunctionLibrary.shaderFunction(.Basic_Fragment)
        renderPipelineDescriptor.vertexDescriptor = BaseVertexDescriptorLibrary.vertexDescriptor(.BASIC)
        
        return renderPipelineDescriptor
    }
    
    init() {
        renderPipelineState = buildRenderPipelineState(renderPipelineDescriptor)
    }
}

class InstancedTextured_RenderPipelineState: RenderPipelineState{
    var name: String = "Instance Textured Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor{
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preferences.MainDepthStencilFormat
        renderPipelineDescriptor.vertexFunction = ShaderFunctionLibrary.shaderFunction(.Instanced_Vertex)
        renderPipelineDescriptor.fragmentFunction = ShaderFunctionLibrary.shaderFunction(.Textured_Fragment)
        renderPipelineDescriptor.vertexDescriptor = BaseVertexDescriptorLibrary.vertexDescriptor(.BASIC)
        
        return renderPipelineDescriptor
    }
    
    init() {
        renderPipelineState = buildRenderPipelineState(renderPipelineDescriptor)
    }
}

