import java.util.Arrays;


int a,b;
/**
  Apply perspective encoding and form the image
*/

void psnr(int frameNumber) {

  /**
   * Fill Arays to get green color
   */

  double ymseSum = 0;
  double yMSE = 0;
  double cbmseSum = 0;
  double cbMSE = 0;
  double crmseSum = 0;
  double crMSE = 0;
  /**
   * Form M, H, V and D transforms for Luma values 
   */

  for(y=0; y<iheight; y+=1) {
    for(x = 0; x < iwidth; x+=1) {
      a = videoY[(y*iwidth + x)];
      b = videoY1[(y*iwidth + x)];
      //println(a-b);
      ymseSum += Math.pow((a-b), 2);
    }
  }

  /**
   * Form M, H, V and D transforms for Luma values 
   */

  for(y=0; y<chromaHeight; y+=1) {
    for(x = 0; x < chromaWidth; x+=1) {
      a = videoCb[(y*chromaWidth + x)];
      b = videoCb1[(y*chromaWidth + x)];
      //println(a-b);
      cbmseSum += Math.pow((a-b), 2);
    }
  }

  /**
   * Form M, H, V and D transforms for Luma values 
   */
  for(y=0; y<chromaHeight; y+=1) {
    for(x = 0; x < chromaWidth; x+=1) {
      a = videoCr[(y*chromaWidth + x)];
      b = videoCr1[(y*chromaWidth + x)];
      //println(a-b);
      crmseSum += Math.pow((a-b), 2);
    }
  }

  /**
   * Find MSE
   */
  println("ymseSum = ", ymseSum);
  yMSE = ymseSum / (iheight * iwidth);
  ymeanMSESum += yMSE; 

  crMSE = crmseSum / (iheight * iwidth);
  crmeanMSESum += crMSE; 

  cbMSE = cbmseSum / (iheight * iwidth);
  cbmeanMSESum += cbMSE; 
}
