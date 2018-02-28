import MetalKit

enum MeshTypes{
    case TRIANGLE
    case STALL
    case QUAD
}

enum CustomMeshTypes{
    case TRIANGLE
    case QUAD
}

enum FileMeshTypes{
    case STALL
}

class MeshLibrary {

    private static var meshes: [MeshTypes: MeshData] = [:]
    
    public static func initialize(){
        setupAllMeshData()
    }
    
    private static func setupAllMeshData(){
        
    }
}

