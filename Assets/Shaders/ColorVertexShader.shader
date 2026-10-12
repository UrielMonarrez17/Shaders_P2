Shader "ACG/ColorVertexShader"
{
    SubShader
    {
       Pass{
        CGPROGRAM
        
        #pragma vertex vert
        #pragma fragment frag
        #include "UnityCG.cginc"

        struct appdata
        {
            float4 vertex : POSITION;
        };

        struct v2f{
            float4 pos : SV_POSITION;
            float4 color : COLOR;
        }; 
        v2f vert(appdata v){
            v2f o;
            o.pos = UnityObjectToClipPos(v.vertex);
            
    
            //o.color = float4(v.vertex.x, 0.0, 0.0, 1.0); 
            //o.color = float4(v.vertex.x+3, 0.0, 0.0, 1.0);
            //o.color = float4(v.vertex.x, v.vertex.z, 0.0, 1.0);
            //o.color = float4(0, 0.0, 0.0, 1.0);
            //o.color.r = (v.vertex.x+5)/10;
            //o.color.z = (v.vertex.g+5)/10;
            
            return o;
        }

        float4 frag(v2f i) : SV_Target{
            i.color = float4(0,0,0,1);
            float4 col = i.color;
            col.r = i.pos.x /2000;
            col.g = i.pos.y /2000;
            return col;
        }
        ENDCG
       }
    }
}