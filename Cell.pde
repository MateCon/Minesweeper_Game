class Cell {
  int index, xPos, yPos, neighbours, defaultColor = 255 - 20 * int(random(5));
  boolean hasAMine = false, hasBeenDiscovered = false, hasAFlag = false;
  
  Cell(int index, int xPos, int yPos) {
    this.index = index;
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  void handleClick() {
    if(this.hasAMine && !this.hasAFlag) { hasDied = true; }
    else if(!this.hasAFlag) { this.hasBeenDiscovered = true; }
  }
  
  void show() {
    stroke(white);
    strokeWeight(2);
    if(hasAMine && hasDied) fill(255, 100, 100);
    else if(hasAFlag) fill(lightBlue);
    else if(hasBeenDiscovered || hasDied) fill(darkBlue, neighbours * 50);
    else fill(darkBlue, this.defaultColor);
    rect(board.xPos + xPos * board.cellSize, board.yPos + yPos * board.cellSize, board.cellSize, board.cellSize);
    
    if(this.hasBeenDiscovered || hasDied) {
      if(!hasAMine) {
        fill(white);
        textSize(24);
        text(neighbours, board.xPos + xPos * board.cellSize + board.cellSize/2, board.yPos + yPos * board.cellSize + board.cellSize/2 + 6);
      }
    }
  }
}
