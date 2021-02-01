class Stopwatch {
  int minutes, seconds, framerate;
  Stopwatch(int framerate) {
    this.framerate = framerate;
  }
  
  String time() {
    return this.minutes + ": " + this.seconds;
  }
  
  void pause() {
    this.framerate = 0;
  }
  
  void update() {
    if(framerate == 0) {}
    else if(frameCount%this.framerate == 0) this.seconds++;
    if(this.seconds >= 60) {
      this.seconds -= 60;
      this.minutes++;
    }
  }
}
