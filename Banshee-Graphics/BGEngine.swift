import MetalKit

class BGEngine {
    
    public static var device: MTLDevice!
    public static var mtkView: MTKView!
    public static var commandQueue: MTLCommandQueue!
    
    public static var renderer: BGRenderer! = nil

    public static func startup(device: MTLDevice, mtkView: MTKView){
        self.device = device
        self.mtkView = mtkView
        self.commandQueue = device.makeCommandQueue()
        self.renderer = BGRenderer()
    }
    
}
