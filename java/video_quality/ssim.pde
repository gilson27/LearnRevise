import java.util.Arrays;
int p,q;

/**
 * Get the SSIM of the frame
 */

void ssim(int frameNumber) {
  double meanXSum = 0, meanYSum = 0, meanX, meanY;  
  double varXSum = 0, varYSum = 0, covXYSum = 0;
  double varX, varY, covXY; 
	double c1 = 0.01 * (Math.pow(2, 10) - 1);
  double c2 = 0.03 * (Math.pow(2, 10) - 1);
  double currSSIM;

  /**
   * Find all mean values
   */
  for(y=0; y < iheight; y+=2) {
    for(x = 0; x < iwidth; x+=2) {
      p = videoY[(y*iwidth + x)];
      q = videoY1[(y*iwidth + x)];
	  meanXSum += p;
      meanYSum += q;
    }
  }

  meanX = meanXSum/(iheight*iwidth);
  meanY = meanYSum/(iheight*iwidth);

  /**
   * Find variances and covariance 
   */
  for(y=0; y<iheight; y+=2) {
    for(x = 0; x < iwidth; x+=2) {
      p = videoY[(y*iwidth + x)];
      q = videoY1[(y*iwidth + x)];
	  varXSum = Math.pow((p - meanX), 2);
	  varYSum = Math.pow((q - meanY), 2);
	  covXYSum = (p - meanX) * (q - meanY);      
    }
  }

  /**
   * Find variances
   */
  varX = varXSum/(width*height);
  varY = varYSum/(width*height);
  covXY = covXYSum/(width*height);

  /**
   * Calculate SSIM for the frame 
   */
  currSSIM = ((2*meanX*meanY+c1) * (2*Math.pow(covXY,2)+c2)) / ((Math.pow(meanX, 2) + Math.pow(meanY, 2) + c1) * (Math.pow(varX, 2) + Math.pow(varY, 2) + c2)); 
  SSIMSum += currSSIM;
}
