class FieldView
{
  PGraphics copyFieldView;
  float viewSize, viewBrightness;
  boolean flicker = true;

  FieldView(int size)
  {
    viewSize = size; //size of field-of-view
    viewBrightness = 255; //controls field-of-view opacity 255 = 100% 0 = 0%
    
    copyFieldView = createGraphics(width, height);
  }


  void showFieldView()
  {
     checkNear();
     
    pushStyle();

    fieldView.background(0);
    fieldView.fill(150, viewBrightness);

    //change position to player posX and posY
    fieldView.circle(mouseX, mouseY, viewSize);

    popStyle();

    copyFieldView.beginDraw();
    copyFieldView.background(0);

    pushStyle();
    copyFieldView.noStroke();
    copyFieldView.fill(255);
    copyFieldView.circle(mouseX, mouseY, viewSize);
    popStyle();

    copyFieldView.endDraw();
    
    copyFieldView.loadPixels();
  }

  void flickerOn() {
    float n = -5;
    if (viewBrightness >= 255) {
      flicker = true;
    }
    if (viewBrightness <= 0) {
      flicker = false;
    }
    if (!flicker) {
      viewBrightness -= n;
    } else if (flicker) {
      viewBrightness += n;
    }
  }
  
  void checkNear()
  {
    color white = color(255);
    boolean near = false;
    
    for (int positionY = 0; positionY< copyFieldView.height; positionY++) 
    {
      for (int positionX = 0; positionX< copyFieldView.width; positionX++) 
      {
        color c = copyFieldView.pixels[positionX+positionY*copyFieldView.width];
        
        if (enemyPosition.get(positionX, positionY) == white && c == white) 
        {
          near = true;
        } 
      }
    }
    
    if(near)
    {
      viewSize = 150;
    }
    else if(!near)
    {
      viewSize = 300;
    }
  }

}
