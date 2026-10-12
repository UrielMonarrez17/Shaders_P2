// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ACG/VFShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }

    SubShader
    {
        Pass{
             CGPROGRAM
             // Physically based Standard lighting model, and enable shadows on all light types
        #pragma vertex vert
        #pragma fragment frag
        #include "UnityCG.cginc"

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        struct appdata
        {
            float4 pos : POSITION;
            float2 uv : TEXCOORD0;
        };

        struct v2f{
            float4 p_pos : SV_POSITION;
            float2 uv : TEXCOORD0;
        };


        v2f vert(appdata v)
        {
            v2f o;
            o.pos = UnityObjectToClipPos(v.pos);
            o.uv = v.uv;
            return o;
        }

        sampler2D _MainTex;

        float4 frag(v2f i):SV_FRAGMENT{
            float4 color = tex2D(_MainTex, i.uv);
            return color;
        }
        ENDCG
        }

       
        
    }
    FallBack "Diffuse"
}
