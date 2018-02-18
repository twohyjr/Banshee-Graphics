import MetalKit

public enum ClearColors{
    static let Green: MTLClearColor = MTLClearColor(red: 0.22, green: 0.55, blue: 0.34, alpha: 1.0)
}

class Preferences{
    //Clear color property
    public static var ClearColor: MTLClearColor = ClearColors.Green
    
    //Pixel / Depth Formats
    public static var MainPixelFormat: MTLPixelFormat = MTLPixelFormat.bgra8Unorm
    public static var MainDepthStencilFormat: MTLPixelFormat = MTLPixelFormat.depth32Float
    
    //Camera Settings
    public static var camera_fov: Float = 45
    public static var camera_aspectRatio: Float = 1
    public static var camera_nearZ: Float = 0.1
    public static var camera_farZ: Float = 1000
}
