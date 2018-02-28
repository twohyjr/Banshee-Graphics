import MetalKit

enum MeshDataTypes{
    
    //Custom Types
    case TRIANGLE
    case QUAD
    
    //Wavefront file types
    case FRUIT_STAND
    
    //Apple Desinged Types
    case PLANE_APPLE
}

enum AppleDesignedMeshTypes{
    case PLANE
}

class MeshLibrary {

    private static var meshes: [MeshDataTypes: MeshData] = [:]
    
    public static func initialize(){
        setupAllMeshData()
    }
    
    private static func setupAllMeshData(){
        //Custom Meshes
        addCustomMesh(baseMeshData: Triangle())
        addCustomMesh(baseMeshData: Quad())
        
        //Wavefront OBJ Meshes
        addWavefrontMesh(modelName: "stall", meshDataType: .FRUIT_STAND)
        
        //Apple Meshes
        addAppleDesignedMesh(appleDesignedMeshType: .PLANE, meshDataType: .PLANE_APPLE)
    }
    
    public static func mesh(_ meshDataType: MeshDataTypes)->MeshData{
        return (meshes[meshDataType])!
    }
    
    private static func addCustomMesh(baseMeshData: BaseMeshData){
        meshes.updateValue(MeshLoader.LoadCustomMeshData(baseMeshData: baseMeshData), forKey: baseMeshData.meshDataType)
    }
    
    private static func addWavefrontMesh(modelName: String, meshDataType: MeshDataTypes){
        meshes.updateValue(MeshLoader.LoadMeshDataFromWavefront(modelName: modelName), forKey: meshDataType)
    }
    
    private static func addAppleDesignedMesh(appleDesignedMeshType: AppleDesignedMeshTypes, meshDataType: MeshDataTypes){
        meshes.updateValue(MeshLoader.LoadAppleDesignedMeshData(appleDesignedMeshType: appleDesignedMeshType), forKey: meshDataType)
    }
}

