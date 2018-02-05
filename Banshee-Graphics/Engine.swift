import MetalKit

class Engine {
    
    public static var device: MTLDevice!
    public static var mtkView: MTKView!
    public static var commandQueue: MTLCommandQueue!
    
    public static var renderer: Renderer! = nil
    public static var library: MTLLibrary!

    public static func startup(device: MTLDevice, mtkView: MTKView){
        self.device = device
        self.mtkView = mtkView
        self.commandQueue = device.makeCommandQueue()
        self.library = device.makeDefaultLibrary()
        self.renderer = Renderer()
        
        RenderPipelineStateLibrary.initialize()
    }
    
}
