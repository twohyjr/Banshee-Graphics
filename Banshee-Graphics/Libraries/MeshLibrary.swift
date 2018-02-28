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

    private static var meshes: [MeshTypes: Mesh] = [:]
    
    public static func initialize(){
        setupAllMeshData()
    }
    
    private static func setupAllMeshData(){
        //Add the custom meshes here
        addCustomMesh(.TRIANGLE)
        addCustomMesh(.QUAD)
        
        //Add the file meshes here
        addFileMesh(.STALL)
    }
    
    public static func mesh(_ meshTypes: MeshTypes)->Mesh{
        return (meshes[meshTypes])!
    }
    
    private static func addCustomMesh(_ customMeshType: CustomMeshTypes){
        var baseData: BaseMeshData!
        switch customMeshType {
        case .TRIANGLE:
            baseData = Triangle()
        case .QUAD:
            baseData = Quad()
        }
        var mesh = Mesh()
        mesh.vertices = baseData.vertices
        mesh.indices = baseData.indices
        meshes.updateValue(mesh, forKey: baseData.meshType)
    }
    
    private static func addFileMesh(_ fileDataType: FileMeshTypes){
        var mesh = Mesh()
        var meshType: MeshTypes? = nil
        switch fileDataType {
        case .STALL:
            mesh = MeshLoader.LoadMeshFromWavefront(filename: "stall.obj")
            meshType = .STALL
        }
        meshes.updateValue(mesh, forKey: meshType!)
    }
}

