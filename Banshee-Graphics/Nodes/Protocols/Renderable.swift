import MetalKit

protocol Renderable{
    var renderPipelineState: MTLRenderPipelineState! { get }
    
    func draw(_ renderCommandEncoder: MTLRenderCommandEncoder)
}
