# Lab1: F-word 
As far as we can see, one word is 16 bits in LC-3. We may call a word _F-word_ if it contains 4 
**continuous **1 . For example, these words are _F-words_: 
```
1111 0000 0000 0000 
as 
1110 1110 1110 1111 
1111 1111 1111 1111 
```

On the contrary, these words are not _F-words_: 
```
1110 0111 0011 1000 
1010 1010 1010 1010 
0000 0000 0000 0000 
```

In this lab, you are required to write a program with **LC-3 machine code** to identify whether a word is _F-word_. 
## Requirements 

- Write program with **LC-3 machine code**(0's and 1's) 
- Start your program at x3000 
- The word to be checked will be stored at x3100 before running your program 
- Set R2 to your answer: 1 for a _F-word_, 0 otherwise. Any other value will fail the tests. 
- Remember to halt your program in the end 
- **NO CHEATING **
## Grading 
Lab 1 takes 5% of the final score, consisting of Check and Report. 
### Check (50%) 

- Contact to your lab TA to check your code. In most cases, it is required to be **OFFLINE**. 
- TA will test your code in different cases. Correctness is the primary factor in grading.TA will ask you questions to make sure you finish it on your own. It is very important to be familiar with the lab and your code. Suggestion: write some comments in case you forget what your code means. 
- You can retry if you fails a check, but there will be a penalty of 10% points in Check part each time. 
### Report (50%) 

- Written in **English**, concise and complete 
- Convince TA that you finish the lab on your own 
- **No more than** 2 A4 pages 
- Consisting of: 
   - Algorithm explanation 
   - Essential parts of your code with sufficient comments 
   - Questions TA asked you and your answer in Check 
### Other Penalty 

- Delay: -10% each day after ddl 
- Cheating: -100%, and -10% in final score of the course
