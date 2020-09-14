#include "errno.h"
#include "stdlib.h"
#include "stdio.h"
#include "string.h"
#include "raylib.h"

typedef struct GeocoordinateList {
  size_t length;
  Vector3 records[];
} GeocoordinateList;

void parseInputData(char filePath[], GeocoordinateList *parsedInputData) {
  FILE *inputData = fopen(filePath, "r");
  if (inputData == NULL) {
    fclose(inputData);
    fprintf(stderr, "Cannot find GPS input data file at path %s\n", filePath);
    exit(EXIT_FAILURE);
  }

  char *inputLine = NULL;
  size_t lineLength = 0;
  ssize_t numCharactersRead;

  size_t geocoordinateListLength = 0;

  if ((numCharactersRead = getline(&inputLine, &lineLength, inputData)) != -1) {
    if (sscanf(inputLine, "%zu", &geocoordinateListLength) == 1) {
      printf("Number of geocoordinate records: %zu\n", geocoordinateListLength);
    } else if (errno != 0) {
      perror("sscanf");
    } else {
      fprintf(stderr, "First line must contain number of Geocoordinate records.\n");
    }
  }

  // Initiate GeocoordinateList with flexible array member
  parsedInputData = (GeocoordinateList *) malloc(sizeof(GeocoordinateList) +
    (sizeof(Vector3) * geocoordinateListLength));

  if (parsedInputData == NULL) {
    fprintf(stderr, "Failed to allocate memory for Geocoordinate List.\n");
    exit(EXIT_FAILURE);
  }
  parsedInputData->length = geocoordinateListLength;

  size_t currentRecordIndex = 0;

  while ((numCharactersRead = getline(&inputLine, &lineLength, inputData)) != -1) {
    if (currentRecordIndex >= parsedInputData->length - 1) {
      break;
    }

    Vector3 record = {0};
    sscanf(inputLine, "V(%f, %f, %f)", &(record.x), &(record.y), &(record.z));
    parsedInputData->records[currentRecordIndex++] = record;

    printf("%zu: Vector3(%f, %f, %f)\n", currentRecordIndex, record.x, record.y, record.z);
  }

  fclose(inputData);
}

int main(int argc, char *argv[argc+1]) {
  if (argc > 2) {
    printf("Too many arguments supplied.\n");
  } else if (argc == 1) {
    printf("One argument expected. Provide path to gps input data.\n");
    exit(EXIT_FAILURE);
  }

  char inputFilePath[strlen(argv[1])];
  strcpy(inputFilePath, argv[1]);

  GeocoordinateList *inputData;
  parseInputData(inputFilePath, inputData);

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

  free(inputData);

  return EXIT_SUCCESS;
}
