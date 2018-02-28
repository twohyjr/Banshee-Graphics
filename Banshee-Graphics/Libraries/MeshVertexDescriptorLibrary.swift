import MetalKit

enum MeshVertexDescriptorType{
    case BASIC
}

class MeshVertexDescriptorLibrary{
    
    private static var vertexDescriptors: [MeshVertexDescriptorType: MeshVertexDescriptor] = [:]
    
    public static func initialize(){
        setupAllVertexDescriptors()
    }
    
    private static func setupAllVertexDescriptors(){
        vertexDescriptors.updateValue(Basic_MeshVertexDescriptor(), forKey: .BASIC)
    }
    
    public static func vertexDescriptor(_ meshVertexDescriptorType: MeshVertexDescriptorType)->MDLVertexDescriptor{
        return (vertexDescriptors[meshVertexDescriptorType]?.vertexDescriptor)!
    }
}

protocol MeshVertexDescriptor{
    var name: String { get }
    var vertexDescriptor: MDLVertexDescriptor { get }
}

class Basic_MeshVertexDescriptor: MeshVertexDescriptor{
    var name: String = "Basic Vertex Descriptor"
    
    var vertexDescriptor: MDLVertexDescriptor{
        let descriptor = MTKModelIOVertexDescriptorFromMetal(BaseVertexDescriptorLibrary.vertexDescriptor(.BASIC))
        
        let attributePosition = descriptor.attributes[0] as! MDLVertexAttribute
        attributePosition.name = MDLVertexAttributePosition
        descriptor.attributes[0] = attributePosition
        
        let attributeColor = descriptor.attributes[1] as! MDLVertexAttribute
        attributeColor.name = MDLVertexAttributeColor
        descriptor.attributes[1] = attributeColor
        
        let attributeNormal = descriptor.attributes[2] as! MDLVertexAttribute
        attributeNormal.name = MDLVertexAttributeNormal
        descriptor.attributes[2] = attributeNormal
        
        let attributeTexture = descriptor.attributes[3] as! MDLVertexAttribute
        attributeTexture.name = MDLVertexAttributeTextureCoordinate
        descriptor.attributes[3] = attributeTexture
        return descriptor
    }
    
}



