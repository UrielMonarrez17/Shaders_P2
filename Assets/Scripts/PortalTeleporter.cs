using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Playables;

public class PortalTeleporter : MonoBehaviour
{
    [Header("Escena Destino")]
    [Tooltip("Nombre de la escena a cargar al atravesar el portal o finalizar la cinemática")]
    public string targetSceneName = "";

    [Header("Modo de Transición Automática por Tiempo")]
    [Tooltip("Si se asigna o se encuentra un PlayableDirector (Timeline), cambiará de escena al terminar")]
    public PlayableDirector director;
    [Tooltip("Tiempo en segundos para cambio automático si no se usa Timeline (0 desactiva este timer)")]
    public float autoSwitchTime = 0f;

    [Header("Modo Físico (Trigger)")]
    [Tooltip("Tag requerido para activar el portal por colisión (vacío acepta cualquier objeto)")]
    public string triggerTag = "";
    [Tooltip("Retardo tras la colisión antes de cambiar de escena")]
    public float delay = 0.5f;

    private bool isTransitioning = false;

    private void Awake()
    {
        if (director == null)
        {
            director = FindFirstObjectByType<PlayableDirector>();
        }
    }

    private void Start()
    {
        if (director != null)
        {
            director.stopped += OnDirectorStopped;
        }

        if (autoSwitchTime > 0)
        {
            StartCoroutine(AutoSwitchRoutine(autoSwitchTime));
        }
    }

    private void OnDestroy()
    {
        if (director != null)
        {
            director.stopped -= OnDirectorStopped;
        }
    }

    private void OnDirectorStopped(PlayableDirector pd)
    {
        if (isTransitioning) return;
        ExecuteTransition();
    }

    private IEnumerator AutoSwitchRoutine(float time)
    {
        yield return new WaitForSeconds(time);
        if (!isTransitioning)
        {
            ExecuteTransition();
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (isTransitioning) return;

        if (string.IsNullOrEmpty(triggerTag) || other.CompareTag(triggerTag))
        {
            isTransitioning = true;
            if (delay > 0)
            {
                Invoke(nameof(ExecuteTransition), delay);
            }
            else
            {
                ExecuteTransition();
            }
        }
    }

    public void ExecuteTransition()
    {
        Debug.Log($"Amonos");
        
        isTransitioning = true;

        if (!string.IsNullOrEmpty(targetSceneName))
        {
            Debug.Log($";^");
            
            SceneManager.LoadScene(targetSceneName);
        }
        else
        {
            Debug.Log($":^");
            
        }
        Debug.Log($"A");
    }

    // Método público que puede invocarse desde un Timeline Signal Marker
    public void LoadTargetScene()
    {
        ExecuteTransition();
    }
}
