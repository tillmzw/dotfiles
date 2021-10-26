const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#073642", /* black   */
  [1] = "#dc322f", /* red     */
  [2] = "#859900", /* green   */
  [3] = "#b58900", /* yellow  */
  [4] = "#268bd2", /* blue    */
  [5] = "#d33682", /* magenta */
  [6] = "#2aa198", /* cyan    */
  [7] = "#eee8d5", /* white   */

  /* 8 bright colors */
  [8]  = "#6c7c80",  /* black   */
  [9]  = "#dc322f",  /* red     */
  [10] = "#859900", /* green   */
  [11] = "#b58900", /* yellow  */
  [12] = "#268bd2", /* blue    */
  [13] = "#d33682", /* magenta */
  [14] = "#2aa198", /* cyan    */
  [15] = "#eee8d5", /* white   */

  /* special colors */
  [256] = "#073642", /* background */
  [257] = "#fdf6e3", /* foreground */
  [258] = "#dc322f",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
