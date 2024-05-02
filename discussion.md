# Discussion and Reflection


The bulk of this project consists of a collection of five
questions. You are to answer these questions after spending some
amount of time looking over the code together to gather answers for
your questions. Try to seriously dig into the project together--it is
of course understood that you may not grasp every detail, but put
forth serious effort to spend several hours reading and discussing the
code, along with anything you have taken from it.

Questions will largely be graded on completion and maturity, but the
instructors do reserve the right to take off for technical
inaccuracies (i.e., if you say something factually wrong).

Each of these (six, five main followed by last) questions should take
roughly at least a paragraph or two. Try to aim for between 1-500
words per question. You may divide up the work, but each of you should
collectively read and agree to each other's answers.

[ Question 1 ] 

For this task, you will three new .irv programs. These are
`ir-virtual?` programs in a pseudo-assembly format. Try to compile the
program. Here, you should briefly explain the purpose of ir-virtual,
especially how it is different than x86: what are the pros and cons of
using ir-virtual as a representation? You can get the compiler to to
compile ir-virtual files like so: 

racket compiler.rkt -v test-programs/sum1.irv 

(Also pass in -m for Mac)

sub.irv

(mov-lit r0 5)
(mov-lit r1 8)   
(mov-lit r2 0)    
(sub r2 r1 r0)    
(print r2)

mul.irv

   (mov-lit r0 5)
   (mov-lit r1 8)
   (mov-lit r2 0)
   (mov-lit r3 0)
loop:
   (add r2 r0)
   (add r3 1)
   (cmp r3 r1)
   (jlt loop)
   (print r2)

div.irv

(mov-lit r0, 5)
(mov-lit r1, 8)
(div r1, r0, r2)
(print r2)

ir-virtual intends to make instructions easier, and it does this by putting all actions into a virtual register while stack allocating everything. Comparing it to x86 makes it much simpler to understand, although ir-virtual is much more restrictive in nature. x86 allows for more than just registers, which makes it much more intuitive and faster to run. ir-virtual works as intended, but will take much longer compared to other architectures.

[ Question 2 ] 

For this task, you will write three new .ifa programs. Your programs
must be correct, in the sense that they are valid. There are a set of
starter programs in the test-programs directory now. Your job is to
create three new `.ifa` programs and compile and run each of them. It
is very much possible that the compiler will be broken: part of your
exercise is identifying if you can find any possible bugs in the
compiler.

For each of your exercises, write here what the input and output was
from the compiler. Read through each of the phases, by passing in the
`-v` flag to the compiler. For at least one of the programs, explain
carefully the relevance of each of the intermediate representations.

For this question, please add your `.ifa` programs either (a) here or
(b) to the repo and write where they are in this file.

[Program 1]
Input (q2_1.ifa):`((let* ([a 2] [b 3]) (* a b)))`
Output 
```
ifarith-tiny:
'(let ((a 2)) (let ((b 3)) (* a b)))
'(let ((a 2)) (let ((b 3)) (* a b)))
2
'(let ((b 3)) (* a b))
3
'(* a b)
'a
'b
anf:
'(let ((x1254 2))
   (let ((a x1254))
     (let ((x1255 3)) (let ((b x1255)) (let ((x1256 (* a b))) x1256)))))
ir-virtual:
'(((label lab1257) (mov-lit x1254 2))
  ((label lab1258) (mov-reg a x1254))
  ((label lab1259) (mov-lit x1255 3))
  ((label lab1260) (mov-reg b x1255))
  ((label lab1261) (mov-reg x1256 a))
  (imul x1256 b)
  (return x1256))
x86:
section .data
	int_format db "%ld",10,0
	global _main
	extern _printf
section .text
_start:	call _main
	mov rax, 60
	xor rdi, rdi
	syscall
_main:	push rbp
	mov rbp, rsp
	sub rsp, 80
	mov esi, 2
	mov [rbp-24], esi
	mov esi, [rbp-24]
	mov [rbp-32], esi
	mov esi, 3
	mov [rbp-16], esi
	mov esi, [rbp-16]
	mov [rbp-40], esi
	mov esi, [rbp-32]
	mov [rbp-8], esi
	mov edi, [rbp-40]
	mov eax, [rbp-8]
	imul eax, edi
	mov [rbp-8], eax
	mov rax, [rbp-8]
	jmp finish_up
finish_up:	add rsp, 80
	leave 
	ret 
```
[Program 2]
Input (q2_2.ifa): `(+ 1 (* 2 (+ 3 4)))`
Output
``` 
ifarith-tiny:
'(+ 1 (* 2 (+ 3 4)))
'(+ 1 (* 2 (+ 3 4)))
1
'(* 2 (+ 3 4))
2
'(+ 3 4)
3
4
anf:
'(let ((x1254 1))
   (let ((x1255 2))
     (let ((x1256 3))
       (let ((x1257 4))
         (let ((x1258 (+ x1256 x1257)))
           (let ((x1259 (* x1255 x1258)))
             (let ((x1260 (+ x1254 x1259))) x1260)))))))
ir-virtual:
'(((label lab1261) (mov-lit x1254 1))
  ((label lab1262) (mov-lit x1255 2))
  ((label lab1263) (mov-lit x1256 3))
  ((label lab1264) (mov-lit x1257 4))
  ((label lab1265) (mov-reg x1258 x1256))
  (add x1258 x1257)
  ((label lab1266) (mov-reg x1259 x1255))
  (imul x1259 x1258)
  ((label lab1267) (mov-reg x1260 x1254))
  (add x1260 x1259)
  (return x1260))
x86:
section .data
        int_format db "%ld",10,0


        global _main
        extern _printf
section .text


_start: call _main
        mov rax, 60
        xor rdi, rdi
        syscall


_main:  push rbp
        mov rbp, rsp
        sub rsp, 112
        mov esi, 1
        mov [rbp-56], esi
        mov esi, 2
        mov [rbp-48], esi
        mov esi, 3
        mov [rbp-40], esi
        mov esi, 4
        mov [rbp-32], esi
        mov esi, [rbp-40]
        mov [rbp-24], esi
        mov edi, [rbp-32]
        mov eax, [rbp-24]
        add eax, edi
        mov [rbp-24], eax
        mov esi, [rbp-48]
        mov [rbp-16], esi
        mov edi, [rbp-24]
        mov eax, [rbp-16]
        imul eax, edi
        mov [rbp-16], eax
        mov esi, [rbp-56]
        mov [rbp-8], esi
        mov edi, [rbp-16]
        mov eax, [rbp-8]
        add eax, edi
        mov [rbp-8], eax
        mov rax, [rbp-8]
        jmp finish_up
finish_up:      add rsp, 112
        leave 
        ret 
```
[Program 3]
Input (q2_3.ifa): `(let* ([a 3]) a)`
Output:

```
Input source tree in IfArith:
'(let* ((a 3)) a)
ifarith-tiny:
'(let ((a 3)) a)
'(let ((a 3)) a)
3
'a
```
ifarith-tiny is needed in order to convert down to administrative normal form. Here the code is simplified, the amount of instructions is condensed down in order to contain the same logical value while being simplier to compile. The goal is to convert the instructions to act on virtual registers so before that we must simplify the instructions themselves.
```
anf:
'(let ((x1254 3)) (let ((a x1254)) a))
```
In administrative normal form we preform another abstruction on the code. Since values must be stored in registers and then registers assigned to variables this pass directly abstracts the code in this way. For example we cant to `a = 5` we must assign 5 to a register and then define a as that register.
```
ir-virtual:
'(((label lab1255) (mov-lit x1254 3))
  ((label lab1256) (mov-reg a x1254))
  (return a))
```
In this pass we finally convert the instructions down to a condensed set. In prior passes we were just munipulating the values and ways variables were assigned now we can begin to compile the instructions to known mappings that can be easily converted to assembly.
```
x86:
section .data
        int_format db "%ld",10,0


        global _main
        extern _printf
section .text


_start: call _main
        mov rax, 60
        xor rdi, rdi
        syscall


_main:  push rbp
        mov rbp, rsp
        sub rsp, 32
        mov esi, 3
        mov [rbp-8], esi
        mov esi, [rbp-8]
        mov [rbp-16], esi
        mov rax, [rbp-16]
        jmp finish_up
finish_up:      add rsp, 32
        leave 
        ret 
```
In this final pass we produce the final assembly code, this is essentially just a final conversion of the condensed and simplified instructiuons and values from the previous step.
[ Question 3 ] 

Describe each of the passes of the compiler in a slight degree of
detail, using specific examples to discuss what each pass does. The
compiler is designed in series of layers, with each higher-level IR
desugaring to a lower-level IR until ultimately arriving at x86-64
assembler. Do you think there are any redundant passes? Do you think
there could be more?

In answering this question, you must use specific examples that you
got from running the compiler and generating an output.

For this question, we ran `if1.ifa`. The first pass, `ifarith-tiny`, restates the program while dissecting each part of it until it can't go any further. For example, the statement `'(print (+ 1 2))` takes the following path: `'(print (+ 1 2))` -> `'(+ 1 2)` -> `1` -> `2`. The next pass, `anf`, assigns each term into a `let` statement with a virtual address in the order they appear in the program. For example, `1` is assigned to `x1254`, then the if is called on `x1254`, with the next instance of `1` being assigned to `x1255`, and so on. In `ir-virtual`, `x86` operations are introduced while still maintaining the virtual addresses of `anf`. Each operation is assigned to a label with a 4 digit number (ex: `(label lab1261)`). `(label lab1266)` corresponds to `(print x1257)`, which is the original expression of `(+ 1 2)`. Finally, it is translated to `x86`, which contains assembly programs that moves each value into various registers. Labels `lab1263` and `lab1267` act as the `jz` and `jmp` headers here. `esi` originally holds the value `1`, before it is moved into `[rbp]-72` so it can hold `0`. I think each pass serves an intended purpose in this compiler, making sure no stone goes unturned. Because of this, I don't think there is any more passes that could be done here.

[ Question 4 ] 

This is a larger project, compared to our previous projects. This
project uses a large combination of idioms: tail recursion, folds,
etc.. Discuss a few programming idioms that you can identify in the
project that we discussed in class this semester. There is no specific
definition of what an idiom is: think carefully about whether you see
any pattern in this code that resonates with you from earlier in the
semester.

In this larger project, we've encountered several programming idioms that use unique aspects of functional programming and help streamline complex operations. Below are a few idioms that stood out, which we've discussed in class and seen in our projects.

Tail Recursion: Tail recursion is a vital idiom in functional programming, especially relevant in languages that support tail call optimization. It replaces traditional looping constructs with a function that calls itself at the last step of its execution, thereby preventing additional stack frame allocations. In projects throughout the semester, we implemented a tail-recursive function to iteratively process data entries without risking stack overflow. This method proved invaluable for handling large datasets efficiently.

Folds: The use of folds, particularly `foldl` (fold left), has been predominant in projects throughout the semester to reduce collections to a single cumulative value. We applied `foldl` to aggregate results from a list of numerical data, such as summing totals or computing averages, which are common tasks in data analysis. This idiom not only simplifies the code but also enhances its readability by abstracting the looping mechanism.

Comprehensions: Although not exclusive to functional programming, comprehensions are a powerful idiom for constructing new lists or dictionaries from existing iterables. We used list comprehensions extensively to transform lists in a concise and readable way, which is less error-prone compared to traditional for-loops. For instance, filtering and modifying elements in a single, clear line of code greatly simplified our data preprocessing steps.

Pattern Matching: Another functional programming idiom we explored this semester is pattern matching, which allows direct comparison of a variable against a pattern. This is more expressive and cleaner than multiple if-else statements. We utilized pattern matching to decode and handle various types of input data seamlessly, making our error handling more robust and straightforward.

These idioms not only make code more efficient and concise but also align well with the functional programming paradigm, emphasizing immutability and stateless operations. Reflecting on these patterns, we appreciate how they encourage clearer and more maintainable code structures, especially as complex projects scale. Their application in projects has demonstrated how well-chosen idioms can significantly enhance both performance and readability.

[ Question 5 ] 

In this question, you will play the role of bug finder. I would like
you to be creative, adversarial, and exploratory. Spend an hour or two
looking throughout the code and try to break it. Try to see if you can
identify a buggy program: a program that should work, but does
not. This could either be that the compiler crashes, or it could be
that it produces code which will not assemble. Last, even if the code
assembles and links, its behavior could be incorrect.

To answer this question, I want you to summarize your discussion,
experiences, and findings by adversarily breaking the compiler. If
there is something you think should work (but does not), feel free to
ask me.

Your team will receive a small bonus for being the first team to
report a unique bug (unique determined by me).

For `const.ifa`, the program had `let` statements in the form of `[x0 = 5]`. Because of this, when this file was run through the compiler, it immediately outputted an error message saying there was no matching clause and terminated.

The compiler does not check if a symbol is defined before interpeting it. For example inputing `(+ a a)` into the compiler will spit out an assembly file. However, a is not defined so it should not be possible to create an assembly file. 

If we bind a primative operation to a variable then the compiler throws an error. For example `(let* ([e0 +]) (e0 1 1))` spits out an error. The same thing happens with `(let* ([#t 4]) (+ #t 3))`.

If you input a number that is greater than 32 bits, say `9999999999999999999999`, it puts out an error message.

[ High Level Reflection ] 

In roughly 100-500 words, write a summary of your findings in working
on this project: what did you learn, what did you find interesting,
what did you find challenging? As you progress in your career, it will
be increasingly important to have technical conversations about the
nuts and bolts of code, try to use this experience as a way to think
about how you would approach doing group code critique. What would you
do differently next time, what did you learn?

In this project, our biggest takeaway is thinking about compilers as a series of reductions. In our other classes when we write C or ASM code we use a compiler such as GCC as a black box never questioning what goes on behind the scenes. While this project does not compile C, it provides an analogous experience for viewing reduction on code. We learned how to apply our knowledge of racket operations such as folding and tail recursion to compile a program. This required congruent thinking to other projects, as we were essentially just employing pattern matching with recursion. The most challenging part of this project was writing .irv files, as here we must think in terms of the processor and how to manipulate registers rather than the typical control flow that we are used to. If we had to do this project over again we would spend more time looking at the code and seeing where common code patterns are used. This way we would have a deeper understanding of how the reductions are done. Another problem we had was thinking about racket reduction not in terms of the lambda calculus. Coming off of project 4 and the exam, we were thinking about racket as an abstracted lambda calculus, so when we would go to reduce code it made sense to convert to the church encodings. Nevertheless, if we did that it would be a nightmare to compile to virtual code. This required a complete reworking of how we read racket code and expected it to be produced.
