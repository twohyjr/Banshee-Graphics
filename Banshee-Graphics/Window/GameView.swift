import MetalKit

class GameView: MTKView {

    required init(coder: NSCoder) {
        super.init(coder: coder)

        self.device = MTLCreateSystemDefaultDevice()
        
        self.clearColor = Preferences.ClearColor
        
        Engine.startup(device: device!, mtkView: self)
        
        self.colorPixelFormat = Preferences.MainPixelFormat
        
        self.depthStencilPixelFormat = Preferences.MainDepthStencilFormat
        
        self.delegate = Engine.renderer
        
    }
    
}
