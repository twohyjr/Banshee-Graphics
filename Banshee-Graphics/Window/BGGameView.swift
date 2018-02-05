import MetalKit

class BGGameView: MTKView {

    required init(coder: NSCoder) {
        super.init(coder: coder)

        self.device = MTLCreateSystemDefaultDevice()
        
        BGEngine.startup(device: device!, mtkView: self)
        
        self.colorPixelFormat = BGPreferences.MainPixelFormat
        
        self.delegate = BGEngine.renderer
        
    }
    
}
