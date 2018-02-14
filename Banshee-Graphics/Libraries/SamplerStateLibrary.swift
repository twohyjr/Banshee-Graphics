import MetalKit

enum SamplerStateType{
    case BASIC
}

class SamplerStateLibrary{
    
    private static var samplerStates: [SamplerStateType: SamplerState] = [:]
    
    public static func initialize(){
        setupAllSamplerStates()
    }
    
    private static func setupAllSamplerStates(){
        samplerStates.updateValue(Basic_SamplerState(), forKey: .BASIC)
    }
    
    public static func samplerState(_ samplerStateType: SamplerStateType)->MTLSamplerState{
        return (samplerStates[samplerStateType]?.samplerState)!
    }
}

protocol SamplerState{
    var name: String { get }
    var samplerState: MTLSamplerState! { get set }
}

class Basic_SamplerState: SamplerState{
    var name: String = "Basic Sampler State"
    
    var samplerState: MTLSamplerState!
    
    init(){
        let samplerDescriptor = MTLSamplerDescriptor()
        samplerDescriptor.compareFunction = .less
        samplerDescriptor.minFilter = .linear
        samplerDescriptor.magFilter = .linear
        samplerState = Engine.device.makeSamplerState(descriptor: samplerDescriptor)!
    }
}



