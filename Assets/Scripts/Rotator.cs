using UnityEngine;
using System.Collections;

public class Rotator : MonoBehaviour
{
        [Range(1.0f, 50.0f)]
        public float speed = 25.0f;

        void Update()
        {
                transform.Rotate(Vector3.up * Time.deltaTime * speed);
        }
}
