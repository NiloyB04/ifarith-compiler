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

For this task, you will write four new .ifa programs. Your programs
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

[ High Level Reflection ] 

In roughly 100-500 words, write a summary of your findings in working
on this project: what did you learn, what did you find interesting,
what did you find challenging? As you progress in your career, it will
be increasingly important to have technical conversations about the
nuts and bolts of code, try to use this experience as a way to think
about how you would approach doing group code critique. What would you
do differently next time, what did you learn?

