/* 
This file contains ANSI C function prototypes and variable declaration. Here –

- The %module directive specifies the name of the module we will use in Python.
- %{ .. %} block provides a location to insert additional code such as C header 
  files or additional C declaration into the generated wrapper code.
- %include directive let us include additional files like header files.
*/

/* name of module to use*/
%module gfg 
%{ 
    /* Every thing in this file is being copied in  
     wrapper file. We include the C header file necessary 
     to compile the interface */
    #include "gfg.h" 
  
    /* variable declaration*/
    double myvar; 
%}
  
/* explicitly list functions and variables to be interfaced */
double myvar; 
long long int fact(long long int n1); 
int my_mod(int m, int n); 
  
/* or if we want to interface all functions then we can simply 
   include header file like this -  
   %include "gfg.h" 
*/