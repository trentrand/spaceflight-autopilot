#include "stdlib.h"
#include "raylib.h"

int main(void) {
  const int screenWidth = 600;
  const int screenHeight = 600;

  InitWindow(screenWidth, screenHeight, "Automated Rocket Control Visualizer");

  Camera camera = { 0 };
  camera.position = (Vector3){ 800.0f, 800.0f, 800.0f };
  camera.target = (Vector3){ 0.0f, 0.0f, 0.0f };
  camera.up = (Vector3){ 0.0f, 1.0f, 0.0f };
  camera.fovy = 60.0f;
  camera.type = CAMERA_PERSPECTIVE;

  SetCameraMode(camera, CAMERA_FIRST_PERSON);

  SetTargetFPS(60);

  while (!WindowShouldClose()) {
    UpdateCamera(&camera);

    BeginDrawing();
    {
      ClearBackground(RAYWHITE);
      DrawText("Blue World", 250, 50, 20, BLUE);

      BeginMode3D(camera);
      {
        DrawSphere((Vector3){ 0, 0, 0 }, 600.0f, BLUE);
      }
      EndMode3D();
    }
    EndDrawing();
  }

  CloseWindow();

  return EXIT_SUCCESS;
}
