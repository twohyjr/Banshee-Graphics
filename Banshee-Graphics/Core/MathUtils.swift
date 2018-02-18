import MetalKit

func radians(fromDegrees degrees: Float) -> Float{
    return (degrees / 180) * Float.pi
}


class Maths{
    public static func barryCentric(_ p1: float3,_ p2: float3,_ p3: float3,_ pos: float2)->Float{
        let det = (p2.z - p3.z) * (p1.x - p3.x) + (p3.x - p2.x) * (p1.z - p3.z);
        let l1 = ((p2.z - p3.z) * (pos.x - p3.x) + (p3.x - p2.x) * (pos.y - p3.z)) / det;
        let l2 = ((p3.z - p1.z) * (pos.x - p3.x) + (p1.x - p3.x) * (pos.y - p3.z)) / det;
        let l3 = 1.0 - l1 - l2;
        return l1 * p1.y + l2 * p2.y + l3 * p3.y;
    }
}

var X_AXIS: float3{
    return float3(1,0,0)
}

var Y_AXIS: float3{
    return float3(0,1,0)
}

var Z_AXIS: float3{
    return float3(0,0,1)
}


