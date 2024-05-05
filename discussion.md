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

ir-virtual puts all actions through virtual registers for computation. Its shorter and simpler so it takes less processing power and runs faster. Ir-virtual is more structured than x86 which makes it have more restrictions. Cons: inability to manipulate all memory addresses and worse performance in large complex programs.

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

programs in the test programs file: 60.ifa, arith3.ifa, arith4.ifa   
60.ifa input: 60  output: 60    
arith3.ifa input: (+ 2 8)  output: 10    
arith4.ifa input: (* (- 5 3) 7)  output: 14

[ Question 3 ] 

Describe each of the passes of the compiler in a slight degree of
detail, using specific examples to discuss what each pass does. The
compiler is designed in series of layers, with each higher-level IR
desugaring to a lower-level IR until ultimately arriving at x86-64
assembler. Do you think there are any redundant passes? Do you think
there could be more?

In answering this question, you must use specific examples that you
got from running the compiler and generating an output.

For arith3.ifa: Stage1: '+' is 'bop?', '2' and '8' are the literals.   
Stage2: arith3 input is a basic arithmetic operation.    
Stage3: input transformed into ANF and for output: (let ([v1 2] [v2 8]) (+ v1 v2)).    
Stage4: all the values and operations are assigned to a virtual register, the output is 'mov-lit v1, 2'; 'mov-lit v2, 8'; 'add v3, v1, v2'.    
Stage5: Converts virtual registers into x86 registers.    
Step6: Converts x86 into NASM assembly and returns 10.    
Stage1 and Stage2 were redundant due to this being a basic arithmetic operation.    

[ Question 4 ] 

This is a larger project, compared to our previous projects. This
project uses a large combination of idioms: tail recursion, folds,
etc.. Discuss a few programming idioms that you can identify in the
project that we discussed in class this semester. There is no specific
definition of what an idiom is: think carefully about whether you see
any pattern in this code that resonates with you from earlier in the
semester.

In this project, several programming idioms were used, reflecting concepts we discussed in class this semester. One prominent idiom is tail recursion, which is evident in the codebase's recursive functions. Tail recursion allows for efficient memory usage by reusing the same stack frame for each recursive call, ultimately reducing the risk of stack overflow errors. Additionally, folds, such as map and foldl, were utilized to process lists in a functional style, simplifying code and making it more expressive. These idioms promote code readability, maintainability, and performance, aligning with the functional programming paradigm we've explored in class.

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

We explored the codebase extensively to identify potential issues. One area we focused on was the handling of nested function calls within expressions. After thorough testing, we discovered a bug where the compiler failed to correctly generate code for certain nested function call scenarios, resulting in unexpected behavior or compilation errors. This bug appears to stem from a limitation in the compiler's code generation logic for complex expression trees. By pushing the boundaries and testing edge cases, we were able to uncover this issue, highlighting the importance of rigorous testing and quality assurance in software development.

[ High Level Reflection ] 

In roughly 100-500 words, write a summary of your findings in working
on this project: what did you learn, what did you find interesting,
what did you find challenging? As you progress in your career, it will
be increasingly important to have technical conversations about the
nuts and bolts of code, try to use this experience as a way to think
about how you would approach doing group code critique. What would you
do differently next time, what did you learn?

The most important thing we learned while working on this project is a deeper understanding of how compilers work reductively. The most interesting thing was how depite irv being completely unfamiliar how intuitive it was when dissecting it. The most challenging part was debugging a little bit to our surprise, took way more time than expected perhaps because this is a fairly long program and debugging is not something neither of us has really spent a lot of time doing for other classes. One thing we would do differently next time is having better communication throughout the work process and dividing work more efficiently, would probably have saved some time. We learned a lot especially from the debugging about how to be more thorough with reading code and combining what we have learned through the course which will be very useful in our careers as a big part of jobs in CS are debugging large code bases.
