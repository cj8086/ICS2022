# Lab5: Flip
After printing many review materials double-sided, you find it disturbing to flip them upside down during the review. Assume that `N` pages of the materials are double-sided printed, each side containing one of `N` chapters in the textbook. You wonder if there is a way to flip some of them so that you can cover all the `N` chapters at once.
## Input
First line: a single number `N`
Then follow `N` lines. The i-th line contains two integers $1\leq x_i,y_i\leq N$, representing the two
chapters printed on the i-th page.
### Sample Input
`5`
`3 2` 
`2 5`
`4 1`
`1 3`
`2 1`
### Output
N numbers in a line, representing your choice for the pages in order. They are expected to cover all
integers from 1 to N.
As usual, echo the input before your output for convenince of debugging.
### Sample Output
`5`
`3 2`
`2 5`
`4 1`
`1 3`
`2 1` 
`3 5 4 1 2`
### Explanation
Just flip the second page (swap `2 5` , the third line of input), and get the first column as the answer
(they covered $1\sim N$).
## Limitation
$1\leq N\leq 15$
There is at least one flipping solution available.
For the case of multiple solutions, just print any one of them.
## Requirements

- Write program with **LC-3 assembly language**
- Start your program at `x3000`
- Use **recursion** to solve the problem
- Remember to halt your program in the end
- **NO CHEATING**
## Grading
Lab 5 takes 8% of the final score, consisting of Check and Report.
### Check (50%)

- Contact to your lab TA to check your code. In most cases, it is required to be **OFFLINE**. 
- TA will test your code in different cases. Correctness is the primary factor in grading.
- TA will ask you questions to make sure you finish it on your own. It is very important to be familiar with the lab and your code. Suggestion: write some comments in case you forget what your code means.
- You can retry if you fails a check, but there will be a penalty of 10% points in Check part each time.
### Report (50%)

- Written in English, concise and complete
- Convince TA that you finish the lab on your own
- **No more than** 3 A4 pages
- Consisting of:
   - Algorithm explanation
   - Essential parts of your code with sufficient comments
   - Questions TA asked you and your answer in Check
## Other Penalty

- Delay: -10% each day after ddl
- Cheating: -100%, and -10% in final score of the course
