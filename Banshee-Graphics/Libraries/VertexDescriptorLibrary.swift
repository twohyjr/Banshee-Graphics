import MetalKit

enum VertexDescriptorType{
    case BASE
}

class VertexDescriptorLibrary{
    
    private static var vertexDescriptors: [VertexDescriptorType: VertexDescriptor] = [:]
    
    public static func initialize(){
        setupAllVertexDescriptors()
    }
    
    private static func setupAllVertexDescriptors(){
        
        vertexDescriptors.updateValue(Base_VertexDescriptor(), forKey: .BASE)
        
    }
    
    public static func vertexDescriptor(_ vertexDescriptorType: VertexDescriptorType)->MTLVertexDescriptor{
        return (vertexDescriptors[vertexDescriptorType]?.vertexDescriptor)!
    }
}

protocol VertexDescriptor{
    var name: String { get }
    var vertexDescriptor: MTLVertexDescriptor { get }
}

class Base_VertexDescriptor: VertexDescriptor{
    var name: String = "Base Vertex Descriptor"
    var vertexDescriptor: MTLVertexDescriptor{
        let vertexDescriptor = MTLVertexDescriptor()
        
        //Position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        
        //Color
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = MemoryLayout<float3>.size
        
        //Normal
        vertexDescriptor.attributes[2].format = .float3
        vertexDescriptor.attributes[2].bufferIndex = 0
        vertexDescriptor.attributes[2].offset =  MemoryLayout<float3>.size + MemoryLayout<float4>.size
        
        //Texture Coordinate
        vertexDescriptor.attributes[3].format = .float2
        vertexDescriptor.attributes[3].bufferIndex = 0
        vertexDescriptor.attributes[3].offset = MemoryLayout<float3>.size + MemoryLayout<float4>.size +  MemoryLayout<float3>.size
        
        vertexDescriptor.layouts[0].stride = Vertex.stride(1)
        
        return vertexDescriptor
    }
}


