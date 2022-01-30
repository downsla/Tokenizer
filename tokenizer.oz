% Liam Downs
% 11/22/2020

declare

[File]={Module.link ['File.ozf']}
Content = {File.readList "foo.txt"}

local Y={NewCell 0} Zs={NewCell 0} in

   fun {Stream List}
      case List of nil then Y:=0 Zs:=nil nil
      [] X|Xr then
	 if {NullSeparator [X]} then Y:=~1 Zs:=Xr nil
	 elseif {Separator [X]} then Y:=X Zs:=Xr nil
	 elseif {Operator [X]} then Y:=X Zs:=Xr nil
	 elseif {DualOperator [X]} then
	    if [Xr.1] == "=" then
	       case Xr of nil then nil
	       [] X1|X2 then Y:=[X X1] Zs:=X2 nil
	       end
	    else Y:=X Zs:=Xr nil
	    end
	 else X|{Stream Xr}
	 end 
      end
   end

   fun {Store List}
      local C in
	 case {Stream List} of nil then
	    if @Y==0 then nil
	    elseif @Y==~1 then {Assign Y 0} {Store @Zs}
	    else {Exchange Y C 0} [C]|{Store @Zs}
	    end
	 [] L then
	    if {Or @Y==0 @Y==~1} then
	       if {Keyword L} then {Assign Y 0} L|{Store @Zs}
	       elseif {Lowercase L.1} then {Assign Y 0} L|{Store @Zs}
	       elseif {Or {String.isInt L} {String.isFloat L}} then {Assign Y 0} L|{Store @Zs}
	       else {Exception.error {String.toAtom L}}
	       end
	    elseif {CheckList @Y} then
	       if {Keyword L} then {Exchange Y C 0} L|C|{Store @Zs}
	       elseif {Lowercase L.1} then {Exchange Y C 0} L|C|{Store @Zs}
	       elseif {Or {String.isInt L} {String.isFloat L}} then {Exchange Y C 0} L|C|{Store @Zs}
	       else {Exception.error {String.toAtom L}}
	       end
	    else
	       if {Keyword L} then {Exchange Y C 0} L|[C]|{Store @Zs}
	       elseif {Lowercase L.1} then {Exchange Y C 0} L|[C]|{Store @Zs}
	       elseif {Or {String.isInt L} {String.isFloat L}} then {Exchange Y C 0} L|[C]|{Store @Zs}
	       else {Exception.error {String.toAtom L}}
	       end
	    end
	 end
      end
   end

end

fun {NullSeparator A}
   if A == " " then true
   elseif A == "\r" then true
   elseif A == "\n" then true
   else false
   end
end

fun {Separator A}
   if A == ";" then true
   elseif A == "," then true
   elseif A == "(" then true
   elseif A == ")" then true
   elseif A == "{" then true
   elseif A == "}" then true
   else false
   end
end

fun {Operator A}
   if A == "+" then true
   elseif A == "-" then true
   elseif A == "*" then true
   elseif A == "/" then true
   else false
   end
end

fun {DualOperator A}
   if A == "=" then true
   elseif A == "!" then true
   elseif A == ">" then true
   elseif A == "<" then true
   else false
   end
end

fun {Keyword A}
   if A == "program" then true
   elseif A == "void" then true
   elseif A == "bool" then true
   elseif A == "int" then true
   elseif A == "float" then true
   elseif A == "true" then true
   elseif A == "false" then true
   elseif A == "if" then true
   elseif A == "then" then true
   elseif A == "else" then true
   elseif A == "local" then true
   elseif A == "in" then true
   elseif A == "end" then true
   elseif A == "assign" then true
   elseif A == "call" then true
   else false
   end
end

fun {Lowercase A}
   if {Or A<97 122<A} then false
   else true
   end
end

fun {CheckList L}
   case L of nil then false
   [] X|Xr then true
   [] X then false
   end
end

fun {Print S}
   case S of nil then nil
   [] X|Xr then
      if {String.isInt X} then {String.toInt X}|{Print Xr}
      elseif {String.isFloat X} then {String.toFloat X}|{Print Xr}
      else {String.toAtom X}|{Print Xr}
      end
   end
end

{Browse {Print {Store Content}}}