# Tokenizer
COSC 3308 Design Programming Languages - Tokenizer Project 11/22/2020

Write an Oz program which reads a sequence of characters, and provides in the output the list of tokens according to the above rules. If a token cannot be accepted, then the Oz program should provide an error message accordingly.  
For example, the file  

program foo;  
int meth1(int x) {  
assign x=x+1;  
call boo(3)  
}  

should provide at the output the list of tokens:  
[program foo ';' int meth1 '(' int x ')' '{' assign x '=' x '+' 1 ';' call boo '(' 3 ')' '}']

Other examples can be:
- “local x in x=10 end” should provide at the output the list of tokens:  
- ['local' x 'in' x '=' 10 'end']
- “bool b=false; a=b;” should provide at the output the list of tokens:  
- [bool b '=' 'false' ';' a '=' b ';']
- “if b==true then a=b else b=a;” should provide at the output the list of tokens:  
- ['if' b '==' 'true' 'then' a '=' b 'else' b '=' a ';']
- “void m(a,b) if a==b then c=true else c=false” should provide at the output the list of tokens:  
- [void m '(' a ',' b ')' 'if' a '==' b 'then' c '=' 'true' 'else' c '=' 'false']

The proposed imperative language which should be tokenized has the following list of tokens: keywords, operators, atoms, integers, floats, and separators.  
The keywords are: program, void, bool, int, float, true, false, if, then, else, local, in, end, assign, call.  
The operators are: ‘=’, ‘+’, ‘-‘, ‘*’, ‘/’, ‘==’, ‘!=’, ‘>’, ‘<’, ‘<=’, ‘>=’.  
An atom starts with a lowercase character, followed by any number of alphanumeric characters, but it cannot be a keyword.  
The integers and floats are those known like in any programming language.  
The separators are blanks (spaces), ‘;’, ‘,’, ‘(‘, ‘)’, ‘{‘, ‘}’.
