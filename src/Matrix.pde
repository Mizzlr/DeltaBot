class Matrix {


 // variables
 int row;
 int col;

 float[] value;


 // Member Functions
 //   |--> Matrix(int rows,int cols) :: the constructor
 //   |--> read(String inputFile) :: reads a input matrix from CSV style text file 
 //   |--> write(String outputFile) :: write a output file in a compatible format
 //   |--> matrixPrint(String message) :: prints the matrix in MATLAB style along with the message 
 //   |--> matrixRandom() :: fills the matrix with random values between -1 and 1
 //   |--> matrixRandom(float low, float high) :: fills matrix with random values between low and high
 //   |--> Matrix plus(Matrix secondMatrix) :: returns the sum of two matrix if they are compatible
 //   |--> Matrix minus(Matrix secondMatrix) :: returns the difference of two matrix if they are compatible 
 //   |--> Matrix times(Matrix secondMatrix) :: returns the product of two matrix if they are compatible
 //   |--> matrixMap(float fromLow, float fromHigh, float toLow, float toHigh) :: element wise map() function.
 //   |--> matrixImage(int xsize, int ysize, int x,int y) :: to draw the image of a matrix of size (xsize,ysize) and at (x,y)
 //   |--> Matrix transpose() :: returns transpose of a matrix
 //   |--> Matrix sigmoid() :: element wise sigmoid funtion :: g(x)  = 1 / ( 1 + exp(-x)) // special function used in neural network
 //   |--> Matrix scaledTo() :: scalar multiplication
 //   |--> Matrix eye() :: returns identity matrix of size of invoking matrix
 //   |--> Matrix zeros() ::returns zero matrix of size of invoking matrix
 //   |--> Matrix ones()  :: returns ones matrix of size of invoking matrix
 //   |--> Matrix subMatrix(int rowLow,int rowHigh, int colLow, int colHigh) :: extract a sub matrix as specified by it parameters
 //   |            note that it logical indexing of rows or columns begins from 1 ( and not 0, as in matrix in C++,C etc).
 //   |--> Matrix verticalStack( Matrix secondMatrix) :: concatenate two matricies vertically
 //   |--> Matrix horizontalStack( Matrix secondMatrix) :: concatanate two matricies horizontally
 //   |--> Matrix dotTimes( Matrix secondMatrix) :: element wise multiplication 
 //   |--> Matrix dotDiv( Matrix secondMatrix) :: element wise division
 //   |--> Matrix sumRows() :: sums all rows into a single row. That is row1 + row2 + ...+ lastRow  
 //   |--> Matrix sumCols() :: sums all columns into a single column. That is col1 + col2 +...+ lastCol
 //   |--> Matrix maxRows() :: maximum value from each column. That result in  row of maximum value
 //   |--> Matrix maxCols() :: maximum value from each row. That result in  column of maximum value
 //   |--> float max() :: maximum value in the matrix   
 //   |--> Matrix minRows() :: minimum value of each column. That result in  row of minimum value
 //   |--> Matrix minCols() :: minimum value of each row. That result in  column of minimum value
 //   |--> float min() :: minimum value in the matrix
 //   |--> float norm() :: returns square root of sum of squares of all the elements of the vector
 //   |--> Matrix power(float exponent) :: element wise exponentiation. 
 //   |--> int row() :: returns the number of rows in invoking object
 //   |--> int col() :: returns the number of columns in invoking object
 //   |--> Matrix sortRowWise() :: sorts each row, that is row wise sorting
 //   |--> Matrix sortColWise() :: sorts each column, that is  column wise sorting 
 //   |--> Matrix matrixReverse() :: flips the matrix, last row into first row
 //   |--> Matrix reshape(int rows,int cols) :: reshapes the matrix
 //   `--> Matrix matrixAbs() :: returns a matrix of absolute value of the invoking matrix
 //   
 //   I have not yet implemented funtions for eigen values and vectors, inverse, determinant, svd etc..
 //   Most I wouldn't need that


 // NOTE: some specialized neural network functions are not yet documented. Remind me later.   


 Matrix(int r, int c)
 {
   row = r;
   col = c;
   value = new float[row * col];
   for (int i = 0; i< row; i++)
     for (int j = 0; j < col; j++)
       value[i * col + j] = 0.0f;

   // println(" Matrix initialized ");
 }

 Matrix(int r, int c, float[] value)
 {
   row = r;
   col = c;
   this.value = value;

   // println(" Matrix initialized ");
 }
 void read(String matrixFile)
 {
   int j = 0;
   String[] lines = loadStrings(matrixFile);
   println(" Matrix loaded from file : " + matrixFile);
   row = lines.length;
   for ( int i = 0; i < lines.length; i++) {
     String[] line = split(lines[i], ",");
     for ( j = 0; j < line.length; j++ )
       value[i * line.length +  j] = float(line[j]);
   }
   col = j;
 }


 void write(String matrixFile)
 {
   PrintWriter file  = createWriter(matrixFile);
   for (int i = 0; i< row; i++) {
     for (int j = 0; j < col; j++) {
       file.print(value[i * col + j ]);
       if (j<col-1) file.print(",");
     }
     file.println("");
   }
   file.flush();
   file.close();
 }

 void matrixPrint(String message)
 { 
   int x; 
   int consoleCols = 18; 
   int remCol = consoleCols;
   println(" Matrix " + message); 
   for (int k = 0; k < col; k += consoleCols) {

     if (col - k < consoleCols) remCol = col - k;
     if (col > consoleCols && remCol == consoleCols) println(" Columns " + (k+1) + " through " + (k+consoleCols) + ":");
     if (remCol < consoleCols && remCol != 1) println(" Columns " + (k+1) + " through " + (k+remCol) + ":");
     if (remCol == 1) println(" Column " + (k+1) +   ":");
     for (int i = 0; i< row; i++) {
       for (int j = k; j < remCol +k; j++) {
         if ( value[i * col + j] >= 0) {
           x =   str(int(value[i * col + j])).length();
           print(" " + nf(value[i * col + j], x, 4) + "\t");
         } else { 
           x = str(int(value[i * col + j])).length() - 1;
           print(nf(value[i * col + j], x, 4) + "\t");
         }
       }
       println("");
     }
   }
 }


 void matrixRandom() {

   for (int i = 0; i< row; i++)
     for (int j = 0; j < col; j++)
       value[i * col + j] = random(-1, 1);
 }


 void matrixRandom(int low, int high ) {

   for (int i = 0; i< row; i++)
     for (int j = 0; j < col; j++)
       value[i * col + j] = random(low, high);
 }
 Matrix plus(Matrix m)
 {

   Matrix result = new Matrix(row, col);
   if ( row == m.row && col == m.col) //check compatibility
   {


     for (int i = 0; i< row; i++)
       for (int j = 0; j < col; j++)
         result.value[i * col + j] = value[i * col + j] + m.value[i * col + j];
   } else println("incompatible matrix addition");
   return result;
 }

 Matrix minus(Matrix m)
 {

   Matrix result = new Matrix(row, col);
   if ( row == m.row && col == m.col) //check compatibility
   {


     for (int i = 0; i< row; i++)
       for (int j = 0; j < col; j++)
         result.value[i * col + j] = value[i * col + j] - m.value[i * col + j];
   } else println("incompatible matrix subtraction");
   return result;
 }


 Matrix times(Matrix m)
 {
   if ( col == m.row ) // check compatibility
   {
     Matrix result = new Matrix(row, m.col);

     for (int i=0; i < row; i++)
       for (int j=0; j < m.col; j++) {  
         result.value[i * m.col + j]=0;
         for (int k=0; k < col; k++)
           result.value[i * m.col + j] += value[i * col + k] * m.value[k * m.col + j];
       }      
     return result;
   } else println("incompatible matrix multiplication");
   Matrix m1 = new Matrix(1, 1);
   return m1;
 }

 void matrixMap(float fromLow, float fromHigh, float toLow, float toHigh) {


   for (int i=0; i < row; i++)
     for (int j=0; j < col; j++)
       value[i * col + j] = map(value[i * col + j], fromLow, fromHigh, toLow, toHigh);
 }


 void matrixImage(int xsize, int ysize, int y, int x) {
   matrixMap(minimum(), maximum(), 0, 255); 
   transpose();
   xsize *= col();
   ysize *= row();
   int xstep = xsize / col;
   int ystep = ysize / row;
   for (int i=0; i < row; i++ )
     for (int j=0; j < col; j++) {
       fill(int(value[i * col + j]));
       noStroke();
       rect(y + j*xstep, x + i*ystep, xstep, ystep);
     }
 }


 Matrix transpose()
 {

   Matrix result = new Matrix(col, row);

   for (int i=0; i<row; i++)
     for (int j=0; j<col; j++)
       result.value[j * row + i] = value[i * col + j];

   return result;
 }  
 Matrix sigmoid()
 {

   Matrix result = new Matrix(row, col);

   for (int i=0; i<row; i++)
     for (int j=0; j<col; j++)
       result.value[i * col + j] = 1 / ( 1 + exp(- value[i * col + j]) );

   return result;
 }


 Matrix inverseSigmoid()
 {

   Matrix result = new Matrix(row, col);

   for (int i=0; i<row; i++)
     for (int j=0; j<col; j++)
       result.value[i * col + j] = -log( -1 + 1 / value[i * col + j]) ;
   return result;
 }

 Matrix matrixConstrain(float low, float high)
 {

   Matrix result = new Matrix(row, col);

   for (int i=0; i<row; i++)
     for (int j=0; j<col; j++)
       result.value[i * col + j] = constrain(value[ i * col + j], low, high);
   return result;
 }



 Matrix scaledTo(float scalingFactor)
 {
   Matrix result = new Matrix(row, col);

   for (int i=0; i<row; i++)
     for (int j=0; j<col; j++)
       result.value[i * col + j] = value[i * col + j] * scalingFactor;
   return result;
 }


 Matrix eye()
 {
   Matrix result = new Matrix(row, col);
   for (int i = 0; i< row; i++)
     for (int j=0; j< col; j++)
       if ( i == j) result.value[i * col + j] = 1;

   return result;
 }  

 Matrix zeros()
 { 
   Matrix result = new Matrix(row, col);
   return result;
 }

 Matrix ones()
 {
   Matrix result  = new Matrix( row, col);
   for (int i=0; i<row; i++)
     for (int j=0; j<col; j++)
       result.value[i * col + j] = 1;
   return result;
 } 


 Matrix subMatrix(int rowLow, int rowHigh, int colLow, int colHigh) {
   Matrix result = new Matrix(abs(rowHigh - rowLow )+ 1, abs(colHigh - colLow) + 1);

   if (rowHigh >= rowLow && colHigh >= colLow) {

     int subRow = rowHigh - rowLow + 1;
     int subCol = colHigh - colLow + 1;
     for (int i=1; i<= subRow; i++)
       for (int j=1; j<= subCol; j++)
         result.value[ (i -1 ) * subCol + j -1 ] = value[ (rowLow + i ) * col  + (colLow + j ) - 2 * col -2 ];
   } else println("Invalid order of rows or columns");

   return result;
 }


 Matrix horizontalStack( Matrix m) {


   Matrix result = new Matrix(row, col + m.col);
   if (row == m.row) {

     for (int i=0; i < row; i++)
       for (int j=0; j< col; j++)   
         result.value[i * (col+m.col) + j] = value[i * col +j];
     for (int i=0; i < row; i++)
       for (int j=0; j < m.col; j++)
         result.value[ i * (col+m.col) + j + col] = m.value[i * col +j + i];
   } else println("Horizontal Stack not possible, row mismatch");

   return result;
 }


 Matrix verticalStack( Matrix m) {


   Matrix result = new Matrix(row + m.row, col);
   if (col == m.col) {

     for (int i=0; i < row; i++)
       for (int j=0; j< col; j++)   
         result.value[i * col + j] = value[i * col +j];
     for (int i=0; i < m.row; i++)
       for (int j=0; j < col; j++)
         result.value[ (i + row) * col + j] = m.value[i * col +j];
   } else println("Vertical Stack not possible, column mismatch");

   return result;
 }

 Matrix dotTimes(Matrix m)
 {

   Matrix result = new Matrix(row, col);
   if ( row == m.row && col == m.col) //check compatibility
   {


     for (int i = 0; i< row; i++)
       for (int j = 0; j < col; j++)
         result.value[i * col + j] = value[i * col + j]  *  m.value[i * col + j];
   } else println("incompatible matrix addition");
   return result;
 }

 Matrix dotDiv(Matrix m)
 {

   Matrix result = new Matrix(row, col);
   if ( row == m.row && col == m.col) //check compatibility
   {


     for (int i = 0; i< row; i++)
       for (int j = 0; j < col; j++)
         result.value[i * col + j] = value[i * col + j] / m.value[i * col + j];
   } else println("incompatible matrix addition");
   return result;
 }

 Matrix sumRows() { // sums all rows into a single row  
   Matrix result = new Matrix(1, col);

   for ( int i = 0; i < row; i++)
     for (int j = 0; j < col; j++)
       result.value[j] = result.value[j] +  value[ i * col + j];

   return result;
 }
 Matrix sumCols() { // sums all columns into a single column  
   Matrix result = new Matrix(row, 1);

   for ( int i = 0; i < row; i++)
     for (int j = 0; j < col; j++)
       result.value[i] = result.value[i] +  value[ i * col + j];

   return result;
 }

 float sum() {

   float result = 0;

   for ( int i = 0; i < row; i++)
     for (int j = 0; j < col; j++)
       result +=  value[ i * col + j];

   return result;
 }
 Matrix maxRows() { // maximum value of each column :: CAREFULL  
   Matrix result = subMatrix(1, 1, 1, col);


   for ( int i = 1; i < row; i++)
     for (int j = 0; j < col; j++)
       if ( result.value[j] < value[ i * col + j]) 
         result.value[j]  =  value[ i * col + j];

   return result;
 }
 Matrix maxCols() { // maximum value in each row  :: CAREFULL
   Matrix result = subMatrix(1, row, 1, 1);

   for ( int i = 0; i < row; i++)
     for (int j = 1; j < col; j++)
       if ( result.value[i] < value[ i * col + j]) 
         result.value[i]  =  value[ i * col + j];

   return result;
 }

 Matrix minRows() { // minimum value of each column  :: CAREFULL
   Matrix result = subMatrix(1, 1, 1, col);


   for ( int i = 1; i < row; i++)
     for (int j = 0; j < col; j++)
       if ( result.value[j] > value[ i * col + j]) 
         result.value[j]  =  value[ i * col + j];

   return result;
 }
 Matrix minCols() { // minimum value in each row  :: CAREFULL
   Matrix result = subMatrix(1, row, 1, 1);

   for ( int i = 0; i < row; i++)
     for (int j = 1; j < col; j++)
       if ( result.value[i] > value[ i * col + j]) 
         result.value[i]  =  value[ i * col + j];

   return result;
 }

 float maximum() { // maximum value of each column  
   float result = value[0];


   for ( int i = 1; i < row; i++)
     for (int j = 0; j < col; j++)
       if ( result < value[ i * col + j]) 
         result  =  value[ i * col + j];

   return result;
 }


 float minimum() { // maximum value of each column  
   float result = value[0];


   for ( int i = 1; i < row; i++)
     for (int j = 0; j < col; j++)
       if ( result > value[ i * col + j]) 
         result =  value[ i * col + j];

   return result;
 }
 Matrix matrixAbs() { // returns Matrix with absolute value of each element  
   Matrix result = new Matrix(row, col);

   for ( int i = 0; i < row; i++)
     for (int j = 0; j < col; j++)
       result.value[ i * col +j ] = abs(value[ i * col + j]);

   return result;
 } 

 float norm2() {
   float norm2 = 0; 
   if (col == 1) {
     for ( int i = 0; i < row; i++ )
       norm2 += sq(value[i]);
   } else println("norm() requires a column vector, error in invocation");
   return norm2;
 }

 float norm() {

   float norm = 0;
   if (col == 1) {
     float sum = 0;
     for ( int i = 0; i < row; i++ )
       sum += sq(value[i]);
     norm = sqrt(sum);
   } else println("norm() requires a column vector, error in invocation");
   return norm;
 }

 Matrix power(float exponent) {

   Matrix result = new Matrix(row, col);

   for ( int i = 0; i < row; i++)
     for (int j = 0; j < col; j++)
       result.value[i * col + j] = pow(value[ i * col + j], exponent);
   return result;
 }

 int row() {
   return row;
 }

 int col() {
   return col;
 } 

 Matrix sortRowWise() {
   Matrix result = new Matrix(row, col);

   for ( int i = 0; i < row; i++) {
     Matrix aRow = subMatrix(i+1, i+1, 1, col);
     float[] list = reverse(sort(aRow.value)); 
     for ( int j = 0; j < col; j++)
       result.value[ i * col + j] = list [j] ;
   }
   return result;
 }
 Matrix sortColWise() {

   Matrix result = transpose().sortRowWise().transpose();
   return result;
 }

 Matrix matrixReverse() {
   Matrix result = new Matrix(row, col);
   for ( int i = 0; i < row; i++)
     for (int j = 0; j < col; j++)
       result.value[i * col + j] = value[ (row - i - 1) * col + j];
   return result;
 }



 Matrix __reshape(int rows, int cols) {
   Matrix result = new Matrix(rows, cols);
   Matrix m = transpose();
   if ( rows * cols == row * col) {
     for ( int i = 0; i < m.row; i++) {

       for (int j = 0; j < m.col; j++)
         result.value[i + j * m.row] = m.value[i * m.col + j];
     }
   } else print(" Error in reshaping, incompatible size to reshape : from " + row + "x" + col + " to " + rows + "x" + cols);
   return result;
 }
 Matrix reshape(int rows, int cols) {
   Matrix result = new Matrix(rows, cols);
   result = transpose().__reshape(cols, rows).transpose();
   return result;
 }

 Matrix blur() {
   int tic = millis();
   Matrix result = new Matrix(row, col);

   Matrix kernel = new Matrix(5, 5);
   kernel.read("blur.mat");
   //matrixPrint(" img = ");
   for ( int i = 0; i < row; i++)
     for (int j = 0; j < col; j++)
       for ( int k = -2; k < 3; k++)
         for (int l = -2; l < 3; l++) {
           //println("Loop i: " + i + " j: " + j + " k: " + k+ " l: " + l);
           if ( (i + k) >= 0 && (i + k) < row && (j +l ) >= 0 && (j + l) < col)
             result.value[ (i + k) * col + j + l] = result.value[ (i + k) * col + j + l] + value[i * col + j] * kernel.value[  ( k + 2 ) * 5 + l + 2 ] ;
         }
   //result.matrixPrint(" result = "); 
   int toc = millis();
   println(" Time taken to blur: " + (toc - tic) + "ms");
   return result;
 }

 float determinant()
 {
   float[] c = new float[row]; 
   float d;
   Matrix b = new Matrix(row-1, col-1);
   int j, p, q, t, pr;
   if (row == 2)
   {
     d=(value[0]*value[3])-(value[1]*value[2]);
     return d ;
   } else
   {
     for (j = 0; j < row; j++)
     {        
       int r=0, s=0;
       for (p = 0; p < row; p++)
       {
         for (q = 0; q < col; q++)
         {
           if (p!=0 && q!=j)
           {
             b.value[r * b.col + s] = value[p * col +q];
             s++;
             if (s > b.row-1 )
             {
               r++;
               s=0;
             }
           }
         }
       }

       for (t=0, pr=1; t < (1+j); t++)
         pr=(-1)*pr;
       // b.matrixPrint("b at j: " + j + " is: ");

       c[j]=pr* b.determinant();
       // println("c["+ j + "]: is " + c[j]);
     }
     for (j = 0, d=0; j < row; j++)
     {
       d=d+(value[j]*c[j]);
     }
     return d;
   }
 }
 Matrix inverse()
 {
   int n = row;
   float[] A = value;
   if ( row == col) {


     // A = input matrix AND result matrix
     // n = number of rows = number of columns in A (n x n)
     int pivrow;     // keeps track of current pivot row
     int k, i, j;      // k: overall index along diagonal; i: row index; j: col index
     int[] pivrows = new int[n]; // keeps track of rows swaps to undo at end
     float tmp;      // used for finding max value and making column swaps

     pivrow = 0;
     for (k = 0; k < n; k++)
     {
       // find pivot row, the row with biggest entry in current column
       tmp = 0;
       for (i = k; i < n; i++)
       {
         float A1 = A[i * col + k];
         if ( abs(A1) >= tmp)   
         {
           tmp = abs(A1);
           pivrow = i;
         }
       }

       // check for singular matrix
       if (A[pivrow * col + k] == 0.0)
       {
         println("Inversion failed due to singular matrix");
       }

       // Execute pivot (row swap) if needed
       if (pivrow != k)
       {
         // swap row k with pivrow
         for (j = 0; j < n; j++)
         {
           tmp = A[k * col +j];
           A[k*n+j] = A[pivrow*n+j];
           A[pivrow * col + j] = tmp;
         }
       }
       pivrows[k] = pivrow;    // record row swap (even if no swap happened)

       tmp = 1.0f/A[k*col +k];    // invert pivot element
       A[k*col+k] = 1.0f;        // This element of input matrix becomes result matrix

       // Perform row reduction (divide every element by pivot)
       for (j = 0; j < n; j++)
       {
         A[k*col+j] *= tmp;
       }

       // Now eliminate all other entries in this column
       for (i = 0; i < n; i++)
       {
         if (i != k)
         {
           tmp = A[i*col+k];
           A[i*col+k] = 0.0f;  // The other place where in matrix becomes result mat
           for (j = 0; j < n; j++)
           {
             A[i*col+j] = A[i*col+j] - A[k*col+j]*tmp;
           }
         }
       }
     }

     // Done, now need to undo pivot row swaps by doing column swaps in reverse order
     for (k = n-1; k >= 0; k--)
     {
       if (pivrows[k] != k)
       {
         for (i = 0; i < n; i++)
         {
           tmp = A[i*col+k];
           A[i*n+k] = A[i*n+pivrows[k]];
           A[i*col+pivrows[k]] = tmp;
         }
       }
     }
   } else println("cannot invert, not a square matrix");

   Matrix result = new Matrix(n, n, A);
   return result;
 }
}//end of class Matrix






// TRASH SECTION :: unimplemented functions 

/*

*/