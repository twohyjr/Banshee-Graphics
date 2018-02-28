import MetalKit

enum BaseVertexDescriptorType{
    case BASIC
}

class BaseVertexDescriptorLibrary{
    
    private static var vertexDescriptors: [BaseVertexDescriptorType: BaseVertexDescriptor] = [:]
    
    public static func initialize(){
        setupAllVertexDescriptors()
    }
    
    private static func setupAllVertexDescriptors(){
        vertexDescriptors.updateValue(Basic_BaseVertexDescriptor(), forKey: .BASIC)
    }
    
    public static func vertexDescriptor(_ vertexDescriptorType: BaseVertexDescriptorType)->MTLVertexDescriptor{
        return (vertexDescriptors[vertexDescriptorType]?.vertexDescriptor)!
    }
}

protocol BaseVertexDescriptor{
    var name: String { get }
    var vertexDescriptor: MTLVertexDescriptor { get }
}

class Basic_BaseVertexDescriptor: BaseVertexDescriptor{
    var name: String = "Basic Vertex Descriptor"
    var vertexDescriptor: MTLVertexDescriptor{
        let vertexDescriptor = MTLVertexDescriptor()
        
        //Position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        
        //Color
        vertexDescriptor.attributes[1].format = .float3
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = MemoryLayout<float3>.stride
        
        //Normal
        vertexDescriptor.attributes[2].format = .float3
        vertexDescriptor.attributes[2].bufferIndex = 0
        vertexDescriptor.attributes[2].offset =  MemoryLayout<float3>.stride + MemoryLayout<float3>.stride
        
        //Texture Coordinate
        vertexDescriptor.attributes[3].format = .float2
        vertexDescriptor.attributes[3].bufferIndex = 0
        vertexDescriptor.attributes[3].offset = MemoryLayout<float3>.stride + MemoryLayout<float3>.stride +  MemoryLayout<float3>.stride
        
        vertexDescriptor.layouts[0].stride = Vertex.stride(1)
        
        return vertexDescriptor
    }
}


