#include "stdlib.h"
#include "raylib.h"

int main(void) {
  const int screenWidth = 600;
  const int screenHeight = 600;

  InitWindow(screenWidth, screenHeight, "Automated Rocket Control Visualizer");

  SetTargetFPS(60);

  while (!WindowShouldClose()) {
    BeginDrawing();
    {
      ClearBackground(RAYWHITE);
      DrawText("Hello World", 300, 200, 20, LIGHTGRAY);
    }
    EndDrawing();
  }

  CloseWindow();

  return EXIT_SUCCESS;
}
