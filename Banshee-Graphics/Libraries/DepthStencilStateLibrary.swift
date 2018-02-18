import MetalKit

enum DepthStencilStateType{
    case BASIC
}

class DepthStencilStateLibrary{
    
    private static var depthStencilStates: [DepthStencilStateType: DepthStencilState] = [:]
    
    public static func initialize(){
        setupAllDepthStencilStates()
    }
    
    private static func setupAllDepthStencilStates(){
        depthStencilStates.updateValue(Basic_DepthStencilState(), forKey: .BASIC)
    }
    
    public static func depthStencilState(_ depthStencilStateType: DepthStencilStateType)->MTLDepthStencilState{
        return (depthStencilStates[depthStencilStateType]?.depthStencilState)!
    }
}

protocol DepthStencilState{
    var name: String { get }
    var depthStencilState: MTLDepthStencilState! { get set }
}

class Basic_DepthStencilState: DepthStencilState{
    var name: String = "Basic DepthStencil State"
    
    var depthStencilState: MTLDepthStencilState!
    
    init(){
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.isDepthWriteEnabled = true
        depthStencilDescriptor.depthCompareFunction = .less
        depthStencilDescriptor.label = "Twohy's Depth Stencil Descriptor"
        depthStencilState = Engine.device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
}




