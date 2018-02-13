import MetalKit

protocol Renderable{
    var renderPipelineState: MTLRenderPipelineState! { get }
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder)
}
