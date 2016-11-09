import java.io.*;

/**
 * Video 1 frame array
 */
int videoY[] = new int[2073600];
int videoCr[] = new int[1036800];
int videoCb[] = new int[1036800];

/**
 * Video 2 frame array
 */
int videoY1[] = new int[2073600];
int videoCr1[] = new int[1036800];
int videoCb1[] = new int[1036800];

/**
 * File names 
 */

final String inRoute = "/home/gilson/Projects/streams/ten_bit/";
final String outRoute = "/home/gilson/Projects/streams/ten_bit/";
final String inFileName1 = inRoute + "crowd0_380.yuv";
final String inFileName2 = inRoute + "recreated_thresould_16.yuv";
final String outFileNameMain = outRoute + "crowd_run_recreated.yuv";
final String mFileName = outRoute + "M.yuv";
final String hFileName = outRoute + "H.yuv";
final String vFileName = outRoute + "V.yuv";
final String dFileName = outRoute + "D.yuv";


/**
 * Image Parameters
 */
int iheight = 1080;
int iwidth = 1920;
int chromaHeight = iheight;
int chromaWidth = iwidth/2;
int x,y,z;
double ymeanMSESum = 0;
double yfinalMSE = 0;
double yPSNR = 0, ypsnr = 0;

double crmeanMSESum = 0;
double crfinalMSE = 0;
double crPSNR = 0, crpsnr = 0;

double cbmeanMSESum = 0;
double cbfinalMSE = 0;
double cbPSNR = 0, cbpsnr = 0;

double SSIMSum = 0, SSIM;
/**
 * Read YUV video and store it in an array
 */
void setup() {
  int count = 0;
  int no_frames = 380;
  int vWidth = 0;
  int frameLength = iwidth*iheight*16/6;
  int yIndex = 0, cbIndex = 0, crIndex = 0;
  int yIndex1 = 0, cbIndex1 = 0, crIndex1 = 0;

  byte b[];
  byte b1[];
  String videoFile = inFileName1;
  String videoFile1 = inFileName2;
  RandomAccessFile randomAccessFile;
  int byte4;
  
  /**
   * Make the files to b written null
   */
  /**
  try {
    FileOutputStream fos = new FileOutputStream(outFileNameMain);
    fos.close();
     println("File Not found"); 
  } catch (IOException ie) {
     println("Error writing to file");
  }
  */
  /**
   * Virtual width of a line
   */
  vWidth = (iwidth*16/6);
  println("frameLength = ", frameLength);
  /**
   * Divide video into different frames and 
   */
  
  for(z=0;z<no_frames; ++z) {
      println("--z = ", z);
      b = new byte[5529600];
      b1 = new byte[5529600];
      /**
       * Read a single frame from the file
       */
      try {
        randomAccessFile = new RandomAccessFile(videoFile, "r");
        randomAccessFile.seek((z * frameLength));
        randomAccessFile.read(b, 0, frameLength);
        randomAccessFile.close();

        randomAccessFile = new RandomAccessFile(videoFile1, "r");
        randomAccessFile.seek((z * frameLength));
        randomAccessFile.read(b1, 0, frameLength);
        randomAccessFile.close();
      } catch(FileNotFoundException e) {
        println(e);
      } catch(IOException e) {
        println(e);
      }
       
      println(z,b.length);



      /**
       * Extract all video color components
       */
      yIndex = 0; 
      cbIndex = 0;
      crIndex = 0;
      for(y = 0; y<iheight; ++y) {
        for(x = 0; x < (iwidth*16/6); x+=8) {
          if(x==0 && y==0) {
            //println(hex(b[(y*vWidth + x)]), hex(b[(y*vWidth + x + 1)]), hex(b[(y*vWidth + x + 2)]), hex(b[(y*vWidth + x + 3)]));
            //println(hex(b[(y*vWidth + x+4)]), hex(b[(y*vWidth + x + 5)]), hex(b[(y*vWidth + x + 6)]), hex(b[(y*vWidth + x + 7)]));
          }

          byte4 = 0;
          byte4 = byte4 | ((b[(y*vWidth + x + 3)]  & 0xFF) << 24) | ((b[(y*vWidth + x + 2)] & 0xFF) << 16) | ((b[(y*vWidth + x + 1)] & 0xFF) << 8) | ((b[(y*vWidth + x)] & 0xFF));
          /** 32 bit line-1 */
          videoCr[crIndex] = (byte4 & 0x3FF00000) >> 20;
          videoY[yIndex]   = (byte4 & 0x000FFC00) >> 10;
          videoCb[cbIndex] = (byte4 & 0x000003FF);
          if(x==0 && y==0) {
            //println(Integer.toHexString(videoCr[crIndex]), Integer.toHexString(videoY[yIndex]), Integer.toHexString(videoCb[cbIndex]));  
          }
          crIndex++;
          yIndex++;
          cbIndex++;

          byte4 = 0;
          byte4 = byte4 | ((b[(y*vWidth + x + 7)] & 0xFF) << 24) | ((b[(y*vWidth + x + 6)] & 0xFF) << 16) | ((b[(y*vWidth + x + 5)] & 0xFF) << 8) | ((b[(y*vWidth + x + 4)] & 0xFF));
          /** 32 bit line-2 */
          videoY[yIndex]   = (byte4 & 0x3FF00000) >> 20;
          videoCb[cbIndex] = (byte4 & 0x000FFC00) >> 10;
          yIndex++;
          videoY[yIndex]   = (byte4 & 0x000003FF);
          if(x==0 && y==0) {
            //println(Integer.toHexString(videoY[yIndex-1]), Integer.toHexString(videoCb[cbIndex]), Integer.toHexString(videoY[yIndex]));  
          }
          cbIndex++;
          yIndex++;

          x += 8;
          if(x==8 && y==0) {
            //println("========================= next set =========================");
            //println(hex(b[(y*vWidth + x)]), hex(b[(y*vWidth + x + 1)]), hex(b[(y*vWidth + x + 2)]), hex(b[(y*vWidth + x + 3)]));
            //println(hex(b[(y*vWidth + x+4)]), hex(b[(y*vWidth + x + 5)]), hex(b[(y*vWidth + x + 6)]), hex(b[(y*vWidth + x + 7)]));
          }
          byte4 = 0;
          byte4 = byte4 | ((b[(y*vWidth + x + 3)]  & 0xFF) << 24) | ((b[(y*vWidth + x + 2)] & 0xFF) << 16) | ((b[(y*vWidth + x + 1)] & 0xFF) << 8) | ((b[(y*vWidth + x)] & 0xFF));
          /** 32 bit line-3 */
          videoCb[cbIndex] = (byte4 & 0x3FF00000) >> 20;
          cbIndex++;
          videoY[yIndex]   = (byte4 & 0x000FFC00) >> 10;
          videoCr[crIndex] = (byte4 & 0x000003FF);
          if(x==8 && y==0) {
            //println(Integer.toHexString(videoCr[crIndex]), Integer.toHexString(videoY[yIndex]), Integer.toHexString(videoCr[crIndex]));  
          }
          crIndex++;
          yIndex++;

          byte4 = 0;
          byte4 = byte4 | ((b[(y*vWidth + x + 7)] & 0xFF) << 24) | ((b[(y*vWidth + x + 6)] & 0xFF) << 16) | ((b[(y*vWidth + x + 5)] & 0xFF) << 8) | ((b[(y*vWidth + x + 4)] & 0xFF));
          /** 32 bit line-4 */
          videoY[yIndex]   = (byte4 & 0x3FF00000) >> 20;
          videoCr[crIndex] = (byte4 & 0x000FFC00) >> 10;
          yIndex++;
          videoY[yIndex]   = (byte4 & 0x000003FF);
          if(x==8 && y==0) {
            //println(Integer.toHexString(videoY[yIndex-1]), Integer.toHexString(videoCb[cbIndex]), Integer.toHexString(videoY[yIndex]));  
          }
          crIndex++;
          yIndex++;
        }
      }

      /**
       * Read videofile1
       */
      yIndex = 0; 
      cbIndex = 0;
      crIndex = 0;

      for(y = 0; y<iheight; ++y) {
        for(x = 0; x < (iwidth*16/6); x+=8) {
          if(x==0 && y==0) {
            //println(hex(b[(y*vWidth + x)]), hex(b[(y*vWidth + x + 1)]), hex(b[(y*vWidth + x + 2)]), hex(b[(y*vWidth + x + 3)]));
            //println(hex(b[(y*vWidth + x+4)]), hex(b[(y*vWidth + x + 5)]), hex(b[(y*vWidth + x + 6)]), hex(b[(y*vWidth + x + 7)]));
          }

          byte4 = 0;
          byte4 = byte4 | ((b1[(y*vWidth + x + 3)]  & 0xFF) << 24) | ((b1[(y*vWidth + x + 2)] & 0xFF) << 16) | ((b1[(y*vWidth + x + 1)] & 0xFF) << 8) | ((b1[(y*vWidth + x)] & 0xFF));
          /** 32 bit line-1 */
          videoCr1[crIndex] = (byte4 & 0x3FF00000) >> 20;
          videoY1[yIndex]   = (byte4 & 0x000FFC00) >> 10;
          videoCb1[cbIndex] = (byte4 & 0x000003FF);
          if(x==0 && y==0) {
            //println(Integer.toHexString(videoCr[crIndex]), Integer.toHexString(videoY[yIndex]), Integer.toHexString(videoCb[cbIndex]));  
          }
          crIndex++;
          yIndex++;
          cbIndex++;

          byte4 = 0;
          byte4 = byte4 | ((b1[(y*vWidth + x + 7)] & 0xFF) << 24) | ((b1[(y*vWidth + x + 6)] & 0xFF) << 16) | ((b1[(y*vWidth + x + 5)] & 0xFF) << 8) | ((b1[(y*vWidth + x + 4)] & 0xFF));
          /** 32 bit line-2 */
          videoY1[yIndex]   = (byte4 & 0x3FF00000) >> 20;
          videoCb1[cbIndex] = (byte4 & 0x000FFC00) >> 10;
          yIndex++;
          videoY1[yIndex]   = (byte4 & 0x000003FF);
          if(x==0 && y==0) {
            //println(Integer.toHexString(videoY[yIndex-1]), Integer.toHexString(videoCb[cbIndex]), Integer.toHexString(videoY[yIndex]));  
          }
          cbIndex++;
          yIndex++;

          x += 8;
          if(x==8 && y==0) {
            //println("========================= next set =========================");
            //println(hex(b[(y*vWidth + x)]), hex(b[(y*vWidth + x + 1)]), hex(b[(y*vWidth + x + 2)]), hex(b[(y*vWidth + x + 3)]));
            //println(hex(b[(y*vWidth + x+4)]), hex(b[(y*vWidth + x + 5)]), hex(b[(y*vWidth + x + 6)]), hex(b[(y*vWidth + x + 7)]));
          }
          byte4 = 0;
          byte4 = byte4 | ((b1[(y*vWidth + x + 3)]  & 0xFF) << 24) | ((b1[(y*vWidth + x + 2)] & 0xFF) << 16) | ((b1[(y*vWidth + x + 1)] & 0xFF) << 8) | ((b1[(y*vWidth + x)] & 0xFF));
          /** 32 bit line-3 */
          videoCb1[cbIndex] = (byte4 & 0x3FF00000) >> 20;
          cbIndex++;
          videoY1[yIndex]   = (byte4 & 0x000FFC00) >> 10;
          videoCr1[crIndex] = (byte4 & 0x000003FF);
          if(x==8 && y==0) {
            //println(Integer.toHexString(videoCr[crIndex]), Integer.toHexString(videoY[yIndex]), Integer.toHexString(videoCr[crIndex]));  
          }
          crIndex++;
          yIndex++;

          byte4 = 0;
          byte4 = byte4 | ((b1[(y*vWidth + x + 7)] & 0xFF) << 24) | ((b1[(y*vWidth + x + 6)] & 0xFF) << 16) | ((b1[(y*vWidth + x + 5)] & 0xFF) << 8) | ((b1[(y*vWidth + x + 4)] & 0xFF));
          /** 32 bit line-4 */
          videoY1[yIndex]   = (byte4 & 0x3FF00000) >> 20;
          videoCr1[crIndex] = (byte4 & 0x000FFC00) >> 10;
          yIndex++;
          videoY1[yIndex]   = (byte4 & 0x000003FF);
          if(x==8 && y==0) {
            //println(Integer.toHexString(videoY[yIndex-1]), Integer.toHexString(videoCb[cbIndex]), Integer.toHexString(videoY[yIndex]));  
          }
          crIndex++;
          yIndex++;
        }
      }


      //println("crIndex = ", crIndex, " cbIndex = ", cbIndex, " yIndex = ", yIndex);
      //writeFile(outFileNameMain, videoY, videoCb, videoCr);
      psnr(z);
      ssim(z);
    }
  yfinalMSE = ymeanMSESum/frameLength; 
  println(ymeanMSESum, " yfinalMSE = ", yfinalMSE); 

  if(yfinalMSE == 0) {
    println("===================================================");
    println("yPSNR = Infinite");
  } else {
    ypsnr = 1024/yfinalMSE;
    yPSNR = 10 * Math.log10(ypsnr);
    println("yPSNR = ", yPSNR);  
  }

  cbfinalMSE = cbmeanMSESum/frameLength; 
  println(cbmeanMSESum, " cbfinalMSE = ", cbfinalMSE); 

  if(cbfinalMSE == 0) {
    println("===================================================");
    println("cbPSNR = Infinite");
  } else {
    cbpsnr = 1024/cbfinalMSE;
    cbPSNR = 10 * Math.log10(cbpsnr);
    println("cb PSNR = ", cbPSNR);  
  }

  crfinalMSE = crmeanMSESum/frameLength; 
  println(crmeanMSESum, " crfinalMSE = ", crfinalMSE); 

  if(crfinalMSE == 0) {
    println("===================================================");
    println("crPSNR = Infinite");
  } else {
    crpsnr = 1024/crfinalMSE;
    crPSNR = 10 * Math.log10(crpsnr);
    println("crPSNR = ", crPSNR);  
  }
  
  SSIM = SSIMSum / no_frames;
  println("SSIM = ", SSIM); 
}
