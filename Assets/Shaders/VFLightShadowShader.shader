// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ACG/VFLightShadowShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }

    SubShader
    {
        Pass{
            Tags{"LightMode" = "ForwardBase"}

             CGPROGRAM
           
        #pragma vertex vert
        #pragma fragment frag
    
        #include "UnityCG.cginc"
        #include "UnityLightingCommon.cginc"

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        struct appdata
        {
            float4 vertex : POSITION;
            float2 uv : TEXCOORD0;
            float3 normal : NORMAL;
        };

        struct v2f{
            float4 vertex : SV_POSITION;
            float2 uv : TEXCOORD0;
            float diff : COLOR0;
        };

        sampler2D _MainTex;


        v2f vert(appdata v)
        {
            v2f o;
            o.vertex = UnityObjectToClipPos(v.vertex);
            o.uv =v.uv;
            half3 worldNormal = UnityObjectToWorldNormal(v.normal);
            half dotP = dot(worldNormal, _WorldSpaceLightPos0.xyz);
            o.diff = dotP * _LightColor0;
            return o;
        }


        fixed4 frag(v2f i):SV_Target{
            fixed4 color = tex2D(_MainTex, i.uv);
            color *= i.diff;
            return color;
        }
        ENDCG
        }

       
        
    }
    FallBack "Diffuse"
}
