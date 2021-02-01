color white = #E8E7EE,
      lightBlue = #6F81A1,
      blue = #4E5B72,
      darkBlue = #3E465A,
      black = #2D3142,
      red = color(255, 100, 100);

PFont font;
Board board;
boolean hasDied = false;
int size[] = {8, 8};
int cellSize = 580/8,
    mineTotal = 10,
    mineMode = 5,
    framerate = 30;

void setup() {
  size(600, 710);
  frameRate(framerate);
  font = createFont("Raleway-Light.ttf", 36);
  board = new Board(size, cellSize, mineTotal);
  board.initialize();
}

void draw() {
  background(black);
  board.update();
}

void keyPressed(){
  if(key == 'z' ||  key == 'x') {
    for(int x = 0; x < size[0]; x++) {
      for(int y = 0; y < size[1]; y++) {
        if(mouseX > board.xPos + x * cellSize && mouseX < board.xPos + x * cellSize + cellSize && mouseY > board.yPos + y * cellSize && mouseY < board.yPos + y * cellSize + cellSize) {
          if(key == 'z') {
            board.cells[x + y*size[0]].handleClick();
            if(board.cells[x + y*size[0]].neighbours == 0) {
              board.clearNeighbours(x + y*size[0]);
            }
          }
          if(key == 'x' && !board.cells[x + y*size[0]].hasBeenDiscovered) {
            if(board.cells[x + y*size[0]].hasAFlag) {
              board.flagCount--;
              board.cells[x + y*size[0]].hasAFlag = false;
            } else if(board.mines - board.flagCount > 0) {
              board.flagCount += (board.cells[x + y*size[0]].hasAFlag) ? -1 : 1;
              board.cells[x + y*size[0]].hasAFlag = !board.cells[x + y*size[0]].hasAFlag;
            }
          }
        }
      }
    }
  } else if(key == '1') {
    size[0] = 4;
    size[1] = 4;
    cellSize = 580/4;
  } else if(key == '2') {
    size[0] = 8;
    size[1] = 8;
    cellSize = 580/8;
  } else if(key == '3') {
    size[0] = 16;
    size[1] = 16; 
    cellSize = 580/16;
  } else if(key == '4') {
    mineMode = 12;
  } else if(key == '5') {
    mineMode = 8;
  } else if(key == '6') {
    mineMode = 4;
  } if(key == 'r' || key == 'c' || key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6') {
    mineTotal = int((size[0] * size[1])/mineMode);
    board = new Board(size, cellSize, mineTotal);
    board.initialize();
    hasDied = false;
  }
}
