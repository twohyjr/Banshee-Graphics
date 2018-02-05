import MetalKit

class GameView: MTKView {

    required init(coder: NSCoder) {
        super.init(coder: coder)

        self.device = MTLCreateSystemDefaultDevice()
        
        Engine.startup(device: device!, mtkView: self)
        
        self.colorPixelFormat = Preferences.MainPixelFormat
        
        self.delegate = Engine.renderer
        
    }
    
}
