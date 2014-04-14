
#include <iostream.h> 
#include <fstream.h> 
#include <iostream.h> 
#include <string> 
using std::string;

#define MAX 100 


void int2binary(unsigned int n, char *buffer, unsigned int buffer_size)
{
	int i = (buffer_size - 1);
	buffer[i] = '\0';
	while(i > 0)
	{
		if(n & 0x01)
		{
			buffer[--i] = '1';
		} else
		{
			buffer[--i] = '0';
		}
		n >>= 1;
	}
}
void Xoa(char s[MAX], int n, int i) 
{ 
    char p[MAX]; 
    strncpy(p, s, i - 1); 
    int len = strlen(s); 
    strcpy(p + i - 1, s + (i - 1) + n); 
    p[len - n] = '\0'; 
    strcpy(s,p); 
} 
//Them ch vao vi tri thu i cua s 
void Them(char s[MAX], int i, char ch[MAX]) 
{ 
    int len = strlen(s); 
    int lench = strlen(ch); 
	for (int j = len; j >= i - 1; j--) 
        s[j + lench] = s[j]; 
	for (int j = 0; j < lench; j++)  // --> for (int j = 0; j < lench; j++)
        s[i - 1 + j] = ch[j];
} 

void ThayThe(char s[MAX], char s1[MAX], char s2[MAX]) 
{ 
    int len = strlen(s); 
    int len1 = strlen(s1); 
    int len2 = strlen(s2); 
    char *p; 
    int i; 
    while ((p = strstr(s,s1)) != NULL) 
    { 
           i = p - s + 1; 
           Xoa(s,len1,i); 
           Them(s,i,s2); 
    } 
} 
void earse_character(char a[], char temp)
{
    int n= strlen(a); // cai ham nay cua borland C++  dùng d? l?y d? dài c?a chu?i.

     for(int i=0;i<n;i++)
      {
         if(a[i]==temp)
         {
            for(int j=i; j<n;j++)
              a[j]=a[j+1];
            a[n--]='\0';      // bao g?m 2 phép toán : a[n]='\0' (NULL) và n--
             i--; // vì sau dây i++, n?u kô tr? di, s? b? qua ký t? v?a du?c d?n v? tru?c.
          }
      }
}

int main()
{
	int i=0;
	int var=0;
	char temp[10];
	
	char temp1[50];
    ofstream dest ("code.mif");
    ifstream source ("code.txt");
	dest<< "WIDTH=10;"<<endl<<"DEPTH=256;\n\n";
	dest<< "ADDRESS_RADIX=DEC;"<<endl<<"DATA_RADIX=BIN;\n\n";
	dest<< "CONTENT BEGIN\n";
	dest<<"[00..255]	:	0000000000;\n";
	dest <<i<<" : 0101100000;\n";
	i++;
	while(!source.eof())
	{
		source >> temp;
		if (strcmp(temp,"add")==0 || strcmp(temp,"sub")==0 || strcmp(temp,"and")==0 || strcmp(temp,"or")==0)
		{
			source.getline(temp1,50);
			earse_character(temp1,' ');
			ThayThe(temp1,"r0","00");
			ThayThe(temp1,"r1","01");
			ThayThe(temp1,"r2","10");
			ThayThe(temp1,"r3","11");
			ThayThe(temp,"add","0000");	
			ThayThe(temp,"sub","0001");		
			ThayThe(temp,"and","0010");		
			ThayThe(temp,"or","0011");	
			dest<<i<<" : "<<temp<<temp1<<";\n";
					
		}
		else if(strcmp(temp,"not")==0)
		{
			dest<<i<<" : 0100";
			source.getline(temp1,50);
			earse_character(temp1,' ');
			ThayThe(temp1,"r0","00");
			ThayThe(temp1,"r1","01");
			ThayThe(temp1,"r2","10");
			ThayThe(temp1,"r3","11");
			temp1[4] = temp1[2];
			temp1[5] = temp1[3];
			dest<<temp1<<";\n";
		}
		else if(strcmp(temp,"siz")==0)
		{
			dest <<i<<" : 0101000000;\n";
		}
		else if (strcmp(temp,"nop")==0)
		{
			dest <<i<<" : 0101100000;\n";
		}
		else if(strcmp(temp,"jump")==0)
		{
			source>>var;
			int2binary(var,temp1,8);
			dest <<i<<" : 011"<<temp1<<";\n";			
		}
		else if (strcmp(temp,"store")==0)
		{
			source>>var;
			int2binary(var,temp1,8);
			dest <<i<<" : 100"<<temp1<<";\n";			
			
		}
		else if (strcmp(temp,"load")==0)
		{
			source>>var;
			int2binary(var,temp1,8);
			dest <<i<<" : 101"<<temp1<<";\n";			
			
		}
		else if (strcmp(temp,"save")==0)
		{
			source>>var;
			int2binary(var,temp1,9);
			dest <<i<<" : 11"<<temp1<<";\n";			
		}
		else
		{
			i--;
		}
		i++;
	}
	
	dest<<i<<" : 0101110000;"<<endl;
	dest<<"END;\n";
	source.close();
	dest.close();
	return 0;

}
