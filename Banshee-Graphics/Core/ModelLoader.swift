import MetalKit

class ModelLoader {

    public static func LoadModelFromWavefront(filename: String)->ModelData{
        let myStrings = FileHandler.LoadFileString(fileName: filename)
        var model = ModelData()
        for var line in myStrings{
            //remove all unwanted whitespaces and comments
            line = line.trim()
            if(line == String.Empty){
                continue
            }
            
            let splits = line.split(separator: " ")
            //Vertices
            if(splits[0] == "v"){
                model.addPosition(float3(Float(splits[1])!, Float(splits[2])!, Float(splits[3])!))
            }
            
            //Texture Coords
            if(splits[0] == "vt"){
                model.addTextureCoord(float2(Float(splits[1])!, Float(splits[2])!))
            }
            
            //Normals
            if(splits[0] == "vn"){
                model.addNormal(float3(Float(splits[1])!, Float(splits[2])!, Float(splits[3])!))
            }
            
            //Combine all things
            if(splits[0] == "f"){
                let vertexData1 = splits[1].replacingOccurrences(of: "//", with: "/0/").split(separator: "/")
                let vertexData2 = splits[2].replacingOccurrences(of: "//", with: "/0/").split(separator: "/")
                let vertexData3 = splits[3].replacingOccurrences(of: "//", with: "/0/").split(separator: "/")
                
                model.updateVertex(int3(Int32(vertexData1[0])!, Int32(vertexData1[1])!, Int32(vertexData1[2])!))
                model.updateVertex(int3(Int32(vertexData2[0])!, Int32(vertexData2[1])!, Int32(vertexData2[2])!))
                model.updateVertex(int3(Int32(vertexData3[0])!, Int32(vertexData3[1])!, Int32(vertexData3[2])!))
            }
        }
        return model
    }
    
}
