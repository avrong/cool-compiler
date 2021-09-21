(*
 *  CS164 Fall 94
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *)

class Main inherits IO {
   stack : List <- new List;
   stackCommand : StackCommand <- new StackCommand;

   main() : Object {
         let input : String in

         while not (input = "x") loop
            {
               out_string("> ");
               input <- in_string();

               stack <- stackCommand.process(input, stack);
            }
         pool
   };
};


class StackCommand inherits IO {
   process(command : String, stack : List) : List {
      if command = "e" then
         (new EvalStackCommand).execute(stack)
      else if command = "d" then {
         (new DisplayStackCommand).execute(stack);
         stack;
      } else
         stack.cons(command)
      fi fi
   };
};

class EvalStackCommand inherits StackCommand {
   execute(stack : List) : List {
      if stack.isNil() then
         stack
      else if stack.head() = "+" then
         (new AddStackCommand).execute(stack.tail())
      else if stack.head() = "s" then
         (new SwapStackCommand).execute(stack.tail())
      else
         stack
      fi fi fi

   };
};

class DisplayStackCommand inherits StackCommand {
   execute(stack : List) : Object {
      if not stack.isNil() then {
         out_string(stack.head());
         out_string("\n");

         execute(stack.tail());
      } else
         (new Utils).doNothing()
      fi
   };
};

class AddStackCommand inherits StackCommand {
   a2i: A2I <- new A2I;

   first : Int;
   second : Int;
   result : Int;

   execute(stack : List) : List {
      {
         first <- a2i.a2i(stack.head());
         second <- a2i.a2i((stack.tail()).head());

         result <- first + second;

         (new Cons).init(a2i.i2a(result), stack.tail().tail());
      }
   };
};

class SwapStackCommand inherits StackCommand {
   first : String;
   second : String;

   execute(stack : List) : List {
      {
         first <- stack.head();
         second <- (stack.tail()).head();

         (new Cons).init(second, (new Cons).init(first, stack.tail().tail()));
      }
   };
};

class List {
   isNil() : Bool { true };

   head() : String {
      {
         abort();

         "";
      }
   };
   
   tail() : List {
      {
         abort();

         self;
      }
   };

   cons(i : String) : List {
      (new Cons).init(i, self)
   };

};

class Cons inherits List {
   car : String;
   cdr : List;

   isNil() : Bool { false };
   head()  : String { car };
   tail()  : List { cdr };

   init(i : String, rest : List) : List {
      {
         car <- i;
         cdr <- rest;
         
         self;
      }
   };

};

class Utils {
   doNothing() : Object { new Object };
};