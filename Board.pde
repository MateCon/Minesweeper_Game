class Board {
  int xPos = 10, yPos = 110;
  int cellSize, totalCells, mines, flagCount = 0;
  int[] size;
  
  Cell[] cells;
  Stopwatch stopwatch;
  
  Board(int[] size, int cellSize, int mines) {
    
    this.totalCells = size[0] * size[1];
    this.size = size;
    this.mines = mines;
    
    cells = new Cell[totalCells];
    for(int y = 0; y < size[1]; y++) {
      for(int x = 0; x < size[0]; x++) {
        this.cells[x + y*size[0]] = new Cell(x + y*size[0], x, y);
      }
    }
    
    this.cellSize = cellSize;
    this.stopwatch = new Stopwatch(framerate);
  }
  
  void placeMines() {
    for(int iteration = 0; iteration < mines; iteration++) {
      int minePosition;
      do {
        minePosition = int(random(0, totalCells));
      } while(this.cells[minePosition].hasAMine == true);
      this.cells[minePosition].hasAMine = true;
    }
  }
  
  void findNeighbours() {
    int counter;
    for(int index = 0; index < totalCells; index++) {
      counter = 0;
      boolean[] conditions = {
        (this.cells[index].xPos > 0 && this.cells[index-1].hasAMine),
        (this.cells[index].xPos < size[0]-1 && this.cells[index+1].hasAMine),
        (this.cells[index].yPos > 0 && this.cells[index-size[0]].hasAMine),
        (this.cells[index].yPos < size[1]-1 && this.cells[index+size[0]].hasAMine),
        (this.cells[index].xPos > 0 && this.cells[index].yPos > 0 && this.cells[index-1-size[0]].hasAMine),
        (this.cells[index].xPos < size[0]-1 && this.cells[index].yPos > 0 && this.cells[index+1-size[0]].hasAMine),
        (this.cells[index].xPos > 0 && this.cells[index].yPos < size[1]-1 && this.cells[index-1+size[0]].hasAMine),
        (this.cells[index].xPos < size[0]-1 && this.cells[index].yPos < size[1]-1 && this.cells[index+1+size[0]].hasAMine),
      };
      
      for(boolean condition : conditions) {
        if(condition) counter++;
      }
      
      this.cells[index].neighbours = counter;
    }
  }
  
  void clearNeighbours(int index) {
    cells[index].hasBeenDiscovered = true;
    int[] neighbours = {
      index-1,
      index+1,
      index-size[0],
      index+size[0],
      index-1-size[0],
      index+1-size[0],
      index-1+size[0],
      index+1+size[0]
    };
    
    boolean[] conditions = {
      (this.cells[index].xPos > 0),
      (this.cells[index].xPos < size[0]-1),
      (this.cells[index].yPos > 0),
      (this.cells[index].yPos < size[1]-1),
      (this.cells[index].xPos > 0 && this.cells[index].yPos > 0),
      (this.cells[index].xPos < size[0]-1 && this.cells[index].yPos > 0),
      (this.cells[index].xPos > 0 && this.cells[index].yPos < size[1]-1),
      (this.cells[index].xPos < size[0]-1 && this.cells[index].yPos < size[1]-1),
    };
    for(int iteration = 0; iteration < 8; iteration++) {
      if(conditions[iteration] && !this.cells[neighbours[iteration]].hasBeenDiscovered) {
        cells[neighbours[iteration]].handleClick();
        if(cells[neighbours[iteration]].neighbours == 0) {
          this.clearNeighbours(neighbours[iteration]);
        }
      }
    }
  }
  
  void initialize() {
    placeMines();
    findNeighbours();
  }
  
  void show() {
    
    translate(0, 10);
    fill(white);
    textFont(font);
    textAlign(CENTER);
    text("minesWeeper", width/2 , 40);
    
    textAlign(RIGHT);
    textSize(16);
    text("remaining flags: " + (mines - flagCount), width - 10, 95);
    
    boolean hasWon = true;
    for(Cell cell : cells) {
      if(!cell.hasBeenDiscovered && !cell.hasAFlag) {
        hasWon = false;
        break;
      }
    }
    
    if(hasWon || hasDied) stopwatch.pause();
    
    text((hasWon && !hasDied) ? "You won! Your time was " + this.stopwatch.time() : this.stopwatch.time(), width - 10, 75);
    
    textAlign(LEFT);
    text("settings", 10, 55);
    
    textSize(16);
    text("- size -> " + size[0] + " * " + size[1] + " (1, 2 or 3)", 15, 75);
    text("- mines -> " + ((mineMode == 12) ? "8%" : ((mineMode == 8) ? "12%" : "25%")) + " (4, 5 or 6)", 15, 95);

    textAlign(CENTER);
    for(int index = 0; index < board.size[0] * board.size[1]; index++) {
      board.cells[index].show();
    }
    translate(0, -10);
  }
  
  void update() {
    this.stopwatch.update();
    this.show();
  }
}
