//import MetalKit
//
//class MeshLoader {
//
//    public static func LoadModelFromWavefront(modelName: String)->Mesh{
//        var meshes: [AnyObject]?
//        let assetURL = Bundle.main.url(forResource: modelName, withExtension: "obj")
//        
//        let assetVertexDescriptor = MTKModelIOVertexDescriptorFromMetal(VertexDescriptorLibrary.vertexDescriptor(.BASE))
//        
//        let position = assetVertexDescriptor.attributes[0] as! MDLVertexAttribute
//        position.name = MDLVertexAttributePosition
//        assetVertexDescriptor.attributes[0] = position
//        
//        let color = assetVertexDescriptor.attributes[1] as! MDLVertexAttribute
//        color.name = MDLVertexAttributeColor
//        assetVertexDescriptor.attributes[1] = color
//        
//        let normals = assetVertexDescriptor.attributes[2] as! MDLVertexAttribute
//        normals.name = MDLVertexAttributeNormal
//        assetVertexDescriptor.attributes[2] = normals
//        
//        let textureCoordiantes = assetVertexDescriptor.attributes[3] as! MDLVertexAttribute
//        textureCoordiantes.name = MDLVertexAttributeTextureCoordinate
//        assetVertexDescriptor.attributes[3] = textureCoordiantes
//        
//        let bufferAllocator = MTKMeshBufferAllocator(device: Engine.device)
//        var modelData = Mesh()
//        let asset = MDLAsset(url: assetURL!, vertexDescriptor: assetVertexDescriptor, bufferAllocator: bufferAllocator)
//        do{
//            meshes = try MTKMesh.newMeshes(asset: asset, device: Engine.device).metalKitMeshes
//        }catch let error as NSError{
//            print(error)
//        }
////        modelData.asset = asset
////        modelData.meshes = meshes! as! [MTKMesh]
//        return modelData!
//    }
//    
//    public static func LoadModelFromCustomObject(object: BaseModelData)->Mesh{
//        
//
//        return Mesh()!
//    }
//    
//}

