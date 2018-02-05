import MetalKit

class BGRenderer: NSObject{
    
    override init() {
        super.init()
        
        
    }
    
}

extension BGRenderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
    
    func draw(in view: MTKView) {
        
    }
    
}
